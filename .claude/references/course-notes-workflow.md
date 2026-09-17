# Course-notes workflow — why the four layers exist

A human rationale for [`/course-notes`](../skills/course-notes/SKILL.md). The procedure lives in the skill; this file is the "why."

Adapted from the old standalone kit in `aw-local/old-note-methodology/`. That kit was a one-repo-per-course `CLAUDE.md` plus a write-in-place `fact-auditor`. This template splits the same intent across the primitives the rest of the repo already uses.

Voice and page chrome follow the CSC413/2516 lecture-note site (Raffel) as an exemplar: measured lecture prose, navy book CSS, Quarto chapters. See [`course-notes-voice.md`](course-notes-voice.md) and `aw-local/planning/`.

## Four layers

1. **`COURSE.md` (per course) + path-scoped `.claude/rules/course-notes.md`.** The old root `CLAUDE.md` was a whole-session rulebook. Putting it here would fire during lecture and research work. Audience, URL, and design tokens stay in `courses/<slug>/COURSE.md`. Always-on writing constraints (definitions, homework-answer ban, `.qmd` as SoT) load only for `courses/**`.

2. **`/course-notes` skill.** The old "When asked to add a new week" procedure. Slash-invoked, `disable-model-invocation: true`, so a fuzzy "write notes" prompt cannot create week files. `init` / `add` / `audit` are modes of one skill, not three.

3. **`fact-auditor` agent.** The old cold-read auditor, still independent (forked, no writing-conversation memory, no style rules). It **reports** findings. The skill applies accepted corrections. That matches the fleet rule that reviewers do not write.

4. **Local Quarto book under `courses/<slug>/`.** One `lectures/weekNN.qmd` chapter per week is source of truth (prose, SVG, Wikipedia). `quarto render` writes gitignored `_site/`. This is **not** the instructor RevealJS tree in `Quarto/` (Beamer SoT, `/translate-to-quarto`, `/deploy`).

## What changed from the old kit

| Old | New |
|---|---|
| Auto commit and push | Explicit `/commit` |
| `artifact-design` / hand-rolled `notebook.html` | Quarto book in `templates/course-notes-book/` |
| Feedback folded into root `CLAUDE.md` | `COURSE.md` (course-specific) or `/learn` → `[LEARN:course-notes]` |
| Skill named around "study notes" | `/course-notes` — a course week loop, not a notes family |
| Auditor writes files | Auditor reports; skill applies |
| Analogy-first beginner kit | Raffel-like lecture voice (motivate, then define) |

## What this is not

Not instructor lecture decks (`/create-lecture`, files in `Quarto/`). Not literature notes (`/lit-review`). Not manuscript CoVe (`/verify-claims`). Not a parent `/study-notes` dispatcher — that waits until a second note type exists.
