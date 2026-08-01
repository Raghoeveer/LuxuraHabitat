# Schema.org / Structured Data Audit — luxurahabitat.com

Audited via local repo source (all 62 sitemap URLs cross-referenced against `/Users/raghuveernr/Desktop/luxuraHabitat`). Method: extracted every `application/ld+json` block per template class (homepage, 18 project pages, 30 blog posts, 4 area pages, hub/index pages, about/contact/testimonials).

## Score: 60 / 100

The blog template (30/30 posts) is a genuinely strong, consistent `BlogPosting` + `BreadcrumbList` implementation. Project pages — the commercially most important template — are inconsistent: three project pages ship **zero** listing/business schema, one has an invalid `Product` price format, and most lack `BreadcrumbList`. Several hub pages (`/projects/`, `/blog/`, `/contact/`, `/testimonials/`) carry no structured data at all. Area pages skip the `LocalBusiness`/`Place` schema that would reinforce their local-SEO purpose.

---

## What Works

- **Blog template is excellent and 100% consistent**: all 30 blog posts (`/blog/*/index.html`) use a single `@graph` combining `BlogPosting` + `BreadcrumbList`, each with `headline`, `description`, `image` (absolute URL), `datePublished`/`dateModified` in ISO 8601, `author` (Person, linked to `/about/`), and `publisher.logo` (ImageObject with absolute URL). This is the correct pattern and should be the template copied elsewhere.
- **`@context` is `https://schema.org` (HTTPS) everywhere** — no legacy `http://schema.org` instances found.
- **Homepage `LocalBusiness` is structurally valid**: correct nesting of `PostalAddress`, `hasOfferCatalog` → `OfferCatalog` → `Offer` → `Service`, and `employee` → `Person` with a real (non-placeholder) RERA agent identifier. No syntax errors.
- **`tvs-emerald-altura` is the best-built project page**: RERA number is encoded as a proper machine-readable `PropertyValue` (`identifier.value`), and pricing uses numeric `AggregateOffer`/`Offer` values — this should be the reference template for the other 17 project pages.
- **About page `Person`/`EducationalOccupationalCredential`** correctly models the RERA-registered agent with real (not placeholder) registration numbers for both Karnataka and Tamil Nadu RERA.
- No deprecated types found anywhere (no `HowTo`, `SpecialAnnouncement`, `CourseInfo`, `EstimatedSalary`, `LearningVideo`).

---

## Findings

### 1. Three project pages have zero listing/business schema — only FAQPage
- **Severity:** Critical
- **Description:** `/projects/sattva-la-vita/`, `/projects/sattva-lumina/`, and `/projects/sattva-aeropolis/` each contain exactly one JSON-LD block, and it is `FAQPage` only. There is no `RealEstateListing`, `Product`, `Offer`, or `LocalBusiness`/`RealEstateAgent` schema at all — despite these being priced, RERA-registered listings (e.g. RERA number `PRM/KA/RERA/1251/446/PR/041223/006446` for Sattva La Vita is only present as unstructured text buried inside a FAQ answer, not as a machine-readable property). Since FAQPage no longer produces a Google rich result (retired for all sites), these three pages currently derive **no structured-data value at all**, Google SERP or otherwise.
- **Recommendation:** Add a `RealEstateListing`/`Offer` block matching the pattern used on `assetz-zen-sato` or `tvs-emerald-altura` (numeric price, absolute image URLs, RERA number as a structured `identifier`/`PropertyValue`, not just prose). Example for Sattva La Vita:
```json
{
  "@context": "https://schema.org",
  "@type": "RealEstateListing",
  "name": "Sattva La Vita",
  "description": "Premium apartments by Sattva Group in Hennur, North Bengaluru.",
  "url": "https://luxurahabitat.com/projects/sattva-la-vita/",
  "image": "https://luxurahabitat.com/images/projects/sattva-la-vita/hero.webp",
  "address": {
    "@type": "PostalAddress",
    "addressLocality": "Hennur",
    "addressRegion": "Karnataka",
    "addressCountry": "IN"
  },
  "about": {
    "@type": "HousingProject",
    "name": "Sattva La Vita",
    "identifier": {
      "@type": "PropertyValue",
      "name": "Karnataka RERA Registration Number",
      "value": "PRM/KA/RERA/1251/446/PR/041223/006446"
    }
  },
  "agent": {
    "@type": "RealEstateAgent",
    "name": "Luxura Habitat",
    "telephone": "+918438344093",
    "email": "projectinfoindia@gmail.com"
  }
}
```
(Keep the existing FAQPage block too — just add this alongside it, ideally merged into one `@graph`.)

