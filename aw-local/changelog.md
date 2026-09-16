# Changelog

## 2026-09-16 — Fix validate-setup failures

- Made `.claude/hooks/claim-reconcile.py`, `git-guardrails.py`, and `root-of-trust-guard.py` executable (git mode `100644` → `100755`).
- Installed missing host tools so `./scripts/validate-setup.sh` passes:
  - Claude Code 2.1.267 (`brew install --cask claude-code`)
  - GitHub CLI 2.101.0 (`brew install gh`)
  - Quarto 1.10.18 (official macOS tarball in `~/.local/opt`, linked at `/opt/homebrew/bin/quarto`; Homebrew cask needs sudo)
  - XeLaTeX via TinyTeX, with Beamer packages so `Slides/HelloWorld.tex` compiles
- Re-ran `./scripts/validate-setup.sh`: 11 passed, 0 warnings, 0 failed.
