#!/usr/bin/env python3
"""Inventory what a local project page already contains.

Usage: gap_check.py <path/to/index.html> <out/baseline.json>

Output lists headings, FAQ questions, numeric facts, image srcs (+ perceptual
hashes for de-dupe), and JSON-LD types (with @graph unpacked).
"""
import json
import re
import sys
from pathlib import Path

from bs4 import BeautifulSoup

try:
    import imagehash
    from PIL import Image
except ImportError:
    imagehash = None

REPO = Path(__file__).resolve().parents[4]

NUM_PATTERNS = {
    "price": r"₹\s?[\d,.]+\s?(?:Cr|L|Lakh|Lakhs|Crore)?\*?",
    "sqft": r"[\d,]{3,6}\s?(?:-|to)?\s?[\d,]{0,6}\s?sq\.?\s?ft",
    "acres": r"[\d.]+\s?acres?",
    "units": r"\d[\d,]*\+?\s?(?:homes|units|apartments|villas|plots|flats)",
    "bhk": r"\d(?:\.\d)?\s?BHK",
    "floors": r"(?:\d?B\s?\+\s?)?G\s?\+\s?\d{1,2}|\d{1,2}\s?(?:floors|storeys)",
    "date": r"(?:Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)[a-z]*\.?\s?\d{4}",
    "rera": r"(?:PRM/KA/RERA|TN/\d+/Building|PR/\d+)[^\s<,]*",
}


def walk_jsonld(node, types):
    if isinstance(node, list):
        for n in node:
            walk_jsonld(n, types)
    elif isinstance(node, dict):
        t = node.get("@type")
        if t:
            types.extend(t if isinstance(t, list) else [t])
        for v in node.values():
            if isinstance(v, (dict, list)):
                walk_jsonld(v, types)


def phash(path):
    if not imagehash or not path.exists() or path.suffix.lower() == ".svg":
        return None
    try:
        return str(imagehash.phash(Image.open(path)))
    except Exception:
        return None


def main():
    page, out = Path(sys.argv[1]), Path(sys.argv[2])
    soup = BeautifulSoup(page.read_text(encoding="utf-8"), "html.parser")

    jsonld_types, faq_schema_qs = [], []
    for s in soup.find_all("script", type="application/ld+json"):
        try:
            data = json.loads(s.string or "")
        except json.JSONDecodeError:
            jsonld_types.append("INVALID_JSON")
            continue
        walk_jsonld(data, jsonld_types)
        stack = [data]
        while stack:
            n = stack.pop()
            if isinstance(n, list):
                stack.extend(n)
            elif isinstance(n, dict):
                if n.get("@type") == "Question":
                    faq_schema_qs.append(n.get("name", "").strip())
                stack.extend(v for v in n.values() if isinstance(v, (dict, list)))

    for s in soup(["script", "style", "noscript"]):
        s.decompose()
    text = re.sub(r"\s+", " ", soup.get_text(" "))

    images = []
    for img in soup.find_all("img"):
        src = img.get("src") or ""
        if not src or src.startswith("data:"):
            continue
        local = REPO / src.lstrip("/")
        images.append({"src": src, "alt": img.get("alt", ""), "phash": phash(local)})

    baseline = {
        "page": str(page),
        "title": soup.title.string.strip() if soup.title and soup.title.string else "",
        "meta_description": (soup.find("meta", attrs={"name": "description"}) or {}).get("content", ""),
        "headings": [{"level": h.name, "text": h.get_text(" ", strip=True)}
                     for h in soup.find_all(["h1", "h2", "h3"])],
        "section_ids": [s.get("id") for s in soup.find_all("section") if s.get("id")],
        "faq_visible": [q.get_text(" ", strip=True) for q in soup.select(".faq-question [itemprop=name], .faq-question")
                        if q.name == "span" or not q.select("[itemprop=name]")],
        "faq_schema": faq_schema_qs,
        "numbers": {k: sorted(set(m.strip() for m in re.findall(p, text, re.I))) for k, p in NUM_PATTERNS.items()},
        "images": images,
        "jsonld_types": sorted(set(jsonld_types)),
        "word_count": len(text.split()),
    }
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(json.dumps(baseline, indent=2, ensure_ascii=False))
    print(f"baseline: {len(baseline['headings'])} headings, {len(baseline['faq_visible'])} FAQs "
          f"(schema {len(faq_schema_qs)}), {len(images)} images, {baseline['word_count']} words, "
          f"jsonld={baseline['jsonld_types']}")


if __name__ == "__main__":
    main()
