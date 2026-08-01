# Content Quality Audit — luxurahabitat.com

**Score: 58/100**

## E-E-A-T Breakdown (internal weighting model)

| Factor | Weight | Score /100 | Notes |
|---|---|---|---|
| Experience | 20% | 55 | Named advisor (Narayanan Rajesh) with testimonials citing hands-on site-visit involvement; no visible photos/first-hand evidence of the 150+ claimed transactions, no case-study detail |
| Expertise | 25% | 60 | Consistent RERA credential display, developer-partnership list; but blog byline says "Luxura Habitat Team" while structured data attributes single-author expertise — undermines the expertise signal |
| Authoritativeness | 25% | 45 | No external citations, press mentions, backlinks-worthy original data, or third-party recognition anywhere sampled; all "authority" is self-asserted |
| Trustworthiness | 30% | 60 | Legit RERA agent numbers, disclaimers, NAP consistent in footers; but one blog page contains a self-contradictory RERA number for a project explicitly marked pre-launch elsewhere on the same site — a direct trust/factual-accuracy failure |

## AI Citation Readiness: 50/100
- Project pages (15/18) carry FAQPage schema with acceptedAnswer blocks — good for AI Overviews/citation.
- All 30 blog posts have **zero** FAQPage/QAPage schema — the highest-volume content type on the site is the least citation-ready.
- Blog posts do use clear H2/H3 hierarchy, comparison tables, and a closing "Our Honest Assessment" verdict paragraph — a genuinely quotable, well-structured pattern where it appears.
- BlogPosting schema is present and correctly wired (author, publisher, breadcrumbs) on all sampled posts.

## What Works
- Consistent NAP, RERA registration numbers (agent-level), and channel-partner disclaimers in every footer sampled (about, blog posts, project pages).
- `Person` schema for Narayanan Rajesh on /about/ with `hasCredential` (RERA registration) — solid structured E-E-A-T signal.
- Area guide pages (devanahalli 1,673 words, hennur 1,414, yelahanka 2,659, kanakapura-road 1,515) and project pages (assetz-palmscape 1,393, century-kindle 1,717) all clear their respective content-minimum floors comfortably, with genuine local detail (timelines, data tables, FAQs).
- The best "vs" comparison post sampled (`vajram-vivera-vs-vajram-chrysanthemum`) is a genuine differentiation piece — unique comparison table, "who should choose which" section, project-specific tradeoffs — not filler. This is the template other comparison posts should be held to.
- Testimonials include specific, plausible first-hand detail (encumbrance certificate walkthroughs, personal site-visit accompaniment) rather than generic praise.

## Findings

### 1. Self-contradictory RERA claim on a live page (fabricated-looking registration number)
**Severity: Critical**
`blog/assetz-palmscape-devanahalli-price-layout-rera/index.html` states in the article body (Section 5, Legal and RERA Verification): *"RERA Status: Pre-launch EOI stage — confirm RERA number at project launch with our team"* — yet the sidebar widget on the same page lists a specific number, `RERA: PRM/KA/RERA/1251/446/PR/270524/006757`. The linked project page (`projects/assetz-palmscape/index.html`) confirms the project is genuinely pre-launch (badge: "Pre-Launch", "Pre-Launch EOI: ₹3 Lakhs Token", no RERA number anywhere on that page). This specific number does not appear on any other page of the site — it appears to be either copy-pasted from another project's template slot or fabricated to fill the sidebar component. For a site whose entire value proposition is "verified, zero-litigation" legal due diligence, a self-contradicting RERA claim on the same page is a serious trust/factual-accuracy failure and exactly the kind of inaccuracy the Sept 2025 QRG flags for low-quality/templated AI content.
**Recommendation:** Audit every blog post's sidebar RERA field against the linked project's actual current RERA status; leave the field blank or show "Pre-launch — RERA pending" rather than a specific number when a project has no registration yet. Add a build-time check comparing sidebar RERA numbers to the canonical project-page RERA field to prevent recurrence.

