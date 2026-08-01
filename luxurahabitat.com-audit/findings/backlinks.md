# Backlink Profile Audit — luxurahabitat.com

## Data Sources Checked

`claude-seo run backlinks_auth.py --check --json` → **Tier 0** (Common Crawl + local verification crawler only). No `MOZ_API_KEY` or `BING_WEBMASTER_API_KEY` configured, so Moz metrics/anchors/pages and Bing inbound links were unavailable this run.

- `claude-seo run commoncrawl_graph.py luxurahabitat.com --json` → `in_crawl: false`, `in_rankings: false`, `pagerank: null`. Domain not present in the current release (`cc-main-2026-jan-feb-mar`). Per validator guidance, this must **not** be read as "low authority" — it means Common Crawl has not sampled/discovered this host yet, consistent with a young site. CC web graphs are quarterly (source: https://commoncrawl.org/web-graphs).
- No known/candidate backlink list was supplied for this audit, so `verify_backlinks.py` (the local verification crawler) had nothing to check against.
- Moz, Bing Webmaster, DataForSEO: not available (no credentials / no MCP tools this session — see `dataforseo.md` for the DataForSEO gap).

Pre-delivery validation run via `validate_backlink_report.py`: **PASS** (1 info flag, correctly acknowledging the CC "not found" interpretation above; 0 errors, 0 warnings).

## Score

**INSUFFICIENT DATA — not scored numerically.**

The Backlink Health Score methodology weights 7 factors (referring domains, domain quality distribution, anchor text naturalness, toxic link ratio, link velocity, follow/nofollow ratio, geographic relevance). At Tier 0, with the domain absent from Common Crawl and no Moz/Bing/DataForSEO access, **0 of 7 factors have any data source**. Producing a numeric 0-100 here would be fabricated and misleading, per the scoring-sufficiency rule (numeric score requires ≥4/7 factors with real data). Do not average an assumed score into the overall site audit total — treat this category as unscored/pending rather than as a 0 (a 0 would incorrectly imply a measured, poor backlink profile rather than an unmeasured one).

## What Works

- No signal from any checked source suggests a toxic, penalized, or spam-laden link profile — but this is inconclusive (absence of data, not a verified clean bill of health), not a confirmed positive.
- Site foundation is link-acquisition-ready: per the sitemap audit (`sitemap.md`), all 62 URLs are indexable, well-structured, and free of blocking issues, meaning any future inbound links will point at crawlable, correctly-indexed pages rather than pages with noindex/redirect problems.
- Content depth already exists to support real link-building outreach: dedicated area pages (Devanahalli, Hennur, Yelahanka, Kanakapura Road), 19 individual project pages, and ~28 blog posts including market-trend and comparison content — this is exactly the kind of material directories, developers, and local press look for before linking, so outreach can start immediately rather than waiting on content production.

## Findings

| Title | Severity | Description | Recommendation |
|---|---|---|---|
| No Moz or Bing Webmaster credentials configured (Tier 0 only) | Medium | `backlinks_auth.py --check` confirms only Common Crawl (domain graph) and the local verify crawler are active. Both free upgrade paths (Moz API key, Bing Webmaster site registration) are unconfigured, so DA/PA, spam score, referring-domain counts, anchor text distribution, and Bing inbound-link data are all unavailable — this is the single biggest reason the category is unscored. | Sign up for a free Moz API key (2,500 rows/month, https://moz.com/products/api) and register the domain in Bing Webmaster Tools (free). Both are no-cost and would immediately unlock 5 of the 7 scoring factors. Re-run this audit once configured. |
| Domain not yet present in Common Crawl's web graph | Info | `commoncrawl_graph.py` returned `in_crawl: false`, `in_rankings: false`, `pagerank: null` for the `cc-main-2026-jan-feb-mar` release. Per validator guidance this reflects the site not yet being discovered/sampled by CC's crawl — consistent with a young site with recent commits (e.g. `85c3d40`, `d131082` in the git log) — and must not be read as a low-authority or penalty signal. | Re-check after the next quarterly CC release. In parallel, submit the sitemap to Google Search Console and Bing Webmaster Tools to accelerate discovery/crawling generally. |
| Referring domain count, anchor text, and toxic-link ratio: no data source available | High | No source (Moz, Bing, Common Crawl, or the local verify crawler) returned any referring domain, anchor text, or spam-score data for luxurahabitat.com. Combined with the CC "not found" result, the most honest reading is that this is a genuinely new site with an effectively empty or near-empty backlink profile, not a site with a hidden/unmeasured but healthy profile. No candidate backlink list was provided to run through the verification crawler, so nothing could be independently confirmed live either. | Treat this as "profile needs to be built," not "profile needs to be cleaned." Prioritize the link-building gaps below over any cleanup/disavow work, since disavowing is not actionable without any identified toxic links in the first place. |
| Link velocity and follow/nofollow ratio: not assessable from free sources | Info | Per the scoring methodology, link velocity trend data is DataForSEO-only (not available this session) and follow/nofollow ratio depends on Bing link details or DataForSEO, neither of which returned data. | No action possible now; revisit once Bing Webmaster is registered or DataForSEO access is enabled. |
| Link-building opportunity gaps: real estate directories, local Bengaluru listings, developer co-marketing, PR | Medium (opportunity) | The site has strong topical depth for its 4 covered micro-markets (Devanahalli, Hennur, Yelahanka, Kanakapura Road) and 19 named developer projects (Assetz, Sattva, Century, Vajram, Brigade, Concorde, TVS Emerald, KNS) but currently shows no discoverable referring domains. Concrete gaps: (1) **Real estate directories/portals** — 99acres, MagicBricks, Housing.com, NoBroker agency/broker profile listings; (2) **Local Bengaluru business listings** — Google Business Profile (verify separately it's claimed/complete), Justdial, Sulekha, IndiaMART agency category; (3) **Developer co-marketing** — the site already publishes in-depth, RERA/price/layout content on named developer projects, making "authorized channel partner" or "featured on" reciprocal links from those developers' own project pages a low-effort, highly relevant ask; (4) **Local PR / property press** — Bengaluru-focused property and business press (e.g. Economic Times Realty, Moneycontrol Real Estate, Times Property, local editions) for market-commentary bylines, using the already-published market-trend posts (`devanahalli-real-estate-market-trends-2026`, `kanakapura-road-real-estate-market-trends-2026`, `hennur-thanisandra-real-estate-market-2026`) as ready-made source material; (5) **RERA/industry association directories** relevant to Karnataka real estate. | Prioritize dual-purpose placements first — agency profiles on 99acres/MagicBricks/Housing.com and Google Business Profile/Justdial/Sulekha both earn a referring domain and drive direct local leads. Follow with developer co-marketing outreach (highest topical relevance, lowest outreach friction given existing content) and then local PR pitches built on the existing market-trend blog content. Re-run this audit after initial placements to begin measuring actual referring-domain growth. |

## Confidence Note

All findings above are based on **Tier 0 sources only** (Common Crawl domain graph, confidence 0.50; local verify crawler, not exercised — no candidate links supplied). No Moz (0.85), Bing (0.70), or DataForSEO (1.00) data was available. This report should be treated as a starting-point gap analysis, not a measured baseline — re-run once Moz/Bing credentials are added to get real referring-domain, anchor-text, and spam-score numbers.

## Related Audits

- For crawlability/indexability context supporting future link equity flow-through, see `sitemap.md`.
- For on-page/E-E-A-T factors that make content link-worthy, recommend `/seo content <url>` (not duplicated here).
- For technical crawlability issues, recommend `/seo technical <url>` (not duplicated here).
- DataForSEO enrichment (would unlock referring domains, domain quality, anchor naturalness, toxic ratio, velocity, geo data at confidence 1.00) is tracked separately in `dataforseo.md` — currently unavailable.
