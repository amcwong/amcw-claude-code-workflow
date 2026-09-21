---
name: course-notes
description: Write beginner-facing course notes for one lecture week under courses/<slug>/ — a Quarto book chapter, optional practice chapter, cumulative glossary, and local render. Use when the user says "add week N", "write course notes", "init course notes", "audit the course notes", "revise course notes", "park that", "promote that", "clarification dropdown", "course-notes practice", or "practice problems for week N" of a course under courses/. NOT for instructor Beamer/Quarto decks (use `/create-lecture` / `/teach-from-paper`), NOT for literature or paper notes (use `/lit-review`), NOT for manuscript fact-checking (use `/verify-claims`), NOT for generic "study notes" or "add notes." NOT for a graded student set plus separate answer key (use `/scaffold-exercises`).
argument-hint: "[init <slug> | add <slug> <N> | practice <slug> <N> | revise <slug> [N] | audit <slug>] [--no-render] [--no-audit]"
allowed-tools: ["Read", "Write", "Edit", "Grep", "Glob", "Bash", "Agent", "Task"]
disable-model-invocation: true
effort: high
---

# /course-notes — Weekly Course Notes

Produce beginner-facing notes for one lecture week of a course under `courses/<slug>/`: a Quarto book chapter (`lectures/weekNN.qmd`, source of truth), an optional self-study practice chapter (`lectures/weekNN-practice.qmd`), a cumulative glossary chapter, and a local `_site/` render. `revise` is the human pass between writing and audit. Fact-audit is a separate mode of this same skill.

**Core principle:** the week `.qmd` is source of truth; HTML is only `quarto render` output. Nothing in this skill commits or pushes — that is [`/commit`](../commit/SKILL.md).

Instructor RevealJS lives in `Quarto/` and is out of scope. Never write course notes there.

Two optional Claude Code plugins (`superpowers`, `document-skills`) are intended to support this workflow.

## When to pick this skill

- **`/course-notes`** (this skill) — learner notes for a **course** with lecture weeks, optional practice chapters, homework-depth, and a term-length glossary + book.
- **`/create-lecture` / `/teach-from-paper`** — instructor Beamer/Quarto decks in `Slides/` / `Quarto/`. Different audience, different artifacts.
- **`/lit-review`** — literature across papers, not a weekly course loop.
- **`/verify-claims`** — manuscript / draft CoVe. Course-notes audits use `fact-auditor` instead.
- **`/scaffold-exercises`** — graded problem sets as a **separate student file + solution key**. Self-study dropdowns in the course book are this skill's `practice` mode.

If the user says only "study notes" or "add notes" without "course" or "week," ask which type. v1's only implemented type is course.

## Inputs

Parse `$ARGUMENTS`:

- `init <slug>` — scaffold `courses/<slug>/` from `templates/course-notes-book/` plus `COURSE.md`.
- `add <slug> <N>` — add week `N` (integer). Filename is `lectures/weekNN.qmd` with `N` zero-padded to two digits (`1` → `week01`).
- `practice <slug> <N>` — self-study practice chapter for week `N`. Requires `lectures/weekNN.qmd`. Filename is `lectures/weekNN-practice.qmd`.
- `revise <slug> [N]` — pre-audit edit pass on week `N` (or the week under discussion). Also fire on “park that”, “promote that”, or “clarification dropdown” when a week is already in context. Names the practice chapter if the user says so.
- `audit <slug>` — fork `fact-auditor` over that course tree.

Slug must be kebab-case (`imaging-2026`). Reject path separators or `..`.

## Phases

### `init` — scaffold a course

1. Confirm `courses/<slug>/` does not already exist. If it does, stop.
2. Create the directory, `sources/` (empty), `lectures/figures/` (empty except `.gitkeep`), and `styles/`. Copy:
   - `templates/course.md` → `COURSE.md`
   - `templates/course-notes-readme.md` → `README.md`
   - `templates/course-notes-book/_quarto.yml` → `_quarto.yml`
   - `templates/course-notes-book/index.qmd` → `index.qmd`
   - `templates/course-notes-book/glossary.qmd` → `glossary.qmd`
   - `templates/course-notes-book/styles/custom.css` → `styles/custom.css`
   - `templates/course-notes-book/styles/custom-dark.css` → `styles/custom-dark.css`
   - `templates/course-notes-book/lectures/figures/.gitkeep` → `lectures/figures/.gitkeep`
   - `templates/fact-audit.md` → `FACT_AUDIT.md` (placeholder until the first audit)
