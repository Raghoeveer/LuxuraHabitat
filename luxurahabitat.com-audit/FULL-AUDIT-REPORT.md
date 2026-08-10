# Full SEO Audit — luxurahabitat.com

**Date:** 2026-08-01
**Business type:** Real Estate Advisory / Consultancy — Hybrid, leaning Service-Area Business (SAB), Bengaluru, India (Devanahalli, Hennur, Yelahanka, Kanakapura Road corridors)
**Pages audited:** 62 (full sitemap coverage: homepage, about, 4 area guides, 19 project pages, 30 blog posts, contact, developers, testimonials, privacy, terms)
**Method:** Live crawl + direct repo read (`/Users/raghuveernr/Desktop/luxuraHabitat`), 13 specialist subagents, Google API Tier 2 (fully live as of 2026-08-07 — GSC/GA4 access was granted after the initial audit), DataForSEO (unavailable this session — see note)

---

## Executive Summary

### SEO Health Score: 63 / 100

Weighted across the 7 standard categories (methodology below). This is a **technically sound, well-structured site held back by content-scale shortcuts and unverified trust claims** — the kind of profile typical of a fast-launched real-estate site that prioritized breadth (19 projects, 30 posts, 4 area guides in ~3 weeks) over per-page depth and QA.

| Category | Score | Weight | Weighted |
|---|---|---|---|
| Technical SEO | 78/100 | 22% | 17.2 |
| Content Quality | 58/100 | 23% | 13.3 |
| On-Page SEO | 65/100 | 20% | 13.0 |
| Schema / Structured Data | 60/100 | 10% | 6.0 |
| Performance (CWV) | 58/100 | 10% | 5.8 |
| AI Search Readiness (GEO) | 61/100 | 10% | 6.1 |
| Images | 35/100 | 5% | 1.75 |
| **Total** | | | **63.15 ≈ 63** |

*On-Page SEO and Images don't have dedicated subagents in this run; both scores are derived from evidence across the Technical, Content, Schema, and Performance findings (see those sections). Re-run `/seo images` for a dedicated image-SEO pass if you want a directly-measured Images score.*

**Supplementary scores (not part of the weighted total, but important for this business type):**
| Category | Score | Note |
|---|---|---|
| Sitemap | 90/100 | Excellent — near-flawless |
| Visual / Mobile Rendering | 64/100 | Known mobile bug still unfixed on most pages |
| SXO (Search Experience) | 58/100 | Separate diagnostic metric, not averaged into Health Score |
| Local SEO | 40/100 | Critical for an SAB business — no GBP signals detected |
| Maps Intelligence | 32/100 | Overlaps with Local; confirms GBP gap independently |
| Google API (GSC/GA4) | 70/100 | **Now fully live** (updated 2026-08-07) — access granted, real data flowing; score reflects an early-stage new site, not a blocker |
| Backlinks | Unscored | Insufficient data (new site, no Moz/Bing/DataForSEO access) |
| DataForSEO enrichment | Unscored | MCP tools unavailable this session (needs Claude Code restart) |

### Top 5 Critical Issues

