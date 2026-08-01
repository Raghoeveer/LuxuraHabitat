# Maps Intelligence Audit — luxurahabitat.com

**Score: 32/100**

**Capability tier detected: Tier 0 (free APIs only).** No `mcp__dataforseo__*` tools were reachable in this session (consistent with `findings/dataforseo.md`, which confirms the DataForSEO MCP server was unavailable to the parallel enrichment agent). All data below comes from Nominatim (geocoding), Overpass API (OSM competitor POIs), and WebFetch against Google/Bing search and the live site — no DataForSEO credit was spent.

Business type confirmed (same conclusion as `findings/local.md`): **Service-Area Business (SAB)**. `/contact/` labels itself "Service Area Office," the schema `PostalAddress` has no `streetAddress`, and the business is an independent RERA-registered advisor (Narayanan Rajesh) working across four target corridors: Devanahalli, Hennur, Yelahanka, Kanakapura Road (plus Sarjapur Road, Whitefield, Thanisandra, South Bengaluru per the existing `areaServed` list).

## Dimension Breakdown (Tier 0 weights, geo-grid 25% redistributed per rubric)

| Dimension | Weight | Estimate | Weighted |
|---|---|---|---|
| GBP Profile Completeness (20%+10%) | 30% | 30/100 | 9.0 |
| Review Health (20%+10%) | 30% | 25/100 | 7.5 |
| Cross-Platform Presence (15%+5%) | 20% | 15/100 | 3.0 |
| Competitor Position | 10% | 55/100 | 5.5 |
| Schema & AI Readiness | 10% | 65/100 | 6.5 |
| **Total** | | | **~32** |

Geo-Grid Visibility / SoLV (normally 25%) was **not assessed** — that requires DataForSEO Maps SERP with `location_coordinate`, which was intentionally not used per the task's instruction to protect the shared $1 DataForSEO trial balance for the SERP/keyword agent. This is the single largest blind spot in the score above; see Limitations.

## What Works

- **Geocodable, unambiguous locality anchors.** All four target corridors resolved cleanly via Nominatim to precise coordinates (Devanahalli 13.2484, 77.7134; Hennur 13.0371, 77.6414; Yelahanka 13.1007, 77.5963; Kanakapura Road 12.9189, 77.5739) — the business is naming real, well-defined OSM-recognized places, not vague/ambiguous micro-market labels, which is a good foundation for any future geo-grid or "near me" targeting.
- **LocalBusiness schema already exists sitewide** (`index.html` lines 456-497) with `name`, `telephone`, `email`, `address`, `areaServed` (8 localities), `hasOfferCatalog`, a named `employee` with RERA `identifier`, and `sameAs`. This is a real foundation to extend, not a from-scratch build.
- **Correct SAB posture on address.** No fabricated street address anywhere — city/region/country only, matching a business with no public storefront. This is the right pattern and should not be "fixed" by inventing a fake pin.
- **WhatsApp + tel click paths are present everywhere**, which matters for Maps/GBP conversion even in the absence of a verified profile (a claimed GBP for a real estate consultant benefits directly from an already-optimized click-to-contact experience).

## Findings

### 1. Cannot verify whether a Google Business Profile exists at all
- **Severity:** Critical
- **Description:** No free-tier tool available to this agent can query live Google Business Profile / Google Maps data (Nominatim and Overpass are OSM-sourced, not Google's index; DataForSEO's My Business Info API was intentionally not used to preserve the shared trial budget). A direct Nominatim name search for `"Luxura Habitat, Bengaluru"` returned zero results (OSM has no POI node for the business), and WebFetch against `google.com/search?q="Luxura Habitat" Bengaluru reviews` and `bing.com/search?q="Luxura Habitat" Bengaluru real estate` returned no usable rendered business-listing signal (both search engines return JS-heavy/blocked pages to generic fetchers, not a knowledge panel). The homepage, `/about/`, and `/contact/` also carry no outbound Maps/GBP link, no embedded map, and no CID/Place ID reference anywhere in the codebase. This is the same gap `findings/local.md` finding #1 already flags from the on-page side — this confirms it independently from the geo-data side and adds that OSM itself has no record of the business either.
- **Recommendation:** Confirm directly in the Google Business Profile dashboard (owner/admin login) whether a listing exists, is claimed, and is verified. If it exists, set it up as a Service Area Business (hide address, define a service-area radius or the specific localities/pincodes served) under the primary category "Real Estate Consultant" or "Real Estate Agent." If it does not exist, create one — for an SAB with no walk-in office, GBP presence is close to a prerequisite for any Maps-surface visibility at all in Devanahalli/Hennur/Yelahanka/Kanakapura Road searches. Once confirmed, a DataForSEO My Business Info pull (single low-cost call) would give live completeness scoring — recommend spending a small slice of the trial budget on exactly this one call if it becomes available, since it is otherwise unverifiable for free.

