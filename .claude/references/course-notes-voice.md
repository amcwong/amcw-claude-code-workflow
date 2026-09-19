# Course-notes voice

Writing constraints for `courses/**` week chapters. The procedure lives in [`/course-notes`](../skills/course-notes/SKILL.md). The path-scoped rule [`.claude/rules/course-notes.md`](../rules/course-notes.md) points here.

Exemplar (cite, do not copy files): [CSC413/2516 lecture notes](https://r-three.github.io/deep-learning-lecture-notes/lectures/02-mlp-backprop.html) (Raffel, University of Toronto). Findings: `aw-local/planning/raffel-lecture-notes-findings.md`.

---

## Register

Write calmly and precisely, as a knowledgeable person explaining something to a capable reader. Use **we** to walk through the reasoning together. Motivate before mechanism: pose the question a concept answers, then answer it. Hedge where the truth is qualified (`generally`, `in practice`, `typically`, `under benign assumptions`). Be honest about conventions, limitations, and misnomers. Never reach for excitement the material does not itself justify.

## Do

- Open a topic with the problem it solves, often as a plain question, then a `::: {.definition-block}` led by `**Definition.**` with the term in bold.
- Ground abstractions in **one running domain example** from the lecture. Reuse it across the section. If the slides used a specific example, use that one.
- After a clean equation, one sentence of interpretation (what it means), not an exclamation.
- Point forward and backward (`Week 2`, `building blocks for the rest of the course`).
- Hedge honestly. Be candid when a factor is a convenience (`the 1/2 cancels when we differentiate`).
- Close the chapter with `## Summary`, a `::: {.callout-note}` of **Key takeaways**, a **Next week:** sentence, and a short self-check.

## Do not

- **U+2014 em dashes** in week, glossary, or index body copy (including figure captions). Use a period, colon, comma, or parentheses. En dashes in numeric ranges (`2010–2012`) and hyphens in compounds (`log-likelihood`) stay. Titles use a colon, not an em dash.
- **Invented analogies.** No recipes, music, eye-colour tables, or “dials you can turn” unless that example is in the lecture. A same-domain instance is fine (a Bernoulli coin as a model, a diagnostic test from the tutorial).
- Hype adjectives used as decoration: powerful, amazing, incredible, revolutionary, magical, beautiful, elegant. Earn “remarkably clean” or do not use it.
- Filler openers: “Let’s dive in”, “Here’s the thing”, “It turns out that…” as a tic.
- Manufactured surprise: “Surprisingly,” unless the result is genuinely counterintuitive and you then explain why.
- Exclamation marks in body prose.
- Over-signposting: “Importantly,”, “Crucially,”, “Note that”, “it’s worth pinning down”, “the one idea to take away”, `*(derivation intuition:)*`.
- Editorializing difficulty: “this is easy”, “trivially”, “obviously”.
- Bold pedagogical labels (`**Analogy first.**`, `**Formal framing.**`). Let definition blocks and section headers carry the structure.

## Figures (SVG in the `.qmd`)

Inline SVG in `` ```{=html} `` blocks. Helvetica, `'Helvetica Neue', Arial, sans-serif` on the outer `<svg>`. Title ≥ 24px, labels ≥ 16px, nothing below 14px. Never screenshots of lecture slides. Leave a **title band** under the title (`y` from roughly `title_y - font-size` to `title_y + 8`) with no nodes in it — the notes scorer treats a shape in that band as overflow.

**Pastel Rainbow** (role → fill / stroke / ink), reused every week:

| Role | Fill | Stroke | Ink |
| --- | --- | --- | --- |
| Input / data | `#C6DEF1` | `#5795C7` | `#205279` |
| Hidden / processing | `#C9E4DE` | `#57C7AE` | `#207965` |
| Neutral / intermediate | `#FAEDCB` | `#C7A857` | `#796020` |
| Parameters | `#DBCDF0` | `#8457C7` | `#442079` |
| Decision / loss | `#F2C6DE` | `#C75794` | `#792051` |
| Output | `#F7D9C4` | `#C78557` | `#794520` |

Reserved sharp colours, only for start / error / success: `#fbc02d`, `#e53935`, `#2e7d32`. Axes and arrows: `#555` / `#888`. Figure numbering is **per chapter** (Quarto default).

Hand-placed image files (plots, photos) go in `lectures/figures/weekNN/` and are included from the week `.qmd` with `![caption](figures/weekNN/name.png)`. Inline SVG remains the default for diagrams the notes author.

`{ojs}` widgets are allowed later when a concept needs a slider. They are not required.

## Clarification dropdowns

Parked during `/course-notes revise`, not during `add`. Only on sections the user asked to park. Closed by default.

```markdown
::: {.callout-tip collapse="true" .clarification}
**Clarification.** [The extra derivation or distinction. Same homework-answer ban. No em dashes.]
:::
```

Place the block at the end of the named `##` / `{#sec-…}` section, before the next heading. Chat in Claude Code plan mode may be looser while teaching; **what gets parked still follows this voice file** (no invented analogies, no hype). Promote into the spine uses this register and must not duplicate the same prose in a dropdown.

These boxes ship with the book on GitHub Pages.

## Page chrome

Fonts and colours are locked in `COURSE.md` and implemented in `styles/custom.css`. Default system: navy `#002A5C`, hover `#1E3A6E`, white reading column, light-grey `#f0f0f0` left sidebar, Source Serif 4 for body and headings, Source Code Pro for code, system-ui for sidebar and tables. Never redesign per week. Never put course notes under the instructor `Quarto/` RevealJS tree.
