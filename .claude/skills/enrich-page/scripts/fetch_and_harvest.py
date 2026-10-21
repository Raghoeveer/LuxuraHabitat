#!/usr/bin/env python3
"""Fetch each competitor page once, save it, and harvest its images.

Usage: fetch_and_harvest.py <run_dir>    (expects run_dir/urls.json, run_dir/baseline.json)

Writes:
  pages/NN-domain.html, pages/NN-domain.txt   raw HTML + cleaned text (for content-extractor)
  imgs/orig/IMG-NNN.<ext>                     downloaded originals
  imgs/view/IMG-NNN.jpg                       <=1024px previews (for image-classifier)
  harvest.json                                pages + images + rejection counts

Fetch strategy: plain requests first; Playwright (scroll + click gallery/plan tabs +
sniff network images) when the page is blocked, JS-rendered, or yields few images.
Watermark detection is left to the image-classifier agent.
"""
import hashlib
import io
import json
import re
import sys
from collections import Counter
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path
from urllib.parse import urljoin, urlparse

import imagehash
import requests
from bs4 import BeautifulSoup
from PIL import Image

UA = ("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/130.0 Safari/537.36")
MIN_LONG_SIDE, MIN_SHORT_SIDE = 700, 300
PLAN_MIN_LONG, PLAN_MIN_SHORT = 500, 250  # brokers often serve plans at ~600x350
PLAN_HINT = re.compile(r"plan|floor|layout|bhk|map|location|site|tower|elevation", re.I)
PHASH_DIST = 6
JUNK_NAME = re.compile(r"logo|icon|sprite|avatar|favicon|placeholder|loader|spinner|badge|"
                       r"whatsapp|call-?now|arrow|star|rating|flag|emoji|pixel|1x1|blank", re.I)
BLOCK_MARKERS = re.compile(r"cf-browser-verification|captcha|access denied|just a moment|"
                           r"enable javascript|are you a robot", re.I)
TAB_TEXT = re.compile(r"floor ?plan|master ?plan|site ?plan|unit ?plan|layout|gallery|photos|"
                      r"images|amenities|location", re.I)
IMG_ATTRS = ("src", "data-src", "data-lazy", "data-lazy-src", "data-original", "data-url",
             "data-bg", "data-image", "data-full", "data-zoom-image", "data-large")

session = requests.Session()
session.headers.update({"User-Agent": UA, "Accept-Language": "en-IN,en;q=0.9"})


def slug(url):
    return re.sub(r"[^a-z0-9]+", "-", urlparse(url).netloc.lower().removeprefix("www."))[:40].strip("-")


def clean_text(html):
    soup = BeautifulSoup(html, "html.parser")
    for t in soup(["script", "style", "noscript", "svg", "iframe"]):
        t.decompose()
    lines = [re.sub(r"\s+", " ", l).strip() for l in soup.get_text("\n").splitlines()]
    return "\n".join(l for l in lines if l)


def fetch_plain(url):
    try:
        r = session.get(url, timeout=25)
        return r.status_code, r.text
    except Exception as e:
        return 0, str(e)


def fetch_browser(url):
    """Render with Chromium, scroll to trigger lazy-load, click gallery/plan tabs."""
    from playwright.sync_api import sync_playwright
    net_imgs = set()
    with sync_playwright() as p:
        b = p.chromium.launch()
        pg = b.new_page(user_agent=UA, locale="en-IN", viewport={"width": 1366, "height": 900})
        pg.on("response", lambda r: net_imgs.add(r.url)
              if r.request.resource_type == "image" and r.ok else None)
        try:
            pg.goto(url, wait_until="domcontentloaded", timeout=45000)
            pg.wait_for_timeout(2500)
            for _ in range(12):
                pg.mouse.wheel(0, 1400)
                pg.wait_for_timeout(400)
            for el in pg.query_selector_all("a, button, li[role=tab], [role=tab], .nav-link")[:400]:
                try:
                    txt = (el.inner_text() or "")[:40]
                    if TAB_TEXT.search(txt) and el.is_visible():
                        href = el.get_attribute("href") or ""
                        if href.startswith("http") and urlparse(href).netloc != urlparse(url).netloc:
                            continue
                        el.click(timeout=1500, no_wait_after=True)
                        pg.wait_for_timeout(700)
                except Exception:
                    pass
            pg.keyboard.press("Escape")
            html = pg.content()
            status = 200
        except Exception as e:
            html, status = str(e), 0
        b.close()
    return status, html, net_imgs


