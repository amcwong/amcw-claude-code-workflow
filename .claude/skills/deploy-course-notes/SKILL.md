---
name: deploy-course-notes
description: Render course-notes Quarto books and sync to docs/courses/ for GitHub Pages. Use when user says "deploy course notes", "publish notes", "host notes on github", "ship CSC2506 notes", "deploy all course notes", or after course-notes edits that should go public. NOT for instructor RevealJS slides — use `/deploy`. NOT for writing week chapters — use `/course-notes`.
argument-hint: "[slug | all | ALL]"
allowed-tools: ["Read", "Bash"]
---

# Deploy Course Notes to GitHub Pages

Publish learner Quarto **books** from `courses/<slug>/` to `docs/courses/<slug>/` for GitHub Pages (Option A).

## Prerequisites (user, one-time)

GitHub **Settings → Pages → Source:** branch `main`, folder `/docs`. Without this, the public URL 404s even after commit.

## Steps

1. **Run the sync script:**
   - One course: `./scripts/sync_course_notes_to_docs.sh CSC2506`
   - **Every** course with `_quarto.yml`: `./scripts/sync_course_notes_to_docs.sh all`
     - `ALL` / `All` / `all` are equivalent (case-insensitive)
     - Deploys each `courses/*/` book in sorted order; if one fails the quality gate, remaining courses still run, then the script exits non-zero

2. **What the script does (per course):**
   - Scores `index.qmd`, `glossary.qmd`, and every `lectures/week*.qmd` (must be ≥ 80)
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

5. **Remind the user:**
   - `/deploy-course-notes` does **not** commit or push
   - Run `/commit`, then push to `main`
   - Pages may take 1–5 minutes to update
   - Update `docs/index.html` course links if a newly published course is missing from the hub

## Cross-references

- [`/course-notes`](../course-notes/SKILL.md) — write weeks; does not publish
- [`/deploy`](../deploy/SKILL.md) — instructor RevealJS slides only
- [`/commit`](../commit/SKILL.md) — ship source + rendered HTML
