# Changelog

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
