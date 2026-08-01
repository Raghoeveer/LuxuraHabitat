# SXO Analysis — luxurahabitat.com

Method note: DataForSEO MCP tools were unavailable this session (see
`findings/dataforseo.md`), so SERP analysis below uses live Google Web Search
(WebSearch tool) against the site's core keyword patterns, cross-referenced
against the locally rendered HTML of representative pages in each of the
4 target page-type categories. Page-type taxonomy and scoring rubrics per
`skills/seo-sxo/references/`.

## Score

**SXO Gap Score: 58 / 100** (Needs Work)

This is a distinct metric from any SEO Health Score and should not be averaged
with it.

| Dimension | Score | Basis |
|---|---|---|
| Page Type Alignment | 10/15 | Area hubs & investment-guide post match SERP format; price/RERA posts under-match the developer-funnel format Google/users actually reward |
| Content Depth | 8/15 | Area hub only covers Luxura's own 4 client projects vs. competitor guides citing 5-8+ projects with per-project ₹/sqft data |
| UX Signals | 9/15 | Good tables/timeline on hub pages; blog posts are single-column prose with only 1 in-body image |
| Schema | 7/15 | BlogPosting + BreadcrumbList present on posts, but FAQPage schema missing on all 4 area hub pages despite visible FAQ content |
| Media | 6/15 | One hero image per blog post; no floor plans, master-plan galleries, or price-comparison infographics that competing project pages show |
| Authority/Trust | 5/15 | Critical: self-contradicting RERA disclosure on the Assetz Palmscape review (see Finding 1) |
| Freshness | 8/10 | Dates present and recent (July 2026) with schema `datePublished`/`dateModified` |
| **Total** | **58/100** | |

## What Works

- The 4 area hub pages (`/areas/devanahalli/`, `/areas/hennur/`, `/areas/yelahanka/`, `/areas/kanakapura-road/`) already match the long-form "guide" format that dominates the SERP for "[area] real estate" queries — hero stats, price-trend tables, infrastructure timeline, FAQ, and a projects grid, closely mirroring competitors like realhubb.in, onecityproperty.com, and nxtfootstep.com.
- The "plots vs apartments" investment-guidance post is genuinely well-aligned to what ranks: independent competitor articles (onecityproperty, houzbay, oraiyangroups, naverahassets) use the identical structure — ownership/freedom, appreciation, regulatory (BDA/RERA), liquidity, cost of ownership — and Luxura's post covers the same dimensions with an honest, non-salesy tone.
- For the niche "Assetz Palmscape vs Sattva Aeropolis" comparison query, no genuine head-to-head content exists elsewhere in the SERP (competitors only publish single-project pages) — Luxura's dedicated comparison post is a real differentiation opportunity if depth is increased.
- BlogPosting + BreadcrumbList schema, author bylines, and datePublished/dateModified are consistently implemented across all 30 blog posts.
- Internal linking between area hub → comparison post → price/RERA deep-dive → project page forms a coherent topical cluster that mirrors how users actually research (confirmed by the "Explore Devanahalli" cluster section).

## Findings

### Finding 1: Self-contradicting RERA disclosure on the money-page for "Assetz Palmscape price + RERA"
- **Severity:** Critical
- **Description:** `/blog/assetz-palmscape-devanahalli-price-layout-rera/` is the exact page type ("price, layout, RERA") that Google rewards with developer-funnel and broker pages showing verified, specific RERA numbers (confirmed via WebSearch — competing pages cite `PRM/KA/RERA/1250/303/PR/300626/008780` for this project). Luxura's own article body states plainly: *"RERA Status: Pre-launch EOI stage — confirm RERA number at project launch with our team"* — yet the sidebar "Featured in this Article" card on the **same page** displays a specific, fully-formed number: `PRM/KA/RERA/1251/446/PR/270524/006757`. That prefix (`1251/446`) is identical to KNS Sampada's RERA prefix used elsewhere on the site, suggesting a copy/template error rather than a verified figure. This is the exact scenario already flagged in project memory ("never guess between conflicting RERA numbers, placeholder + ask user, then sync everywhere") — it remains unresolved on this page. For a "verified by our team" positioning aimed at NRI/HNI buyers who will independently check the Karnataka RERA portal before wiring funds, a page that contradicts itself on the single highest-stakes trust fact is a severe E-E-A-T and conversion risk.
- **Recommendation:** Remove the sidebar RERA number immediately and replace with "RERA: To be confirmed at launch — verify with our team" until the real number is confirmed, matching the body copy. Audit all pre-launch project pages/sidebars site-wide for the same sidebar-vs-body mismatch pattern before this ships to more pages.