### 2. No detectable review-platform presence anywhere (Google, or otherwise)
- **Severity:** Critical
- **Description:** No `AggregateRating` or `Review` schema exists for the business anywhere in the codebase (only two unrelated *project* pages — `assetz-palmscape`, `orchid-salisbury` — carry review schema for the property, not the advisory). `/testimonials/` and `/about/` show six named client quotes as plain text with no date stamps, source attribution, or star ratings, so they cannot be traced to Google, JustDial, or any other platform. Real estate is a trust-heavy vertical for SAB searches, and this business currently shows zero portable, platform-verified review signal for either Google Maps or the "likely just Google" cross-platform scope named in this task (Tripadvisor/Trustpilot are not relevant categories for a real estate advisory and were not checked further).
- **Recommendation:** Once a GBP is confirmed/claimed, prioritize review acquisition immediately — review recency and velocity are known Maps ranking inputs, and a profile with zero or stale reviews will underperform an SAB competitor with even a handful of recent ones. Add a "Leave us a Google review" link (once the GBP Place ID is known) to `/contact/`, `/testimonials/`, and post-transaction WhatsApp follow-ups. Do not fabricate `AggregateRating` schema from the unstructured testimonial text — only mark up reviews with a real, attributable source.

### 3. Zero cross-platform map/directory footprint detected outside the website itself
- **Severity:** High
- **Description:** `sameAs` in the schema block contains only `https://wa.me/918438344093` — no Google Maps, Bing Places, Apple Maps, JustDial, 99acres, MagicBricks, Sulekha, or Housing.com reference anywhere in the codebase (confirmed via `grep` across `index.html` and `about/index.html`). Nominatim/OSM independently shows no POI node for the business (a proxy for Apple Maps / OSM-derived map data, since Apple Maps licenses OSM data in some regions). This is consistent with `findings/local.md` finding #5, adding the OSM-negative-result as new evidence specific to this audit.
- **Recommendation:** Build/verify NAP-identical listings (name: "Luxura Habitat", phone: +91 84383 44093) on Google Business Profile (priority 1), Bing Places for Business (free, ~10 minutes, directly improves Bing/Copilot local answers), and at least one India-specific real estate directory (99acres agent profile or MagicBricks agent profile) to seed OSM/Apple Maps indirectly and diversify off-site citation sources.

### 4. Competitor radius mapping shows uneven OSM density across the four target corridors — Kanakapura Road is the most visibly contested
- **Severity:** Medium
- **Description:** Overpass API queries for `office=estate_agent` / `shop=real_estate` around each locality's geocoded center returned:
  - **Kanakapura Road** (4 km radius, center 12.9189, 77.5739): **6 mapped competitors** — Homigo Realty Private Limited, SMS Real Estate Agency, Nirman Shelter Pvt. Limited, Sri Sai Pinnacle, "chif n' dale," SLV Associates.
  - **Yelahanka** (3 km radius, center 13.1007, 77.5963): **1 mapped competitor** — Dhani Properties.
  - **Hennur** (3 km radius, center 13.0371, 77.6414): **0 mapped competitors.**
  - **Devanahalli** (7 km radius, center 13.2484, 77.7134): **0 mapped competitors.**
  These are raw OSM POI counts, not a live SERP-position comparison (that requires DataForSEO Maps SERP, out of scope here) — Overpass rate-limited this session's IP mid-run (`rate_limited` error on a Hennur re-query and an initial Kanakapura Road attempt), so the zero counts for Hennur/Devanahalli likely reflect OSM under-mapping of small local agents in India (a known, well-documented gap) rather than a genuinely empty competitive field — both corridors have significant real-world real estate activity given the airport-corridor (Devanahalli) and ORR/metro (Hennur) growth narratives already published on the site's own `/areas/` pages.
- **Recommendation:** Treat the OSM zero-counts as "invisible on this data layer" rather than "no competitors" — do not use them to conclude Devanahalli/Hennur are uncontested. For a directional live competitor read, a single DataForSEO Business Listings Search call per locality (4 calls, low cost) would give an actual current competitor count/rating comparison if budget allows; otherwise treat Kanakapura Road as the corridor with the most establishable local-agent density signal and prioritize GBP/citation work there first, while still building Devanahalli/Hennur presence proactively ahead of visible competition.

### 5. `areaServed` is a flat string array with no coordinates — recommend structured `Place`/`GeoCircle` upgrade
- **Severity:** Medium
- **Description:** `index.html` lines 473-476 list `areaServed` as plain strings (`"Kanakapura Road"`, `"Devanahalli"`, `"Hennur"`, etc.) with no `@type`, no `geo`, and no explicit `serviceArea` property at all. This is the same gap flagged as Low severity in `findings/local.md` finding #6 from an entity-disambiguation angle; from a Maps/geo-data angle it also means the schema carries no machine-readable coordinates that a Maps-crawling or AI-answer engine could use to confirm the four target localities are real, nearby places actually served by a Bengaluru-based advisor (as opposed to string-matched keyword stuffing).
- **Recommendation:** Upgrade to typed `Place` entities with real coordinates (geocoded via Nominatim, reusable without any paid API) and add an explicit `serviceArea` `GeoCircle` centered on the four-corridor centroid. Suggested JSON-LD to merge into the existing schema block:

