# Technical SEO Audit — luxurahabitat.com

**Date:** 2026-08-01
**Score: 78 / 100**

## What Works

- `robots.txt` allows all crawlers and correctly declares `Sitemap: https://luxurahabitat.com/sitemap.xml`; validated as a well-formed `urlset` by `sitemap_discovery.py` (HTTP 200, `valid: true`, no query redaction).
- All 62 sitemap URLs use consistent trailing-slash directory-style paths (except two legacy `.html` files, `/privacy.html` and `/terms.html`, which are consistent with each other).
- Every checked page (`areas/*`, `blog/*`, `projects/*`, `about/`, `contact/`, `developers/`, `testimonials/`) has a self-referencing, correct `<link rel="canonical">` — no cross-page canonical mismatches found.
- No accidental `noindex`: the only `meta name="robots" content="noindex, nofollow"` in the whole site is on `/thank-you/`, which is intentionally excluded from `sitemap.xml` — correct implementation of a post-form-submit page.
- Titles and meta descriptions are unique across all 59 audited pages — zero duplicate `<title>` or duplicate description strings.
- Extensive, varied JSON-LD structured data: `BlogPosting`, `FAQPage`, `RealEstateListing`, `LocalBusiness`, `Organization`, `BreadcrumbList`, `Person`, `Apartment`/`ApartmentComplex`, `Offer`/`AggregateOffer` are used appropriately across content types, not just boilerplate `Organization` on every page.
- Clean single-hop 301 redirects: extensionless paths (`/about`, `/projects`, `/testimonials`, etc.) and legacy `.html` variants (`/about.html`, `/projects.html`, `/testimonials.html`) all 301 directly to the canonical trailing-slash URL with no redirect chains; `http://` and `https://www.` both resolve to the canonical apex `https://` in a single hop.
- The four area pages (`devanahalli`, `hennur`, `yelahanka`, `kanakapura-road`) and the ~30 blog posts show no templated/boilerplate near-duplication — shingle-overlap analysis found effectively zero shared text blocks between area pages.
- `viewport` meta (`width=device-width, initial-scale=1.0`) present on every page checked, including the homepage — no mobile-viewport regressions found.
- HSTS (`strict-transport-security: max-age=31536000`) is present on every response tested (homepage, blog index, a project page, an area page), confirming the earlier report that it's live via Netlify.
- Site is 100% static, pre-rendered HTML — no client-side-rendered content dependency, so there is no JS-rendering risk for crawlers (no CSR/SPA shell).
- Stale `additional_websites/*/index.html` and `zen&sato3/index.html` duplicate project mini-sites referenced in `.htaccess` no longer exist in git or on disk (their `index.html` files were removed, only image assets remain, which correctly 404 as directories/pages while individual image URLs still 200). No live duplicate-content exposure from this vector today.

## Findings

### 1. `.htaccess` is dead code on Netlify — redirect/security logic it documents is not actually enforced by that file
**Severity:** Medium
**Description:** The repo root has a 29-line `.htaccess` with `RewriteRule` directives for legacy `.html` → clean-URL redirects and for blocking/redirecting orphaned `additional_websites/*` mini-sites. Netlify's static hosting does not process `.htaccess` (that's an Apache directive format) — there is no `netlify.toml`, `_redirects`, or `_headers` file anywhere in the repo. Confirmed live: `/about.html` → 301 to `/about/` still works, but this is coming from **Netlify's own automatic "clean URL" resolution**, not from the `.htaccess` rule. This is currently harmless by luck (Netlify's default behavior happens to match the intent, and the `additional_websites` files the block-rules targeted have since been deleted from the repo), but it is fragile: any future re-addition of files under `additional_websites/` or a new legacy `.html` path will NOT be protected, because the `.htaccess` rules that "look like" they cover it do nothing on this host.
**Recommendation:** Delete the inert `.htaccess` (it misleads future editors into thinking redirect/blocking logic exists), and if explicit redirect/block control is ever needed again, add a real `_redirects` file or `netlify.toml` `[[redirects]]` blocks with equivalent rules.