3. Do **not** copy a week chapter or a practice chapter. Stop and tell the user to fill `[BRACKETED]` placeholders in `COURSE.md` and `index.qmd` / `_quarto.yml` (audience, course URL, expected week count, book title) and drop Week 1 slides into `sources/week1/`. Do not write week notes.

### `add` — one week (plan-first)

#### Phase 0 — Pre-flight (blocking)

Read `COURSE.md`, prior `lectures/week*.qmd`, `glossary.qmd`, everything in `courses/<slug>/sources/weekN/` (or `weekNN/` if that is how the user laid it out), and any files already in `lectures/figures/weekNN/` (or `lectures/figures/`).

**Sparse slide PDFs:** try the Read tool first. For diagram/formula slides whose extracted text looks empty or suspicious, use the `document-skills` plugin's PDF skill to pull the slide images and look at the images before trusting a number or label; fall back to rendering pages with `pdftoppm`/PyMuPDF if the plugin fails. Skip logistics slides (schedule, grading, staff, policies).

Emit, then **stop and wait for approval**. Do not write notes yet:

- concept list (mark anything a current or upcoming homework leans on)
- underlying math each concept assumes
- dependency map (prerequisite / formalizes / builds-on)
- proposed section order (**lecture/slide order**, not a wholesale dependency reorder). If a true prerequisite is missing, flag a short subsection where it will be inserted
- which slides are logistics and will be skipped

#### Phase 1 — Write the week chapter (source of truth)

After approval, write `courses/<slug>/lectures/weekNN.qmd` from [`templates/course-notes-book/lectures/week.md`](../../../templates/course-notes-book/lectures/week.md). Honor [`.claude/rules/course-notes.md`](../../rules/course-notes.md) and [`course-notes-voice.md`](../../references/course-notes-voice.md): motivate then define, lecture-owned examples, no invented analogies, no em dashes, no homework numeric answers, no dense walls. Wikipedia on first mention of a term in this chapter. Inline SVG in `{=html}` blocks (Pastel Rainbow, Helvetica stack). Hand-placed images the user dropped in `lectures/figures/weekNN/` are included with `![caption](figures/weekNN/name.png)`. `{ojs}` is optional, not required. Do **not** insert empty `.clarification` dropdowns on `add`.

#### Phase 2 — Glossary and book list

Append `## Week N` to `glossary.qmd`. One-sentence-plus-cross-reference per term. Never delete or rewrite away an earlier beginner entry; a later week may add a "stricter sense" note.

Insert `- lectures/weekNN.qmd` into `_quarto.yml` under `book.chapters`, **before** `glossary.qmd`.

If `COURSE.md` still has blank font/colour tokens after Week 1, write the navy defaults into `COURSE.md` so later weeks cannot drift.

#### Phase 3 — Render (skip if `--no-render`)

From `courses/<slug>/`, run `quarto render`. If `quarto` is missing, stop with the same install hint as `/deploy` (`TROUBLESHOOTING.md`). Do not invent a second HTML SoT. Open `_site/lectures/weekNN.html` (or tell the user to).

Then score the new chapter with the **book** rubric (not the RevealJS slide rubric):

```bash
python3 scripts/quality_score.py courses/<slug>/lectures/weekNN.qmd
```

If the score is below 80, fix display-math splits, SVG title clearance, or CSS before telling the user the week is ready. Do not treat a horizontal scrollbar as a pass.

#### Phase 4 — Stop for revise, then audit

