#!/usr/bin/env python3
"""Top-10 organic URLs for a keyword from Bing India (free, no API key).

Usage: serp_top10.py "<keyword>" <out/urls.json> [--n 10] [--exclude domain ...]
       serp_top10.py "<keyword>" <out/urls.json> --manual URL [URL ...]

--manual writes the same urls.json format from a given list (DataForSEO results
or URLs the user pasted), so later phases don't care where the list came from.

Exits 2 if Bing returns too few relevant results (it sometimes serves a generic
result set for repeat queries, see memory free-keyword-research-methods). The
skill then falls back to DataForSEO (paid, ask first) or a user-supplied list.
"""
import argparse
import base64
import json
import re
import sys
from pathlib import Path
from urllib.parse import parse_qs, urlparse

import requests
from bs4 import BeautifulSoup

UA = ("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/130.0 Safari/537.36")
SKIP_DOMAINS = {"luxurahabitat.com", "youtube.com", "facebook.com", "instagram.com",
                "twitter.com", "x.com", "linkedin.com", "pinterest.com", "quora.com"}


def unwrap_bing(href):
    """Bing wraps results as bing.com/ck/a?...&u=a1<base64url>."""
    if "bing.com/ck/a" not in href:
        return href
    u = parse_qs(urlparse(href).query).get("u", [""])[0]
    if u.startswith("a1"):
        b = u[2:]
        try:
            return base64.urlsafe_b64decode(b + "=" * (-len(b) % 4)).decode()
        except Exception:
            pass
    return href


def domain(url):
    return urlparse(url).netloc.lower().removeprefix("www.")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("keyword")
    ap.add_argument("out")
    ap.add_argument("--n", type=int, default=10)
    ap.add_argument("--exclude", nargs="*", default=[])
    ap.add_argument("--manual", nargs="+")
    ap.add_argument("--source", default="manual")
    a = ap.parse_args()

    if a.manual:
        urls = [u for u in dict.fromkeys(a.manual) if "luxurahabitat.com" not in u][:a.n]
        results = [{"rank": i + 1, "url": u, "domain": domain(u), "title": "", "relevant": True}
                   for i, u in enumerate(urls)]
        Path(a.out).parent.mkdir(parents=True, exist_ok=True)
        Path(a.out).write_text(json.dumps({"keyword": a.keyword, "source": a.source, "results": results}, indent=2))
        print(f"wrote {len(results)} URLs ({a.source})")
        return

    skip = SKIP_DOMAINS | {d.lower() for d in a.exclude}
    tokens = [t for t in re.findall(r"\w+", a.keyword.lower()) if len(t) > 3]
    s = requests.Session()
    s.headers.update({"User-Agent": UA, "Accept-Language": "en-IN,en;q=0.9"})

    results, seen = [], set()
    for first in (1, 11, 21):
        r = s.get("https://www.bing.com/search",
                  params={"q": a.keyword, "cc": "IN", "setlang": "en-IN", "first": first}, timeout=20)
        soup = BeautifulSoup(r.text, "html.parser")
        for li in soup.select("li.b_algo"):
            link = li.select_one("h2 a")
            if not link or not link.get("href"):
                continue
            url = unwrap_bing(link["href"])
            d = domain(url)
            if not url.startswith("http") or url in seen or any(d == x or d.endswith("." + x) for x in skip):
                continue
            seen.add(url)
            title = link.get_text(" ", strip=True)
            relevant = all(t in (title + " " + url).lower() for t in tokens[:2])
            results.append({"rank": len(results) + 1, "url": url, "domain": d,
                            "title": title, "relevant": relevant})
        if len(results) >= a.n:
            break

    results = results[:a.n]
    n_rel = sum(r["relevant"] for r in results)
    Path(a.out).parent.mkdir(parents=True, exist_ok=True)
    Path(a.out).write_text(json.dumps({"keyword": a.keyword, "source": "bing-in", "results": results},
                                      indent=2, ensure_ascii=False))
    for r in results:
        print(f"{r['rank']:>2}. {'✓' if r['relevant'] else '?'} {r['domain']:<28} {r['title'][:70]}")
    if len(results) < 5 or n_rel < 3:
        print(f"\nOnly {n_rel}/{len(results)} results mention the keyword; Bing likely served a generic "
              "set. Fall back to DataForSEO (ask user) or a manual URL list.", file=sys.stderr)
        sys.exit(2)


if __name__ == "__main__":
    main()
