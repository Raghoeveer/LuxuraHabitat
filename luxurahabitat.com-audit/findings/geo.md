# GEO / AI Search Readiness — luxurahabitat.com

**Score: 61 / 100**

## Dimension breakdown
| Dimension | Weight | Score | Weighted |
|---|---|---|---|
| Citability | 25% | 55/100 | 13.8 |
| Structural Readability | 20% | 65/100 | 13.0 |
| Multi-Modal Content | 15% | 40/100 | 6.0 |
| Authority & Brand Signals | 20% | 50/100 | 10.0 |
| Technical Accessibility | 20% | 90/100 | 18.0 |
| **Total** | | | **60.8 ≈ 61** |

## AI Crawler Access Status
- `robots.txt` (live, 200 OK): `User-agent: *` / `Allow: /` + sitemap reference — **no crawler-specific blocks at all**. GPTBot, OAI-SearchBot, ClaudeBot, PerplexityBot, CCBot, anthropic-ai, cohere-ai are all implicitly allowed.
- No `meta robots noindex` anywhere except the appropriate `/thank-you/` confirmation page.
- All 62 pages confirmed static server-rendered HTML — verified by curling a live blog URL and finding body text present in the raw response (no JS execution required). This is ideal for crawlers like GPTBot/ClaudeBot that largely don't execute JavaScript.
- Sitemap.xml live, 200 OK, contains all 62 URLs with `lastmod`.

## llms.txt Status
- **Missing.** No `/llms.txt` locally or in production (confirmed 404 on `https://luxurahabitat.com/llms.txt`). No RSL 1.0 licensing file either. This is a low-priority, optional signal (ignored by Google Search and not yet a confirmed ranking factor for any major AI platform), but it's a trivial file to add given how much structured knowledge (project specs, RERA numbers, area data) already exists on-site.

---

## what_works
- Robots.txt is maximally permissive for AI crawlers — nothing to fix here, this is a clean pass.
- Fully static/SSR HTML across all 62 pages (no SPA shell, no client-side content injection) — content is guaranteed visible to non-JS-executing AI crawlers.
- Rich, valid schema.org coverage site-wide: `LocalBusiness`, `RealEstateAgent`, `Person`, `BlogPosting`, `BreadcrumbList`, `RealEstateListing`, `AggregateRating` — far beyond what most small real-estate sites implement.
- All 16 `/projects/` pages carry full `FAQPage` schema with `Question`/`Answer` pairs (140 Q&A pairs site-wide) — these are the commercially critical pages and they're well-optimized for AI Overview / ChatGPT extraction.
- Named, credentialed author entity: "Narayanan Rajesh" carries a `Person` schema with two verifiable RERA registration numbers (`hasCredential`), not just a generic "our team" claim — strong E-E-A-T raw material.
- Blog posts consistently include `datePublished`/`dateModified`, canonical tags, OG tags, and breadcrumb schema linking article → area hub → home, giving AI crawlers a clear topical hierarchy.
- 3 of 4 area guide pages (Devanahalli, Hennur, Kanakapura Road) already contain hand-written, genuinely self-contained FAQ blocks in question format with direct 30-70 word answers (e.g. "Is Devanahalli a good investment in 2026? Yes — for buyers with a 5+ year horizon...") — this is exactly the citable format AI Overviews/ChatGPT prefer, it's just not marked up (see findings).
- Data-rich content: 23 pages use real `<table>` elements with dated price/appreciation figures rather than burying stats in prose — good for extraction as a citable fact block.
- Image alt text is present on all 241 images across the blog section — no accessibility/citability gap there.

---

## findings

