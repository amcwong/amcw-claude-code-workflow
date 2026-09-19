---
name: course-notes
description: Write beginner-facing course notes for one lecture week under courses/<slug>/ — a Quarto book chapter, cumulative glossary, and local render. Use when the user says "add week N", "write course notes", "init course notes", "audit the course notes", "revise course notes", "park that", "promote that", or "clarification dropdown". NOT for instructor Beamer/Quarto decks (use `/create-lecture` / `/teach-from-paper`), NOT for literature or paper notes (use `/lit-review`), NOT for manuscript fact-checking (use `/verify-claims`), NOT for generic "study notes" or "add notes."
argument-hint: "[init <slug> | add <slug> <N> | revise <slug> [N] | audit <slug>] [--no-render] [--no-audit]"
allowed-tools: ["Read", "Write", "Edit", "Grep", "Glob", "Bash", "Agent", "Task"]
disable-model-invocation: true
effort: high
---

# /course-notes — Weekly Course Notes

Produce beginner-facing notes for one lecture week of a course under `courses/<slug>/`: a Quarto book chapter (`lectures/weekNN.qmd`, source of truth), a cumulative glossary chapter, and a local `_site/` render. `revise` is the human pass between writing and audit. Fact-audit is a separate mode of this same skill.

**Core principle:** the week `.qmd` is source of truth; HTML is only `quarto render` output. Nothing in this skill commits or pushes — that is [`/commit`](../commit/SKILL.md).

Instructor RevealJS lives in `Quarto/` and is out of scope. Never write course notes there.

Two optional Claude Code plugins (`superpowers`, `document-skills`) are intended to support this workflow.

## When to pick this skill

- **`/course-notes`** (this skill) — learner notes for a **course** with lecture weeks, homework-depth, and a term-length glossary + book.
- **`/create-lecture` / `/teach-from-paper`** — instructor Beamer/Quarto decks in `Slides/` / `Quarto/`. Different audience, different artifacts.
- **`/lit-review`** — literature across papers, not a weekly course loop.
- **`/verify-claims`** — manuscript / draft CoVe. Course-notes audits use `fact-auditor` instead.
- **`/scaffold-exercises`** — graded problem sets, not notes.

If the user says only "study notes" or "add notes" without "course" or "week," ask which type. v1's only implemented type is course.

## Inputs

Parse `$ARGUMENTS`:

- `init <slug>` — scaffold `courses/<slug>/` from `templates/course-notes-book/` plus `COURSE.md`.
- `add <slug> <N>` — add week `N` (integer). Filename is `lectures/weekNN.qmd` with `N` zero-padded to two digits (`1` → `week01`).
- `revise <slug> [N]` — pre-audit edit pass on week `N` (or the week under discussion). Also fire on “park that”, “promote that”, or “clarification dropdown” when a week is already in context.
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
3. Do **not** copy a week chapter. Stop and tell the user to fill `[BRACKETED]` placeholders in `COURSE.md` and `index.qmd` / `_quarto.yml` (audience, course URL, expected week count, book title) and drop Week 1 slides into `sources/week1/`. Do not write week notes.

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

Do not run the auditor yet unless the user already asked for `audit` in the same invocation and did not pass `--no-audit`. Tell them to read the week `.qmd` and the rendered chapter, then `/course-notes revise <slug> [N]` (Claude Code **plan mode** for questions; default mode for writes). Fold repeat generation complaints into `COURSE.md` (or `/learn` as `[LEARN:course-notes]`). After revise, `/course-notes audit <slug>` and `/commit`.

### `revise` — pre-audit edits (promote or park)

Confirm `courses/<slug>/` exists and the target `lectures/weekNN.qmd` exists. If `[N]` is omitted, use the week already in the conversation or the latest `weekNN.qmd`; if still ambiguous, ask.

**Claude Code overlay.** Prefer **plan mode** for a streak of questions (read-only). Prefer **default mode** for promote, park, audit, and commit. The rules below still apply if plan mode is off.

**Write only on these cues.** Anything else is more clarification: answer in chat, do not write, do not nag for a disposition.

