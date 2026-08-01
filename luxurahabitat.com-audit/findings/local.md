# Local SEO Audit — luxurahabitat.com

**Score: 40/100**

Business type: **Hybrid, leaning Service-Area-Business (SAB)**. No street address anywhere on the site or in schema — only "Bengaluru, Karnataka, India" — phone/WhatsApp is the primary contact channel (`tel:+918438344093`, `wa.me/918438344093` appear on every page), and `/contact/` explicitly labels itself a "Service Area Office." This is the correct posture for an independent real estate advisor and should not be changed by inventing a fake storefront address.

Industry vertical: **Real Estate (advisory/consultancy, India)**. Confirmed via RERA-registration language, `hasOfferCatalog` of plot/apartment/legal-due-diligence services, developer-partner marquee, project listing pages, and "Advertiser/Agent RERA" disclosures on individual project blog posts.

## Dimension Breakdown

| Dimension | Weight | Estimate | Weighted |
|---|---|---|---|
| GBP Signals | 25% | 25/100 | 6.25 |
| Reviews & Reputation | 20% | 40/100 | 8.0 |
| Local On-Page SEO | 20% | 70/100 | 14.0 |
| NAP Consistency & Citations | 15% | 30/100 | 4.5 |
| Local Schema Markup | 10% | 45/100 | 4.5 |
| Local Link & Authority Signals | 10% | 30/100 | 3.0 |
| **Total** | | | **~40** |

## What Works

- **WhatsApp + tel CTAs are present on literally every page** (`tel:+918438344093`, `wa.me/918438344093`), click-tracked via GA4 in the capture phase — strong conversion/engagement infrastructure for an SAB where GBP messaging and click-to-call substitute for foot traffic.
- **Named individual advisor with E-E-A-T signals**: `/about/` carries a `Person` schema for Narayanan Rajesh with `hasCredential` (both RERA registrations), bio, and a dedicated testimonials section — this is exactly the kind of practitioner-level trust signal Google rewards for advisory/service businesses.
- **Four well-developed area/service hub pages** (`/areas/devanahalli/`, `/areas/hennur/`, `/areas/yelahanka/`, `/areas/kanakapura-road/`) each carry unique market data, project inventory, FAQs, and internal links to matching blog content — this is the "dedicated service pages" pattern called out as the #1 local-organic and #2 AI-visibility ranking factor in the current guidance.
- **Core NAP (name, phone, email) is verbatim-consistent** everywhere the footer `nap-block` appears: "Narayanan Rajesh" / "+91 84383 44093" / "projectinfoindia@gmail.com" match across homepage, about, contact, testimonials, developers, areas index, and blog posts.
- **`hasOfferCatalog` schema clearly itemizes services** (plot consultation, apartment/villa advisory, RERA and legal due-diligence support) — useful entity/service disambiguation for Google and AI answer engines.
- **RERA registration is disclosed prominently and repeatedly**, and the footer disclaimer transparently states the business is an independent facilitator, not a developer — reduces misleading-claims risk, which matters heavily in the Indian real-estate trust/compliance context.

## Findings

