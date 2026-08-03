---
name: add-project
description: End-to-end pipeline for launching a new Luxura Habitat project page — parses a builder's source export (images, facts, Web3Forms key), builds an SEO/conversion-optimized page modeled on sattva-aeropolis (with a developer-branded favicon, fully optimized meta tags/headers/structured data), writes 2-3 keyword-researched blog posts, and runs a bidirectional internal-linking pass. Use whenever the user hands over a new project's source folder/content and says to add/build/launch it as a project page, or asks for a site-wide SEO/meta-tag audit.
---

# Add a new project (page + blogs + internal linking)

This skill turns a raw source dump (images + facts + a Web3Forms access key) into a
fully shipped, interlinked project on luxurahabitat.com: one project page, 2-3 blog
posts, and links in both directions to the rest of the site.

**Read `docs/adding-a-project.md` first — it is the canonical build checklist and this
skill does not repeat its line items.** This skill adds the parts that checklist only
gestures at: how to parse the source material, how to isolate a developer-branded
favicon from whatever logo the source hands you, a full on-page SEO checklist (title/
meta/canonical/OG/Twitter/robots/heading-hierarchy/alt-text — not just meta
description length), how to actually do the keyword research for blog topics, and the
precise internal-linking algorithm. Everything in that doc (nav/logo rules, RERA/NAP
footer, FAQ sync, meta description length, redirect field, BreadcrumbList via
`js/seo.js`, verification pass) still applies and is not optional.

Work through the phases below in order. Use TodoWrite to track them — this is a long,
multi-file task and it's easy to silently skip a phase under context pressure.

## Phase 0 — Inputs

You need, at minimum:
- A source folder or file with the project's facts (land area, unit count, density,
  configs + sizes, pricing, possession date, amenities, specifications, location
  proximities, RERA number, developer name, logo).
- A folder of source images (hero/banner, about, amenities, interiors, master plan,
  unit/floor plans, location map, logo).
- A Web3Forms access key for the lead forms.
- If not given, ask: which of the 3 area hubs does this belong to (Devanahalli /
  Hennur-Thanisandra / Yelahanka), or is it standalone? You'll need this for Phase 6.

Read the entire source file before extracting anything — don't skim. Note every
number (units/acre density, sqft ranges, price ranges, possession date, maintenance
estimate, UDS%) verbatim; don't round or infer facts the source didn't give you. If a
floor plan's exact sqft isn't stated, use a qualitative label ("Premium Layout") rather
than fabricating a number.

## Phase 1 — Legal-data collision check (do this before writing anything)

RERA registration numbers must be unique per project. Before using the source's RERA
number anywhere, grep the whole repo for it:

```bash
grep -rl "PRM/KA/RERA/..." --include="*.html" .
```

If it already appears attached to a *different* project, or the source itself contains
multiple different-looking RERA numbers across its own table/FAQ/footer, **do not
guess which is correct.** Ship (or hold) with a clear placeholder and use
AskUserQuestion to surface the conflict with the exact conflicting strings and where
each came from. This has happened twice already (Century Kindle had 3 conflicting
numbers in one source file; Chrysanthemum's source reused Vajram Vivera's live
number) — both times guessing would have shipped a legally wrong number. If the
correction affects an already-shipped page, fix every occurrence there too (table,
footer, visible FAQ text, FAQPage JSON-LD) and re-verify it, not just the new page.

## Phase 2 — Images

