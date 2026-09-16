---
paths:
  - "courses/**"
---

# Course notes — writing constraints

These rules apply only while editing files under `courses/`. They are constraints, not a procedure. The week-writing loop lives in [`/course-notes`](../skills/course-notes/SKILL.md).

## Who the notes are for

The reader is a beginner to the subject named in `COURSE.md`. Assume nothing beyond the background recorded there.

- Define every term on first use, including everyday vocabulary from neighbouring fields that the lecture treats as obvious.
- Put definitions inline where a term first appears, not only in the glossary. A reader should never have to jump elsewhere to follow the current sentence. The glossary entry can be a shorter echo.
- Give a plain-language analogy before the formal definition.
- For formulas, show the derivation intuition (why the formula has that shape), not just the result.
- Cross-reference where a concept reappears or gets formalized in a later week.
- Go deeper on concepts a homework assignment depends on, even if the lecture only mentions them in passing. Build from first principles, and work through at least one concrete numeric example before generalizing. Briefly restate earlier-lecture terms in their new context rather than only pointing back at them.
- Disambiguate overloaded terms explicitly every time they recur (state inline which meaning is meant).
- When a later section introduces a stricter sub-term for a word already used loosely, audit every other use of that word across the course files and the notebook. Either switch to the precise term or add a short note on why the loose term is still correct there.
- Avoid dense, unbroken blocks of text. A long paragraph signals a concept needs restructuring. Split paragraphs at idea boundaries, pull worked examples into their own blocks, and use lists for enumerations.

## What never goes in these notes

Never compute the specific numeric answers a homework asks the student to derive. Do explain the underlying concepts a homework depends on, and explicitly flag that the specific calculation is left to the assignment.

Skip course-logistics slides (schedule, grading, staff, policies). Notes start from the first technical slide.

## Two artifacts, one source of truth

- **Markdown** (`weekNN-course-notes.md`, `glossary.md`) is the source of truth: text and tables only. No diagrams. No hyperlinks.
- **`notebook.html` is derived.** Diagrams live only there, as original inline SVG using the page's CSS custom properties (never screenshots of lecture slides). Figure captions are numbered "Fig. N" sequentially across the whole page. Wikipedia is the only hyperlink target, and only on first mention of a term within its week section.
- `glossary.md` is cumulative and grouped by week. Never delete an existing entry; a later week may deepen a definition, but the original beginner anchor stays.

## Design lock

Reuse the fonts and colours recorded in `COURSE.md` exactly every week. Never redesign the notebook per week. If tokens are still blank after Week 1, write the chosen values into `COURSE.md` before adding Week 2.
