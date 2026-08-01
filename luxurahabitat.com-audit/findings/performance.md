# Performance / Core Web Vitals Findings — luxurahabitat.com

Method: Lighthouse lab data via `pagespeed_check.py --psi-only` (Lighthouse 13.x through PSI API v5), mobile strategy (Moto G power + slow 4G, 4x CPU throttle) unless noted. Four representative templates sampled from the 62-page site: homepage, one area page, one blog post, two project/listing pages (one mobile, one desktop due to an API error on the first page's mobile run — see Finding 6). Field/CrUX data is covered by a separate agent; that agent independently reported mobile LCP 4.1s and desktop TBT 1,080ms, which is consistent with the lab evidence below (GTM long-tasks + oversized logo/hero PNGs).

Pages tested:
- Home: https://luxurahabitat.com/ (mobile)
- Area: https://luxurahabitat.com/areas/devanahalli/ (mobile)
- Blog: https://luxurahabitat.com/blog/devanahalli-real-estate-market-trends-2026/ (mobile)
- Project: https://luxurahabitat.com/projects/assetz-palmscape/ (mobile) and https://luxurahabitat.com/projects/sattva-aeropolis/ (desktop, mobile run errored)

## Score

**58 / 100** (blended, page-count-weighted across templates)

Lighthouse Performance scores (mobile unless noted):
| Page | Performance | LCP | CLS | TBT |
|---|---|---|---|---|
| Home | 77 | 4.14s — **Poor** | 0.031 — Good | 141ms |
| Area (Devanahalli) | 62 | 13.87s — **Poor** | 0.000 — Good | 21ms |
| Blog post | 61 | 15.33s — **Poor** | 0.000 — Good | 36ms |
| Project (Assetz Palmscape, mobile) | 82 | 3.05s — Needs Improvement | 0.102 — Needs Improvement | 127ms |
| Project (Sattva Aeropolis, **desktop**) | 87 | 0.82s — Good (desktop, not comparable to mobile) | 0.003 — Good | 224ms |

Lab TBT is used as an LCP/main-thread proxy — Lighthouse does not measure INP directly (field-only metric); the separate CrUX agent's field INP figures should be treated as authoritative.

Blog posts (36 of 62 URLs) and area pages (7 of 62) are the site's two most common templates and both fail LCP badly in lab testing, which is why the blended score is pulled well below the raw average of the four numeric Performance scores (~70.5).

## What Works

- Server response time (TTFB) is excellent everywhere tested: 2–33ms across all four pages — Netlify's edge CDN is not a bottleneck.
- CLS is Good (≤0.05) on the homepage, area page, and blog post — above-the-fold layout is largely stable on those templates.
- Best Practices and SEO Lighthouse categories score 100 on every content page tested.
- JS execution/main-thread work is genuinely light on content pages outside of third-party scripts (bootup-time and mainthread-work-breakdown both score 1.0, 0.1–0.3s) — the site's own JS is not the bottleneck.
- No excessive DOM size found (190–422 elements per page, well under the 1,500-element risk threshold).

## Findings

### 1. Critical — LCP catastrophically poor on the site's two highest-volume templates (blog, area pages), driven by unoptimized hero/content images
**Evidence:** Devanahalli area page: LCP 13.87s (Lighthouse score 0). The `image-delivery-insight` audit flags `devanahalli-hero.jpg` at 1,004,735 bytes (1.0MB) with 829,972 bytes (83%) of that flagged as pure waste (oversized/uncompressed for its display size). Blog post "Devanahalli Real Estate Market Trends 2026": LCP 15.33s (score 0). Largest offenders: `images/about/about_us_advisor.png` at 1,260,720 bytes (1.26MB) with 1,257,715 bytes (99.8%) wasted, and `images/blog/devanahalli_market_trends.png` at 1,066,939 bytes with 993,235 bytes (93%) wasted. Neither image uses WebP/AVIF; both are shipped at far larger dimensions/quality than they render at.
**Recommendation:** Convert every hero/inline content image to WebP or AVIF, resize to actual rendered dimensions with a `srcset`, and compress aggressively (target <150KB for hero images, <50KB for inline blog images and the author avatar). Add `<link rel="preload" as="image" fetchpriority="high">` for each page's actual LCP element. This is the single highest-impact fix available — it directly addresses images responsible for 80–99% waste on the two slowest templates, which together make up roughly 70% of the site's 62 pages.

### 2. High — Google Tag Manager and Zendesk chat widget consume significant main-thread time on every template, worse on project pages
**Evidence:** `third-parties-insight` shows GTM main-thread time of 105–207ms on home/area/blog (mobile). On the Sattva Aeropolis project page (desktop run), the Zendesk widget alone consumed 572ms of main-thread time and 484,389 bytes transferred — on top of GTM's 210ms — which lines up with the 1,080ms desktop TBT the field-data agent reported. Combined third-party payload (GTM + Fonts + GA + Zendesk) ranges 170KB (content pages) to 650KB+ (project pages with chat widget).
**Recommendation:** Defer Zendesk widget initialization until user interaction (click the chat bubble to lazy-load the SDK) rather than loading it eagerly on every project page. Load GTM off the critical path (e.g., via a facade/Partytown or after `window.onload` + `requestIdleCallback`), and audit the GTM container for redundant/duplicate tags firing on load.

### 3. High — Render-blocking Google Fonts stylesheet costs ~750ms on every single page
**Evidence:** `render-blocking-insight` flags `fonts.googleapis.com/css2?family=Inter...&family=Playfair+Display...` as render-blocking with `wastedMs: 751` identically on the homepage, area page, and blog post. The local `css/styles.css` adds a further 216–254ms of render-blocking time on each of those pages.
**Recommendation:** Self-host Inter and Playfair Display as woff2 files with `font-display: swap`, and preload the critical weights via `<link rel="preload" as="font" crossorigin>` from the same origin — this eliminates the extra DNS/TLS/render round-trip to fonts.googleapis.com that is currently costing ~750ms of render delay site-wide. Inline critical above-the-fold CSS and defer the rest of `styles.css`.

### 4. Medium — Oversized developer/partner logo images bloat the homepage and repeat sitewide via the header logo
**Evidence:** Homepage `image-delivery-insight` flags the builder-marquee logos as almost pure waste relative to their rendered size: `VAJRAM...LOGO-01.webp` 154,542 bytes (154,488 wasted), `Godrej Properties Symbol PNG.png` 151,592 bytes (150,126 wasted), `Prestige_Group.png` 119,834 bytes (118,917 wasted) — each rendering at roughly 100×48px thumbnail size. The site header `company_logo.png` (69,836 bytes, 66,784 wasted) recurs on every page in the audit, including the area and blog pages.
**Recommendation:** Re-export all marquee/partner logos and the header logo as properly sized WebP/PNG at 2x display resolution (target <10KB each). This alone recovers roughly 500–650KB of homepage payload and ~65KB on every other page site-wide from the header logo alone.

### 5. Medium — CLS "Needs Improvement" on project/listing templates from unsized images
**Evidence:** Project pages score CLS 0.102 (Needs Improvement band) versus 0–0.03 (Good) on home/area/blog. The `unsized-images` audit scores 0.5 on every template tested, meaning some `<img>` elements lack explicit `width`/`height` attributes — most concentrated on the project template's gallery/plan images.
**Recommendation:** Add explicit `width`/`height` or CSS `aspect-ratio` to every gallery and unit-plan image on project pages, particularly ones rendered inside dynamically toggled panels, to reserve layout space before the image loads.

### 6. Info — Lighthouse mobile audit failed to complete (null category score) for 2 of 6 project pages spot-checked
**Evidence:** PSI mobile runs for `/projects/sattva-aeropolis/` and `/projects/sattva-forest-ridge/` both returned a Lighthouse category with a `None` score, causing the checker script to error (`TypeError: unsupported operand ... 'NoneType'`), while the corresponding desktop run for Aeropolis succeeded (Performance 87). Both are gallery-heavy project pages carrying multiple 400KB–1MB unoptimized WebP images (e.g., `Aeropolis/Tower-A.webp` at 1,032,778 bytes, 1,010,533 wasted).
**Recommendation:** Re-run PSI/Lighthouse directly against these two URLs to confirm whether this is a transient API/tooling issue or a genuine mobile rendering timeout caused by the unusually heavy unoptimized gallery images competing for bandwidth under mobile's throttled network profile. If reproducible, prioritize these two pages' image optimization above others, since a failed/timed-out Lighthouse run under throttled mobile conditions is itself a signal of a real-world slow-load risk for mobile users on 4G.

## Priority Order (expected impact)

1. Compress/convert hero, blog, and avatar images (Finding 1) — directly fixes the two worst LCP scores (13.9s, 15.3s → likely sub-3s).
2. Self-host fonts + eliminate render-blocking font CSS (Finding 3) — ~750ms saved on every page, no downside.
3. Defer Zendesk widget + move GTM off critical path (Finding 2) — largest lever for TBT/INP risk on project pages.
4. Compress logo/partner images (Finding 4) — quick win, ~500KB+ off homepage.
5. Add image dimensions on project template (Finding 5) — closes the CLS gap on listing pages.
6. Investigate the two failed mobile Lighthouse runs (Finding 6) — diagnostic follow-up.