def image_candidates(html, base):
    soup = BeautifulSoup(html, "html.parser")
    out = {}

    def add(u, alt="", ctx=""):
        if not u or u.startswith("data:"):
            return
        u = urljoin(base, u.strip().split(" ")[0])
        if u.startswith("http") and u not in out:
            out[u] = {"alt": alt[:200], "context": ctx[:140]}

    def heading_near(el):
        prev = el.find_previous(["h1", "h2", "h3", "h4", "figcaption"])
        nxt = el.find_next(["h1", "h2", "h3", "h4", "figcaption"])
        p = prev.get_text(" ", strip=True)[:60] if prev else ""
        n = nxt.get_text(" ", strip=True)[:60] if nxt else ""
        return f"after: {p} | before: {n}"

    for img in soup.find_all(["img", "source"]):
        alt, ctx = img.get("alt", "") or "", heading_near(img)
        for a in IMG_ATTRS:
            add(img.get(a), alt, ctx)
        for a in ("srcset", "data-srcset"):
            if img.get(a):
                best = img[a].split(",")[-1].strip()  # last = largest by convention
                add(best, alt, ctx)
    for el in soup.find_all(style=re.compile(r"url\(", re.I)):
        for u in re.findall(r"url\(['\"]?([^'\")]+)", el["style"]):
            add(u, "", heading_near(el))
    for el in soup.find_all(attrs={"data-bg": True}):
        add(el["data-bg"], "", heading_near(el))
    for a in soup.find_all("a", href=re.compile(r"\.(jpe?g|png|webp)(\?|$)", re.I)):
        add(a["href"], a.get("title", ""), heading_near(a))
    for m in soup.find_all("meta", property="og:image"):
        add(m.get("content"), "og:image", "")
    pdfs = {urljoin(base, a["href"]) for a in soup.find_all("a", href=re.compile(r"\.pdf(\?|$)", re.I))}
    return out, pdfs


def pdf_images(pdf_url):
    import fitz
    try:
        r = session.get(pdf_url, timeout=40)
        doc = fitz.open(stream=r.content, filetype="pdf")
    except Exception:
        return []
    out = []
    for pno, page in enumerate(doc):
        for img in page.get_images(full=True):
            try:
                data = doc.extract_image(img[0])
                out.append((f"{pdf_url}#page={pno + 1}", data["image"]))
            except Exception:
                pass
    return out


def download(u):
    try:
        r = session.get(u, timeout=25)
        if r.ok and r.content:
            return u, r.content
    except Exception:
        pass
    return u, None


