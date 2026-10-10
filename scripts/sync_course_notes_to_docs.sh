#!/bin/bash
# sync_course_notes_to_docs.sh
# Render a course-notes Quarto book and sync _site/ to docs/courses/<slug>/ for GitHub Pages.
#
# Usage: ./scripts/sync_course_notes_to_docs.sh [slug|all]
# With no argument, deploys all courses (same as `all`).
# Examples:
#   ./scripts/sync_course_notes_to_docs.sh            # all courses (default)
#   ./scripts/sync_course_notes_to_docs.sh CSC2506
#   ./scripts/sync_course_notes_to_docs.sh all
#   ./scripts/sync_course_notes_to_docs.sh ALL   # same as all (case-insensitive)

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
COURSES_DIR="$REPO_ROOT/courses"
DOCS_COURSES="$REPO_ROOT/docs/courses"
QUALITY="$REPO_ROOT/scripts/quality_score.py"
MIN_SCORE=80

usage() {
    echo "Usage: $0 [slug|all]" >&2
    echo "  slug  Course directory name under courses/ (e.g. CSC2506)" >&2
    echo "  all   Deploy every courses/* book that has _quarto.yml (case-insensitive: ALL, All)" >&2
    echo "  (no argument) same as all" >&2
    exit 1
}

github_pages_user() {
    if [[ -n "${GITHUB_PAGES_USER:-}" ]]; then
        echo "$GITHUB_PAGES_USER"
        return
    fi
    local url owner
    url="$(git -C "$REPO_ROOT" config --get remote.origin.url 2>/dev/null || true)"
    if [[ "$url" =~ github.com[:/]([^/]+)/ ]]; then
        owner="${BASH_REMATCH[1]}"
        echo "$owner"
        return
    fi
    echo "YOUR_GITHUB_USERNAME"
}

github_pages_repo() {
    if [[ -n "${GITHUB_PAGES_REPO:-}" ]]; then
        echo "$GITHUB_PAGES_REPO"
        return
    fi
    local url repo
    url="$(git -C "$REPO_ROOT" config --get remote.origin.url 2>/dev/null || true)"
    if [[ "$url" =~ github.com[:/][^/]+/([^/.]+)(\.git)?$ ]]; then
        repo="${BASH_REMATCH[1]}"
        echo "$repo"
        return
    fi
    echo "claude-code-my-workflow"
}

public_url() {
    local slug="$1"
    local user repo
    user="$(github_pages_user)"
    repo="$(github_pages_repo)"
    echo "https://${user}.github.io/${repo}/courses/${slug}/"
}

hub_url() {
    echo "https://$(github_pages_user).github.io/$(github_pages_repo)/"
}

# Ensure the book sidebar links back to the hub (docs/index.html). Idempotent:
# skips any _quarto.yml that already mentions the hub URL. Edits the source
# _quarto.yml in place so the link persists for future renders.
ensure_hub_link() {
    local yml="$1"
    local url
    url="$(hub_url)"
    if grep -qF "$url" "$yml"; then
        return 0
    fi
    echo "=== Adding hub link (${url}) to $(basename "$(dirname "$yml")")/_quarto.yml ==="
    python3 - "$yml" "$url" <<'PY'
import sys
path, url = sys.argv[1], sys.argv[2]
lines = open(path).read().split("\n")
item = [
    "      - icon: house-door",
    f"        href: {url}",
    '        text: "All course notes"',
]
book = next((i for i, l in enumerate(lines) if l.rstrip() == "book:"), None)
if book is None:
    sys.exit(f"Error: no top-level 'book:' key in {path}")
# End of the book block: next line at column 0 that is not blank
end = next((i for i in range(book + 1, len(lines))
            if lines[i] and not lines[i][0].isspace()), len(lines))
sidebar = next((i for i in range(book + 1, end) if lines[i].rstrip() == "  sidebar:"), None)
if sidebar is None:
    lines[end:end] = ["  sidebar:", "    tools:"] + item
else:
    s_end = next((i for i in range(sidebar + 1, end)
                  if lines[i].strip() and len(lines[i]) - len(lines[i].lstrip()) <= 2), end)
    tools = next((i for i in range(sidebar + 1, s_end) if lines[i].rstrip() == "    tools:"), None)
    if tools is None:
        lines[s_end:s_end] = ["    tools:"] + item
    else:
        lines[tools + 1:tools + 1] = item
open(path, "w").write("\n".join(lines))
PY
}

