# Google API Data Findings — luxurahabitat.com

**Credential tier:** Tier 2 configured (API key + service account `claude-seo@openclawplaces-494918.iam.gserviceaccount.com` + GA4), but the service account is **not yet granted access** in GSC or GA4, and the Search Console API is **not enabled** in the linked GCP project (`openclawplaces-494918` / project number `957832293351`). As a result, all GSC and GA4 calls returned permission errors rather than data. Only CrUX/PSI (API-key-based, Tier 0) succeeded.

**Data source:** Google API (field + lab data) where available; permission/config errors reported verbatim below.

## Score: 45/100

Score reflects that the site itself looks technically sound in the one channel we could actually measure (PSI/Lighthouse), but four of six requested API calls (GSC search analytics, GSC sitemaps, GSC URL Inspection x2 sample, GA4 organic, GA4 top-pages) failed outright due to access/config gaps — meaning indexation status, real query performance, and organic traffic are currently unverifiable via Google APIs. The score is capped because we cannot confirm the site's actual search visibility or indexing state, which is the core purpose of this check.

## what_works
- Tier 2 credentials are correctly configured for PSI/CrUX (API key auth working); the tooling and service-account identity itself are valid, just missing role grants.
- Mobile Lighthouse SEO score: 100/100, Best Practices: 100/100 (homepage) — no crawlability/meta/canonical/robots.txt issues found in lab data.
- Mobile Lighthouse Performance: 83/100. FCP 2.7s, TBT 15ms, CLS 0.031 (good), Speed Index 2.7s.
- robots.txt valid, canonical valid, meta description present, title present, links crawlable, page not blocked from indexing — all confirmed by Lighthouse SEO audit (lab-level signal, not a substitute for real indexing status).

## findings

### 1. GSC service account lacks property access (blocks all Search Console data)
- **Severity:** Critical
- **Description:** `gsc_query.py` (search analytics) returned: `Permission denied for property 'sc-domain:luxurahabitat.com'. Ensure the service account email is added as a user in Google Search Console > Settings > Users and permissions.` Same error on both URL Inspection calls (homepage and a project page): `Permission denied. Add the service account as an Owner in GSC property 'sc-domain:luxurahabitat.com'.` This means we have **zero real query/click/impression/position data** and **zero real indexation status** for any URL on the site right now — everything reported elsewhere in this audit about indexing must be treated as inferred from crawl/lab checks, not confirmed via Google.
- **Recommendation:** In Google Search Console (search.google.com/search-console), go to Settings > Users and permissions for the `sc-domain:luxurahabitat.com` property and add `claude-seo@openclawplaces-494918.iam.gserviceaccount.com` as **Owner** (Owner is required for URL Inspection API; Full/Restricted user is insufficient for that specific call). Re-run once granted — propagation is usually near-instant but can take a few minutes.

### 2. Search Console API not enabled in the GCP project (blocks sitemap status check)
- **Severity:** Critical
- **Description:** The sitemap-status call failed separately from the permission issue above: `Google Search Console API has not been used in project 957832293351 before or it is disabled.` This is a project-level configuration gap, distinct from the per-property access grant in finding #1 — both must be fixed for GSC to work.
- **Recommendation:** Visit `https://console.developers.google.com/apis/api/searchconsole.googleapis.com/overview?project=957832293351` and click Enable. Allow a few minutes for propagation, then re-run `gsc_query.py sitemaps`.

### 3. GA4 service account lacks property access (blocks organic traffic data)
- **Severity:** Critical
- **Description:** Both `ga4_report.py` calls (organic traffic totals/daily, and top-pages) returned: `Permission denied for property 'properties/547237847'. Add the service account email as Viewer in GA4 Admin > Property Access Management.` No sessions, users, or landing-page data could be pulled. We cannot confirm whether the site is receiving any organic traffic at all via GA4.
- **Recommendation:** In GA4 Admin (Property > Property Access Management) for property 547237847, add `claude-seo@openclawplaces-494918.iam.gserviceaccount.com` with **Viewer** role. Re-run once granted.