### 2. Invalid, non-numeric `price` in Product schema on orchid-salisbury
- **Severity:** Critical
- **Description:** `/projects/orchid-salisbury/index.html` has a `Product` block with four `Offer`s where `"price"` is a currency-word string, e.g. `"price": "1.03 Crore"`, `"price": "1.7 Crore"`. Google's structured-data spec requires `Offer.price` to be a plain number (as string or numeric), with `priceCurrency` carrying the currency separately — `"1.03 Crore"` will fail the Rich Results Test and be ignored/dropped for Product rich results. Note this page's own `RealEstateListing` block (same page) correctly uses numeric `lowPrice`/`highPrice` (`10300000`/`17000000`), so the values are internally consistent — only the format in the `Product` block is broken.
- **Recommendation:** Fix each offer, e.g.:
```json
{
  "@type": "Offer",
  "name": "2 BHK Compact",
  "priceCurrency": "INR",
  "price": "10300000",
  "availability": "https://schema.org/InStock",
  "url": "https://luxurahabitat.com/projects/orchid-salisbury/",
  "description": "930 sq ft, starting from ₹1.03 Crore"
}
```
Also add `priceValidUntil` (Google recommends this for Product offers) and change the `"image": "sal.jpg"` relative path to an absolute URL (see Finding 3).

### 3. Placeholder empty strings and relative (non-absolute) URLs in project schema
- **Severity:** High
- **Description:**
  - `assetz-palmscape`: 4 occurrences of `"url": ""`, 1 `"logo": ""`, 1 `"sameAs": []` across its `RealEstateAgent`/`LocalBusiness`/`RealEstateListing`/`Organization` blocks — all invalid/placeholder for URL-typed properties. Also uses relative image paths (`"Assetz-Palmscape-grand-entrance-wide-angle-image.webp"`) instead of absolute URLs in 3 places.
  - `orchid-salisbury`: 3 occurrences of `"url": ""`, and `"image": "sal.jpg"` (relative) in the `Product` block.
  - `sattva-kaveri-siri`: `"image": "Kaveri-Siri-banner-1.jpg"` (relative) in `RealEstateAgent`.
  - `tvs-emerald-altura`: 1 occurrence of `"url": ""`.
- **Recommendation:** Fill every empty `url`/`logo`/`sameAs` with the real page URL / actual logo asset, and prefix every `image` value with `https://luxurahabitat.com/...` (absolute). An empty string is worse than omitting the property — omit if no real value exists.

### 4. BreadcrumbList missing on 12 of 18 project pages, and on all hub pages
- **Severity:** High
- **Description:** Only `assetz-palmscape`, `assetz-zen-sato`, `brigade-eternia`, `concorde-mayfair`, `sattva-city`, `tvs-emerald-altura`... (checked programmatically) — actually only 6 of 18 project pages contain `BreadcrumbList`. The other 12 (`assetz-zen-sato`, `brigade-eternia`, `assetz-palmscape`, `concorde-mayfair`, `sattva-city`, `tvs-emerald-altura`, `orchid-salisbury`, `sattva-aeropolis`, `sattva-kaveri-siri`, `sattva-sanio`, `sattva-lumina`, `sattva-la-vita`) have none. [Note: grep found these 12 files lack the string "BreadcrumbList" at all.] Separately, `/projects/`, `/blog/`, `/contact/`, and `/testimonials/` index/hub pages have **zero** JSON-LD blocks of any kind, unlike `/areas/` and `/developers/` which have `CollectionPage` + `LocalBusiness`.
- **Recommendation:** Add a consistent `BreadcrumbList` (Home → Projects → [Project Name]) to every project page, matching the pattern already used correctly on all blog posts. Add at minimum a `CollectionPage` (matching `/areas/` and `/developers/`) to `/projects/`, `/blog/`, and `/contact/`; consider `ItemList` on `/projects/` and `/blog/` to enumerate the listings/posts.

### 5. Area pages lack LocalBusiness/Place schema
- **Severity:** Medium
- **Description:** `/areas/devanahalli/`, `/areas/hennur/`, `/areas/kanakapura-road/`, `/areas/yelahanka/` each only carry generic `WebPage` + `BreadcrumbList` + `Organization`(ImageObject) schema — no `Place` or `LocalBusiness` entity representing the micro-market itself, and no `geo` coordinates, despite these pages being location-specific and the `/areas/` index page itself using `LocalBusiness` as publisher.
- **Recommendation:** Add a `Place` entity per area page (with `GeoCoordinates`) and reference it via `areaServed` on a nested `LocalBusiness`, consistent with the geo data already used correctly inside several project pages (e.g. `assetz-palmscape`, `orchid-salisbury`).

### 6. Entity URL mismatch on About page (canonical vs. schema identity)
- **Severity:** Medium
- **Description:** `/about/index.html` has `<link rel="canonical" href="https://luxurahabitat.com/about/">`, but the `Person` schema's `@id` and `url` both use `https://luxurahabitat.com/about.html` (the old flat-file URL, not the clean directory URL). This creates a mismatched/duplicate entity identity for Narayanan Rajesh between what Google indexes as canonical and what the schema declares.
- **Recommendation:** Update both `@id` and `url` in the `Person` block to `https://luxurahabitat.com/about/` to match canonical.

