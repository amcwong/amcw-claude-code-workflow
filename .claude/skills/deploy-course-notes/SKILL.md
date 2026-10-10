---
name: deploy-course-notes
description: Render course-notes Quarto books and sync to docs/courses/ for GitHub Pages. Use when user says "deploy course notes", "publish notes", "host notes on github", "ship CSC2506 notes", "deploy all course notes", or after course-notes edits that should go public. NOT for instructor RevealJS slides — use `/deploy`. NOT for writing week chapters — use `/course-notes`.
argument-hint: "[slug | all]  (default: all)"
allowed-tools: ["Read", "Bash", "Skill"]
---

# Deploy Course Notes to GitHub Pages

Publish learner Quarto **books** from `courses/<slug>/` to `docs/courses/<slug>/` for GitHub Pages (Option A).

## Prerequisites (user, one-time)

GitHub **Settings → Pages → Source:** branch `main`, folder `/docs`. Without this, the public URL 404s even after commit.

## Steps

1. **Run the sync script.** With no argument, `/deploy-course-notes` deploys **all** courses.
   - **Every** course with `_quarto.yml` (default): `./scripts/sync_course_notes_to_docs.sh` or `./scripts/sync_course_notes_to_docs.sh all`
     - `ALL` / `All` / `all` are equivalent (case-insensitive)
   - One course, only when a slug is given: `./scripts/sync_course_notes_to_docs.sh CSC2506`
     - Deploys each `courses/*/` book in sorted order; if one fails the quality gate, remaining courses still run, then the script exits non-zero

2. **What the script does (per course):**
   - Scores `index.qmd`, `glossary.qmd`, and every `lectures/week*.qmd` (must be ≥ 80)
   - Ensures the book sidebar has a house-icon link ("All course notes") back to the hub (`docs/index.html`, i.e. `https://<user>.github.io/<repo>/`). If `_quarto.yml` does not already mention the hub URL, the script adds a `book.sidebar.tools` entry to the source file. This is idempotent, and the edit is part of what you commit.
   - `quarto render` from the course root
   - Rsync `_site/` → `docs/courses/<slug>/`
   - Prints the public URL (`https://<user>.github.io/<repo>/courses/<slug>/`)

3. **Verify locally:**
   - Confirm HTML exists under `docs/courses/<slug>/` for each deployed course
   - `open docs/courses/<slug>/index.html` (macOS)
   - Spot-check one week chapter, glossary, and search

4. **Phone check (required before calling deploy done):**
   - After the user pushes, open the public URL on a phone or Chrome device mode (~390px)
   - Confirm sidebar, math scroll, and one inline SVG figure are usable

5. **Commit and push to `main` (default `nopr`):**
   - If the sync script exited 0 for every course deployed, invoke the `commit` skill with args `nopr`. No flag is needed.
   - If the sync script exited non-zero, do not commit. Report the failure.

6. **Remind the user** (only if the commit did not run):
   - Run `/commit nopr` manually to publish
   - Pages may take 1–5 minutes to update
   - Update `docs/index.html` course links if a newly published course is missing from the hub

## Cross-references

- [`/course-notes`](../course-notes/SKILL.md) — write weeks; does not publish
- [`/deploy`](../deploy/SKILL.md) — instructor RevealJS slides only
- [`/commit`](../commit/SKILL.md) — ship source + rendered HTML
