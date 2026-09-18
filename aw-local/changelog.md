## 2026-09-18 — Deploy course notes (Option A)

- Added `/deploy-course-notes` skill and `scripts/sync_course_notes_to_docs.sh` (quality ≥ 80 → render → `docs/courses/<slug>/`).
- Set `website.site-path` on course book `_quarto.yml` (template, CSC2506, CSC2529).
- Mobile `@media` rules in course-notes `custom.css` (template + both courses).
- Published CSC2506 to `docs/courses/CSC2506/`; link on `docs/index.html`.
- Fixed CSC2506 Week 1 display-math splits and SVG title issues (deploy gate).
- Inventory 61 → 62 skills; guide re-rendered and stamped.

## 2026-09-18 — Course-notes quality gate

- Implemented book rubric in `scripts/course_notes_quality.py`; `quality_score.py` dispatches `courses/**` and `templates/course-notes-book/**`.
- Fixtures in `scripts/test_course_notes_quality.py`. CSS `.katex-display` overflow on template + CSC2506/CSC2529. Fixed CSC2506 Week 2 Step 2 math split and DAG title band.
- Checked off `aw-local/todos.md`.

## 2026-09-17 — Course-notes quality-check todo

- Added `aw-local/todos.md` with one open task: define how `/course-notes` book `.qmd` files should be quality-gated, instead of applying the slide `quality_score.py` rubric.

## 2026-09-16 — Course-notes surfaces: white page, grey sidebar

- Stopped auto-importing `custom-dark.css` on `prefers-color-scheme: dark` (it painted the reading column navy).
- Locked page chrome: white main column (`#ffffff`), light-grey left sidebar (`#f0f0f0`); navy stays on headings, links, and borders.

## 2026-09-16 — Course notes: Quarto book + Raffel-like voice

- Replaced `notebook.html` + week markdown with a Quarto book under `courses/<slug>/` (`templates/course-notes-book/`, `lectures/weekNN.qmd` SoT, gitignored `_site/`).
- Voice: motivate then define; no invented analogies; no em dashes. Navy `#002A5C` / Source Serif 4 / Source Code Pro.
- Skill: `--no-render`; lecture-order pre-flight; fact-auditor reads `.qmd` chapters.
- Migrated CSC2506 Week 1 to `lectures/week01.qmd` and rendered `_site/` successfully.
- Deleted `templates/notebook.html` and the old CSC2506 markdown/html pair.
## 2026-09-16 — Course-notes user guide (local)

- Added `aw-local/course-note-workflow/README.md` — how to run `/course-notes` (init / weekly loop / audit / troubleshooting).
- Copied `aw-local/devplan.md` → `aw-local/course-note-workflow/devplan.md` as a snapshot of the implementation plan.
- Guide section **Supporting this workflow with the rest of the repo** — sibling skills for auditing, editing, and content generation.
- Guide: clarified command inputs (slug / week `N` / sources) and that `audit` is course-wide only (no single-file form).
- Added `aw-local/course-note-workflow/workflow-gap-research.md` — sibling-skill comparison justifying `/course-notes`.

## 2026-09-16 — Add `/course-notes` infrastructure

- Ported the old study-notes kit into this repo as a **course-scoped** workflow (not a generic notes family):
  - Skill: `.claude/skills/course-notes/SKILL.md` (`init` / `add` / `audit`, slash-only)
  - Agent: `.claude/agents/fact-auditor.md` (read-only; skill applies fixes)
  - Rule: `.claude/rules/course-notes.md` (`courses/**`)
  - Reference: `.claude/references/course-notes-workflow.md`
  - Templates: `week-course-notes.md`, `course.md`, `glossary.md`, `course-notes-readme.md`, `notebook.html`, `fact-audit.md`
- Surface updates: README agent/skill rows, inventory **61 / 19 / 38 / 8**, fleet, sibling fencing on `/create-lecture` and `/verify-claims`, hygiene allowlist for `courses/` + `aw-local/`, gitignore for `courses/*/sources/`.
- CHANGELOG `v2.5.2` inventory line for the derived-counts gate; guide frontmatter bumped to 2.5.2 and re-rendered/stamped.
- `./scripts/backtest.sh` passes.
- No real `courses/<slug>/` content yet — run `/course-notes init <slug>` when ready.
- Left `aw-local/old-note-methodology/` in place as the archival source.

## 2026-09-16 — Fix validate-setup failures

- Made `.claude/hooks/claim-reconcile.py`, `git-guardrails.py`, and `root-of-trust-guard.py` executable (git mode `100644` → `100755`).
- Installed missing host tools so `./scripts/validate-setup.sh` passes:
  - Claude Code 2.1.267 (`brew install --cask claude-code`)
  - GitHub CLI 2.101.0 (`brew install gh`)
  - Quarto 1.10.18 (official macOS tarball in `~/.local/opt`, linked at `/opt/homebrew/bin/quarto`; Homebrew cask needs sudo)
  - XeLaTeX via TinyTeX, with Beamer packages so `Slides/HelloWorld.tex` compiles
- Re-ran `./scripts/validate-setup.sh`: 11 passed, 0 warnings, 0 failed.