### 1. Visible FAQ content exists but has zero FAQPage schema on area pages
- **Severity:** High
- **Description:** `/areas/devanahalli/`, `/areas/hennur/`, and `/areas/kanakapura-road/` each contain a hand-authored FAQ section (`faq-question`/`faq-answer` divs) with 6-7 genuinely good, self-contained, direct-answer Q&As — e.g. Devanahalli's "Is Devanahalli a good investment in 2026?", "Which is better — a plot or an apartment?", "How far is Devanahalli from Bangalore city centre?". None of this is wrapped in `FAQPage`/`Question`/`Answer` JSON-LD (confirmed via `grep -c FAQPage` = 0 on all four area pages, vs. 19 files site-wide that do have it, all under `/projects/`). This is the single highest-leverage gap: the citable content already exists, it's just invisible to AI Overview's FAQ-rich-result and answer-extraction pipeline as structured data.
- **Recommendation:** Copy the `FAQPage` JSON-LD pattern already used on the 16 project pages and apply it to the visible FAQ blocks on the 3 area pages that have them. Effort: Low (1-2 hours, mechanical templating).

### 2. Yelahanka area guide has no FAQ section at all
- **Severity:** Medium
- **Description:** `/areas/yelahanka/` returns 0 for `faq-question` — it's the only one of the four area hub pages without any direct-answer Q&A block, creating an inconsistent citability profile across an otherwise-parallel page template.
- **Recommendation:** Author 6-7 FAQs matching the format already used for Devanahalli/Hennur/Kanakapura Road, then apply FAQPage schema per Finding 1. Effort: Medium (content writing + schema).

### 3. Blog posts (30 of 62 pages, the largest content category) have no Q&A blocks and almost no question-format headings
- **Severity:** High
- **Description:** Across all 30 blog posts, `faq-question` class occurs 0 times — none of the blog content is packaged as extractable Q&A. Heading analysis across the same 30 posts found 224 total H2/H3 headings, of which only 12 (5.4%) are phrased as questions (e.g. most read as declarative labels like "Why Devanahalli is Different From Every Other Corridor" rather than "Why is Devanahalli different from other Bangalore corridors?"). Question-phrased headings map directly to how users phrase prompts to ChatGPT/Perplexity/Google AI Overview and significantly increase citation odds.
- **Recommendation:** (a) Reframe H2/H3s in new and existing posts as questions matching real search/prompt intent where it reads naturally; (b) add a 4-6 question FAQ block to each blog post, matching the area-page pattern, with matching FAQPage schema. Effort: Medium-High (content rewrite across 30 posts, can be phased by traffic priority).

### 4. Answer passages run shorter than the optimal AI-citation length
- **Severity:** Medium
- **Description:** Sampled paragraph word counts from `blog/plots-vs-apartments-investment-bangalore/` and `blog/hennur-connectivity-orr-hebbal-metro-nagavara/` cluster at 16-90 words per paragraph (most in the 40-70 word range), below the 134-167 word range that performs best for AI Overview/ChatGPT citation. Several answers (e.g. the 16-word Hebbal flyover paragraph) are too fragmentary to stand alone as a citable passage without surrounding context.
- **Recommendation:** For priority posts, consolidate short adjacent paragraphs into single self-contained 134-167 word answer blocks that open with a direct answer sentence, keeping supporting detail in the same block rather than splitting across multiple short paragraphs. Effort: Medium (editing pass, not full rewrite).

### 5. Authorship signal is internally contradictory across all 30 blog posts
- **Severity:** Medium
- **Description:** Every blog post's visible byline reads "By the Luxura Habitat Team" (article meta) and the footer author-card heading says "Written by the Luxura Habitat Team," yet the same footer card displays Narayanan Rajesh's photo and 12+ years/bio copy, and the page's own `BlogPosting` JSON-LD names `"author": {"@type": "Person", "name": "Narayanan Rajesh"}`. This mismatch (anonymous "Team" in visible copy vs. named individual in structured data and imagery) is a confusing authorship signal for any system trying to establish a single, consistent E-E-A-T entity, and it undercuts the credibility of having a named, RERA-credentialed advisor in the first place.
- **Recommendation:** Standardize on "By Narayanan Rajesh, Principal Advisor" (or an explicit "Reviewed by Narayanan Rajesh" if the team genuinely drafts content) consistently across visible byline, footer card heading, and JSON-LD. Effort: Low (find/replace across 30 files).

