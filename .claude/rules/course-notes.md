---
paths:
  - "courses/**"
---

# Course notes — writing constraints

These rules apply only while editing files under `courses/`. They are constraints, not a procedure. The week-writing loop lives in [`/course-notes`](../skills/course-notes/SKILL.md). Voice detail: [`course-notes-voice.md`](../references/course-notes-voice.md).

## Who the notes are for

The reader is a beginner to the subject named in `COURSE.md`. Assume nothing beyond the background recorded there.

- Define every term on first use, including everyday vocabulary from neighbouring fields that the lecture treats as obvious.
- Put definitions where a term first appears, in a `::: {.definition-block}` led by `**Definition.**`, not only in the glossary. A reader should never have to jump elsewhere to follow the current sentence. The glossary entry can be a shorter echo.
- Motivate with a question or problem, then the formal definition, then the lecture's running domain example. Do not invent analogies from another domain.
- After a formula, one sentence of interpretation (why it has that shape / what it means). Not a labelled “derivation intuition” aside.
- Cross-reference where a concept reappears or gets formalized in a later week.
- Go deeper on concepts a homework assignment depends on, even if the lecture only mentions them in passing. Work through at least one concrete numeric example before generalizing. Briefly restate earlier-lecture terms in their new context rather than only pointing back at them.
- Disambiguate overloaded terms explicitly every time they recur (state inline which meaning is meant).
- When a later section introduces a stricter sub-term for a word already used loosely, audit every other use of that word across the course files. Either switch to the precise term or add a short note on why the loose term is still correct there.
- Avoid dense, unbroken blocks of text. Split paragraphs at idea boundaries, pull worked examples into callouts, and use lists for enumerations.
- Use inclusive “we”. No hype adjectives, filler openers, exclamation marks in body prose, or over-signposting (“Importantly,”, “it’s worth pinning down”).
- **Never use U+2014 em dashes** in week, glossary, or index body copy. Use a period, colon, comma, or parentheses. En dashes in ranges and hyphens in compounds stay. Titles use a colon.

## What never goes in these notes

Never compute the specific numeric answers a homework asks the student to derive. Do explain the underlying concepts a homework depends on, and explicitly flag that the specific calculation is left to the assignment.

Skip course-logistics slides (schedule, grading, staff, policies). Notes start from the first technical slide.

## One source of truth

- **`lectures/weekNN.qmd` is the source of truth** for that week: prose, tables, definition/callout/algorithm blocks, inline SVG, and Wikipedia links. HTML is only the gitignored `_site/` from `quarto render`.
- Diagrams live in the week `.qmd` as original inline SVG (Helvetica stack; Pastel Rainbow role palette in [`course-notes-voice.md`](../references/course-notes-voice.md)). Never screenshots of lecture slides. Figure numbering is per chapter.
- Wikipedia is the only hyperlink target, and only on first mention of a term within that week chapter.
- `glossary.qmd` is a book chapter, cumulative and grouped by week. Never delete an existing entry; a later week may deepen a definition, but the original beginner anchor stays.

## Math notation

Formulas are LaTeX (`$...$` inline, `$$...$$` display). Quarto renders them with **KaTeX** (`html-math-method: katex` in `_quarto.yml`). Never hand-transliterate formulas to Unicode. SVG figure labels are the exception: KaTeX does not run inside `<svg><text>`, so diagram labels stay short plain text.

## Design lock

Reuse the fonts and colours recorded in `COURSE.md` exactly every week. Never redesign the book per week. If tokens are still blank after Week 1, write the chosen values into `COURSE.md` before adding Week 2. Default chrome is navy `#002A5C` / Source Serif 4 / Source Code Pro in `styles/custom.css`.
