# DMLS Designing Machine Learning Systems: Course Notes

Index of this course's note files. Personal ML-interview prep notes on Chip Huyen's *Designing Machine Learning Systems* (O'Reilly, First Edition, 2022).

- **Rulebook:** `COURSE.md` (audience, sources, design tokens, and the exceptions below in full)
- **Book:** `_quarto.yml` (Quarto project). Preview with `quarto preview`, or open `_site/index.html` after `quarto render`
- **Chapters:** `lectures/weekNN.qmd`, where NN is the **book chapter** number (source of truth: prose, SVG, Wikipedia)
- **Practice:** `lectures/weekNN-practice.qmd` (optional; interview questions for chapter NN via `/course-notes practice design-ml-sys <N>`)
- **Figures:** `lectures/figures/weekNN/` (optional hand-placed images; reference as `figures/weekNN/name.png`)
- **Glossary:** `glossary.qmd` (cumulative, grouped by chapter)
- **Audit:** `FACT_AUDIT.md` (written only by `/course-notes audit`)
- **Sources:** `sources/` (the book PDF, `example-ml-questions.md`, and any extra context; binaries gitignored)

## Exceptions to the standard course layout

This is not a lecture course, so the usual one-week-one-source-folder layout does not apply:

- **Week = book chapter.** `/course-notes add design-ml-sys <N>` writes notes for Chapter N of the book. Files keep the `weekNN` names; page titles say "Chapter N".
- **One source.** Every chapter is read from the single book PDF in `sources/`, not from `sources/weekN/`.
- **Extra files are context only.** Anything else added to `sources/` informs the notes but never gets its own `add` page.
- **`practice` takes a chapter number** and produces interview-style questions for that chapter, in the style of `sources/example-ml-questions.md`.
- **Chapter numbers follow the 11-chapter First Edition** (see the table in `COURSE.md`).

Add a chapter with `/course-notes add design-ml-sys <N>`. Do not commit or push from that skill; use `/commit`.