| User says | Action |
| --- | --- |
| **Promote** / “put that in the section” / “change the section” | Edit the named section in lecture voice. No `.clarification` callout. If a promote introduces a new term, echo it in `glossary.qmd`. Then render + score (unless `--no-render`). |
| **Park** / “clarification dropdown” / “add a clarification” | Append a collapsed callout at the **end of the named section** (before the next `##`). Do not also paste that prose into the spine. Then render + score (unless `--no-render`). |
| **Discard** | Drop the last explanation. Stay in revise. Write nothing. |
| **Audit** | End revise; run the `audit` mode below. Chat-only text is not on the page. |
| **Commit** | End revise. Do **not** commit. Tell them to run [`/commit`](../commit/SKILL.md). Chat-only text is not on the page. |
| **Any question or follow-up** | Explain in chat. No file writes. May be parked or promoted later. |

Parked shape (once per kept question, not one empty box per heading):

```markdown
::: {.callout-tip collapse="true" .clarification}
**Clarification.** [Extra derivation or distinction.]
:::
```

Honor [`.claude/rules/course-notes.md`](../../rules/course-notes.md) and [`course-notes-voice.md`](../../references/course-notes-voice.md) on both promote and park (homework-answer ban, no em dashes, no invented analogies, Wikipedia-only links). After park/promote, `quarto render` from the course root and `python3 scripts/quality_score.py courses/<slug>/lectures/weekNN.qmd`. Fix scores below 80 before calling the week ready.

Once per **pause** (the user seems done asking, not after every question), you may mention that promote / park / discard / audit / commit are available. Never treat silence or a follow-up as park.

### `audit` — cold factual pass (skip if `--no-audit` on an `add`)

1. Confirm `courses/<slug>/` exists and has at least one `lectures/week*.qmd`.
2. Fork `fact-auditor` with **no** writing-conversation context and **no** style rules. Hand it paths only: README, every `lectures/weekNN.qmd`, `glossary.qmd`, `index.qmd`. Do **not** include `COURSE.md`, root `CLAUDE.md`, this skill's body, or `_site/`.

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
- `revise`: for questions, the explanation only; for park/promote, path + section id + render status + score; for discard/audit/commit, the action taken. Never “not committed” as a substitute for `/commit`.
- `audit`: `FACT_AUDIT.md` + the short summary above.

## Exit behavior

- **Pre-flight not yet approved:** write nothing.
- **Slug missing or invalid / week number missing on `add`:** stop with the expected invocation.
- **`courses/<slug>/` missing on `add`/`revise`/`audit`:** tell the user to `init` first.
- **Question during `revise`:** write nothing.
- **Never commit or push.**

## Flags

- `--no-render` — skip Phase 3 on `add`, and skip `quarto render` + quality score after a `revise` park or promote.
- `--no-audit` — do not run `audit` after `add` even if the user bundled the request. Does not block an explicit **audit** cue during `revise`.

## Cross-references

- [`.claude/rules/course-notes.md`](../../rules/course-notes.md) — path-scoped writing constraints (`courses/**`).
- [`.claude/references/course-notes-voice.md`](../../references/course-notes-voice.md) — lecture voice, figure palette, clarification dropdowns.
- [`.claude/agents/fact-auditor.md`](../../agents/fact-auditor.md) — forked cold auditor this skill dispatches.
- [`.claude/references/course-notes-workflow.md`](../../references/course-notes-workflow.md) — why the four layers exist.
- [`templates/course-notes-book/lectures/week.md`](../../../templates/course-notes-book/lectures/week.md) — week chapter shape.
- [`/commit`](../commit/SKILL.md) — shipping source. This skill does not.
- [`/deploy-course-notes`](../deploy-course-notes/SKILL.md) — render book to `docs/courses/<slug>/` for GitHub Pages after `/commit`. Parked dropdowns ship with that HTML.
- [`/learn`](../learn/SKILL.md) — generic recurring lessons as `[LEARN:course-notes]`.

## What this skill does NOT do

- **Instructor slides** — [`/create-lecture`](../create-lecture/SKILL.md) / [`/teach-from-paper`](../teach-from-paper/SKILL.md) / files in `Quarto/`.
- **Literature or paper notes** — [`/lit-review`](../lit-review/SKILL.md). A future `/paper-notes` is out of scope.
- **Manuscript fact-checking** — [`/verify-claims`](../verify-claims/SKILL.md) / `claim-verifier`.
- **Problem sets** — [`/scaffold-exercises`](../scaffold-exercises/SKILL.md).
- **Commit, push, or publish** — use [`/commit`](../commit/SKILL.md) then [`/deploy-course-notes`](../deploy-course-notes/SKILL.md); not this skill.
- **A parent `/study-notes` dispatcher** — not until a second note type exists.
- **Auto-park after every question** — park only when the user says park.
