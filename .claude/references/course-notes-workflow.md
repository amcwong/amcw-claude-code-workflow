# Course-notes workflow — why the four layers exist

A human rationale for [`/course-notes`](../skills/course-notes/SKILL.md). The procedure lives in the skill; this file is the "why."

Adapted from the old standalone kit in `aw-local/old-note-methodology/`. That kit was a one-repo-per-course `CLAUDE.md` plus a write-in-place `fact-auditor`. This template splits the same intent across the primitives the rest of the repo already uses.

## Four layers

1. **`COURSE.md` (per course) + path-scoped `.claude/rules/course-notes.md`.** The old root `CLAUDE.md` was a whole-session rulebook. Putting it here would fire during lecture and research work. Audience, URL, and design tokens stay in `courses/<slug>/COURSE.md`. Always-on writing constraints (inline definitions, homework-answer ban, markdown vs notebook split) load only for `courses/**`.

2. **`/course-notes` skill.** The old "When asked to add a new week" procedure. Slash-invoked, `disable-model-invocation: true`, so a fuzzy "write notes" prompt cannot create week files. `init` / `add` / `audit` are modes of one skill, not three.

3. **`fact-auditor` agent.** The old cold-read auditor, still independent (forked, no writing-conversation memory, no style rules). It **reports** findings. The skill applies accepted corrections. That matches the fleet rule that reviewers do not write.

4. **Local `notebook.html`.** The old published Claude artifact is optional and undocumented in v1. Markdown week files are source of truth; the notebook is derived (diagrams and Wikipedia links only there), the same idea as Beamer → Quarto.

## What changed from the old kit

| Old | New |
|---|---|
| Auto commit and push | Explicit `/commit` |
| `artifact-design` required | Local HTML shell in `templates/notebook.html` |
| Feedback folded into root `CLAUDE.md` | `COURSE.md` (course-specific) or `/learn` → `[LEARN:course-notes]` |
| Skill named around "study notes" | `/course-notes` — a course week loop, not a notes family |
| Auditor writes files | Auditor reports; skill applies |

## What this is not

Not instructor lecture decks (`/create-lecture`). Not literature notes (`/lit-review`). Not manuscript CoVe (`/verify-claims`). Not a parent `/study-notes` dispatcher — that waits until a second note type exists.