Follow `docs/adding-a-project.md` §2 (clean per-project path, never point og:image /
twitter:image / preload at another project's folder). Concretely:

```bash
mkdir -p images/projects/<slug>
# copy/rename source images into it with descriptive names:
#   <slug>-banner.webp, <slug>-about.webp, <slug>-amenities-N.webp,
#   <slug>-interior-N.webp, <slug>-master-plan.webp, <slug>-location-map.webp,
#   <slug>-<config>-<sqft>.webp (unit plans), <slug>-logo.<ext>

# thumbnail for projects/index.html and hub cards:
cwebp -resize 1100 0 -q 82 <source-banner> \
  -o images/projects-thumbs/<slug>-thumb.webp
```

### Favicon (every project page needs its own, developer-branded one)

Every project page's browser-tab icon should be the **developer's own mark**, not
the generic Luxura Habitat favicon — it's how a visitor tells project tabs apart when
several are open, and it reinforces the builder's brand on what is otherwise a
Luxura Habitat-branded page. Don't leave a project page on the site-wide fallback
just because the source logo isn't a clean square — six shipped pages did exactly
that (Assetz Palmscape, Assetz Zen & Sato, Orchid Salisbury, Sattva Kaveri Siri,
Sattva Lumina, TVS Emerald Altura) before being caught and fixed.

- If the source logo file is already a clean square/near-square mark: convert
  directly.
  ```bash
  # sips needs an explicit format flag if the source logo is webp:
  sips -s format png -z 180 180 images/projects/<slug>/<slug>-logo.webp \
    --out images/projects/<slug>/favicon.png
  ```
- If the source logo is a horizontal lockup (icon + wordmark side by side, or a
  wordmark with no separate pictorial mark at all — the common case), **isolate just
  the icon/mark portion** rather than squashing the whole wide logo into a square.
  Use PIL to find the content region and crop it out (scan columns for
  non-background pixels to find the gap between the icon and the wordmark, or scan
  for a distinct color range if the mark is colored and the wordmark is plain
  black/navy), then pad it into a square canvas:
  ```python
  from PIL import Image

  def make_favicon(src_path, crop_box, out_path, pad_ratio=0.14,
                    bg=(255, 255, 255, 255), size=180):
      im = Image.open(src_path).convert("RGBA")
      icon = im.crop(crop_box)
      bbox = icon.getbbox()
      if bbox:
          icon = icon.crop(bbox)
      w, h = icon.size
      side = max(w, h)
      pad = int(side * pad_ratio)
      canvas = Image.new("RGBA", (side + pad * 2, side + pad * 2), bg)
      canvas.paste(icon, ((canvas.width - w) // 2, (canvas.height - h) // 2), icon)
      canvas.resize((size, size), Image.LANCZOS).save(out_path)
  ```
  Preview the crop with Read before wiring it in — check it's still recognizable at
  32px, not just at full size. If two sibling projects share one developer (e.g. two
  Sattva or two Assetz projects), it's fine to reuse the same cropped mark for both.
  If the source has genuinely no isolable icon (just a wordmark, no pictorial
  element, letters overlapping via a connecting flourish so no column-gap exists),
  fall back to letterboxing the full wordmark into a square — better than the
  generic site favicon, even if less legible at 16px.
- Wire it in with the same tag every other project page uses:
  ```html
  <link rel="icon" href="/images/projects/<slug>/favicon.png" type="image/png">
  ```
  This replaces (not supplements) whatever generic `/images/favicon/...` block
  `_TEMPLATE.html` inherited from the site-wide default — a page should end up with
  exactly one `rel="icon"` tag.

## Phase 3 — Build the page

Start from `projects/_TEMPLATE.html` and copy structure/CSS from `sattva-aeropolis`
(the reference the user pointed at) — it's the most conversion-tuned page on the site.
Section order to replicate, top to bottom:

1. `nav` — Luxura Habitat logo (never the builder's), "Authorized Channel Partner"
   caption, sticky, links scroll to each section below.
2. `.hero` with the photo as a **CSS `background-image` directly on the `<section
   class="hero">`** (not a separate `.hero-media` div, not a mobile-only `<img>`) —
   this is what keeps the hero photo visible on mobile with zero extra markup. Inside:
   `.hero-logo` (builder's logo), badge, `<h1>`, quick-facts strip, primary CTA button
   that opens the details panel, WhatsApp button (`wa.me` link, pre-filled message
   naming the project).
3. Trust bar (RERA-registered / possession year / builder credibility strip).
4. `.about` — project overview narrative.
5. `.highlights` — key-facts table (land area, units, density, configs, possession,
   RERA number).
6. `.amenities` — grid + `.gallery-item` photos.
7. `.gallery` — full photo grid, every item `onclick="openLightbox(this)"`.
8. `.plan` (`#units`) — master plan image + unit/floor plan cards. **Master plan and
   every unit/floor-plan image get `onclick="toggleDetailsPanel()"` and
   `style="cursor:pointer;"` — not `openLightbox()`.** These are the images a serious
   buyer clicks to get pricing/detail, so route that click straight into the lead
   panel instead of just showing a bigger picture. Keep `openLightbox()` only for
   interior/amenity/location-map photos.
9. `.pricing` — price table by configuration.
10. `.plan` (`#location`) — location map image (static image + `openLightboxFromSrc`
    is fine; a live Google Maps iframe isn't required — see Century Astoria/Vajram
    Chrysanthemum precedent) + proximity list (schools/employers/transit).
11. Investment/ROI angle section.
12. Developer/builder section.
13. `.faq` — button + schema.org microdata, kept in exact sync with the FAQPage
    JSON-LD (verify this programmatically in Phase 7, don't eyeball it).
14. `.lead-form-section` — the main Web3Forms form.
15. Mobile sticky bottom bar (Call / WhatsApp / Enquire) — `.mobile-cta-btn`.
16. `.project-footer-strip` — "Similar Projects" (`.proj-compare-grid`) + "Market
    Insights" (`.insight-grid`), populated in Phase 5.

Known latent bugs to check for on every new page (found on shipped pages, easy to
silently reinherit by copy-pasting the template):
- `.gallery-item::after` (the "Click to View" hover label) **must have
  `pointer-events: none`** — without it, the pseudo-element sits on top of the `<img>`
  and silently eats the click before `openLightbox()` ever fires. No console error, so
  it's easy to ship broken.
- If you add a fixed vertical "Request Brochure" side-tab (`.sidebar-widget`), give it
  `display: none` inside the existing mobile media query — it has no built-in mobile
  override in the template lineage and overflows past the viewport edge on narrow
  screens. `.mobile-cta-btn` already covers the same affordance on mobile, so hiding it
  there loses nothing.
- Any heading/accent color from the source export gets swapped to this project's own
  brand palette before shipping — don't inherit a generic blue or the wrong project's
  colors just because the source file had them.
- Every Web3Forms form (there are usually 2-3: hero panel, main lead-form section,
  possibly a sticky-bar mini form) needs the hidden `redirect` field set to exactly
  `https://luxurahabitat.com/thank-you/`.
- Every page needs the Zendesk chat widget snippet, right before `</body>` (copy
  verbatim from an existing page, e.g. `projects/kns-sampada/index.html` or
  `projects/vajram-chrysanthemum/index.html` — same key sitewide, don't generate a
  new one):
  ```html
  window.zESettings = {
      webWidget: {
          launcher: {
              chatLabel: { '*': 'Chat now' }
          }
      }
  };

  (function(){
      var script = document.createElement('script');
      script.id = 'ze-snippet';
      script.src = 'https://static.zdassets.com/ekr/snippet.js?key=86305e35-2ef4-45f7-a9e8-2aba11189ef9';
      script.async = true;
      document.body.appendChild(script);
  })();
  ```
  This is what `js/project-page.js`'s automatic `chat:start` GA4 tracking (see
  `docs/adding-a-project.md` §1) actually hooks into — without this snippet on the
  page, that tracking silently has nothing to attach to.
- **WhatsApp click tracking is not reliably automatic — don't assume GA4 catches it
  for free.** `_TEMPLATE.html`'s inline tracking script fires `phone_click`,
  `email_click` and `whatsapp_click` explicitly in the *capture* phase, which is
  deliberate: GA4's own automatic outbound-click detection listens in the *bubble*
  phase, so any WhatsApp button with `onclick="event.stopPropagation()"` (needed on
  card-grid layouts like `projects/index.html`, where the whole card is itself
  clickable and the WhatsApp button must stop that click from also navigating the
  page) silently prevents GA4 from ever seeing the click — this was a real, live gap
  found in production analytics before being fixed. If you copy this inline script
  from `_TEMPLATE.html` verbatim (don't hand-roll a shorter version), WhatsApp clicks
  stay tracked regardless of any `stopPropagation()` elsewhere on the page.

## Phase 4 — SEO: meta tags, headings, structured data, on-page optimization

This phase applies to every page you touch — the new project page, both/all new
blog posts, and any existing page you edit for Phase 6 interlinking. It also applies
retroactively any time you're asked to audit or improve SEO on existing pages, not
just when launching something new — walk the same list per page.

**Research the target query before writing the tags — don't template them.** Check
Google autocomplete and "People also ask" for the project's actual name + locality
(e.g. does this market search "apartments in X" vs "flats in X" vs "villas in X"?
"3 BHK" vs "3BHK" vs "three bedroom"?) and match that vocabulary in the title, H1,
and meta description. These pages often double as landing pages for paid WhatsApp/
lead-gen ads too — keeping the H1 and above-the-fold copy aligned with the likely ad
headline/keyword matters for message-match and Quality Score, not just organic
ranking, so don't let page copy drift from how the project is actually advertised.

- **`<title>`**: unique per page, primary keyword near the front, project name +
  locality + config or angle, brand at the end. Keep it short enough that Google
  doesn't truncate it in the SERP (~55-60 characters is the safe zone — verify actual
  rendered length, not the raw string).
- **`<meta name="description">`**: ~150-160 characters (see
  `docs/adding-a-project.md` — Century Kindle and Vajram Vivera's first drafts both
  shipped over this and got truncated). Check the rendered character count, not the
  HTML-entity-escaped source string.
- **`<meta name="keywords">`**: this site still sets one on every page (see
  `index.html`) — keep the convention, populate it with the same real-intent terms
  the research above surfaced, not a generic list.
- **Canonical**: `<link rel="canonical" href="https://luxurahabitat.com/...">` —
  absolute URL, trailing slash, matching exactly what you put in `sitemap.xml`. A
  page copied from a template can carry over the wrong canonical if you forget to
  update it — check it explicitly, don't assume.
- **Open Graph + Twitter Card**: `og:title`, `og:description`, `og:image`, `og:url`,
  `og:type`, plus `twitter:card` (`summary_large_image`), `twitter:title`,
  `twitter:description`, `twitter:image`. **`og:image`/`twitter:image` must point at
  *this* project's own image folder** — Sattva La Vita shipped pointed at Aeropolis's
  folder, don't repeat it.
- **Robots meta**: should allow indexing (`index, follow`) unless there's a specific
  reason not to. Templates/dev copies occasionally carry a stray `noindex` — check
  for one and remove it before shipping.
- **Structured data**: handled by the JSON-LD `@graph` pattern (RealEstateListing,
  Residence, Organization, FAQPage, LocalBusiness, ImageObject) plus `js/seo.js`'s
  auto-generated `BreadcrumbList` — don't hand-write a second `BreadcrumbList`, that's
  a known duplicate-schema bug (`docs/adding-a-project.md` §1). Validate every JSON-LD
  block actually parses in Phase 8.
- **Heading hierarchy**: exactly one `<h1>` per page (the project name + key
  differentiator — should read like the query someone actually searched), one `<h2>`
  per major section, `<h3>` for sub-points within a section. Never skip a level, and
  never reach for a heading tag just because you want bigger text — that's a CSS
  class's job.
- **Image alt text**: every meaningful image gets descriptive alt text that
  naturally includes what's depicted and, where genuine, the project name/locality
  (e.g. "Vajram Chrysanthemum 3 BHK living room interior") — not a generic filename,
  and not keyword-stuffed either. A recurring failure mode in shipped pages: single-
  or two-word alts like `alt="Elevation"`, `alt="Interiors"`, `alt="Amenities View"`
  that carry zero project/locality context. Every gallery, hero, and floor-plan image
  needs project name + what's depicted (+ config/sqft for unit plans), e.g.:
  - `alt="Elevation"` → `alt="Concorde Mayfair Yelahanka elevation exterior view"`
  - `alt="Interiors"` → `alt="Concorde Mayfair 3 BHK luxury interior design"`
  - `alt="3 BHK Floor Plan 1452 Sq Ft"` → `alt="Concorde Mayfair 3 BHK 1452 sq ft
    floor plan layout"`
- **Favicon**: see Phase 2 — every project page gets the developer's own mark, not
  the site-wide default.
- **URL/slug**: lowercase-hyphenated, matches the project/topic name, consistent
  everywhere it's referenced (internal links, sitemap, canonical).

## Phase 5 — Keyword research → 2-3 blog posts

Do not default to "review post + vs-nearest-sibling" out of habit. For *this*
project, actually check: Google autocomplete and "People also ask" for `[project
name]`, `[project name] + locality`, `[project name] + builder`; what aggregator/
competitor sites already rank for it; and which real intent buckets apply —
price/RERA/floor-plan, locality/commute comparison, investment/ROI, school/employer
proximity, same-developer sibling comparison (only if genuinely justified — e.g. two
projects from the same builder on the same corridor with overlapping positioning, not
just "they're both nearby"). Pick 2-3 topics because the research supports them, and
write down in one sentence why each topic corresponds to real search intent — if you
can't articulate that, it's a default pick, drop it.

For each post:
- URL slug pattern: `blog/<slug-describing-the-query>/`.
- Open with the exact high-intent query as the effective title/H1.
- Include a pricing/fact table pulling from the same verified source numbers as the
  project page — never let a figure drift between the two.
- If it's a legal-data topic (RERA), state the number and, if there's a sibling
  project with a different number, explicitly distinguish the two so a reader doesn't
  conflate them (see the Vivera-vs-Chrysanthemum post for the pattern).
- End with an "Our Honest Assessment" section, not just a sales pitch — this is what
  makes the review posts read as trustworthy rather than an ad, which is itself a
  conversion lever.
- **Funnel every post toward a lead action**: at least one in-content CTA linking to
  the project page's `#form` anchor or a WhatsApp deep link, plus whatever internal
  links Phase 6 adds. A blog post that only informs and never asks for the click is a
  wasted funnel stage.

## Phase 6 — Internal-linking pass (do this explicitly, not incidentally)

1. **Scan for related pages.** Read `sitemap.xml` and the relevant `/areas/<hub>/`
   page to find: (a) sibling project pages in the same area hub, (b) existing blog
   posts covering overlapping locality/topic, (c) the hub page itself.
2. **Insert 3-5 contextual internal links into the new content** (spread across the
   project page + its 2-3 blog posts, not all crammed into one): link out to the area
   hub, to 1-2 genuinely relevant sibling project pages, and to 1-2 existing blog posts
   whose topic actually overlaps (not a random link for link's sake — each one should
   read as something a reader on that sentence would plausibly want to click).
3. **Insert reciprocal links FROM 2-3 existing relevant pages TO the new page(s).**
   This is the step that's easy to skip because it means editing files that aren't the
   new page:
   - Add a card for the new project into the `.project-footer-strip`
     `.proj-compare-grid` on each sibling project page you linked to in step 2 (this
     hand-authored grid — not `js/seo.js`'s `clusters` object, which is dead code for
     this purpose — is what actually renders visible cross-links today).
   - Add the new blog post(s) into the `.insight-grid` of at least one existing
     sibling page or a topically related existing blog post.
   - Add the project + both new posts to the `/areas/<hub>/` page in all 4 spots it
     needs: `.project-hub-card`, one `.blog-hub-card` per post, `.explore-project-card`,
     and the footer's Projects + Insights quick-link columns.
4. Confirm the count: the new page(s) should end up with 3-5 outbound contextual
   links, and 2-3 *other* existing pages should now contain a link back to the new
   page(s) that didn't exist before you started.

## Phase 7 — Site plumbing

- Add the card to `projects/index.html` (copy an existing card's exact shape:
  thumbnail from `/images/projects-thumbs/<slug>-thumb.webp`, `data-area` attribute,
  WhatsApp CTA). If the project doesn't fit any existing `data-area` filter
  (Yelahanka/Devanahalli/Hennur/Whitefield/Kanakapura), use `data-area="other"`
  rather than forcing it into the wrong filter bucket.
- Add a card for each new blog post to **`blog/index.html`'s `.blog-grid`**, at the
  top (newest-first), matching the existing `.blog-card` markup exactly. This is a
  separate, hand-maintained listing page — it is not auto-generated from
  `sitemap.xml` or from the posts' own front matter, so a post can be fully live and
  linked everywhere else and still be invisible here if this step is skipped. This
  step was missed for two prior projects' posts before being caught — don't skip it.
- Add every new URL (project page + each blog post) to `sitemap.xml` with today's date
  as `<lastmod>`.

## Phase 8 — Verify before calling it done

- Tag-balance check (div/section/nav/a/form/table/ul/li) on every new/edited HTML
  file via a quick Python regex script.
- JSON-LD parses (`json.loads` on every `<script type="application/ld+json">` block).
- FAQ visible-text/JSON-LD sync: script-compare `itemprop="name"`/`itemprop="text"`
  against the FAQPage `name`/`acceptedAnswer.text` — must match exactly, count for
  count.
- Every image `src` referenced actually resolves to a file on disk.
- Grep every `alt="..."` on the page for generic one/two-word values (Elevation,
  Interiors, Amenities, Gallery, Exterior, View, Photo, Image, etc.) with no project
  name or locality in them — rewrite each to be descriptive per the Phase 4 alt-text
  rule before shipping.
- Re-run the RERA grep from Phase 1 to confirm no stale/incorrect number survived
  anywhere in the repo.
- Confirm every new blog post URL appears both in `sitemap.xml` **and** as a card in
  `blog/index.html`'s grid — these are two separate lists that don't derive from
  each other, so passing one check doesn't confirm the other.
- Re-check the Phase 4 SEO list per page: title length, meta description length,
  canonical present/correct/absolute, `og:image`/`twitter:image` point at this
  project's own folder, robots meta isn't accidentally `noindex`, exactly one `<h1>`,
  no skipped heading levels, and the favicon link is the developer's own mark (not
  the site-wide default).
- Live check with a local server + Playwright: desktop click-through every nav item
  (scrolls to just below the sticky nav, URL hash updates, zero console errors), FAQ
  accordion (only one open at a time, text matches JSON-LD), and a mobile viewport
  pass (hamburger menu opens, nav-link text has visible contrast against its
  background, sticky bottom CTA bar doesn't overlap content, no horizontal overflow).
  Kill the test server when done.

Only report the project shipped once all of Phase 8 passes clean.