### Finding 2: Area hub pages have visible FAQ content but no FAQPage schema
- **Severity:** High
- **Description:** All 4 area hub pages (`/areas/devanahalli/`, `/areas/hennur/`, `/areas/yelahanka/`, `/areas/kanakapura-road/`) contain 5-6 well-written FAQ items each (e.g., "Is Devanahalli a good investment in 2026?", "Which is better — a plot or an apartment?") but ship only `BreadcrumbList` + `WebPage` schema — no `FAQPage`. Meanwhile 19 other pages on the site (mostly project pages) do carry `FAQPage` schema. These 4 hub pages are exactly the page type most likely to win a featured-snippet or PAA placement for head terms like "Devanahalli real estate," which is the highest-value query in this cluster.
- **Recommendation:** Add `FAQPage` structured data to all 4 area hub pages using the existing FAQ markup as the source (mainEntity/Question/acceptedAnswer), matching the pattern already used on project pages.

### Finding 3: Area hub content depth is narrower than what ranks — only in-house projects, not the full corridor
- **Severity:** Medium
- **Description:** Competing "Devanahalli real estate" guides (realhubb.in, onecityproperty.com, nxtfootstep.com) rank by citing granular, corridor-wide pricing across many projects — e.g., "average ₹11,350/sqft, ranging from ₹8,500/sqft (Provident Ecopolitan) to ₹13,000/sqft (Tata Carnatica)." Luxura's Devanahalli hub only discusses the 4 projects it represents (Assetz Palmscape, Sattva Aeropolis, Sattva City, Century Astoria) and gives blended price bands rather than named-project benchmarks against the wider market. An NRI investor doing first-pass research typically wants an unbiased market map before narrowing to an agent's shortlist — the current page reads as curated inventory rather than neutral research, which is the opposite of what ranks.
- **Recommendation:** Add a "How Luxura's projects compare to the wider Devanahalli market" table naming 3-5 non-represented projects with public price bands, positioned before the "Active Projects" section, to establish neutrality before the pitch.

### Finding 4: Money-page format mismatch — editorial article vs. structured funnel/spec page
- **Severity:** Medium
- **Description:** For "[project] price layout RERA" queries, the SERP is dominated by developer/broker microsites structured as Price / Floor Plan / Master Plan / Brochure tabs with downloadable brochures, floor-plan image galleries, and EMI/price calculators (assetzprelaunch.com, assetzpalmscape.com, homznspace.com, propnewz.com). Luxura's equivalent page (`/blog/assetz-palmscape-devanahalli-price-layout-rera/`) is a single-column prose article with one hero image and one pricing table — no floor plan visuals, no master plan image, no brochure CTA, no calculator. This is a page-type depth gap (Blog Post format vs. the Hybrid Service+Content format Google is actually rewarding for this query), not a full mismatch, since Luxura's page does rank on the right topic and structure otherwise.
- **Recommendation:** Add a floor-plan/master-plan image block per plot category and a "Download Brochure" or "Get Verified Price List" lead-gen CTA inline with the pricing table (not just the generic sidebar consult), matching the funnel depth competitors show.

### Finding 5: Comparison posts lack a persona-driven "who wins" visual anchor above the fold
- **Severity:** Low
- **Description:** The "Assetz Palmscape vs Sattva Aeropolis" post buries its two "who should buy which" tables at H2 #1 and #4, after a full comparison table — a comparison-fatigued reader (evidenced by the general prevalence of "X vs Y" and "best X for Y" related-search patterns in this niche) wants the verdict-by-persona table near the top, not two scrolls down.
- **Recommendation:** Move a condensed 2-row "Best for NRI/long-horizon → Palmscape; Best for end-user/rental → Aeropolis" callout box directly under the hero image, before the detailed comparison table.

## User Stories (cite SERP/observed signals)

**Awareness stage**
1. As an **NRI investor** researching "Devanahalli real estate," I want an unbiased view of price/sqft across the whole corridor, because I need context before I trust any single agent's shortlist, but I'm blocked by Luxura's hub only naming its own 4 represented projects vs. competitor guides that name 5-8 projects market-wide. *(Source: competitor SERP data citing Provident Ecopolitan/Tata Carnatica benchmarks; Finding 3)*

