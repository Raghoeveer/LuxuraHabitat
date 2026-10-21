---
name: enrich-page
description: SEO enrichment pipeline for an existing Luxura Habitat project page. It takes the top 10 ranking pages for the project, fetches each once, harvests new images / floor plans / master plans and new facts / FAQs from them via two subagents (content-extractor, image-classifier), runs claude-seo audits, verifies every quote, applies all verified facts, FAQs, gaps and SEO fixes automatically (plus the project's review blog), and asks the user only to review major conflicts and pick which images to add. Use when the user says "enrich <project>", "/enrich-page <slug>", "add more content/images to <page>", "find floor plans for <project>", or "improve SEO of <project> page from competitors".
---

# Enrich an existing project page

Turns the top 10 competitor pages into sourced additions. **Standing user rule (2026-10-21):**
the top 10 pages are the source of truth for project facts, FAQs and gaps. Apply all of it
without asking. The only things put to the user are the **major conflicts** (for review) and
the **image picks**. The project's review blog is updated too, and no other blog is.

**Division of labour:** scripts do mechanical work (search, fetch, download, de-dupe,
verify). Subagents do judgment (extracting facts, viewing images, SEO audit). The main
session orchestrates, merges, reports and applies. Subagents can't spawn subagents, so
every spawn happens from here.

Use TodoWrite to track the phases. Never skip Phase 6's image STOP.

## Setup (one-time per machine)
```bash
S=.claude/skills/enrich-page
[ -x $S/.venv/bin/python ] || { python3 -m venv $S/.venv && $S/.venv/bin/pip install -q -r $S/scripts/requirements.txt && $S/.venv/bin/playwright install chromium; }
PY=$S/.venv/bin/python
RUN=<scratchpad>/enrich-runs/<slug>-<YYYY-MM-DD>   # use the session scratchpad dir
```

## Phase 0: Baseline
- Find the page: `projects/<slug>/index.html` or `projects/<city>/<slug>/index.html`.
- `$PY $S/scripts/gap_check.py <page> $RUN/baseline.json`
- Read the page fully yourself as well. Note what the hero/units sections promise.
- Check memory for this project (contested facts, RERA decisions, user-confirmed numbers).
  User-confirmed facts in memory **beat** anything scraped.
- Optional: check the GA4 channel mix for the page. Organic traffic is near zero site-wide, so
  set expectations that this improves quality and rankings over weeks.

## Phase 1: Top-10 URLs
- Keyword = the project's main name as the page targets it (from the `<title>`/H1).
- `$PY $S/scripts/serp_top10.py "<keyword>" $RUN/urls.json`
- **Exit code 2 means Bing served its generic result set** (almost always). Fall back to
  Serper (Google India, the user's preferred source): `POST https://google.serper.dev/search`
  with header `X-API-KEY: $SERPER_API_KEY` and body `{"q":"<keyword>","gl":"in","hl":"en"}`
  (`"page":2` for results 11-20). Drop non-text results (Spotify, YouTube) and backfill from page 2.
  The key is saved in `~/.claude/settings.json` under `env.SERPER_API_KEY` (user-level, never the repo).
  If the env var is empty in this session, read it from that file. Ask the user only if it's missing there too.
  Then `$PY $S/scripts/serp_top10.py "<keyword>" $RUN/urls.json --n <count> --manual <urls...> --source serper-google-in`.
- Don't use the WebSearch tool for rankings: it's US-only and returns spam for Indian project names.
- Ask before doing any *extra* keyword research beyond this one SERP (standing user rule).

## Phase 2: Fetch once + harvest
`$PY $S/scripts/fetch_and_harvest.py $RUN` (takes a few minutes; run with a long timeout).
It saves `pages/*.txt|html`, downloads and filters images into `imgs/`, and writes
`harvest.json`. Report blocked pages to the user. 99acres often blocks even the headless browser.

## Phase 3: Fan out (ONE message, 5 parallel Agent calls)
Give every agent `$RUN` absolute paths and tell it to write files there and return only a summary.
1. `content-extractor`: run dir + project name.
2. `image-classifier`: run dir + project name + our configurations (e.g. "3 & 4 BHK, 1,750-2,700 sq ft").
3. `claude-seo:seo-content`: audit our page file for E-E-A-T, thin sections and citability,
   comparing it against `$RUN/pages/*.txt`. Write `$RUN/seo-content.md`.
4. `claude-seo:seo-sxo`: given `urls.json` and the saved pages, decide what page type and
   sections the SERP rewards versus what our page offers. Write `$RUN/seo-sxo.md`.
5. `claude-seo:seo-schema`: validate our page's JSON-LD (unpack `@graph`) and propose fixes. Write `$RUN/seo-schema.md`.

For agents 3-5, paste these house rules into the prompt so the advice fits the site: meta
description ~150-160 chars; visible FAQ and FAQPage JSON-LD must match exactly;
BreadcrumbList comes from `js/seo.js` (don't hand-add it); no em-dash characters in copy;
single `#gallery`; plan images open the brochure form; never point og:image at another
project's folder. All of them must be **report-only**, with no edits to repo files.

## Phase 4: Verify + merge
- `$PY $S/scripts/verify_quotes.py $RUN` writes `content.verified.json`. Rejected items are never applied.
  Most rejects are multi-line values backed by a one-line quote, or values that include our own
  arithmetic. Re-quote the full block from `pages/*.txt` and strip derived numbers, then re-run.
  Only what still fails is dropped.
- Merge rules:
  - **The top 10 are the source of truth.** Every verified fact, FAQ and gap gets applied.
  - **Conflicts are applied, not asked about.** When sources disagree with each other or with our
    page, keep the page's current headline value and add every other published value next to it
    with its source: highlights table, source-note box, units cards, a "reported elsewhere" table
    for prices, and FAQ answers. Never declare one value correct.
  - **Exception:** a user-confirmed fact in memory still beats scraped values. Keep it as the
    headline and mention the scraped alternatives.
  - **Attribution:** label each claim by source type: channel-partner site, broker portal, X post,
    forum opinion. Low-trust or templated sources are still used, but labelled that way.
  - RERA numbers: `grep -rl "<number>" --include="*.html" .` to catch collisions with other
    projects. A colliding RERA number is never applied: report it instead.
  - Content copied from competitors is never used verbatim: always use the `rewrite`.
  - Gaps that need data none of the top 10 have (e.g. metro station names, commute times) may be
    filled from official or open sources (CMRL, Wikipedia station tables, OSRM free-flow routing),
    clearly labelled. Never invent numbers.
  - SEO fixes from the three audits are applied when they fit the house rules. Skip anything that
    would only make sense site-wide (e.g. the FAQ microdata pattern used on all project pages),
    and note what was skipped.

## Phase 5: Apply content (no approval needed)
- **Facts:** update every place the fact appears (hero, highlights, pricing, units, FAQ answers,
  JSON-LD, meta description). Grep the page for the old value.
- **FAQs:** add to the visible FAQ *and* the FAQPage JSON-LD with identical text. Build both from
  one list in a script so they can't drift.
- **Gaps:** add a section or checklist for each (status/timeline, booking and payment plan,
  pros and cons, "questions to ask before you pay", distance table).
- **Copy:** no em-dash characters (a hook blocks them anyway). Prices take a "*" plus the existing disclaimer.
- Use a patch script whose replacements assert exactly one match. Keep a backup of the page in the scratchpad.

## Phase 5b: Update the review blog (only that one)
- Find it from the project page's "Project Review" insight card, i.e. the `/blog/...` link whose
  slug contains `review`. Leave locality guides and every other blog alone. If there's no review
  blog, say so and skip this step.
- Add a short "Latest update (<date>)" section with the key new facts. Keep the same side-by-side
  conflict disclosure as the page, plus the booking/status and price-comparison highlights.
  Link back to the matching project-page sections (`#booking`, `#pricing`, `#location`).
- Update any blog figures that now contradict the page, so the two stay consistent.
- New blog FAQs go in both the visible FAQ and the blog's FAQPage JSON-LD, with identical text.
- Bump `dateModified` in the blog's BlogPosting JSON-LD and any visible "updated" date. The blog's
  BreadcrumbList is hand-written, unlike project pages, so leave it as it is.
- Images: add 2 to 4 after the user picks images in Phase 6. Reuse the chosen files from
  `/images/projects/<slug>/` with blog-relative paths (`../../images/...`), `loading="lazy"` and
  the "Representative" alt prefix where unconfirmed. Don't copy files into a blog folder.
- Never point the blog's og:image at another project's folder.

## Phase 6: Conflict + image report and STOP
Publish an Artifact (load `artifact-design` first) with two groups:
1. **Major conflicts (C1, C2, ...), for review.** These are disagreements on headline facts:
   RERA number, price band, land area, unit count, configurations/BHK mix, tower count/floors,
   possession date, and location/locality name. Show every value with its source and what the
   page and blog now say. They are already disclosed side by side; the user can reply with a
   value to promote to the headline (e.g. `C2: use 906 homes`). Minor ones (a 1 km distance
   difference, a spec line) are applied silently and not listed.
2. **Images (I1, I2, ...).** Group them by bucket, with:
- thumbnails embedded as data URIs from `imgs/view/`;
- each image's source page, risk tier, project_match, flags and suggested alt;
- a checkbox tray that builds the reply string.

At the top, add a short summary of the content already applied, so the user can review the page.
Then stop and ask: "Reply with the image numbers to add, e.g. `I1, I3-I5`, plus any conflict
you want resolved, e.g. `C2: use 906 homes`". Add no images and change no headline values until
the user answers.

Then apply what the user chose. Any conflict values they promote go to the headline everywhere,
on both the page and the review blog. Then add the chosen images:
- Convert `imgs/orig/<id>` to WebP (≤1600px long side) and save as
  `/images/projects/<slug>/<slug>-<descriptor>.webp`.
- Floor plans and master plans go in the `#units` section. Clicks call
  `toggleDetailsPanel()`, never `openLightbox()`.
- Everything else goes in the single `#gallery` as
  `<div class="gallery-item" onclick="openLightbox(this)"><img ... loading="lazy"><span class="gallery-tag">Label</span></div>`.
  Don't create a second gallery and don't add near-duplicates of existing shots.
- Images whose match isn't confirmed keep the "Representative" alt prefix.
- Add 2 to 4 of the chosen images to the review blog as well (see Phase 5b).

## Phase 7: Verify
- Re-run `gap_check.py` to a new file and diff it against `baseline.json`: confirm every applied item and chosen image landed.
- Spawn `claude-seo:seo-schema` and `claude-seo:seo-technical` (parallel, report-only) on the edited page and the review blog.
- Check in a real browser at desktop and ~390px mobile width: sticky nav still sticks, the
  gallery lightbox opens, plan images open the brochure form, FAQ toggles work, there are no
  console errors, and the sidebar widget doesn't overflow.
- Commit only when the user asks. Save a project memory recording which conflicts were disclosed and any user decisions.

## Files
- `scripts/gap_check.py`: page inventory (`@graph`-aware JSON-LD, perceptual hashes of existing images)
- `scripts/serp_top10.py`: Bing India top 10, or `--manual`
- `scripts/fetch_and_harvest.py`: requests then Playwright fallback, image harvest, PDF image extraction, de-dupe
- `scripts/verify_quotes.py`: verbatim-quote and number check
- `.claude/agents/content-extractor.md`, `.claude/agents/image-classifier.md`
