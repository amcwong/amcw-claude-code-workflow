# CSC2529 Computational Imaging: Course Notes

## Purpose

Running course notes for CSC2529 (Computational Imaging, University of Toronto, instructor David Lindell): one Quarto chapter per lecture week plus a cumulative glossary. The goal is to help the user learn the field from scratch over the term, not to solve homework.

## Who these notes are for

The user is a complete beginner to optics and computational imaging as a problem domain, but comfortable with Python, numpy, and linear algebra. Each week distinguishes course-taught material from prerequisite background the notes supply to fill gaps the lecture/problem-session assumes.

## Source material

- Course site: cs.toronto.edu/~lindell/teaching/2529/
- Lecture slides, problem-session slides, and homework files live in `sources/weekN/` (gitignored binaries).
- Homework assignments are Python-based (numpy/scipy/scikit-image); flag concepts they depend on wherever they appear. Never compute an assignment's specific numeric answer in these notes.

## Book

- **Project:** `_quarto.yml` (Quarto book). Preview with `quarto preview` from this directory, or open `_site/index.html` after `quarto render`.
- **Title:** "CSC2529: Computational Imaging notes"
- **Expected week count:** unknown; extend as weeks are added.
- **Chapters:** `lectures/weekNN.qmd` (source of truth). Do not keep a parallel week markdown file.

## Design system (book page)

Reuse this exactly every week; never redesign per week.

- Fonts: Source Serif 4 for body and headings, Source Code Pro for code, system-ui for sidebar and tables
- Colours: navy `#002A5C` (headings, links, table headers, definition borders) on a white reading column and light-grey `#f0f0f0` left sidebar; hover `#1E3A6E`; gold `#E8B400` used sparingly. Surfaces stay light (do not auto-apply `custom-dark.css`).

## Recurring corrections

- Each week distinguishes course-sourced material (from slides/homework/problem session) from prerequisite background the notes add, at section granularity.
- Never use U+2014 em dashes in body copy.
- Do not invent analogies; keep lecture/problem-session/homework examples.
