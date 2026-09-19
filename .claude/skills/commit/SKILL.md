---
name: commit
description: Stage, commit, push, open a PR, and merge to main. Use ONLY on explicit commit intent — user says "commit", "ship it", "push this", "open a PR", "merge to main", "let's commit this", "commit nopr", or prefixes with `/commit`. `/commit nopr` (or `--nopr`) skips the PR and pushes to main. Do NOT auto-invoke on vague end-of-task phrases ("we're done", "wrap up") — those require explicit confirmation first. Default path is commit-PR-merge; never force-pushes or skips hooks.
argument-hint: "[nopr | --nopr] [optional: commit message]"
allowed-tools: ["Bash", "Read", "Glob", "Agent", "Task"]
---

# Commit, PR, and Merge

Stage changes, verify quality gates, commit with a descriptive message, then either create a PR and merge to main (default) or push straight to `main` (`nopr`).

**Parse `$ARGUMENTS` first.** Tokens `nopr` and `--nopr` are flags (same meaning). Strip them; anything left is the commit message. Do not use `nopr` as the commit subject.

## Flags

- `--nopr` — skip the branch/PR/merge cycle: commit on `main` and `git push origin main`. `/commit nopr` is the same token. Never `--force`. Quality gates (Steps 0–0c) still run. Hooks still run.

## Steps

### Step 0: Quality Gate (Pre-Commit)

**Run before branching (default path) or before committing on `main` (`nopr`).** For every changed `.qmd`, `.tex`, or `.R` file that has quality rubrics, run:

```bash
python3 scripts/quality_score.py <changed-file-paths>
```

Files under `courses/` and `templates/course-notes-book/` use the **course-notes book** rubric (`score_course_notes`: book render, KaTeX column overflow, SVG title band). Instructor decks under `Quarto/` still use the slide rubric. Do not apply the 120-character slide overflow check to book chapters.

- If any file scores below **80**, halt and report the findings. The user must either fix the issues or explicitly override with phrases like *"commit anyway"* or *"skip quality gate"*.
- If all files score 80+, continue.

Spawn the **verifier** agent (via the `Agent` tool with `subagent_type=verifier`) to run compilation/render checks on the changed files. Report pass/fail before committing.

### Step 0b: Consistency Gate (Pre-Commit)

**Runs unconditionally.** The full backtest suite — all ten gates (surface-sync count claims like `"19 agents, 62 skills, 38 rules, 8 hooks"` and marked tables, skill integrity, model currency, links, spec conformance, staleness, repo hygiene, derived counts, ledger coverage, hook battery):

```bash
./scripts/backtest.sh
```

- **Exit 0:** all gates green — continue.
- **Nonzero:** at least one gate is red — print its output and halt. Fix, then re-run. Do NOT proceed past this gate on a red result, even with "commit anyway" — count drift alone produced PRs #70, #76, and #78.

### Step 0c: Passport Check (Pre-Commit)

If the diff touches a manuscript (`.tex`/`.qmd`) that has a passport in `quality_reports/passports/`, any `source_file` a passport lists, or any file a claim declares as a display (its `location:`, or an `appears_in` `path:`), read that passport: a load-bearing claim with `status: FAIL` or `STALE` is a **must-fix** — halt, name the claim, and point at `/audit-reproducibility` (or the stale script) before committing. A touched display triggers the check for the same reason a touched script does: editing one artifact's copy of a number desynchronizes it from that number's other displays — the supplement or deck holding the same value was not necessarily updated in the same commit. Skip silently when no passport exists.

### Step 1: Check current state

```bash
git status
git diff --stat
git log --oneline -5
```

### Step 2: Branch (skip if `nopr`)

**Default:** create a new branch. Never commit to `main` on this path.

```bash
git checkout -b <short-descriptive-branch-name>
```

**`nopr` / `--nopr`:** do not create a PR branch. Stay on `main`, or check out `main` if HEAD is another branch (uncommitted work usually comes along; halt if git refuses). If the previous branch already has commits that `main` lacks, merge that branch into `main` with `--merge` after the commit (same dirty-tree stash rules as Step 6). Then continue at Step 3 on `main`.

### Step 3: Stage files

Add specific files (never use `git add -A`):