Do not run the auditor yet unless the user already asked for `audit` in the same invocation and did not pass `--no-audit`. Tell them to read the week `.qmd` and the rendered chapter, then `/course-notes revise <slug> [N]` (Claude Code **plan mode** for questions; default mode for writes). Fold repeat generation complaints into `COURSE.md` (or `/learn` as `[LEARN:course-notes]`). After revise, optionally `/course-notes practice <slug> <N>`, then `/course-notes audit <slug>` and `/commit`.

### `practice` — self-study problems for one week (plan-first)

Confirm `courses/<slug>/` exists and `lectures/weekNN.qmd` exists. If the course is missing, tell the user to `init` first. If the week chapter is missing, tell them to `add` first. If `lectures/weekNN-practice.qmd` already exists, stop and ask whether to regenerate or `/course-notes revise` that file. Do **not** auto-run `practice` at the end of `add`.

Steal the generation checklist from [`/scaffold-exercises`](../scaffold-exercises/SKILL.md) (pre-flight, types, difficulty, notation reuse, worked solutions). Invert the product: one book chapter, answers on the page in collapsed dropdowns. Do not invoke that skill and do not write `exercises/*_problems.md`.

#### Phase 0 — Pre-flight (blocking)

Read `COURSE.md`, `lectures/weekNN.qmd`, `glossary.qmd`, any existing `lectures/weekNN-practice.qmd`, and homework/slides in `courses/<slug>/sources/weekN/` (or `weekNN/`) **only as a negative list**: which assignment items we will not reproduce.

Emit a report, then **stop and wait for approval**. Do not write the practice chapter yet:

```markdown
## Pre-Flight Report — Course-notes practice

**Course / week:** <slug> Week N
**Source(s) read:** [week chapter; glossary; homework/slides if present]
**Difficulty mix:** intro | core | advanced (default: mostly core, one intro, one stretch)
**Counts by type:** conceptual=N, numeric=N, code-reading=N  (total 5–8 unless `--count`)
**Learning objectives:** [2–4 bullets from the week's summary takeaways]
**Skipped homework items:** [prompts we will not compute; "none in sources" if absent]
**Proposed briefs:**
1. [type] [concept] — invented setup — reteaches §…
```

Default 5–8 problems covering the week's takeaways, not one problem per heading. Types: **conceptual** (explain / distinguish / predict), **numeric** (invented numbers; same method as the week's worked example), optional **code-reading** (predict output or fill a short expression; never dump a homework solution). Notation matches the week chapter. Invented numbers must not be a trivial relabeling of homework or of the week's worked example.

#### Phase 1 — Write the practice chapter

After approval, write `courses/<slug>/lectures/weekNN-practice.qmd` from [`templates/course-notes-book/lectures/week-practice.md`](../../../templates/course-notes-book/lectures/week-practice.md). Honor [`.claude/rules/course-notes.md`](../../rules/course-notes.md) and [`course-notes-voice.md`](../../references/course-notes-voice.md).

Each problem: visible stem, then one collapsed `.practice-answer` (not `.clarification`):

```markdown
## Problem 1: [concept in the reader's words] {#prb-1}

[Self-contained stem.]

::: {.callout-tip collapse="true" .practice-answer title="Worked solution"}
[1. Which week section this reteaches. 2. Reasoning in lecture voice. 3. The answer last.]
:::
```

The dropdown is a teaching walkthrough, not a one-line key. Point at the week section; do not paste the week spine. Wikipedia is allowed on first mention **in this chapter**. No empty `.clarification` boxes. No `{ojs}` graders in v1.

#### Phase 2 — Book list

Insert `- lectures/weekNN-practice.qmd` into `_quarto.yml` under `book.chapters` **immediately after** `- lectures/weekNN.qmd` (before the next week, still before `glossary.qmd`).

#### Phase 3 — Render (skip if `--no-render`)

From `courses/<slug>/`, run `quarto render`. Then score:

```bash
python3 scripts/quality_score.py courses/<slug>/lectures/weekNN-practice.qmd
```

If the score is below 80, fix display-math splits or CSS before calling the chapter ready.

#### Phase 4 — Stop for revise, then audit