def main():
    run = Path(sys.argv[1])
    urls = json.loads((run / "urls.json").read_text())["results"]
    baseline = json.loads((run / "baseline.json").read_text())
    base_hashes = [imagehash.hex_to_hash(i["phash"]) for i in baseline["images"] if i.get("phash")]
    (run / "pages").mkdir(parents=True, exist_ok=True)
    (run / "imgs/orig").mkdir(parents=True, exist_ok=True)
    (run / "imgs/view").mkdir(parents=True, exist_ok=True)

    pages, cands = [], {}  # cands: img_url -> meta
    for r in urls:
        url, nn = r["url"], f"{r['rank']:02d}"
        status, html = fetch_plain(url)
        text = clean_text(html) if status == 200 else ""
        found, pdfs = image_candidates(html, url) if status == 200 else ({}, set())
        via, net = "requests", set()
        if status != 200 or len(text.split()) < 300 or BLOCK_MARKERS.search(text[:3000]) or len(found) < 8:
            b_status, b_html, net = fetch_browser(url)
            b_text = clean_text(b_html) if b_status == 200 else ""
            if len(b_text.split()) > len(text.split()):
                status, html, text, via = b_status, b_html, b_text, "playwright"
                found, pdfs = image_candidates(html, url)
            for u in net:
                found.setdefault(u, {"alt": "", "context": "network"})
        stem = f"{nn}-{slug(url)}"
        (run / "pages" / f"{stem}.html").write_text(html, encoding="utf-8")
        (run / "pages" / f"{stem}.txt").write_text(f"SOURCE: {url}\n\n{text}", encoding="utf-8")
        blocked = bool(BLOCK_MARKERS.search(text[:3000])) and len(text.split()) < 300
        pages.append({"rank": r["rank"], "url": url, "fetched_via": via, "status": status,
                      "words": len(text.split()), "blocked": blocked, "images_found": len(found),
                      "pdfs": sorted(pdfs), "text_path": f"pages/{stem}.txt"})
        for u, meta in found.items():
            cands.setdefault(u, {**meta, "source_page": url})
        for pdf in pdfs:
            for src, data in pdf_images(pdf):
                cands.setdefault(src, {"alt": "", "context": "brochure PDF", "source_page": url, "_data": data})
        print(f"{nn} {via:<10} {status} {len(text.split()):>6}w {len(found):>4} imgs  {url[:70]}")

    reject = Counter()
    todo = [u for u, m in cands.items() if "_data" not in m]
    todo = [u for u in todo if not JUNK_NAME.search(urlparse(u).path.rsplit("/", 1)[-1])
            or reject.update(["junk_name"])]
    todo = [u for u in todo if not re.search(r"\.(svg|gif|ico)(\?|$)", u, re.I) or reject.update(["svg_gif"])]
    with ThreadPoolExecutor(12) as ex:
        blobs = dict(ex.map(download, todo))
    blobs.update({u: m.pop("_data") for u, m in cands.items() if "_data" in m})

    kept, seen_sha = [], set()
    for u, data in blobs.items():
        if not data:
            reject["download_failed"] += 1
            continue
        sha = hashlib.sha1(data).hexdigest()
        if sha in seen_sha:
            reject["exact_dupe"] += 1
            continue
        seen_sha.add(sha)
        try:
            im = Image.open(io.BytesIO(data))
            im.load()
        except Exception:
            reject["not_an_image"] += 1
            continue
        w, h = im.size
        m = cands[u]
        plan_like = bool(PLAN_HINT.search(f"{u} {m.get('alt', '')} {m.get('context', '')}"))
        lo, sh = (PLAN_MIN_LONG, PLAN_MIN_SHORT) if plan_like else (MIN_LONG_SIDE, MIN_SHORT_SIDE)
        if max(w, h) < lo or min(w, h) < sh:
            reject["too_small"] += 1
            continue
        ph = imagehash.phash(im.convert("RGB"))
        if any(ph - b <= PHASH_DIST for b in base_hashes):
            reject["already_on_page"] += 1
            continue
        dupe = next((k for k in kept if ph - k["_ph"] <= PHASH_DIST), None)
        if dupe:
            reject["near_dupe"] += 1
            if w * h > dupe["width"] * dupe["height"]:  # keep the larger copy
                dupe.update({"_data": data, "_im": im, "img_url": u, "width": w, "height": h, "_ph": ph,
                             **cands[u]})
            continue
        kept.append({"img_url": u, "width": w, "height": h, "_ph": ph, "_data": data, "_im": im, **cands[u]})

    images = []
    for i, k in enumerate(kept, 1):
        iid = f"IMG-{i:03d}"
        ext = (k["_im"].format or "jpg").lower().replace("jpeg", "jpg")
        (run / f"imgs/orig/{iid}.{ext}").write_bytes(k["_data"])
        view = k["_im"].convert("RGB")
        view.thumbnail((1024, 1024))
        view.save(run / f"imgs/view/{iid}.jpg", quality=82)
        images.append({"id": iid, "orig": f"imgs/orig/{iid}.{ext}", "view": f"imgs/view/{iid}.jpg",
                       "img_url": k["img_url"], "source_page": k["source_page"], "width": k["width"],
                       "height": k["height"], "phash": str(k["_ph"]), "alt": k.get("alt", ""),
                       "context": k.get("context", "")})

    (run / "harvest.json").write_text(json.dumps(
        {"pages": pages, "images": images, "rejected": dict(reject)}, indent=2, ensure_ascii=False))
    print(f"\n{len(images)} images kept from {len(cands)} candidates; rejected {dict(reject)}")
    print(f"blocked pages: {[p['url'] for p in pages if p['blocked']]}")


if __name__ == "__main__":
    main()