1. **Self-contradictory RERA number on a live "price + RERA" blog post.** `/blog/assetz-palmscape-devanahalli-price-layout-rera/` states in-body "Pre-launch — confirm RERA at launch," but its own sidebar displays a specific RERA number that appears to belong to a different project (KNS Sampada's prefix). Flagged independently by both the Content and SXO agents. This is a direct trust/accuracy failure on a site built around "zero-litigation, verified" positioning — exactly the scenario flagged before in project memory as needing a placeholder + user confirmation rather than a guess.
2. **Three project pages have zero real listing schema.** `/projects/sattva-la-vita/`, `/projects/sattva-lumina/`, `/projects/sattva-aeropolis/` carry only `FAQPage` (which produces no Google rich result anymore) — no `RealEstateListing`/`Offer`/RERA data as structured data at all.
3. **Invalid price format breaks Rich Results eligibility.** `/projects/orchid-salisbury/` has `Product.Offer.price` values like `"1.03 Crore"` (a string) instead of a plain number — will fail Google's Rich Results Test outright.
4. **No verifiable Google Business Profile signals anywhere.** For a Service-Area Business with no storefront, GBP is close to a prerequisite for any Maps-surface visibility. No Maps embed, review widget, or Place ID reference exists for the business itself anywhere on-site (confirmed independently by both Local and Maps agents; OSM/Nominatim also has no POI record).
5. **Catastrophic LCP (13-15 seconds) on the site's two highest-volume templates.** Blog posts and area pages — together ~70% of the 62 pages — score Lighthouse LCP of 13.9s and 15.3s respectively, driven by unoptimized hero/content images (1.0-1.26MB PNGs/JPGs with 80-99% waste, no WebP/AVIF).

*~~6. Google Search Console and GA4 data are currently inaccessible~~ — **RESOLVED 2026-08-07.** Access granted; see the Google API section below for real data now flowing.*

### Top 5 Quick Wins

1. **Add FAQPage schema to the 4 area hub pages.** They already have genuinely good, hand-written FAQ content (visible on-page) — it's just not marked up, unlike 19 other pages that already use this pattern correctly. ~1-2 hours, mechanical.
2. **Fix the 11-page mobile sidebar overflow bug.** A one-line CSS fix (`@media (max-width:1024px){ .sidebar-widget{display:none} }`) already exists correctly on 5 of 16 project pages — just needs copying to the other 11.
3. **Trim meta descriptions sitewide** (currently 161-262 chars vs. the ~155-160 char SERP budget) — a template-level tweak, not a per-page rewrite.
4. **Fix the Assetz Palmscape RERA sidebar contradiction** (Critical Issue #1) — a single-field edit once the correct number (or "pending") is confirmed.
5. ~~Grant the service account GSC/GA4 access~~ — **done 2026-08-07.**

---

## 1. Technical SEO — 78/100

**What works:** Valid, complete sitemap; correct self-referencing canonicals everywhere; no accidental noindex; unique titles/descriptions across all 62 pages; rich varied JSON-LD; clean single-hop redirects with no chains; fully static/pre-rendered HTML (no JS-rendering risk for crawlers); HSTS present via Netlify.

**Findings:**
- **Medium** — `.htaccess` is dead code on Netlify (doesn't actually execute); currently harmless by luck, but fragile. Delete it or replace with a real `_redirects`/`netlify.toml`.
- **Medium** — No security headers beyond HSTS (missing `X-Content-Type-Options`, `X-Frame-Options`, CSP, `Referrer-Policy`, `Permissions-Policy`); HSTS itself lacks `includeSubDomains`/`preload`.
- **Medium** — Meta descriptions systematically too long (161-262 chars) across nearly every area/project/blog page — a template-wide issue, not isolated outliers.
- **Low** — Unbacked `AggregateRating` schema on 2 project pages with no matching visible reviews.
- **Low/Info** — No IndexNow integration; two `.html`-suffixed sitemap URLs (privacy/terms) break the otherwise-consistent trailing-slash convention; no hreflang (expected — single-market site).

Full detail: `findings/technical.md`

---

## 2. Content Quality — 58/100

**E-E-A-T breakdown:** Experience 55/100, Expertise 60/100, Authoritativeness 45/100, Trustworthiness 60/100. **AI Citation Readiness: 50/100.**

**What works:** Consistent NAP/RERA disclaimers; solid `Person` schema for the named advisor; area guides and project pages comfortably clear word-count floors with genuine local detail; the best comparison post (`vajram-vivera-vs-vajram-chrysanthemum`) is genuinely differentiated, not filler.

**Findings:**
- **Critical** — Self-contradictory RERA claim on `assetz-palmscape-devanahalli-price-layout-rera` (see Executive Summary #1).
- **High** — All ~30 blog posts are thin (650-1,220 words vs. a 1,500-word floor), bulk-published in a 17-day window with `dateModified` frozen at `datePublished` — reads as templated, scaled content rather than individually researched.
- **Medium** — Blog byline says "By the Luxura Habitat Team" while every post's JSON-LD attributes single-author expertise to "Narayanan Rajesh" — a structured-data/visible-content mismatch that muddies the E-E-A-T signal.
- **Medium** — Zero of 30 blog posts have FAQ schema, despite being naturally question-shaped content (vs. 15/18 project pages that do).
- **Low** — Dense readability (Flesch ~38-40, "difficult/college level") for a consumer audience that includes first-time buyers and NRIs.
- **Low** — No external authoritativeness signals anywhere sampled (no press mentions, no linked reviews, no case studies).

Full detail: `findings/content.md`

---

## 3. On-Page SEO — 65/100 (derived)

No dedicated subagent ran this pass standalone; this score synthesizes on-page-specific evidence from Technical, Content, and Local findings.

**What works:** Unique titles/meta descriptions across all pages; solid H2/H3 heading structure; internal linking forms a coherent topical cluster (area hub → comparison post → price/RERA post → project page) that mirrors real user research journeys.

**Findings:**
- **Medium** — Meta descriptions too long sitewide (see Technical #3).
- **High** — RERA/NAP footer block is inconsistent across templates: `areas/yelahanka/` drops the Tamil Nadu registration; `areas/devanahalli/`, `areas/hennur/`, `areas/kanakapura-road/` — the highest-intent local pages — have **no NAP footer at all**.
- **Medium** — Only 5.4% of blog H2/H3 headings are phrased as questions, limiting both AI-citation and featured-snippet capture.
- **Low** — Two heavily-marketed micro-markets (Sarjapur Road, Whitefield) appear in hero copy and schema `areaServed` but have no dedicated `/areas/` page to actually rank on.

---

## 4. Schema / Structured Data — 60/100

**What works:** The blog template (30/30 posts) is genuinely excellent — consistent `BlogPosting`+`BreadcrumbList` with proper dates, author, publisher/logo. `tvs-emerald-altura` is the best-built project page (numeric `AggregateOffer`, RERA as structured `PropertyValue`) and should be the reference template.

**Findings:**
- **Critical** — 3 project pages with zero listing schema (see Executive Summary #2).
- **Critical** — Invalid non-numeric price format on orchid-salisbury (see Executive Summary #3).
- **High** — Empty placeholder `"url": ""`/`"logo": ""` and relative (non-absolute) image paths across 4 project pages.
- **High** — `BreadcrumbList` missing on 12 of 18 project pages and on all hub pages (`/projects/`, `/blog/`, `/contact/`, `/testimonials/`).
- **Medium** — Area pages lack `LocalBusiness`/`Place` schema.
- **Medium** — About page `Person` schema `@id`/`url` mismatches its own canonical URL.
- **Low** — Homepage `LocalBusiness` missing `image`, `geo`, `priceRange`, `aggregateRating`.
- **Info** — FAQPage schema present on ~13 project pages produces no ongoing Google rich result (retired May 2026) — harmless to leave, but don't invest further effort adding it elsewhere for *search* reasons (area-page FAQ schema is still worth adding for AI-citation reasons — see GEO section).

Full detail (includes ready-to-merge JSON-LD fixes): `findings/schema.md`

---

## 5. Performance (Core Web Vitals) — 58/100

Lab data (Lighthouse via PSI). Field data (CrUX) is not yet available — site has insufficient Chrome traffic volume, expected for a newer site, not a defect.

| Page | Performance | LCP | CLS | TBT |
|---|---|---|---|---|
| Home | 77 | 4.14s — Poor | 0.031 — Good | 141ms |
| Area (Devanahalli) | 62 | 13.87s — **Poor** | 0.000 — Good | 21ms |
| Blog post | 61 | 15.33s — **Poor** | 0.000 — Good | 36ms |
| Project (mobile) | 82 | 3.05s — Needs Improvement | 0.102 — Needs Improvement | 127ms |
| Project (desktop) | 87 | 0.82s — Good | 0.003 — Good | 224ms |

**What works:** TTFB excellent everywhere (2-33ms, Netlify edge CDN is not a bottleneck); Best Practices/SEO Lighthouse categories score 100 on every page; site's own JS is light — third-party scripts are the bottleneck, not custom code.

**Findings:**
- **Critical** — LCP catastrophically poor on blog/area templates from unoptimized images (829KB-1.26MB wasted per image, 83-99.8% waste, no WebP/AVIF).
- **High** — Google Tag Manager + Zendesk chat widget consume 105-572ms of main-thread time, worst on project pages (matches the field-data agent's 1,080ms desktop TBT finding).
- **High** — Render-blocking Google Fonts stylesheet costs ~750ms on every single page.
- **Medium** — Oversized builder/partner logo images (120-155KB each, rendering at ~100×48px) bloat the homepage and repeat sitewide via the header logo.
- **Medium** — CLS "Needs Improvement" on project templates from unsized gallery/plan images.
- **Info** — 2 of 6 sampled project pages (sattva-aeropolis, sattva-forest-ridge) errored on mobile Lighthouse runs — worth re-testing to rule out a genuine mobile timeout risk from their unusually heavy image galleries.

Full detail: `findings/performance.md`

---

## 6. Images — 35/100 (derived)

No dedicated subagent ran this pass; derived from Performance and GEO evidence.

**What works:** Alt text present on all 241 images sampled (blog section) — no accessibility/citability gap there.

**Findings:**
- **Critical** — Hero/content images running 1.0-1.26MB with 83-99.8% waste (unresized, no WebP/AVIF) — the single highest-impact performance fix available (see Performance #1).
- **Medium** — Builder/partner logos and header logo similarly oversized relative to display size.
- **Medium** — Unsized `<img>` elements on project template gallery/plan images causing layout shift.

*Recommend running `/seo images` for a dedicated pass (responsive `srcset`, format conversion plan, file-level optimization) once the highest-priority pages are identified.*

---

## 7. AI Search Readiness (GEO) — 61/100

| Dimension | Weight | Score |
|---|---|---|
| Citability | 25% | 55/100 |
| Structural Readability | 20% | 65/100 |
| Multi-Modal Content | 15% | 40/100 |
| Authority & Brand Signals | 20% | 50/100 |
| Technical Accessibility | 20% | 90/100 |

**What works:** `robots.txt` is maximally permissive for all AI crawlers (GPTBot, ClaudeBot, PerplexityBot, etc.); fully static/SSR HTML guarantees content visibility to non-JS-executing crawlers; rich schema.org coverage; 140 Q&A pairs site-wide via project-page FAQPage schema; named credentialed author entity; 23 pages use real data tables (good for Perplexity-style citation).

**Findings:**
- **High** — 3 of 4 area pages have genuinely good hand-written FAQ content with zero FAQPage schema — the single highest-leverage gap (content exists, just not marked up).
- **High** — 30 blog posts (the largest content category) have zero Q&A blocks and only 5.4% question-format headings.
- **Medium** — Yelahanka has no FAQ section at all, unlike the other 3 area pages.
- **Medium** — Answer passages run 16-90 words, shorter than the 134-167 word range that performs best for AI Overview/ChatGPT citation.
- **Medium** — Authorship signal is internally contradictory across all 30 blog posts (same issue as Content #3).
- **Medium** — LocalBusiness schema lacks `streetAddress`-equivalent completeness and has only one `sameAs` link.
- **Low** — Person schema `@id`/`url` points to non-canonical URL; no video/multi-modal content anywhere; `/llms.txt` absent (low-priority, optional signal).

Full detail (includes platform-specific notes for Google AI Overviews, ChatGPT, Perplexity, Bing Copilot): `findings/geo.md`

---

## 8. Search Experience Optimization (SXO) — 58/100 (diagnostic, not part of Health Score)

Reads SERPs backwards to check whether page format matches what actually ranks for the site's target queries.

**What works:** Area hub pages already match the long-form "guide" format dominant in the SERP for "[area] real estate" queries; the "plots vs apartments" post structurally mirrors what independently ranks; the Assetz Palmscape vs. Sattva Aeropolis comparison fills a genuine content gap (no competitor publishes head-to-head content).

**Findings:**
- **Critical** — Same RERA contradiction as Content #1, reframed as the highest-stakes trust fact for the "price + RERA" page type specifically.
- **High** — Area hubs missing FAQPage schema despite matching visible content (same as GEO #1).
- **Medium** — Area hub content depth is narrower than what ranks — covers only Luxura's own 4 represented projects vs. competitor guides citing 5-8 projects corridor-wide.
- **Medium** — "Price + RERA" posts are single-column editorial articles where the SERP rewards a Hybrid Service+Content format (floor plans, brochure CTA, calculator).
- **Low** — Comparison posts bury the "who should buy which" verdict two scrolls down instead of surfacing it above the fold.

**Weakest persona:** NRI Investor (61/100) — Trust score of 8/25, driven directly by the RERA contradiction.

Full detail (user stories, persona scores): `findings/sxo.md`

---

## 9. Local SEO — 40/100

Business type confirmed: Hybrid/SAB (no storefront — correct posture, do not fabricate one).

**What works:** WhatsApp/tel CTAs on every page; named credentialed advisor with `Person` schema; four well-developed area hub pages (the #1 local-organic ranking factor per current guidance); core NAP consistent everywhere the footer block appears; `hasOfferCatalog` clearly itemizes services.

**Findings:**
- **Critical** — No detectable Google Business Profile signals anywhere on-site (see Executive Summary #4).
- **High** — RERA/NAP footer inconsistent across templates (Yelahanka drops the TN registration; 3 area pages have no footer NAP block at all — see On-Page #2).
- **High** — `LocalBusiness` should be the more specific `RealEstateAgent` subtype.
- **Medium** — No `geo`, `openingHoursSpecification`, or `aggregateRating`; 6 detailed testimonials exist but aren't marked up as `Review` schema.
- **Medium** — Zero detectable citation footprint on any real estate directory (99acres, MagicBricks, JustDial, Sulekha, Housing.com).
- **Low** — `areaServed` uses flat strings instead of typed `Place` objects; Sarjapur Road/Whitefield are marketed but have no dedicated area page (same as On-Page #4).

Full detail: `findings/local.md`

---

## 10. Maps Intelligence — 32/100 (Tier 0 — free APIs only)

Independently confirms the Local SEO GBP gap from the geo-data side. All four target corridors geocode cleanly via Nominatim (good foundation for future geo-grid work). Zero cross-platform footprint detected (`sameAs` contains only a WhatsApp link). Competitor density via OSM/Overpass is uneven across corridors (6 near Kanakapura Road, 0-1 elsewhere) — likely reflects OSM under-mapping in India rather than genuinely uncontested markets.

Includes a ready-to-merge `serviceArea`/`GeoCircle` JSON-LD block with real geocoded coordinates for all four corridors. Full detail: `findings/maps.md`

---

## 11. Sitemap — 90/100

Near-flawless: well-formed XML, perfect 1:1 coverage between sitemap and live pages, correct exclusion of the `thank-you/` confirmation page, `lastmod` values genuinely reflect content changes (verified against git history) rather than being bumped blindly. Only Info/Low findings remain (deprecated `priority`/`changefreq` tags, two `.html`-suffixed legal page URLs). Full detail: `findings/sitemap.md`

---

## 12. Visual / Mobile Rendering — 64/100

**What works:** Homepage and most project-page heroes are polished on both breakpoints; sticky mobile bottom CTA bar gives persistent conversion paths; no real horizontal-scroll bug on homepage/area hub.

**Findings:**
- **High** — The known "Request Brochure" sidebar-tab mobile overflow bug remains unfixed on 11 of 16 project pages (only 5 have the `@media (max-width:1024px)` override) — verified visually overlapping hero body text on sattva-forest-ridge.
- **Medium-High** — Data tables in blog posts overflow the mobile viewport (real horizontal scroll, clipped rightmost column) — affects at least 19 posts.
- **Medium** — Area hub pages have no CTA button in the hero at all, on either breakpoint.
- **Low** — Floating chat bubble crowds the sticky bottom CTA bar on project pages (mobile).
- **Info** — Blog CTA sidebar stacks far below the fold on mobile.

Full detail + screenshots: `findings/visual.md`, `screenshots/`

---

## 13. Google API Data (GSC / GA4 / CrUX) — 70/100 (updated 2026-08-07, now fully live)

**Access was granted on 2026-08-07** — the Search Console API is enabled, the service account has Owner access in GSC and Viewer access in GA4, and the Analytics Data API is enabled. All previously-blocked checks now return real data. The score reflects an early-stage new site with real but modest traction, not an access problem.

### Indexation (URL Inspection)
Homepage: **PASS** — "Submitted and indexed", robots ALLOWED, canonical matches, `Breadcrumbs` rich result detected, last crawled 2026-08-04.

### Sitemap status (GSC)
`sitemap.xml` submitted, 0 errors, 0 warnings, 87 URLs submitted (last submitted 2026-07-25). *(87 vs. the 62 in the site's current sitemap — GSC keeps historical submission counts; use the crawl/sitemap audit above for the current live count.)*

### Search performance (last 28 days, `sc-domain:luxurahabitat.com`)
| Metric | Value |
|---|---|
| Clicks | 20 |
| Impressions | 1,738 |
| Average CTR | 1.15% |
| Average position | 56.2 |
| Query-page rows tracked | 862 |

Low CTR and a deep average position are expected for a brand-new site with almost no backlink profile (consistent with the Backlinks section) — most tracked queries are long-tail and not yet ranking on page 1.

**Quick-win queries (position 4-10, ranked by impressions):**
| Impressions | Position | Clicks | Query | Page |
|---|---|---|---|---|
| 113 | 9.3 | 5 | brigade jeevan sandhya | `/blog/brigade-jeevan-sandhya-kanakapura-road-prelaunch-review/` |
| 92 | 6.8 | 2 | brigade jeevan sandhya | `/projects/brigade-jeevan-sandhya/` |
| 43 | 5.8 | 0 | kanakapura nice road | `/blog/kanakapura-road-connectivity-nice-road-metro/` |
| 24 | 7.7 | 0 | brigade jeevan sandhya location | `/projects/brigade-jeevan-sandhya/` |
| 23 | 9.3 | 0 | brigade jeevan sandhya location | `/blog/brigade-jeevan-sandhya-kanakapura-road-prelaunch-review/` |
| 8 | 6.5 | 1 | purva hallmark | `/blog/purva-hallmark-vajarahalli-prelaunch-review/` |
| 8 | 9.4 | 0 | nice road kanakapura | `/blog/kanakapura-road-connectivity-nice-road-metro/` |

The Brigade Jeevan Sandhya pair (blog + project page) is the clear standout — already earning real clicks at position 6.8-9.3. The zero-click, position 5-9 rows (kanakapura nice road, purva hallmark variants) are the cheapest wins: small on-page/title tweaks to nudge them onto page 1 where CTR jumps sharply.

### Organic traffic (GA4, last 28 days, property `547237847`)
| Metric | Value |
|---|---|
| Sessions | 39 |
| Users | 32 |
| Pageviews | 97 |
| Avg. daily sessions | 4.9 |

Top landing pages: homepage (7 sessions), the Brigade Jeevan Sandhya blog post (6) and project page (4), the Kanakapura Road connectivity blog post (3), Century Kindle project page (3). Traffic is small but real and spread across exactly the page types the audit expects to perform (blog + matching project page pairs).

### Core Web Vitals — field data (CrUX)
The site has now crossed CrUX's minimum-traffic threshold for some metrics:
| Metric | p75 | Rating |
|---|---|---|
| CLS | 0.01 | **Good** (90.7% of experiences) |
| TTFB | 1,241ms | Needs Improvement |
| FCP | 1,919ms | Needs Improvement |

LCP and INP still have insufficient sample volume for a field-data rating — re-check as traffic grows. The available metrics are consistent with the Performance section's lab findings (render-blocking fonts, third-party scripts).

Full detail (original blocked-state findings, now superseded by this update): `findings/google-api.md`

---

## 14. Backlinks — Unscored (insufficient data)

Tier 0 only (Common Crawl domain graph + local verify crawler; no Moz/Bing/DataForSEO). Common Crawl shows the domain simply hasn't been sampled yet (`in_crawl: false`) — consistent with a young site, not a low-authority signal. Honest read: an effectively empty backlink profile that needs building, not cleaning. Concrete link-building gaps identified: real estate directories (99acres, MagicBricks, Housing.com), local Bengaluru listings (GBP, JustDial, Sulekha), developer co-marketing (given existing in-depth content on 19 named projects), and local property-press PR using the existing market-trend posts as source material.

Full detail: `findings/backlinks.md`

---

## 15. DataForSEO Enrichment — Unavailable This Session

The DataForSEO MCP server was installed and configured (with your $1 trial credentials) partway through this audit, but MCP servers only load at Claude Code session startup — this session was already running. **Restart Claude Code and re-run the SERP/keyword/backlink enrichment** to get live data on: real ranking positions for target keywords, keyword volume/difficulty, a backlink summary, and an AI-visibility/LLM-mention check for "Luxura Habitat." No credit was spent. Full detail: `findings/dataforseo.md`

---

## Cross-Cutting Pattern: The RERA/NAP Consistency Problem

Three independent agents (Content, SXO, Local) converged on the same underlying issue from different angles: **sidebar/footer data fields are populated inconsistently with the canonical facts stated in the main body of each page.** This shows up as:
- A specific RERA number in a blog sidebar contradicting "pre-launch, TBD" body text (Content/SXO Critical finding).
- The Tamil Nadu RERA registration silently missing from one area page's footer, and missing entirely from three others (Local High finding).

This is a **templating/QA gap**, not isolated content errors — the same sidebar/footer component is reused across many pages without a canonical-source-of-truth check. The Action Plan below treats the fix as build-time validation, not just a one-off edit.

---

## Artifacts

- Findings detail: `findings/*.md` (13 files)
- Screenshots: `screenshots/` (desktop + mobile, fold + full-page, for homepage/area/project/blog samples)
- Structured data: `audit-data.json`
- This report: `FULL-AUDIT-REPORT.md`
- Prioritized fixes: `ACTION-PLAN.md`