### 6. Organization/LocalBusiness entity signals are thin on structured data — no street address, single sameAs link
- **Severity:** Medium
- **Description:** The homepage `LocalBusiness` schema's `address` block contains only `addressLocality`, `addressRegion`, `addressCountry` — no `streetAddress` — and `sameAs` contains a single `wa.me` WhatsApp link with no other verifying profile. A `RealEstateAgent`/`LocalBusiness` entity with an incomplete `PostalAddress` and only one `sameAs` reference gives AI systems and Google's entity graph fewer independent corroborating signals to confirm "Luxura Habitat" as a distinct, verifiable local business entity.
- **Recommendation:** Add a `streetAddress` (or a `PostBox`/service-area note if there's no public office) to the `PostalAddress`, and add `sameAs` entries for every verified brand profile the business actually controls (Google Business Profile, LinkedIn company page, Instagram, etc.) — only include profiles that genuinely exist and are actively maintained. Effort: Low (schema edit), contingent on which profiles the business actually has.

### 7. Person schema `@id`/`url` point to a non-canonical URL
- **Severity:** Low
- **Description:** The `/about/` page's own canonical tag is `https://luxurahabitat.com/about/`, but its `Person` JSON-LD uses `"@id": "https://luxurahabitat.com/about.html#narayanan"` and `"url": "https://luxurahabitat.com/about.html"`. Live-site check confirms `about.html` 301-redirects correctly to `/about/`, so this isn't a broken/duplicate-content issue, but using a non-canonical identifier for the entity's `@id` is a minor hygiene gap that can fragment entity resolution across knowledge-graph-style consumers that don't follow redirects on `@id` values.
- **Recommendation:** Update `@id` and `url` in the Person schema to the canonical `https://luxurahabitat.com/about/` (with a `#narayanan` fragment if desired). Effort: Trivial (one-line edit).

### 8. No video or other multi-modal content anywhere on the site
- **Severity:** Low
- **Description:** Site-wide search found zero `<video>` tags or YouTube embeds across all 62 pages. All imagery is static photography with (good) alt text, and 23 pages use data tables, but there is no video walkthrough, drone footage, or embedded multimedia content, which limits the Multi-Modal Content dimension and forecloses a content type increasingly surfaced in AI Overviews and Perplexity's multi-modal answer cards.
- **Recommendation:** Add short embedded video content where practical (project walkthroughs, area drive-throughs) to at least the highest-traffic project and area pages. Effort: High (production dependency), lower priority than Findings 1-6.

### 9. llms.txt absent
- **Severity:** Info
- **Description:** No `/llms.txt` file exists locally or in production (confirmed 404 live). This is an emerging, optional, unstandardized signal — Google Search explicitly ignores it, and no major AI platform has confirmed it as a ranking input — but it's a low-cost addition given the amount of structured project/area data already on the site.
- **Recommendation:** Low priority; if time permits, add a basic `/llms.txt` summarizing site structure, area guides, and project pages. Effort: Low.

---

## Platform-specific notes
- **Google AI Overviews:** Best-positioned dimension today thanks to existing FAQPage schema on `/projects/` pages and clean SSR/crawlability — but the area-page and blog-page FAQ/schema gaps (Findings 1-3) are the main ceiling on AIO visibility for informational/comparison queries.
- **ChatGPT / OAI-SearchBot:** Crawler access is fully open; biggest lever is Finding 4 (passage length) and Finding 3 (question-format headings), since ChatGPT search tends to lift self-contained, directly-worded answer blocks.
- **Perplexity:** Table-based data (Finding: what_works #8) is a strength Perplexity tends to favor for citation; extending that pattern (dated stats with clear labels) into blog posts lacking tables would help.
- **Bing Copilot:** Inherits most of the same technical/crawlability strengths as Google; no Bing-specific blockers found (robots.txt is universally permissive).