**Consideration stage**
2. As a **first-time homebuyer comparing projects**, I want one page with a clear side-by-side verdict for Palmscape vs Aeropolis, because comparing two developer microsites myself is comparison fatigue, but I'm blocked only mildly — Luxura's post exists and is well-structured, though the "who should buy which" verdict is not surfaced early enough. *(Source: absence of genuine "vs" content elsewhere in SERP; Finding 5)*
3. As a **budget-conscious investor** evaluating plots vs apartments, I want concrete ROI numbers rather than general prose, because I make decisions on numbers, but this is a category-wide gap (competitors are prose-only too) rather than a Luxura-specific failure.

**Decision stage**
4. As a **risk-averse NRI decision-maker** ready to act on Assetz Palmscape, I want to verify the RERA number and exact pricing before wiring international funds, because a wrong number could mean fraud or an outdated listing, but I'm blocked by the page's own internal contradiction between "RERA to be confirmed" copy and a specific RERA number in the sidebar. *(Source: Finding 1 — direct page evidence, reinforced by prior project memory on RERA conflicts)*
5. As a **first-time buyer close to booking**, I want a downloadable brochure or floor-plan gallery matching the plot sizes/prices quoted, because developer funnel sites give me this at the same URL, but Luxura's review sends me to a generic "Book a Call" CTA instead. *(Source: Finding 4 — developer/broker SERP competitors offering brochure + floor-plan galleries)*

## Persona Scores

| Persona | Relevance | Clarity | Trust | Action | Total | Rating |
|---|---|---|---|---|---|---|
| NRI Investor (Devanahalli plots, decision stage) | 20/25 | 18/25 | 8/25 | 15/25 | 61/100 | Good, but Trust is a critical mismatch driver |
| First-Time Homebuyer (comparison shopper) | 21/25 | 16/25 | 18/25 | 17/25 | 72/100 | Good |
| Budget-Conscious Investor (plots vs apartments) | 20/25 | 19/25 | 19/25 | 16/25 | 74/100 | Good |
| Corporate/Rental-Yield Buyer (Sattva Aeropolis) | 17/25 | 17/25 | 15/25 | 15/25 | 64/100 | Good, moderate gaps |
| Ready-to-Book Buyer (needs floor plan/brochure) | 14/25 | 14/25 | 15/25 | 12/25 | 55/100 | Needs Work |

### Weakest Persona: NRI Investor (61/100)
**Top issue:** Trust score of 8/25 driven directly by Finding 1's self-contradicting RERA disclosure — the single fact this persona most needs to be unimpeachable.
**Recommended fix:** Fix the sidebar RERA placeholder immediately (Finding 1), then add a "How we verify every project" trust module (RERA portal screenshot/link, khata/encumbrance check description) to the price/RERA post template site-wide.

### Systemic Issues
- Trust: RERA/data-accuracy risk is not isolated to one page — the same sidebar-card template is reused across price/RERA posts, so the fix in Finding 1 should be applied as a template-level check, not a one-off edit.
- Action: CTAs are uniformly generic ("Book a Free Consultation" / "Talk to an Advisor") regardless of journey stage — decision-stage personas (RERA verification, brochure-seekers) get the same CTA as awareness-stage personas.

### Priority Actions
1. Fix the Assetz Palmscape RERA contradiction (Finding 1) — highest severity, single persona-critical fact.
2. Add FAQPage schema to the 4 area hub pages (Finding 2) — cheap, high-leverage for PAA/snippet capture on head terms.
3. Broaden area-hub market data beyond in-house projects (Finding 3) to fix the Awareness-stage neutrality gap.

## Limitations

- No DataForSEO/live rank-tracking data was available this session; SERP composition was assessed via Google Web Search snippets/summaries rather than raw SERP HTML, so exact PAA question sets, AI Overview citations, and ad density could not be directly observed or quantified.
- Only 4 of 62 site pages were rendered/read in full depth (one from each requested category); findings on schema/FAQ presence were cross-checked site-wide via grep but full manual review of all 30 blog posts and 15 project pages was out of scope for this pass.
- The specific competitor-cited RERA number for Assetz Palmscape (`PRM/KA/RERA/1250/303/PR/300626/008780`) is taken from a WebSearch-summarized result, not verified directly against the Karnataka RERA portal — treat it as directional evidence, not a confirmed correct value. The Critical severity of Finding 1 rests primarily on Luxura's own page contradicting itself (verifiable directly in the HTML), independent of whether that external number is accurate.
- Screenshots/visual rendering of the live site were not captured in this pass (only static HTML was read).

Cross-skill references: the RERA/pricing inconsistency (Finding 1) and broader data-accuracy gaps warrant `/seo content` for E-E-A-T review; the missing FAQPage schema (Finding 2) can be resolved via `/seo schema`.

Generate a PDF report? Use `/seo google report`.