list_course_slugs() {
    local yml slug
    local -a slugs=()
    shopt -s nullglob
    for yml in "$COURSES_DIR"/*/_quarto.yml; do
        slug="$(basename "$(dirname "$yml")")"
        slugs+=("$slug")
    done
    shopt -u nullglob
    if [[ ${#slugs[@]} -eq 0 ]]; then
        return 1
    fi
    # Stable order so "all" is predictable
    printf '%s\n' "${slugs[@]}" | LC_ALL=C sort
}

score_course_chapters() {
    local course_dir="$1"
    local slug="$2"
    local qmd failed=0

    echo "=== Quality gate: courses/${slug} (min ${MIN_SCORE}) ==="
    shopt -s nullglob
    local chapters=("$course_dir/index.qmd" "$course_dir/glossary.qmd" "$course_dir"/lectures/week*.qmd)
    shopt -u nullglob
    for qmd in "${chapters[@]}"; do
        if [[ ! -f "$qmd" ]]; then
            continue
        fi
        echo "  Scoring $(basename "$qmd")..."
        if ! python3 "$QUALITY" "$qmd" --summary; then
            failed=1
        fi
    done

    if [[ "$failed" -ne 0 ]]; then
        echo "Error: quality score below ${MIN_SCORE} for courses/${slug}. Fix chapters before deploy." >&2
        return 1
    fi
    return 0
}

deploy_one() {
    local slug="$1"
    local course_dir="$COURSES_DIR/$slug"
    local dest="$DOCS_COURSES/$slug"

    if [[ ! -d "$course_dir" ]]; then
        echo "Error: courses/${slug}/ not found" >&2
        return 1
    fi
    if [[ ! -f "$course_dir/_quarto.yml" ]]; then
        echo "Error: courses/${slug}/_quarto.yml not found" >&2
        return 1
    fi
    if ! command -v quarto >/dev/null 2>&1; then
        echo "Error: quarto not found. Install from https://quarto.org/docs/get-started/" >&2
        return 1
    fi

    if ! score_course_chapters "$course_dir" "$slug"; then
        return 1
    fi

    ensure_hub_link "$course_dir/_quarto.yml" || return 1

    echo "=== Rendering courses/${slug} ==="
    (cd "$course_dir" && quarto render)

    if [[ ! -d "$course_dir/_site" ]]; then
        echo "Error: render did not produce courses/${slug}/_site/" >&2
        return 1
    fi

    echo "=== Syncing to docs/courses/${slug}/ ==="
    mkdir -p "$DOCS_COURSES"
    if command -v rsync >/dev/null 2>&1; then
        rsync -av --delete "$course_dir/_site/" "$dest/"
    else
        rm -rf "$dest"
        mkdir -p "$dest"
        cp -R "$course_dir/_site/." "$dest/"
    fi

    echo ""
    echo "=== Deploy sync complete: ${slug} ==="
    echo "Local preview:  file://${dest}/index.html"
    echo "Public URL (after push + GitHub Pages enabled): $(public_url "$slug")"
    echo ""
    echo "Next: /commit and push to main, then verify on desktop and phone."
    return 0
}

if [[ $# -gt 1 ]]; then
    usage
fi

# Default target is every course
TARGET="${1:-all}"
# Case-insensitive "all" / "ALL" / "All"
TARGET_LC="$(printf '%s' "$TARGET" | tr '[:upper:]' '[:lower:]')"

if [[ "$TARGET_LC" == "all" ]]; then
    SLUGS=()
    while IFS= read -r slug; do
        [[ -n "$slug" ]] && SLUGS+=("$slug")
    done < <(list_course_slugs) || true
    if [[ ${#SLUGS[@]} -eq 0 ]]; then
        echo "Error: no courses with _quarto.yml under courses/" >&2
        exit 1
    fi
    echo "=== Deploying all courses (${#SLUGS[@]}): ${SLUGS[*]} ==="
    FAILED=()
    OK=()
    for slug in "${SLUGS[@]}"; do
        echo ""
        echo "######## ${slug} ########"
        if deploy_one "$slug"; then
            OK+=("$slug")
        else
            echo "Continuing with remaining courses after failure: ${slug}" >&2
            FAILED+=("$slug")
        fi
    done
    echo ""
    echo "=== All-courses summary ==="
    if [[ ${#OK[@]} -gt 0 ]]; then
        echo "Succeeded (${#OK[@]}): ${OK[*]}"
    else
        echo "Succeeded (0): (none)"
    fi
    if [[ ${#FAILED[@]} -gt 0 ]]; then
        echo "Failed (${#FAILED[@]}): ${FAILED[*]}" >&2
        exit 1
    fi
    echo "Failed (0): (none)"
else
    deploy_one "$TARGET" || exit 1
fi