### 7. Homepage LocalBusiness missing several recommended properties
- **Severity:** Low
- **Description:** Homepage `LocalBusiness` (`@id`: `https://luxurahabitat.com/#business`) has no `image`, `geo`, `priceRange`, or `aggregateRating` — all recommended by Google for LocalBusiness-eligible rich results/knowledge panel. `sameAs` contains only a WhatsApp deep link, no real social profile URLs (Google/LinkedIn/Instagram etc. if they exist).
- **Recommendation:** Add `image` (logo/office photo, absolute URL), `priceRange` (e.g. `"₹₹₹₹"` to match project-page convention), and real `sameAs` social profile links if they exist. `geo` is optional since this is a consultancy without a public storefront.

### 8. FAQPage schema present on ~13 project pages — no ongoing Google SERP benefit
- **Severity:** Info
- **Description:** `FAQPage` structured data appears on most project pages (`sattva-aeropolis`, `sattva-la-vita`, `sattva-lumina`, `brigade-eternia`, `century-astoria`, `century-kindle`, `concorde-mayfair`, `kns-sampada`, `orchid-salisbury`, `sattva-city`, `sattva-forest-ridge`, `sattva-kaveri-siri`, `sattva-sanio`, `vajram-chrysanthemum`, `vajram-vivera`). Google retired FAQ rich results for all sites (May 7, 2026), so this markup no longer drives any SERP feature. It is not harmful and any AI/GEO citation benefit is unconfirmed, so it is fine to leave in place — just do not treat it as an SEO deliverable, and do not invest further effort adding it to remaining pages for search-visibility reasons.
- **Recommendation:** No action required. If genuine user-submitted Q&A content is ever added (not marketing FAQ), use `QAPage` instead, not `FAQPage`.

### 9. Testimonials page has no structured data
- **Severity:** Info
- **Description:** `/testimonials/index.html` contains customer testimonials but zero JSON-LD. This is a plausible opportunity for `Review`/`AggregateRating` tied to the `LocalBusiness` entity — but only if the testimonials are genuine, attributable, and verifiable (Google prohibits self-serving/fabricated review markup, and misuse can trigger a manual action).
- **Recommendation:** Only add `Review` schema if each testimonial can be attributed to a real, verifiable person/transaction. Do not fabricate `ratingCount`/`ratingValue` aggregates.

### 10. Inconsistent project-page schema strategy across the 18 project pages
- **Severity:** Info
- **Description:** The 18 project pages use at least 6 different structural approaches: standalone multi-block (`assetz-palmscape`: `RealEstateAgent` + `LocalBusiness` + `RealEstateListing` + `Organization`, 4 separate scripts), `@graph`-combined (`sattva-kaveri-siri`, `tvs-emerald-altura`), `Product`+`Offer` (`orchid-salisbury`), `ApartmentComplex`/`HousingProject` (`brigade-eternia`, `tvs-emerald-altura`), bare `Residence` (`century-kindle`, `century-astoria`, `kns-sampada`, `vajram-vivera`, `vajram-chrysanthemum`, `sattva-forest-ridge`), and FAQ-only (Finding 1). Note also that `RealEstateListing` (used most often) is valid schema.org markup but is **not** one of Google's supported rich-result types — only `Product`+`Offer` (as on orchid-salisbury, once the price format is fixed) is eligible for Google's Product rich result. `RealEstateListing`/`Residence`/`ApartmentComplex` still have value for AI/GEO understanding and Knowledge Graph disambiguation, just not classic SERP rich results.
- **Recommendation:** Standardize on one template (recommend the `tvs-emerald-altura` pattern: `RealEstateListing` + nested `HousingProject`/`identifier` for RERA + `AggregateOffer`/`Offer` for pricing + `BreadcrumbList`), and reserve `Product`+`Offer` specifically where per-unit-type pricing should be rich-result eligible.

---

## Summary Table

| Template | Pages checked | Status |
|---|---|---|
| Homepage | 1 | Valid, missing some recommended properties |
| Blog posts | 30 | Consistent, well-formed `BlogPosting` + `BreadcrumbList` |
| Project pages | 18 | Highly inconsistent; 3 with no listing schema, 1 with invalid price, 12 missing BreadcrumbList |
| Area pages | 4 | Missing `LocalBusiness`/`Place` |
| Hub/index pages | `/projects/`, `/blog/`, `/contact/`, `/testimonials/` | No schema at all |
| Hub/index pages | `/areas/`, `/developers/` | `CollectionPage` + `LocalBusiness`, valid |
| About page | 1 | Valid `Person`, but URL mismatch with canonical |