Do not run the auditor unless the user already asked for `audit` in the same invocation and did not pass `--no-audit`. Tell them to read the practice `.qmd` and the rendered chapter, then `/course-notes revise <slug> [N]` naming the practice chapter for promote/park. After revise, `/course-notes audit <slug>` and `/commit`.

Close with a manifest: path, counts by type, render status, score.

### `revise` — pre-audit edits (promote or park)

Confirm `courses/<slug>/` exists and the target chapter exists (`lectures/weekNN.qmd`, or `lectures/weekNN-practice.qmd` if the user named the practice chapter). If `[N]` is omitted, use the week already in the conversation or the latest `weekNN.qmd`; if still ambiguous, ask. Default target is the week chapter, not the practice file, unless the user names practice.

**Claude Code overlay.** Prefer **plan mode** for a streak of questions (read-only). Prefer **default mode** for promote, park, audit, and commit. The rules below still apply if plan mode is off.

**Write only on these cues.** Anything else is more clarification: answer in chat, do not write, do not nag for a disposition.

| User says | Action |
| --- | --- |
| **Promote** / “put that in the section” / “change the section” | Edit the named section in lecture voice. No `.clarification` callout. If a promote introduces a new term, echo it in `glossary.qmd`. Then render + score (unless `--no-render`). |
| **Park** / “clarification dropdown” / “add a clarification” | Insert a collapsed callout **at the point where the reader would ask the question**: directly after the sentence, equation, or block that raises it, not at the end of the section. Do not also paste that prose into the spine. Then render + score (unless `--no-render`). |
| **Discard** | Drop the last explanation. Stay in revise. Write nothing. |
| **Audit** | End revise; run the `audit` mode below. Chat-only text is not on the page. |
| **Commit** | End revise. Do **not** commit. Tell them to run [`/commit`](../commit/SKILL.md). Chat-only text is not on the page. |
| **Any question or follow-up** | Explain in chat. No file writes. May be parked or promoted later. |

Parked shape (once per kept question, not one empty box per heading). The dropdown is written as a **question the reader might ask**, and the closed box shows that question as its title:

```markdown
::: {.callout-tip collapse="true" .clarification title="Question: [the question a reader would ask at this point]"}
[The answer: extra derivation or distinction. No bold "Clarification." label.]
:::
```

**Placement.** Put the box where the confusion arises. If the user names a spot, use it. Otherwise pick the passage the question is about (the equation, definition, or step that prompts it); if several qualify, take the earliest where the question is natural. Never inside a `.definition-block`, algorithm block, list, table, or display math: place it immediately after the enclosing block. Write the title in the reader's voice ("Why …?", "How does this change when …?"), with no math markup.

Honor [`.claude/rules/course-notes.md`](../../rules/course-notes.md) and [`course-notes-voice.md`](../../references/course-notes-voice.md) on both promote and park (homework-answer ban, no em dashes, no invented analogies, Wikipedia-only links). After park/promote, `quarto render` from the course root and `python3 scripts/quality_score.py` on the chapter you edited (`weekNN.qmd` or `weekNN-practice.qmd`). Fix scores below 80 before calling the week ready.

Once per **pause** (the user seems done asking, not after every question), you may mention that promote / park / discard / audit / commit are available. Never treat silence or a follow-up as park.

### `audit` — cold factual pass (skip if `--no-audit` on an `add`)

1. Confirm `courses/<slug>/` exists and has at least one `lectures/week*.qmd`.
2. Fork `fact-auditor` with **no** writing-conversation context and **no** style rules. Hand it paths only: README, every `lectures/weekNN.qmd`, every `lectures/weekNN-practice.qmd`, `glossary.qmd`, `index.qmd`. Do **not** include `COURSE.md`, root `CLAUDE.md`, this skill's body, or `_site/`.

   ```
   Agent: subagent_type=fact-auditor, context=fork
   Prompt: the file list above. Do not include the writing conversation.
   ```

