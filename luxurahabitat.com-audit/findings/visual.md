# Visual / Above-the-Fold / Mobile Rendering Audit — luxurahabitat.com

**Pages sampled:** homepage (`/`), area hub (`/areas/devanahalli/`), two project pages (`/projects/sattva-forest-ridge/`, `/projects/century-kindle/`), one blog post (`/blog/devanahalli-real-estate-market-trends-2026/`).
**Viewports:** Desktop 1920x1080, Mobile 375x812 (iPhone UA, 2x DPR). Screenshots (fold + full-page) saved to `/Users/raghuveernr/Desktop/luxuraHabitat/luxurahabitat.com-audit/screenshots/`.

## Score: 64 / 100

The homepage and most project-page heroes are polished and convert well on both breakpoints, but a known sidebar-widget overlap bug is still live on the majority of project pages, and blog posts with data tables overflow the mobile viewport (horizontal scroll). Area hub pages also ship without any above-the-fold CTA.

## what_works
- Homepage hero (desktop and mobile) is excellent: full-bleed background photo, legible serif H1 ("Premium Plots, Villas & Apartments in Bangalore"), supporting copy, trust badge, stats row, and two clear CTAs (WhatsApp Consultation, Schedule a Visit) all visible without scrolling on desktop; on mobile the primary WhatsApp CTA is visible in the first viewport.
- Project page (Sattva Forest Ridge, Century Kindle) desktop hero + inline lead-gen form is well composed: H1, description, highlight chips, and a full "Get Brochure" form all sit side-by-side above the fold with no overlap.
- No `document.scrollWidth > clientWidth` horizontal-scroll issue on homepage or area hub page at either viewport (the wide "builder logos" marquee and off-canvas mobile nav that appear to extend past the viewport in the DOM are correctly clipped by parent `overflow:hidden` — not a real bug).
- Consistent header/nav, RERA trust messaging, and sticky mobile bottom bar (Call / WhatsApp / Enquire) present on project pages, giving persistent conversion paths even when the hero CTA scrolls away.
- Typography scales sensibly at 375px width (H1 remains multi-line but readable, body copy ~16px+), and images (hero photos, project renders) scale correctly with no distortion observed.

## findings

### 1. Sidebar "Request Brochure" tab still overflows/overlaps on mobile — unfixed on most project pages
- **Severity:** High
- **Description:** The vertical `.sidebar-widget` "Request Brochure" tab (`position: fixed; right: 20px`) is only hidden on mobile via `@media (max-width: 1024px) { .sidebar-widget { display: none; } }`. That override exists in just 5 of the project templates that reference the widget (`century-astoria`, `century-kindle`, `kns-sampada`, `vajram-chrysanthemum`, `vajram-vivera`). It is **missing** on `assetz-palmscape`, `assetz-zen-sato`, `brigade-eternia`, `orchid-salisbury`, `sattva-aeropolis`, `sattva-city`, `sattva-forest-ridge`, `sattva-la-vita`, `sattva-lumina`, `sattva-sanio`, and `tvs-emerald-altura` — 11 of 16 project pages that ship the widget. Verified visually on `sattva-forest-ridge_mobile.png`: the orange/green "Request Brochure" tab sticks out from the right edge of the 375px viewport and visually overlaps the hero card's body copy (the word "features" in the description is partially covered by the tab). `project-century-kindle_mobile.png` confirms the tab is correctly absent where the override exists.
- **Recommendation:** Add `.sidebar-widget { display: none; }` inside the existing `@media (max-width: 1024px)` block on the 11 affected project pages (same one-line fix already applied elsewhere), or better, extract the widget CSS to a shared stylesheet so this can't regress per-page again.

