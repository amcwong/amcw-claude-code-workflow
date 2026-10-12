# Personal notes → parked clarifications

Inbox for clarifications you worked out while reading the course notes.
The week chapters under `lectures/` stay the source of truth. Files here are
raw material for `/course-notes park-ingest` (park only). Interactive
**promote** stays on `/course-notes revise`.

## Layout

```
personal_notes/
  README.md          ← this file
  unparked/          ← ready for park-ingest
  parked/            ← already applied (archive / provenance)
```

## Lifecycle

1. **Read** a week chapter (and rendered HTML if useful).
2. **Clarify** in your own notes until the confusion is resolved.
3. **Drop one markdown file per clarification topic** into `unparked/`.
   Prefer one resolved idea per file (not a whole week dump).
4. **Run** `/course-notes park-ingest <slug>`. Claude will:
   - read every `*.md` in `unparked/` (or `--path`)
   - propose park placements in `lectures/weekNN.qmd` (anchors, question titles)
   - **stop and wait** for your approval of those placements (same gate as `add`)
5. **You approve, redirect, or drop** each proposed placement. No promote choice.
6. **Claude parks** approved items, then moves fully processed sources
   `unparked/…` → `parked/…`. Deferred items leave the file in `unparked/`.

## What a good unparked file looks like

- One topic in the title.
- A short TL;DR of what you clarified.
- Enough math / counterexample that Claude can rewrite precisely without
  inventing content.
- Pointers to the week/section/equation you were stuck on, when you know them.

Frontmatter (Obsidian-style) is fine and ignored as structure.

## What Claude will turn it into

Parked shape (same as `/course-notes revise` park):

::: {.callout-tip collapse="true" .clarification title="Question: …"}
Concise answer at the point of confusion. Lecture voice. No em dashes.
:::

- Title = question a reader would ask, plain text, no math markup.
- Placement = immediately after the passage that raises it.
- Fat notes get **split** across multiple anchors.
- Dedup against clarifications already on the page (suggested skips in the report).

## What this folder is not

- Not a second Quarto book or a parallel source of truth.
- Not where homework numeric answers go.
- Not auto-merged: nothing lands in `lectures/` without placement approval.
- Not a promote pipeline (use `revise` for spine edits).
