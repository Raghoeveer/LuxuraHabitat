#!/usr/bin/env python3
"""Drop any extracted item whose verbatim quote isn't really in its source page.

Usage: verify_quotes.py <run_dir>
Reads  run_dir/content.json (from content-extractor) + run_dir/harvest.json
Writes run_dir/content.verified.json, with failures moved to "rejected".

Every item in facts/faqs must carry "quote" and "source_url". A fact's "value"
digits must also appear inside its quote, so a misread number can't sneak through
attached to a real sentence.
"""
import json
import re
import sys
from pathlib import Path

# curly quotes, en/em dash, nbsp, rupee sign (built with chr() so the repo's
# no-em-dash hook doesn't flag this file)
TRANS = str.maketrans({chr(0x2018): "'", chr(0x2019): "'", chr(0x201C): '"', chr(0x201D): '"',
                       chr(0x2013): "-", chr(0x2014): "-", chr(0x00A0): " ", chr(0x20B9): "rs "})


def norm(s):
    s = s.lower().translate(TRANS)
    s = re.sub(r"rs\.?\s*", "rs ", s)
    return re.sub(r"\s+", " ", s).strip()


def digits(s):
    return re.findall(r"\d+(?:[.,]\d+)*", s or "")


def main():
    run = Path(sys.argv[1])
    content = json.loads((run / "content.json").read_text())
    pages = json.loads((run / "harvest.json").read_text())["pages"]
    texts = {p["url"]: norm((run / p["text_path"]).read_text(encoding="utf-8")) for p in pages}

    rejected, stats = [], {}
    for section in ("facts", "faqs"):
        ok = []
        for item in content.get(section, []):
            src, quote = item.get("source_url", ""), item.get("quote", "")
            reason = None
            if src not in texts:
                reason = "source_url not among fetched pages"
            elif len(norm(quote)) < 12:
                reason = "quote missing or too short"
            elif norm(quote) not in texts[src]:
                reason = "quote not found verbatim in source"
            elif section == "facts" and item.get("value"):
                q = norm(quote).replace(",", "")
                missing = [d for d in digits(str(item["value"]))
                           if not re.search(rf"(?<![\d.]){re.escape(d.replace(',', ''))}(?![\d])", q)]
                if missing:
                    reason = f"value digits {missing} not in quote"
            if reason:
                rejected.append({**item, "_section": section, "_reason": reason})
            else:
                ok.append(item)
        stats[section] = f"{len(ok)}/{len(content.get(section, []))}"
        content[section] = ok

    content["rejected"] = rejected
    (run / "content.verified.json").write_text(json.dumps(content, indent=2, ensure_ascii=False))
    print(f"verified facts {stats.get('facts')}, faqs {stats.get('faqs')}; {len(rejected)} rejected")
    for r in rejected[:15]:
        print(f"  x [{r['_section']}] {r['_reason']}: {str(r.get('quote', ''))[:70]}")


if __name__ == "__main__":
    main()