### 2. All ~30 blog posts are thin relative to the blog-post floor, and were bulk-published in a 17-day window
**Severity: High**
Measured body word counts (article-content only, tags/nav/footer stripped) across the sampled "price, layout, RERA" and "vs" posts range **650–1,220 words**, well under the 1,500-word blog-post floor — e.g. `assetz-palmscape-devanahalli-price-layout-rera` (547 words in the content div), `kns-sampada-mysore-road-price-layout-rera` (822), `vajram-vivera-vs-vajram-chrysanthemum` (605). Additionally, `datePublished` across all 30 posts falls between 2026-07-14 and 2026-07-31 (10 posts alone on 2026-07-21), with `dateModified` identical to `datePublished` on every post sampled — i.e., a burst-published, never-updated content set. Combined with thin length and a repeated closing-paragraph template ("Our Honest Assessment" appears verbatim in 10/30 posts; "the usual diligence applies" / "usual site-visit and construction-progress check" phrasing repeats across at least 4), this reads as templated, scaled content production rather than individually-researched articles — a core Sept 2025 QRG AI-content quality flag (repetitive structure across pages, no evidence of unique original research per page).
**Recommendation:** Either reclassify these as a "project fact sheet" content type with its own (lower) floor, or expand each post's unique analysis (construction-progress updates, site-visit photos/notes, comparable resale data) to genuinely clear 1,500 words. Stagger publish dates / add real `dateModified` updates as facts change (price revisions, RERA registration granted, possession updates) rather than leaving dates frozen at first publish.

### 3. Blog author byline says "the Luxura Habitat Team" while every post's JSON-LD schema attributes single-author expertise to "Narayanan Rajesh"
**Severity: Medium**
All 30 blog posts render `<span>By the Luxura Habitat Team</span>` in the visible article meta and repeat "Written by the Luxura Habitat Team" in the author-card footer, but the BlogPosting schema's `author` object names `"Narayanan Rajesh"` with `url` pointing to `/about/`, and the visible author-card bio describes "Principal Advisor... 12+ years of experience" — language that only makes sense for one named individual, not a team. This mismatch between structured data and on-page content is a Sept 2025 QRG-relevant inconsistency: search engines and AI crawlers reading the schema will attribute expertise to a named, credentialed person, while human readers see an anonymous "team" byline with no named/credentialed author bio next to it.
**Recommendation:** Pick one model and apply it consistently — either byline every post as "Narayanan Rajesh, Principal Advisor" (matching the schema and reinforcing his credentials each time), or introduce a real editorial-team page with named contributors and adjust schema to `Organization`-authored where appropriate.

### 4. Blog posts (highest-volume content type) have no FAQPage schema
**Severity: Medium**
15 of 18 project pages carry `FAQPage`/`acceptedAnswer` structured data (verified on century-kindle, century-astoria, vajram-chrysanthemum, sattva-forest-ridge, vajram-vivera, kns-sampada, brigade-eternia, sattva-la-vita, sattva-lumina, tvs-emerald-altura). Zero of the 30 blog posts sampled have any FAQ/QA schema, despite many of them (price-layout-rera posts, "vs" comparisons) being naturally structured around question-shaped queries ("Is X RERA registered?", "Which is better, X or Y?") that are prime AI Overview / citation targets. This is a missed low-effort win on the content type Google/AI systems are most likely to surface for long-tail "[project] price" or "[project] vs [project]" queries.
**Recommendation:** Add 3–5 FAQPage Q&A pairs to each blog post template (RERA status, starting price, possession date, "who should buy this"), mirroring the pattern already proven on project pages.

### 5. Readability is dense (Flesch Reading Ease ~38–40, "difficult/college level") for a consumer-facing site
**Severity: Low**
Sampled posts scored FRE 38.3–39.7 (words/sentence 13–16, acceptable, but heavy jargon density — RERA, BDA, IGBC, DC-converted, sq.ft. price tables — pulls the syllable-per-word score down). This is not unusual for real-estate/legal content but sits below the ~60+ "plain English" range typically recommended for a general home-buyer audience that includes NRIs and first-time buyers.
**Recommendation:** Add a one-line plain-language gloss the first time an acronym (BDA, IGBC, DC conversion, EOI) appears per post; keep sentence length where it is (already reasonable).

### 6. No external authoritativeness signals found in sampled pages
**Severity: Low**
Across about/, project pages, and blog posts sampled, all trust/authority claims are self-asserted (developer-partnership list, "150+ families," zero-litigation claim) with no linked third-party evidence — no press mentions, no external review platform links (Google Business Profile, JustDial, etc.), no linked case studies or client documents.
**Recommendation:** Add links to verifiable external proof — Google Business Profile reviews, RERA portal lookup deep-links per project, any press/media mentions — to convert self-asserted authority into third-party-verifiable authority.
