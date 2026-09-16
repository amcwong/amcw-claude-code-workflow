---
name: course-notes
description: Write beginner-facing course notes for one lecture week under courses/<slug>/ — dependency-mapped markdown, cumulative glossary, and a derived notebook. Use when the user says "add week N", "write course notes", "init course notes", or "audit the course notes". NOT for instructor Beamer/Quarto decks (use `/create-lecture` / `/teach-from-paper`), NOT for literature or paper notes (use `/lit-review`), NOT for manuscript fact-checking (use `/verify-claims`), NOT for generic "study notes" or "add notes."
argument-hint: "[init <slug> | add <slug> <N> | audit <slug>] [--no-notebook] [--no-audit]"
allowed-tools: ["Read", "Write", "Edit", "Grep", "Glob", "Bash", "Agent", "Task"]
disable-model-invocation: true
effort: high
---

# /course-notes — Weekly Course Notes

Produce beginner-facing notes for one lecture week of a course under `courses/<slug>/`: a dependency-mapped markdown file (source of truth), a cumulative glossary, and a derived `notebook.html`. Fact-audit is a separate mode of this same skill.

**Core principle:** markdown is source of truth; the notebook is derived. Nothing in this skill commits or pushes — that is [`/commit`](../commit/SKILL.md).

## When to pick this skill

- **`/course-notes`** (this skill) — learner notes for a **course** with lecture weeks, homework-depth, and a term-length glossary + notebook.
- **`/create-lecture` / `/teach-from-paper`** — instructor Beamer/Quarto decks in `Slides/` / `Quarto/`. Different audience, different artifacts.
- **`/lit-review`** — literature across papers, not a weekly course loop.
- **`/verify-claims`** — manuscript / draft CoVe. Course-notes audits use `fact-auditor` instead.
- **`/scaffold-exercises`** — graded problem sets, not notes.

If the user says only "study notes" or "add notes" without "course" or "week," ask which type. v1's only implemented type is course.

## Inputs

Parse `$ARGUMENTS`:

- `init <slug>` — scaffold `courses/<slug>/` from templates.
- `add <slug> <N>` — add week `N` (integer). Filename is `weekNN-course-notes.md` with `N` zero-padded to two digits (`1` → `week01`).
- `audit <slug>` — fork `fact-auditor` over that course tree.

Slug must be kebab-case (`imaging-2026`). Reject path separators or `..`.

## Phases

### `init` — scaffold a course

1. Confirm `courses/<slug>/` does not already exist. If it does, stop.
2. Create the directory and `sources/` (empty). Copy:
   - `templates/course.md` → `COURSE.md`
   - `templates/course-notes-readme.md` → `README.md`
   - `templates/glossary.md` → `glossary.md`
   - `templates/notebook.html` → `notebook.html`
   - `templates/fact-audit.md` → `FACT_AUDIT.md` (placeholder until the first audit)
3. Stop and tell the user to fill `[BRACKETED]` placeholders in `COURSE.md` (audience, course URL, expected week count) and drop Week 1 slides into `sources/week1/`. Do not write week notes.

### `add` — one week (plan-first)

#### Phase 0 — Pre-flight (blocking)

Read `COURSE.md`, prior `week*.md`, `glossary.md`, and everything in `courses/<slug>/sources/weekN/` (or `weekNN/` if that is how the user laid it out).

**Sparse slide PDFs:** try the Read tool first. For diagram/formula slides whose extracted text looks empty or suspicious, render those pages to images (`pdftoppm` or PyMuPDF) and look at the images before trusting a number or label. Skip logistics slides (schedule, grading, staff, policies).

Emit, then **stop and wait for approval**. Do not write notes yet:

- concept list (mark anything a current or upcoming homework leans on)
- underlying math each concept assumes
- dependency map (prerequisite / formalizes / builds-on)
- proposed section order (dependency order, **not** slide order)
- which slides are logistics and will be skipped

#### Phase 1 — Write markdown source of truth

After approval, write `courses/<slug>/weekNN-course-notes.md` from [`templates/week-course-notes.md`](../../../templates/week-course-notes.md). Honor [`.claude/rules/course-notes.md`](../../rules/course-notes.md): define on first use, analogy then formal, worked example in its own block, no homework numeric answers, no dense walls, no hyperlinks, no diagrams in markdown.