### 1. No detectable Google Business Profile signals anywhere on-site
- **Severity:** Critical
- **Description:** Sitewide search for Maps embeds, `g.page`/`goo.gl/maps`/`maps.app.goo.gl` links, a Place ID/CID reference, or a "read our Google reviews" widget targeting the business itself returned nothing on the homepage, `/about/`, or `/contact/` (the only Maps embeds found anywhere are on individual *project* pages — `sattva-sanio`, `sattva-kaveri-siri`, `vajram-vivera` — pointing at developer project locations, not Luxura Habitat's own listing). `/contact/` has a "Service Area Office" text block but no Maps/GBP link at all.
- **Recommendation:** Confirm the GBP exists and is claimed under the correct primary category (likely "Real Estate Consultant" or "Real Estate Agent" for a solo/SAB advisory — GBP primary category is the #1 ranking factor per current guidance, and the wrong category is the #1 *negative* factor). Then surface it on-site: embed a Maps/place link and a live review widget on `/contact/` and the homepage, and keep the profile posting active — rankings fall off a cliff after 18 days without a new review (Sterling Sky).

### 2. RERA/NAP footer disclosure is inconsistent across templates
- **Severity:** High
- **Description:** Most pages (homepage, `/about/`, `/contact/`, `/testimonials/`, `/developers/`, `/areas/`, most blog posts) show `RERA: TN/Agent/0082/2024 | KA: PRM/KA/RERA/1251/310/AG/170823/000045` in the footer `nap-rera` span. `areas/yelahanka/index.html` (line 1309) drops the Tamil Nadu registration entirely and shows only `RERA: KA: PRM/KA/RERA/1251/310/AG/170823/000045`. Meanwhile `areas/devanahalli/`, `areas/hennur/`, and `areas/kanakapura-road/` — the three highest-intent local landing pages on the site — have **no `nap-block` footer at all**: no name, no phone, no RERA line, only a stripped-down link footer.
- **Recommendation:** Do not guess which RERA line is "correct" for Yelahanka — confirm with the business owner whether both registrations legitimately apply sitewide, then propagate the confirmed line identically to every template (this is the same failure mode already flagged in project memory for per-project RERA numbers — apply the same "placeholder + ask, then sync everywhere" discipline here). Add the standard footer NAP block to the three area hub pages currently missing it.

### 3. LocalBusiness schema uses the generic type instead of the Google-recommended `RealEstateAgent` subtype
- **Severity:** High
- **Description:** The business/publisher entity is declared as `"@type": "LocalBusiness"` in `index.html` (line 460), `areas/index.html` (line 383), and `developers/index.html` (line 439). Per Schema.org guidance for the real estate vertical, both agents and brokerages should use `RealEstateAgent` — there is no separate `RealEstateBrokerage` type, and `LocalBusiness` is the generic fallback to avoid when a specific subtype exists.
- **Recommendation:** Change `@type` to `RealEstateAgent` in all three locations (and any other page carrying a `publisher`/business schema block), keeping a shared `@id` so the `Person` (`worksFor`) and `CollectionPage` (`publisher`) references all resolve to one consistent entity.

### 4. Business schema is missing several recommended properties, and testimonials aren't marked up as reviews
- **Severity:** Medium
- **Description:** The homepage/about JSON-LD (index.html lines 458-497) includes name, address (city/region/country only — no `geo`), telephone, url, `areaServed`, `hasOfferCatalog`, `employee`, and `sameAs`, but has no `geo`, no `openingHoursSpecification` (despite "Available Mon–Sat, 9 AM – 7 PM IST" being stated in plain text on `/contact/`), no `priceRange`, and no `aggregateRating`/`review`. Six detailed, named testimonials exist on `/testimonials/` and `/about/` but carry zero `Review` or `AggregateRating` markup anywhere for Luxura Habitat itself (the only `aggregateRating`/`Review` schema found sitewide is on two unrelated project pages — `assetz-palmscape`, `orchid-salisbury` — for the *project*, not the advisory business).
- **Recommendation:** Add `openingHoursSpecification` matching the text already published on `/contact/`. Only add `aggregateRating`/`Review` schema if a real, verifiable rating exists (e.g., from GBP once confirmed) — do not fabricate a star rating from unstructured testimonial text.

### 5. No detectable citation footprint on any Tier-1 or India-specific real estate directory
- **Severity:** Medium
- **Description:** A sitewide search for mentions of/links to 99acres, MagicBricks, Housing.com, Sulekha, JustDial, IndiaMart, or Trustpilot returned zero results anywhere in the codebase, and no outbound GBP/Maps link exists to independently verify a listing. (Note: a live web check for citation presence via WebFetch against Google Search returned no usable rendered results — see Limitations below — so this finding is based on the absence of any on-site reference/backlink to these directories, not a confirmed absence of the listings themselves.)
- **Recommendation:** Verify/build NAP-identical listings on Google Business Profile, 99acres, MagicBricks, Housing.com's agent-profile program, JustDial, and Sulekha using the exact name "Luxura Habitat" and phone "+91 84383 44093," and link at least the GBP listing from the site footer or `/contact/` page. Three of the top five AI-visibility ranking factors are citation-related, so this is a meaningful gap for an SAB with no physical storefront to anchor local relevance.

### 6. `areaServed` is a flat string array rather than typed `Place` entities
- **Severity:** Low
- **Description:** `index.html` lines 473-476 list `areaServed` as plain strings (`"Kanakapura Road", "South Bengaluru", "Sarjapur Road", ...`) rather than `{"@type":"Place","name":"...","sameAs":"https://en.wikipedia.org/wiki/..."}` objects.
- **Recommendation:** Upgrade to typed `Place` objects with `sameAs` links per the industry-recommended SAB schema pattern for stronger entity disambiguation (not a Google-required field, but helps AI/knowledge-graph matching).

### 7. Two heavily-marketed micro-markets have no dedicated area page
- **Severity:** Low
- **Description:** "Sarjapur Road" and "Whitefield" both appear prominently in the homepage hero, meta description/keywords, and the `areaServed` schema list, and testimonials reference Bannerghatta Road/South Bengaluru/Jindal City — but `/areas/` only has sub-pages for Devanahalli, Hennur, Yelahanka, and Kanakapura Road. Dedicated service/location pages are called out as the #1 local-organic ranking factor; these two corridors currently have no page to rank or convert on.
- **Recommendation:** Either build `/areas/sarjapur-road/` and `/areas/whitefield/` pages at the same depth as the existing four (unique market data, project inventory, FAQs), or scale back the homepage/schema claims to areas where there's an actual dedicated page and live inventory.

### 8. NAP address shape (no street address) is appropriate for this business type
- **Severity:** Info
- **Description:** The `PostalAddress` in schema and the visible footer both use city/region/country only, with no `streetAddress`. Given the confirmed SAB/hybrid posture (no storefront, WhatsApp/phone-first contact), this is the correct pattern and should not be "fixed" by adding a fabricated street address purely to satisfy a generic LocalBusiness schema checklist.

## Limitations

- **No live GBP data.** Could not confirm whether a Google Business Profile exists, its claimed primary category, verification status, live review count/rating, review velocity (18-day rule), Q&A activity, or Google Posts cadence — this requires either direct GBP dashboard access or a paid data source (e.g., DataForSEO's business-listing search). The `dataforseo.md` finding for this audit confirms no DataForSEO MCP tools were available this session.
- **No live citation/directory scan.** A WebFetch attempt against Google Search for "Luxura Habitat Bengaluru real estate" returned only a rendered accessibility placeholder, not usable search results (JS-rendered/blocked page), so Tier-1 and India-specific directory presence (99acres, MagicBricks, JustDial, Sulekha, Housing.com, Google Maps) could only be assessed by absence-of-reference on the site itself, not confirmed directly against the live directories.
- **No backlink/local-authority data.** Local link signals (dimension 6) could not be measured without a backlink index; the 30/100 estimate is a conservative default reflecting the absence of any external citation evidence found during this audit, not a measured score.
- **Review authenticity/response patterns unassessed.** The six testimonials on `/testimonials/` and `/about/` are plain text with named clients and project names but no visible date stamps, source attribution (Google/GBP vs. site-collected), or star ratings — cannot assess recency, velocity, or owner-response patterns from this content alone.