### 4. No CrUX field data available for the origin (expected for a new/low-traffic site)
- **Severity:** Info
- **Description:** `pagespeed_check.py --crux-only` on the homepage returned: "No CrUX data for this origin. The site likely has insufficient Chrome traffic volume for eligibility." This is expected/normal for a newer site that hasn't yet crossed CrUX's minimum-traffic threshold (CrUX requires a meaningful volume of real Chrome users over the trailing 28 days) — it is **not** a site defect. It does mean we have no real-user CWV numbers yet, only lab data (see below).
- **Recommendation:** No action needed; this will resolve organically as traffic grows. Re-check monthly. Use PSI lab data (below) as the interim proxy, keeping in mind lab data can diverge from real-user field data (e.g. varying network/device conditions of real visitors).

### 5. PSI lab data: homepage LCP is borderline, desktop TBT is poor
- **Severity:** Medium
- **Description:** Since no field CWV exists, PSI lab data (fallback) is the only signal:
  | Metric | Mobile (lab) | Desktop (lab) | Rating |
  |---|---|---|---|
  | LCP | 4.1 s | 2.1 s | Mobile: Poor (>4000ms); Desktop: Good |
  | CLS | 0.031 | 0.021 | Good (both) |
  | TBT (proxy for INP, lab-only) | 15 ms | 1,080 ms | Mobile: fine; Desktop: Poor |
  | Performance score | 83/100 | 55/100 | Mobile good; Desktop needs work |

  Desktop's poor TBT (1,080ms) and Speed Index (2.4s, score 0.46) are driven mainly by Google Tag Manager's script (`gtag/js`) — flagged in diagnostics with 501ms and 493ms long tasks attributed to GTM, plus 67 KiB of unused JS. Mobile LCP of 4.1s (Poor threshold) is linked to render-blocking CSS/fonts (751ms wasted on Google Fonts CSS) and un-optimized image delivery (est. 579 KiB in savings flagged under "Improve image delivery," including unsized/oversized builder-logo PNGs like Godrej, Prestige, Vajram, Mantri logos in the homepage builder marquee).
- **Recommendation:** Defer/async the GTM script or move it off the critical path (e.g. via `requestIdleCallback` or a lightweight loader), preload the LCP hero image, self-host or preconnect+swap Google Fonts to reduce render-blocking, and compress/resize the builder-logo PNGs in `/images/projects/` (several are 70-155 KB each for 48x48px display size — convert to properly-sized WebP).

### 6. Accessibility/security gaps found in lab audit (secondary, not GSC/GA4-related but surfaced by the same PSI call)
- **Severity:** Low
- **Description:** Lighthouse flagged: missing `<main>` landmark, heading order skips a level (H4 appears out of sequence in the footer), insufficient color contrast on footer text/links (e.g. copyright text at 4.01:1, a bronze-on-dark-green heading at 3.74:1), and missing security headers (no CSP, no COOP, no XFO/clickjacking mitigation, HSTS present but missing `includeSubDomains`/`preload`). Accessibility score: 91/100 mobile, 90/100 desktop.
- **Recommendation:** Wrap main content in a `<main>` landmark, fix footer heading hierarchy, bump footer text/link contrast to meet 4.5:1, and add basic security headers (CSP, X-Frame-Options or frame-ancestors, COOP) at the server/CDN level. Lower priority relative to the Critical API-access items above.

## Data freshness / scope notes
- GSC (search analytics, sitemaps, URL Inspection): **not obtained** — all blocked by access/config errors above, not by lack of data. Cannot yet assess whether the "28 days of meaningful data" concern applies; that question is itself blocked until access is granted.
- GA4: **not obtained** — blocked by access error. Cannot report organic session volume or top landing pages.
- CrUX: confirmed empty (insufficient Chrome traffic volume) — expected for a new-ish site, re-check in ~30 days.
- PSI lab data: fresh as of this run (2026-07-31 run timestamp), single test each for mobile/desktop — lab data is a single synthetic run and can vary run-to-run; not a substitute for field CWV.

## Immediate action items for the user (blocking further Google-API analysis)
1. Add `claude-seo@openclawplaces-494918.iam.gserviceaccount.com` as **Owner** on GSC property `sc-domain:luxurahabitat.com`.
2. Enable the Search Console API on GCP project `openclawplaces-494918` (957832293351).
3. Add `claude-seo@openclawplaces-494918.iam.gserviceaccount.com` as **Viewer** on GA4 property `547237847`.
4. Re-run this audit step once all three are done to get real query/indexation/traffic data.