#### Phase 2 — Glossary

Append `## Week N` to `glossary.md`. One-sentence-plus-cross-reference per term. Never delete or rewrite away an earlier beginner entry; a later week may add a "stricter sense" note.

#### Phase 3 — Notebook (skip if `--no-notebook`)

Read the current `notebook.html`. Append a `<section class="week-block" id="week-N">` inside `#weeks` (before `#glossary`). Refresh the glossary section from `glossary.md`. Reuse `COURSE.md` design tokens exactly. Diagrams: original inline SVG using CSS custom properties; captions "Fig. N" sequential across the page. Wikipedia links on first mention of a term inside that section only.

If `COURSE.md` still has blank font/colour tokens after Week 1, write the chosen values into `COURSE.md` so later weeks cannot drift.

#### Phase 4 — Stop for human review

Do not run the auditor yet unless the user already asked for `audit` in the same invocation and did not pass `--no-audit`. Tell them to read the week file and notebook, fold repeat complaints into `COURSE.md` (or `/learn` as `[LEARN:course-notes]`), then `/course-notes audit <slug>` and `/commit` when ready.

### `audit` — cold factual pass (skip if `--no-audit` on an `add`)

1. Confirm `courses/<slug>/` exists and has at least one `week*.md`.
2. Fork `fact-auditor` with **no** writing-conversation context and **no** style rules. Hand it paths only: README, every `weekNN-course-notes.md`, glossary, notebook. Do **not** include `COURSE.md`, root `CLAUDE.md`, or this skill's body.

   ```
   Agent: subagent_type=fact-auditor, context=fork
   Prompt: the file list above. Do not include the writing conversation.
   ```

3. Treat every finding as a CANDIDATE ([`/adjudicate-review`](../adjudicate-review/SKILL.md)): open the cited location; apply **Corrected** claims in markdown **and** notebook; leave **Unverifiable** untouched; do not "fix" style.
4. Regenerate `courses/<slug>/FACT_AUDIT.md` from [`templates/fact-audit.md`](../../../templates/fact-audit.md) (current state, not accumulated history).
5. Chat summary: total claims, each correction in one line, unverifiable count, whether markdown and notebook had drifted.

## Output / report format

- `init`: paths created + reminder to fill `COURSE.md`.
- `add`: pre-flight block (before writes); then paths written + "not committed."
- `audit`: `FACT_AUDIT.md` + the short summary above.

## Exit behavior

- **Pre-flight not yet approved:** write nothing.
- **Slug missing or invalid / week number missing on `add`:** stop with the expected invocation.
- **`courses/<slug>/` missing on `add`/`audit`:** tell the user to `init` first.
- **Never commit or push.**

## Flags

- `--no-notebook` — skip Phase 3 on `add` (markdown + glossary only).
- `--no-audit` — do not run `audit` after `add` even if the user bundled the request.

## Cross-references

- [`.claude/rules/course-notes.md`](../../rules/course-notes.md) — path-scoped writing constraints (`courses/**`).
- [`.claude/agents/fact-auditor.md`](../../agents/fact-auditor.md) — forked cold auditor this skill dispatches.
- [`.claude/references/course-notes-workflow.md`](../../references/course-notes-workflow.md) — why the four layers exist.
- [`templates/week-course-notes.md`](../../../templates/week-course-notes.md) — week file shape.
- [`/commit`](../commit/SKILL.md) — shipping. This skill does not.
- [`/learn`](../learn/SKILL.md) — generic recurring lessons as `[LEARN:course-notes]`.

## What this skill does NOT do

- **Instructor slides** — [`/create-lecture`](../create-lecture/SKILL.md) / [`/teach-from-paper`](../teach-from-paper/SKILL.md).
- **Literature or paper notes** — [`/lit-review`](../lit-review/SKILL.md). A future `/paper-notes` is out of scope.
- **Manuscript fact-checking** — [`/verify-claims`](../verify-claims/SKILL.md) / `claim-verifier`.
- **Problem sets** — [`/scaffold-exercises`](../scaffold-exercises/SKILL.md).
- **Commit or push.**
- **A parent `/study-notes` dispatcher** — not until a second note type exists.
