#!/bin/bash
# sync_course_notes_to_docs.sh
# Render a course-notes Quarto book and sync _site/ to docs/courses/<slug>/ for GitHub Pages.
#
# Usage: ./scripts/sync_course_notes_to_docs.sh [slug|all]
# Examples:
#   ./scripts/sync_course_notes_to_docs.sh CSC2506
#   ./scripts/sync_course_notes_to_docs.sh all

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
COURSES_DIR="$REPO_ROOT/courses"
DOCS_COURSES="$REPO_ROOT/docs/courses"
QUALITY="$REPO_ROOT/scripts/quality_score.py"
MIN_SCORE=80

usage() {
    echo "Usage: $0 [slug|all]" >&2
    echo "  slug  Course directory name under courses/ (e.g. CSC2506)" >&2
    echo "  all   Deploy every courses/* book that has _quarto.yml" >&2
    exit 1
}

github_pages_user() {
    if [[ -n "${GITHUB_PAGES_USER:-}" ]]; then
        echo "$GITHUB_PAGES_USER"
        return
    fi
    local url owner
    url="$(git -C "$REPO_ROOT" config --get remote.origin.url 2>/dev/null || true)"
    if [[ "$url" =~ github.com[:/][^/]+/([^/.]+) ]]; then
        :
    fi
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

score_course_chapters() {
    local course_dir="$1"
    local slug="$2"
    local qmd failed=0

    echo "=== Quality gate: courses/${slug} (min ${MIN_SCORE}) ==="
    for qmd in "$course_dir/index.qmd" "$course_dir/glossary.qmd" "$course_dir"/lectures/week*.qmd; do
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
        exit 1
    fi
}

deploy_one() {
    local slug="$1"
    local course_dir="$COURSES_DIR/$slug"
    local dest="$DOCS_COURSES/$slug"

    if [[ ! -d "$course_dir" ]]; then
        echo "Error: courses/${slug}/ not found" >&2
        exit 1
    fi
    if [[ ! -f "$course_dir/_quarto.yml" ]]; then
        echo "Error: courses/${slug}/_quarto.yml not found" >&2
        exit 1
    fi
    if ! command -v quarto >/dev/null 2>&1; then
        echo "Error: quarto not found. Install from https://quarto.org/docs/get-started/" >&2
        exit 1
    fi

    score_course_chapters "$course_dir" "$slug"

    echo "=== Rendering courses/${slug} ==="
    (cd "$course_dir" && quarto render)

    if [[ ! -d "$course_dir/_site" ]]; then
        echo "Error: render did not produce courses/${slug}/_site/" >&2
        exit 1
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
}

if [[ $# -ne 1 ]]; then
    usage
fi

TARGET="$1"

if [[ "$TARGET" == "all" ]]; then
    found=0
    for yml in "$COURSES_DIR"/*/_quarto.yml; do
        [[ -f "$yml" ]] || continue
        slug="$(basename "$(dirname "$yml")")"
        deploy_one "$slug"
        found=1
    done
    if [[ "$found" -eq 0 ]]; then
        echo "Error: no courses with _quarto.yml under courses/" >&2
        exit 1
    fi
else
    deploy_one "$TARGET"
fi