```json
{
  "serviceArea": {
    "@type": "GeoCircle",
    "geoMidpoint": {
      "@type": "GeoCoordinates",
      "latitude": 13.076,
      "longitude": 77.631
    },
    "geoRadius": "35000"
  },
  "areaServed": [
    {
      "@type": "Place",
      "name": "Devanahalli",
      "geo": { "@type": "GeoCoordinates", "latitude": 13.2484, "longitude": 77.7134 }
    },
    {
      "@type": "Place",
      "name": "Hennur",
      "geo": { "@type": "GeoCoordinates", "latitude": 13.0371, "longitude": 77.6414 }
    },
    {
      "@type": "Place",
      "name": "Yelahanka",
      "geo": { "@type": "GeoCoordinates", "latitude": 13.1007, "longitude": 77.5963 }
    },
    {
      "@type": "Place",
      "name": "Kanakapura Road",
      "geo": { "@type": "GeoCoordinates", "latitude": 12.9189, "longitude": 77.5739 }
    },
    { "@type": "Place", "name": "South Bengaluru" },
    { "@type": "Place", "name": "Sarjapur Road" },
    { "@type": "Place", "name": "Whitefield" },
    { "@type": "Place", "name": "Thanisandra" },
    { "@type": "City", "name": "Bengaluru", "containedInPlace": { "@type": "State", "name": "Karnataka" } }
  ]
}
```
  `geoRadius` (35 km, in meters) and `geoMidpoint` are an approximation derived from the centroid of the four geocoded corridor centers — treat as a starting point and adjust once the business confirms its actual furthest-served locality (e.g., if Whitefield/Sarjapur Road extend the true radius further east/south). Only the four primary corridors have coordinates above since those are the ones with dedicated `/areas/` pages today (per `findings/local.md` finding #7, Sarjapur Road/Whitefield currently have no dedicated page — resolve that gap before over-indexing schema on them).

## Cross-Skill Delegation Notes

- Full on-page local SEO analysis (NAP consistency across templates, RERA footer discrepancy, `RealEstateAgent` vs `LocalBusiness` type recommendation, missing area pages) is already covered in `findings/local.md` — not duplicated here.
- Full LocalBusiness schema validation beyond the serviceArea/areaServed recommendation above is covered in `findings/schema.md`.
- No AI-visibility/GEO citation analysis was performed here — see `findings/geo.md`.

## Cost Report

**$0.00 DataForSEO credit consumed.** Every data point above came from Nominatim (free, rate-limited to 1 req/sec, `User-Agent` header set), Overpass API (free, IP rate-limited — hit twice this session), and WebFetch against public search engines and the live site. No DataForSEO MCP tool was called at any point, in line with the instruction to leave the shared $1 trial budget for the SERP/keyword/backlink agent.

## Limitations

- **No Geo-Grid / SoLV data.** The single highest-weight dimension in the standard rubric (25%) could not be assessed at all — this requires DataForSEO Maps SERP with `location_coordinate`, deliberately not used here. The 32/100 score above is calculated on the Tier-0 redistributed rubric (GBP +10%, Reviews +10%, Cross-Platform +5%) precisely to account for this, but it still means there is no live "where does Luxura Habitat actually rank on the Map pack for 'real estate agent near me' in each corridor" answer in this report.
- **GBP existence itself is unconfirmed, not confirmed-absent.** Every free-tier signal checked (OSM/Nominatim, on-site links, generic search-engine WebFetch) is negative, but none of these tools can authoritatively state "no GBP listing exists" — only the GBP dashboard or a paid live-data source (DataForSEO My Business Info, Google Places API) can do that. Treat finding #1 as "presence undetectable by free tools," not "confirmed non-existent."
- **Overpass rate-limiting mid-session.** The shared `overpass-api.de` endpoint returned `rate_limited` errors twice (once on Kanakapura Road, once on a Hennur re-query at larger radius) due to this IP's request volume. Results were still obtained after backoff/retry for 3 of 4 corridors, but the Hennur figure (0 competitors) reflects only a single successful 3 km-radius query and was not independently re-verified at a larger radius.
- **No Geoapify data.** No Geoapify API key was available/configured in this environment, so the structured-POI-search fallback described in the skill's Tier 0 capabilities was not used; Overpass was the sole competitor-discovery source.
- **Cross-platform checks are directional, not authoritative.** WebFetch against `google.com/search` and `bing.com/search` returned blocked/JS-rendered placeholder pages rather than genuine SERP HTML in both cases — the "no listing found" conclusion is based on absence-of-evidence from a degraded fetch, not a clean confirmed-negative search result.