### 2. Missing baseline security headers beyond HSTS
**Severity:** Medium
**Description:** Response headers on homepage, `/blog/`, a project page, and an area page show only `strict-transport-security: max-age=31536000`. There is no `X-Content-Type-Options`, `X-Frame-Options` (or `frame-ancestors` in a CSP), `Content-Security-Policy`, `Referrer-Policy`, or `Permissions-Policy` on any tested page. The HSTS header itself is also missing `includeSubDomains` and `preload`.
**Recommendation:** Add a Netlify `_headers` file (or `netlify.toml` `[[headers]]`) applying to `/*`:
```
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
Referrer-Policy: strict-origin-when-cross-origin
Permissions-Policy: geolocation=(), camera=(), microphone=()
Strict-Transport-Security: max-age=31536000; includeSubDomains; preload
```
Add a `Content-Security-Policy` once all third-party script/analytics origins are inventoried (avoid shipping an overly permissive CSP blind).

### 3. Meta descriptions are systematically too long and will be truncated in SERPs
**Severity:** Medium
**Description:** Nearly every `areas/*`, `projects/*`, and `blog/*` page has a meta description well over Google's effective ~155-160 character display budget — measured lengths ranged from 161 to 262 characters (e.g. `projects/assetz-zen-sato/index.html` at 262 chars, `projects/assetz-palmscape/index.html` at 221 chars, all 4 area pages at 179-205 chars, most blog posts at 164-188 chars). This isn't a handful of outliers — it's the norm across the template, meaning the carefully written value props (acreage, unit count, RERA status, amenities) are being cut off mid-sentence in search results, and Google is more likely to rewrite the snippet entirely.
**Recommendation:** Trim meta descriptions to ~120-155 characters, front-loading the strongest differentiator (project name + locality + one killer stat) before the point where truncation typically occurs.

### 4. `AggregateRating` structured data on 2 project pages isn't backed by visible on-page reviews
**Severity:** Low
**Description:** `projects/assetz-palmscape/index.html` (ratingValue 4.8, ratingCount 42) and `projects/orchid-salisbury/index.html` (ratingValue 4.8, ratingCount 100) both declare `AggregateRating` JSON-LD, but neither page contains a corresponding visible reviews/testimonials block with that rating count and value reflected in on-page content — the only related content is a nav link to the separate `/testimonials/` page. Google's structured data guidelines require ratings to be user-visible and specific to the entity being marked up; unbacked/self-serve `AggregateRating` risks the rich-result being ignored or, in aggregate, a manual "spammy structured data" action if this pattern is expanded to more pages.
**Recommendation:** Either remove `AggregateRating` from pages lacking visible per-project reviews, or add a genuine on-page review summary/count matching the JSON-LD values before scaling this schema to more projects.

### 5. No IndexNow key file / IndexNow protocol integration
**Severity:** Low
**Description:** `https://luxurahabitat.com/indexnow-key.txt` returns 404 — there is no IndexNow key file and (per the static-file structure) no evidence of IndexNow ping integration on publish. For a site publishing new project/blog pages multiple times a week (sitemap `lastmod` shows near-daily updates through late July), IndexNow would get Bing/Yandex/Naver to index new URLs faster than waiting on their own crawl schedule, complementing (not replacing) Google Search Console submission.
**Recommendation:** Generate an IndexNow key, publish `/​<key>.txt` at the root, and add a lightweight post-deploy hook (Netlify build plugin or GitHub Action) that pings `https://api.indexnow.org/indexnow` with newly added/changed sitemap URLs.

### 6. Two `.html`-suffixed URLs remain in the sitemap alongside directory-style URLs everywhere else
**Severity:** Info
**Description:** `sitemap.xml` lists `https://luxurahabitat.com/privacy.html` and `https://luxurahabitat.com/terms.html` with the `.html` extension, while all 60 other sitemap URLs use clean trailing-slash directory paths. This is a minor URL-structure inconsistency, not a functional error (both resolve 200 directly, no redirect needed since no directory-style alternative exists for them).
**Recommendation:** For consistency, convert `privacy.html`/`terms.html` to `privacy/index.html` and `terms/index.html` with a 301 from the old `.html` path, matching the rest of the site's URL convention — low priority, cosmetic/consistency only.

### 7. No hreflang tags anywhere on the site
**Severity:** Info
**Description:** No `hreflang` attributes were found on any page. The site is single-market (Bengaluru, India) and single-language (English) with no evidence of alternate-language or alternate-region versions, so this is expected and not a defect — flagged only for completeness per the audit brief. Defer to the `seo-hreflang` sub-skill if/when a regional-language (e.g. Kannada) version is ever planned.
**Recommendation:** No action needed at current scope.