### 2. Data tables in blog posts overflow the mobile viewport (horizontal scroll + clipped column)
- **Severity:** Medium-High
- **Description:** `.article-content table { width: 100%; ... }` has no responsive wrapper (`overflow-x:auto`) or mobile column strategy. On `/blog/devanahalli-real-estate-market-trends-2026/` at 375px width, `document.documentElement.scrollWidth` (385px) exceeds `clientWidth` (375px), producing a real horizontal scrollbar. The rightmost "YoY Change" column is cut off / requires side-scrolling to read (see `blog-devanahalli-market-trends_mobile_table.png`). At least 19 blog posts contain one or more `<table>` elements using the same unwrapped markup and are all at risk of the same overflow.
- **Recommendation:** Wrap tables in a scrollable container (`<div style="overflow-x:auto">`) sitewide in the blog template, or switch to a stacked/card layout for tables below ~480px. Quick win: add `.article-content { overflow-x: auto; }` won't fix it alone — the wrapping div around each `<table>` is needed for a contained scroll affordance instead of page-level overflow.

### 3. Area hub pages (Devanahalli, Hennur, Yelahanka, Kanakapura Road) have no CTA in the hero — desktop and mobile
- **Severity:** Medium
- **Description:** `.hub-hero` markup contains only breadcrumb, H1, paragraph, and a stats row (`20-26%`, `3 Projects`, `₹60L+`, `12,000 acres`) — no WhatsApp/Schedule/Contact button anywhere in the hero, unlike the homepage hero which has two prominent CTAs. On mobile this is worse: the stats row is pushed almost entirely below the fold, so the first viewport is text-only with zero interactive conversion element (only the hamburger menu, which requires an extra tap to reveal "Book Consultation").
- **Recommendation:** Add a CTA button (e.g., "Book a Free Consultation" or "WhatsApp About Devanahalli") into `.hub-hero-inner`, mirroring the homepage hero pattern, for all area hub pages.

### 4. Floating chat bubble sits close to sticky bottom CTA bar on project pages (mobile)
- **Severity:** Low
- **Description:** On `project-century-kindle_mobile.png`, a pink floating chat/WhatsApp bubble is positioned just above the sticky bottom Call/WhatsApp/Enquire bar and partially overlaps body copy ("Wellness & Fun") as the user scrolls. Not a hard blocker (both remain independently tappable at 44px+ size) but the two floating conversion elements crowd the same bottom-right corner.
- **Recommendation:** Either suppress the generic chat widget on project pages that already have a dedicated sticky CTA bar, or reposition the chat bubble above the sticky bar with sufficient margin (e.g., `bottom: 70px`).

### 5. Blog post CTA falls far below the fold on mobile (single-column stacking)
- **Severity:** Info
- **Description:** On desktop, the blog sidebar ("Talk to an Advisor" CTA + featured project card) sits beside the article and is visible in the first viewport. On mobile, the sidebar content stacks after the full article body, so the only above-the-fold conversion path is the persistent header phone number / WhatsApp icon.
- **Recommendation:** Consider inserting a compact inline CTA (e.g., a "Talk to an Advisor" chip) near the top of the article body on mobile, rather than relying solely on the header, since this is standard practice but still worth strengthening given how content-heavy these guides are.

## Screenshots captured
- `screenshots/homepage_desktop.png`, `homepage_mobile.png` (+ `_full.png` variants)
- `screenshots/area-devanahalli_desktop.png`, `area-devanahalli_mobile.png` (+ `_full.png`)
- `screenshots/project-sattva-forest-ridge_desktop.png`, `project-sattva-forest-ridge_mobile.png` (+ `_full.png`) — shows the sidebar-widget overlap bug
- `screenshots/project-century-kindle_mobile.png` (+ `_full.png`) — desktop capture timed out (network-idle timeout on first attempt); mobile capture succeeded and shows the widget correctly hidden
- `screenshots/blog-devanahalli-market-trends_desktop.png`, `blog-devanahalli-market-trends_mobile.png` (+ `_full.png`)
- `screenshots/blog-devanahalli-market-trends_mobile_table.png` — crop showing the overflowing pricing table
