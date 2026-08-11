# Adding a new project page

Follow this in order. It exists because the same handful of bugs got
independently re-introduced across several project pages before this
checklist existed — each item below is here because skipping it already
caused a real, shipped bug once.

## 1. Build the page

- Start from `projects/_TEMPLATE.html`, not by copying whatever project
  page you last had open. Copy visual design (hero layout, colors,
  amenity grid) from a recent page like `sattva-city` or `sattva-sanio`
  — those are the most structurally up to date — but keep this project's
  own color variables, not the source page's.
- Wire up `<script src="/js/project-page.js">` and `<script src="/js/seo.js">`
  from day one. Don't hand-write nav/scroll/reveal JS inline — that's
  exactly the duplication this consistency pass removed.
- Do **not** hand-write a `BreadcrumbList` JSON-LD block. `js/seo.js`
  generates a correct one automatically from the URL and `<h1>`. A
  hand-written one creates a duplicate — this was a live bug on 6 pages
  before being fixed.
- Keep `<meta name="description">` to ~150-160 characters. Google
  truncates the SERP snippet past that, mid-sentence. Century Kindle
  (183 chars) and Vajram Vivera's first draft (176 chars) both shipped
  over the limit — check the actual rendered character count (not the
  HTML-entity-escaped source string) before shipping a new page.
- Add the builder's logo in a `.hero-logo` wrapper, top-left of the hero
  content, above the badge/headline — matching every other project page.
- The nav bar's own logo (top-left of the page, not the hero) must be
  Luxura Habitat's branding (`/images/logos/company_logo.png`, linking to
  `/`) — never the builder's logo. Every project page is Luxura Habitat's
  own site advertising the project, not a mirror of the builder's site.
  If you're building from a source file supplied by someone else (an
  external template, a builder's own microsite export), check this
  explicitly — Sattva Forest Ridge's source file had the builder's logo
  in the nav instead, and it shipped that way before being caught.
- The Luxura Habitat nav logo needs an "Authorized Channel Partner"
  caption next to it (divider + caption span, hidden below ~1024px width)
  — matching every other project page. Copy the exact markup/CSS from an
  existing page rather than just the bare logo image.
- Any heading/accent color pulled from an external source file (a
  builder's own microsite export, an external template) needs to be
  swapped to this project's own color variables before shipping — don't
  assume the source file's palette is intentional. Sattva Forest Ridge's
  source file had section headings and a table header in a generic blue
  (`#2563eb`) that matched nothing else on the page; it should have used
  the page's own accent color from the start.
- Use the FAQ pattern from `_TEMPLATE.html` (button + schema.org
  microdata) if this project has FAQs. Keep the visible questions and
  the separate `FAQPage` JSON-LD block in exact sync — several pages
  were found with the two silently drifting apart (extra questions added
  to one but not the other).
- Add the RERA disclaimer paragraph and NAP (Name/Address/Phone) footer
  block verbatim from an existing page. These are legally load-bearing —
  don't reword them per project.
- The footer's copyright line must read **`Luxura Habitat`**, not the
  builder's name — this is a Luxura Habitat marketing site, not the
  developer's official site (the disclaimer paragraph right next to it
  says exactly that: "We are not developers or builders"). Attributing
  copyright to "Assetz Property Group", "TVS Emerald", "[Project] Team",
  etc. contradicts that disclaimer on the same page. This was wrong on
  28 of 29 shipped project pages before being caught and fixed in one
  pass — check it explicitly, don't copy the copyright line verbatim
  from a random existing page without reading what name is in it.
- The footer must link `Privacy Policy` → `/privacy.html` and
  `Terms & Conditions` → `/terms.html` — **absolute paths, exact
  filenames, no trailing variation.** Every one of these is a real bug
  that shipped before: `href="#"` (dead placeholder, never wired up),
  relative `privacy.html`/`terms.html` (resolves to
  `/projects/<slug>/privacy.html`, which doesn't exist, once the page
  is nested under `/projects/<slug>/`), `privacy-policy.html` /
  `terms-and-conditions.html` (wrong filenames — the real files are
  `privacy.html` and `terms.html` at site root), and `/privacy` /
  `/terms` with no extension (404s — there's no Netlify `_redirects` or
  `netlify.toml` doing extension-stripping on this site). Copy the link
  markup verbatim from an already-correct page (e.g. `kns-sampada`) and
  grep the finished page to confirm both links resolve:
  `grep -oE 'href="[^"]*"[^>]*>(Privacy Policy|Terms)' projects/<slug>/index.html`
  — both matches must read `/privacy.html` or `/terms.html` exactly.
