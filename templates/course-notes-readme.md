# [COURSE-CODE] [Course Name]: Course Notes

Index of this course's note files. Fill `[BRACKETED]` placeholders after `/course-notes init`.

- **Rulebook:** `COURSE.md` (audience, course URL, design tokens)
- **Book:** `_quarto.yml` (Quarto project). Preview with `quarto preview`, or open `_site/index.html` after `quarto render`
- **Weeks:** `lectures/weekNN.qmd` (source of truth: prose, SVG, Wikipedia)
- **Practice:** `lectures/weekNN-practice.qmd` (optional; `/course-notes practice <slug> <N>`)
- **Figures:** `lectures/figures/weekNN/` (optional hand-placed images; reference as `figures/weekNN/name.png`)
- **Glossary:** `glossary.qmd` (cumulative, grouped by week)
- **Audit:** `FACT_AUDIT.md` (written only by `/course-notes audit`)
- **Sources:** `sources/weekN/` (slides and readings; binaries gitignored)

Add a week with `/course-notes add <slug> <N>`. Do not commit or push from that skill; use `/commit`.