3. Treat every finding as a CANDIDATE ([`/adjudicate-review`](../adjudicate-review/SKILL.md)): open the cited location; apply **Corrected** claims in the `.qmd`; leave **Unverifiable** untouched; do not "fix" style.
4. Regenerate `courses/<slug>/FACT_AUDIT.md` from [`templates/fact-audit.md`](../../../templates/fact-audit.md) (current state, not accumulated history).
5. Chat summary: total claims, each correction in one line, unverifiable count, Wikipedia-link failures.

## Output / report format

- `init`: paths created + reminder to fill `COURSE.md`.
- `add`: pre-flight block (before writes); then paths written + render status + “not committed” + pointer to `revise`.
- `practice`: pre-flight block (before writes); then path + counts by type + render status + score + “not committed” + pointer to `revise`.
- `revise`: for questions, the explanation only; for park/promote, path + section id + render status + score; for discard/audit/commit, the action taken. Never “not committed” as a substitute for `/commit`.
- `audit`: `FACT_AUDIT.md` + the short summary above.

## Exit behavior

- **Pre-flight not yet approved:** write nothing (`add` and `practice`).
- **Slug missing or invalid / week number missing on `add` or `practice`:** stop with the expected invocation.
- **`courses/<slug>/` missing on `add`/`practice`/`revise`/`audit`:** tell the user to `init` first.
- **`lectures/weekNN.qmd` missing on `practice`:** tell the user to `add` first.
- **Question during `revise`:** write nothing.
- **Never commit or push.**

## Flags

- `--no-render` — skip Phase 3 on `add` and `practice`, and skip `quarto render` + quality score after a `revise` park or promote.
- `--no-audit` — do not run `audit` after `add` or `practice` even if the user bundled the request. Does not block an explicit **audit** cue during `revise`.
- `--count N` — (`practice` only) total number of problems; default 5–8 covering takeaways.

## Cross-references

- [`.claude/rules/course-notes.md`](../../rules/course-notes.md) — path-scoped writing constraints (`courses/**`).
- [`.claude/references/course-notes-voice.md`](../../references/course-notes-voice.md) — lecture voice, figure palette, clarification and practice dropdowns.
- [`.claude/agents/fact-auditor.md`](../../agents/fact-auditor.md) — forked cold auditor this skill dispatches.
- [`.claude/references/course-notes-workflow.md`](../../references/course-notes-workflow.md) — why the four layers exist.
- [`templates/course-notes-book/lectures/week.md`](../../../templates/course-notes-book/lectures/week.md) — week chapter shape.
- [`templates/course-notes-book/lectures/week-practice.md`](../../../templates/course-notes-book/lectures/week-practice.md) — practice chapter shape.
- [`/scaffold-exercises`](../scaffold-exercises/SKILL.md) — graded student set + separate key; not this mode.
- [`/commit`](../commit/SKILL.md) — shipping source. This skill does not.
- [`/deploy-course-notes`](../deploy-course-notes/SKILL.md) — render book to `docs/courses/<slug>/` for GitHub Pages after `/commit`. Parked dropdowns and practice solutions ship with that HTML.
- [`/learn`](../learn/SKILL.md) — generic recurring lessons as `[LEARN:course-notes]`.

## What this skill does NOT do

- **Instructor slides** — [`/create-lecture`](../create-lecture/SKILL.md) / [`/teach-from-paper`](../teach-from-paper/SKILL.md) / files in `Quarto/`.
- **Literature or paper notes** — [`/lit-review`](../lit-review/SKILL.md). A future `/paper-notes` is out of scope.
- **Manuscript fact-checking** — [`/verify-claims`](../verify-claims/SKILL.md) / `claim-verifier`.
- **Graded problem sets with a separate key** — [`/scaffold-exercises`](../scaffold-exercises/SKILL.md). Self-study dropdowns in the book are `practice`.
- **Commit, push, or publish** — use [`/commit`](../commit/SKILL.md) then [`/deploy-course-notes`](../deploy-course-notes/SKILL.md); not this skill.
- **A parent `/study-notes` dispatcher** — not until a second note type exists.
- **Auto-park after every question** — park only when the user says park.
- **Auto-practice after `add`** — `practice` is an explicit later step.
