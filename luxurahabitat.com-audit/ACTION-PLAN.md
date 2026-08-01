# Action Plan — luxurahabitat.com

Derived from `FULL-AUDIT-REPORT.md`. Phased by urgency and dependency, not just severity — some Critical items are cheap and immediate, others need a decision (e.g. confirming a RERA number) before they can be fixed.

---

## Phase 1: Critical Fixes (This Week)

| # | Item | Why it's first | Depends on | How you'll know it's fixed |
|---|---|---|---|---|
| 1 | **Resolve the Assetz Palmscape RERA contradiction** — sidebar shows a specific number on a page whose body says "pre-launch, TBD." | Direct trust/compliance risk on the exact page type (price+RERA) where accuracy matters most; already flagged in project memory as a recurring pattern. | **User must confirm the real status** — do not guess. Once confirmed, apply site-wide search for the same sidebar-vs-body pattern on other pre-launch projects. | Sidebar and body agree; a build-time check (even a simple grep script comparing sidebar RERA fields to the linked project page's RERA field) exists to prevent recurrence. |
| 2 | **Fix RERA/NAP footer inconsistency** — Yelahanka drops the TN registration; Devanahalli/Hennur/Kanakapura Road area pages have no NAP footer at all. | Same class of trust/compliance risk as #1, affecting the highest-intent local landing pages. | **User must confirm which RERA line(s) legitimately apply sitewide** — do not guess between the two. | All templates show identical, confirmed RERA/NAP data. |
| 3 | **Add real listing schema to 3 project pages** (sattva-la-vita, sattva-lumina, sattva-aeropolis) that currently have only defunct FAQPage schema. | These are commercially critical pages deriving zero structured-data value today. | None — pattern already proven on `tvs-emerald-altura` (see `findings/schema.md` for ready-to-merge JSON-LD). | Google Rich Results Test passes; pages show `RealEstateListing`/`Offer` in structured-data testing tools. |
| 4 | **Fix invalid Product price format** on orchid-salisbury (`"1.03 Crore"` → `"10300000"` numeric). | Currently fails Google's Rich Results Test outright. | None. | Rich Results Test passes for this page. |
| 5 | **Grant Google API access** — add the service account as Owner in GSC, enable the Search Console API in GCP, add the service account as Viewer in GA4. | Unblocks all future measurement of real indexation/traffic/query data; a 5-10 minute task. | User has console access (already demonstrated in this session). | Re-run `/seo google gsc` and `/seo google ga4` successfully. |
| 6 | **Compress the worst-offending images** — `about_us_advisor.png` (1.26MB), `devanahalli_market_trends.png` (1.07MB), `devanahalli-hero.jpg` (1.0MB) — convert to WebP, resize to actual render dimensions. | Directly fixes the two worst LCP scores (13.9s, 15.3s) on the site's two highest-volume templates (~70% of pages). | None. | Re-run PageSpeed Insights; LCP on blog/area templates drops from 13-15s toward sub-3s. |

---

## Phase 2: High-Impact Improvements (Weeks 2-3)

| # | Item | Effort | Impact |
|---|---|---|---|
| 7 | Add `FAQPage` schema to the 4 area hub pages using their existing visible FAQ content. | Low (1-2 hrs, mechanical) | High — cheap PAA/AI-citation win on the highest-intent local pages. |
| 8 | Fix the mobile sidebar-widget overflow bug on the 11 remaining project pages (copy the one-line CSS fix already proven on 5 pages). | Trivial | High — visible, embarrassing bug currently live on most project pages. |
| 9 | Trim meta descriptions sitewide to ~120-155 characters. | Low (template-level) | Medium-High — stops SERP truncation/rewriting across nearly every page. |
| 10 | Self-host Google Fonts (Inter, Playfair Display) instead of the render-blocking `fonts.googleapis.com` request. | Low-Medium | High — ~750ms saved on every single page, no downside. |
| 11 | Defer the Zendesk chat widget until user interaction; move GTM off the critical path. | Medium | High — largest lever for TBT/INP risk, worst on project pages (572ms + 210ms main-thread). |
| 12 | Add `BreadcrumbList` to the 12 project pages missing it, and basic schema to the hub pages (`/projects/`, `/blog/`, `/contact/`, `/testimonials/`) that have none. | Medium | Medium — consistency and crawl-understanding improvement. |
| 13 | Fix empty placeholder `url`/`logo` fields and relative image paths in 4 project pages' schema. | Low | Medium — currently invalid/incomplete structured data. |
| 14 | Add basic security headers (`X-Content-Type-Options`, `X-Frame-Options`, `Referrer-Policy`, `Permissions-Policy`) via a Netlify `_headers` file; delete the inert `.htaccess`. | Low | Medium — hygiene + removes a misleading fragile file. |
| 15 | Wrap blog post data tables in a scrollable container to fix mobile horizontal-scroll overflow (~19 posts affected). | Low-Medium | Medium — real UX bug affecting a fifth of the site. |
| 16 | Standardize the byline/authorship mismatch — pick "Narayanan Rajesh, Principal Advisor" consistently across visible byline, footer card, and JSON-LD (30 blog posts). | Low (find/replace) | Medium — E-E-A-T consistency. |

---

## Phase 3: Content & Authority (Month 2)

| # | Item | Effort | Impact |
|---|---|---|---|
| 17 | Expand thin blog posts (currently 650-1,220 words) toward genuine 1,500+ word depth with unique analysis, or reclassify as a lighter "project fact sheet" content type with its own floor. | High | High — addresses the core content-quality gap; also stagger `dateModified` as facts actually change. |
| 18 | Reframe blog H2/H3 headings as questions where natural, and add 4-6 FAQ Q&A pairs per post with matching schema. | Medium-High (30 posts, can phase by traffic) | High — directly improves AI Overview/ChatGPT citation odds. |
| 19 | Broaden area-hub content to cite the wider corridor market (5-8 projects with public price data), not just Luxura's own 4 represented projects. | Medium | Medium-High — addresses the "biased inventory vs. neutral research" gap that SXO flagged as blocking awareness-stage trust. |
| 20 | Add a floor-plan/master-plan image block and a brochure/price-list CTA to "price + RERA" posts, closing the gap with the Hybrid Service+Content format the SERP actually rewards for these queries. | Medium | Medium — money-page format upgrade. |
| 21 | Confirm/claim Google Business Profile as a Service Area Business under "Real Estate Consultant" or "Real Estate Agent" category; add a Maps/review widget to `/contact/` and the homepage. | Medium (external, one-time) | High — near-prerequisite for any Maps-surface visibility for an SAB. |
| 22 | Build NAP-identical listings on 99acres, MagicBricks, Housing.com, JustDial, Sulekha; link at least GBP from the site footer. | Medium (external) | Medium-High — seeds both local citations and the currently-empty backlink profile. |
| 23 | Upgrade `LocalBusiness` → `RealEstateAgent` schema type; add typed `Place`/`GeoCircle` for `areaServed` (ready-to-merge JSON-LD already in `findings/maps.md`). | Low | Medium — entity disambiguation for Google/AI. |
| 24 | Build dedicated `/areas/sarjapur-road/` and `/areas/whitefield/` pages, or scale back marketing claims to match actual page coverage. | Medium-High | Medium — currently marketed corridors have no page to rank/convert on. |

---

## Phase 4: Monitoring & Iteration (Ongoing)

| # | Item |
|---|---|
| 25 | Re-run `/seo google gsc` and `/seo google ga4` monthly once access is granted — watch real indexation status and query "quick wins" (position 4-10, high impressions). |
| 26 | Restart Claude Code and re-run the DataForSEO enrichment (SERP positions, keyword volume, backlink summary, AI-visibility check) — $1 trial budget, prioritize SERP checks first. |
| 27 | Re-check CrUX field data monthly (currently empty — insufficient Chrome traffic; will resolve organically as the site gains visitors). |
| 28 | Sign up for a free Moz API key and register in Bing Webmaster Tools to unlock 5 of 7 backlink-scoring factors at no cost. |
| 29 | Re-audit the sitemap once area-page count approaches 25-30, to confirm each still clears the 60%+ unique-content bar (currently only 4 pages — well under the 30-page warning threshold). |
| 30 | Track review acquisition once GBP is confirmed — review recency/velocity matters; a profile with zero or stale reviews underperforms even a modest, active competitor. |

---

## Dependency Notes

- **Items 1 and 2 need your input before they can be executed** — I will not guess between conflicting RERA/NAP numbers. Tell me the correct values and I'll propagate them everywhere and add a template-level check.
- **Item 5 and Phase 4 item 26 are prerequisites for future measurement**, not fixes to the site itself — worth doing early so subsequent phases can be validated with real data instead of lab estimates.
- **Items 6, 10, 11 (performance)** compound — fixing images first, then fonts, then third-party scripts, in that order, gives the clearest before/after signal per fix.
