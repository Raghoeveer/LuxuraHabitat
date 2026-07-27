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
- Add the builder's logo in a `.hero-logo` wrapper, top-left of the hero
  content, above the badge/headline — matching every other project page.
- Use the FAQ pattern from `_TEMPLATE.html` (button + schema.org
  microdata) if this project has FAQs. Keep the visible questions and
  the separate `FAQPage` JSON-LD block in exact sync — several pages
  were found with the two silently drifting apart (extra questions added
  to one but not the other).
- Add the RERA disclaimer paragraph and NAP (Name/Address/Phone) footer
  block verbatim from an existing page. These are legally load-bearing —
  don't reword them per project.

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
- Publish a dedicated `[project]-price-layout-rera`-style review post at
  launch.
- Publish a `[project]-vs-[closest-sibling]` comparison post within 1-2
  weeks.

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