```bash
git add <file1> <file2> ...
```

Do NOT stage `.claude/settings.local.json` or any files containing secrets.

### Step 4: Commit with a descriptive message

If `$ARGUMENTS` still has text after stripping `nopr` / `--nopr`, use it as the commit message. Otherwise, analyze the staged changes and write a message that explains *why*, not just *what*.

**The subject line states what is TRUE AFTER the commit** — a plain sentence about behavior that a reader could go and test. *"Fixed review feedback"* and *"Updated the checker"* narrate your afternoon and tell a reader nothing; *"The parity gate refuses a fixture whose hash is unregistered"* is a claim they can check against the code. Process narration — which review round it came from, who asked, how many attempts it took — belongs in the body if it belongs anywhere. The body still carries the *why*; the subject carries the claim.

```bash
git commit -m "$(cat <<'EOF'
<commit message here>
EOF
)"
```

### Step 5: Push (and create PR unless `nopr`)

**`nopr` / `--nopr`:** do not run `gh pr create`. Pull `main` if needed (stash unstaged leftovers first; see Step 6), then:

```bash
git push origin main
```

Never force-push to `main` (no `--force`, no `--force-with-lease`). Report that `main` was pushed; there is no PR URL.

Skip Step 6.

**Default:**

```bash
git push -u origin <branch-name>
gh pr create --title "<short title>" --body "$(cat <<'EOF'
## Summary
<1-3 bullet points>

## Test plan
<checklist>

🤖 Generated with [Claude Code](https://claude.com/claude-code)
EOF
)"
```

### Step 6: Merge and clean up

```bash
gh pr merge <pr-number> --merge --delete-branch
git checkout main
git status --porcelain          # must print nothing before the next line runs
git pull
```

**Expect the tree to be dirty here — that is what Step 3 is for.** Staging specific files means
everything the session touched but did not stage, plus every untracked artifact, is still in the
tree when you arrive at this step. The `git-guardrails` hook this template ships **denies**
`git pull` (and `merge`, and `rebase`) whenever `git status --porcelain` is non-empty, because a
pull that resolves on top of uncommitted work cannot be reviewed afterwards — you can no longer
tell which hunk came from the remote. Chaining a stash into the same command line does not help:
the hook reads the tree, it does not predict what the line will do to it.

Clear the tree deliberately, then pull:

```bash
git stash push -u -m "post-merge: unstaged leftovers"   # -u, or untracked files stay behind
git pull
git stash pop
```

`git pull --autostash` is the one-command alternative, but only on a tree whose dirt is entirely
**tracked**. `git stash` does not stash untracked files, so an autostash over a `??` entry starts
the pull on the same dirty tree the check exists to refuse — the hook therefore reads porcelain
and **denies** `--autostash` whenever any `??` entry is present. At this step that is the usual
state, so the explicit `-u` stash above is the default route and `--autostash` is the shortcut for
the case where `git status --porcelain` shows no `??` lines at all. Git agrees independently: if
the incoming commits add a file at a path you are holding untracked, it aborts the merge
(*"untracked working tree files would be overwritten"*) after the autostash has already been
taken. Either route must be its **own** command — chaining the stash and the pull onto one line is
denied outright, because an identified history op reaches the tree reading only as a standalone
simple command.

`ALLOW_DIRTY_MERGE=1` is the hatch for a dirty state you have looked at and can justify out loud.
It is not the routine remedy, and reaching for it because the block is inconvenient is the
behavior the check exists to prevent.

### Step 7: Report

Report the PR URL and what was merged. On `nopr`, report the `main` push SHA instead.

## Important

- **Never skip Step 0.** Quality gates catch broken compilation, bad citations, and hardcoded paths before they reach `main`. If the user insists on skipping, record their override reason in the commit message.
- Default path: always create a NEW branch — never commit directly to main.
- `nopr` / `--nopr` is the exception: commit on `main` and push `origin main`. Still never force-push.
- Exclude `settings.local.json` and sensitive files from staging.
- Use `--merge` (not `--squash` or `--rebase`) unless asked otherwise.
- If a commit message remains in `$ARGUMENTS` after stripping `nopr` / `--nopr`, use it exactly.
