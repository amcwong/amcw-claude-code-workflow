# PHY2405 Experimental Methods in High Energy Physics: Course Notes

<!-- Copied to courses/<slug>/COURSE.md by `/course-notes init`.
     Fill every [BRACKETED] placeholder. The `/course-notes` skill reads this
     file on every add/audit. Do not put procedure here; that lives in the skill. -->

## Purpose

Running course notes for PHY2405 (Experimental Methods in High Energy Physics, also called eHEP on the slides): one Quarto chapter per lecture week plus a cumulative glossary. The goal is to help the user learn the field from scratch over the term, not to solve homework.

## Who these notes are for

The user is a complete beginner to experimental high energy physics and accelerator physics. Assume nothing beyond undergraduate physics: classical electromagnetism, special relativity, linear algebra, and ordinary differential equations.

## Source material

- Course site: https://www.physics.utoronto.ca/~phy2405/ (plain text, not a hyperlink; Wikipedia is the only hyperlink target in these notes)
- Lecture slides and readings live in `sources/weekN/` (gitignored binaries).
- Week 1 sources: an intro slide deck for the non-collider half, a handout of scanned pages (definition of HEP, the archetypal experiment, LEP, DELPHI and CDF diagrams), and the course outline (logistics skipped).
- Week 2 sources: handwritten accelerator lecture notes (LHC-updated) and a set of textbook figure pages (Edwards and Syphers). No homework sheet supplied; the notes reference Problems 1c and 2c.

## Book

- **Project:** `_quarto.yml` (Quarto book). Preview with `quarto preview` from this directory, or open `_site/index.html` after `quarto render`.
- **Title:** "Experimental Methods in High Energy Physics Notes"
- **Expected week count:** 12 (assumed; edit when the syllabus is known)
- **Chapters:** `lectures/weekNN.qmd` (source of truth). Do not keep a parallel week markdown file.
- **Published URL:** `https://amcwong.github.io/claude-code-my-workflow/courses/PHY2405/` (after `/deploy-course-notes` + push + GitHub Pages enabled)

## Design system (book page)

Reuse this exactly every week; never redesign per week. Defaults after Week 1, then lock them here.

- Fonts: Source Serif 4 for body and headings, Source Code Pro for code, system-ui for sidebar and tables
- Colours: navy `#002A5C` (headings, links, table headers, definition borders) on a white reading column and light-grey `#f0f0f0` left sidebar; hover `#1E3A6E`; gold `#E8B400` used sparingly. Surfaces stay light (do not auto-apply `custom-dark.css`).

## Recurring corrections

<!-- Fold repeat feedback here so later weeks inherit it. Generic lessons go to MEMORY.md via `/learn` as `[LEARN:course-notes]`. After `/course-notes add`, run `/course-notes revise` (promote into the spine or park a clarification dropdown) before `/course-notes audit`. -->