- The GA4 tag + tel/mailto/WhatsApp click tracking is already in
  `_TEMPLATE.html` — don't strip it out or swap the Measurement ID per
  project. Every page shares one GA4 property (`G-4VD9RSVKTV`). Form
  submits are picked up automatically by any Web3Forms form (no extra code
  needed). WhatsApp clicks are **not** reliably automatic — GA4's own
  outbound-click detection listens in the bubble phase, so any button with
  `onclick="event.stopPropagation()"` (used on card-grid WhatsApp buttons,
  e.g. `projects/index.html`, to stop the click from also triggering the
  parent card's own navigate-away handler) silently prevents GA4 from ever
  seeing that click. `_TEMPLATE.html`'s tracking script fires an explicit
  `whatsapp_click` event in the capture phase instead — immune to any
  `stopPropagation()` on the target — so don't rely on "automatic" WhatsApp
  tracking on a new card-grid-style page; make sure this capture-phase
  script is present. The Zendesk `chat:start` tracking lives in
  `/js/project-page.js`, so it works automatically too as long as the
  Zendesk snippet and `project-page.js` are both on the page.
- Any Web3Forms lead form needs a `redirect` hidden field pointing at
  `https://luxurahabitat.com/thank-you/` (exact value, trailing slash,
  no `.html`). Forms with no `redirect` field submit natively straight to
  Web3Forms and dump the visitor off-domain with an unbranded page and
  no way to track the lead — this was a live bug on 5 pages, fixed once,
  don't reintroduce it. If a form submits via JS `fetch()` instead
  (AJAX, in-page success message), it doesn't need this field.

## 2. Images

- Do not extend the `additional_websites/<Folder>/` + `<base href>`
  convention older pages use — it's known debt, not something to copy.
  If a clean per-project image path isn't set up yet, ask before
  proceeding rather than guessing.
- Never point a `<meta property="og:image">`, `twitter:image`, or
  `<link rel="preload">` at a *different* project's image folder. This
  exact bug shipped on Sattva La Vita (pointed at Aeropolis's folder).

## 3. Identify the content cluster

- Which of the 3 area hubs (Devanahalli / Hennur-Thanisandra / Yelahanka)
  does this project belong to? If none, a standalone locality post is
  fine until there's enough inventory to justify a full hub page (see
  `why-invest-in-bagalur-main-road-real-estate` for the existing
  precedent).
- Don't default to the same two blog templates (review post + vs-sibling
  comparison) for every project — that's a habit, not a strategy. Do
  genuine keyword research specific to this project first: check Google
  autocomplete and "People also ask" for the project name + locality +
  builder, see what competing/aggregator sites already rank for on this
  project, and identify real search intent (price/RERA/floor-plan,
  locality comparisons, investment/ROI, commute/connectivity, school or
  employer proximity, etc.) rather than assuming.
- Publish 2 blog posts at launch based on what that research actually
  turns up. A `[project]-price-layout-rera` review post and/or a
  `[project]-vs-[closest-sibling]` comparison are fine outcomes if the
  research supports them — but pick the 2 topics because the keywords
  justify them, not because they're the default pattern.

## 4. Interlink — in both directions

- Add this project's card into the **`.project-footer-strip`
  "Similar Projects" grid on its sibling pages**, not just build one on
  the new page. This hand-authored grid — not `js/seo.js`'s `clusters`
  object — is what actually drives visible cross-linking today. (The
  `clusters` object's own code comment confirms its dynamic HTML
  injection was already replaced by these hardcoded cards; editing
  `clusters` alone creates no visible link.)
- Add the project + its new posts to the relevant `/areas/<hub>/` page.
- Build this page's own footer-strip linking back to siblings and
  relevant posts.

## 5. Site plumbing

- Add the card block to `projects/index.html`, following the exact shape
  of an existing card (e.g. the `sattva-city` one) — thumbnail from
  `/images/projects-thumbs/<slug>-thumb.webp`, `data-area` attribute,
  WhatsApp CTA link.
- Add the URL to `sitemap.xml`.
- Double-check no image reference was accidentally copy-pasted from
  another project's folder (see Phase 7 note in the consistency plan —
  ~185 such cross-references already exist site-wide from before this
  checklist existed; don't add more).

## 6. Verify before shipping

- Load the page and click every nav menu item — it should scroll to just
  below the sticky nav (not underneath it) and the URL hash should
  update. Zero browser console errors.
- If it has an FAQ, click every question — only one should be open at a
  time, and the visible text should match the JSON-LD exactly.
- Check the page on a real mobile viewport width, not just desktop.
