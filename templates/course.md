# [COURSE-CODE] [Course Name]: Course Notes

<!-- Copied to courses/<slug>/COURSE.md by `/course-notes init`.
     Fill every [BRACKETED] placeholder. The `/course-notes` skill reads this
     file on every add/audit. Do not put procedure here; that lives in the skill. -->

## Purpose

Running course notes for [COURSE-CODE] ([Course Name]): one Quarto chapter per lecture week plus a cumulative glossary. The goal is to help the user learn the field from scratch over the term, not to solve homework.

## Who these notes are for

The user is a complete beginner to [SUBJECT AREA]. Assume nothing beyond [general math/programming literacy, e.g. "undergrad CS + bioinformatics; comfortable with Python, linear algebra, and basic stats"].

## Source material

- Course site: [COURSE URL]
- Lecture slides and readings live in `sources/weekN/` (gitignored binaries).
- [Optional: homework topics, exam scope, "the professor said skip X"]

## Book

- **Project:** `_quarto.yml` (Quarto book). Preview with `quarto preview` from this directory, or open `_site/index.html` after `quarto render`.
- **Title:** "[Notebook title]"
- **Expected week count:** [TOTAL, e.g. 10]
- **Chapters:** `lectures/weekNN.qmd` (source of truth). Do not keep a parallel week markdown file.
- **Published URL:** `https://[GITHUB-USER].github.io/[REPO-NAME]/courses/[COURSE-SLUG]/` (after `/deploy-course-notes` + push + GitHub Pages enabled)

## Design system (book page)

Reuse this exactly every week; never redesign per week. Defaults after Week 1, then lock them here.

- Fonts: Source Serif 4 for body and headings, Source Code Pro for code, system-ui for sidebar and tables
- Colours: navy `#002A5C` (headings, links, table headers, definition borders) on a white reading column and light-grey `#f0f0f0` left sidebar; hover `#1E3A6E`; gold `#E8B400` used sparingly. Surfaces stay light (do not auto-apply `custom-dark.css`).

## Recurring corrections

<!-- Fold repeat feedback here so later weeks inherit it. Generic lessons go to MEMORY.md via `/learn` as `[LEARN:course-notes]`. -->
