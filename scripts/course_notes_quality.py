"""Static layout checks for /course-notes Quarto books (not RevealJS slides).

KaTeX does not wrap display math. Inline SVG titles must not sit under nodes.
This module does not score lecture decks under Quarto/.
"""
from __future__ import annotations

import os
import re
import subprocess
from pathlib import Path
from typing import Dict, List, Optional, Tuple

MATH_LINE_LIMIT = 160
MATH_OVERFLOW_CAP = 45
MATH_POINTS = 15
SVG_POINTS = 20
TITLE_MIN_PX = 24
TITLE_MAJOR_POINTS = 5
CSS_POINTS = 20

_UNDERBRACE = re.compile(r"\\(?:underbrace|overbrace)")
_BOOK_RENDER_CACHE: Dict[Path, Tuple[Optional[bool], str]] = {}

_HTML_FENCE = re.compile(
    r"```\{=html\}\s*(.*?)\s*```",
    re.S,
)
_SVG = re.compile(r"<svg\b[^>]*>.*?</svg>", re.S | re.I)
_TAG = re.compile(r"<(circle|rect|ellipse|text)\b([^>]*)>(?:([^<]*)</text>)?", re.I)


def is_course_notes_path(path: Path) -> bool:
    parts = {p.lower() for p in path.resolve().parts}
    return "courses" in parts or "course-notes-book" in parts


def find_book_root(path: Path) -> Optional[Path]:
    cur = path.resolve().parent
    for _ in range(10):
        yml = cur / "_quarto.yml"
        if yml.is_file():
            text = yml.read_text(encoding="utf-8")
            if re.search(r"(?m)^\s*type:\s*book\s*$", text):
                return cur
        if cur.parent == cur:
            break
        cur = cur.parent
    return None


def render_book(root: Path) -> Tuple[Optional[bool], str]:
    """quarto render from the book project root. Cached per process."""
    root = root.resolve()
    if root in _BOOK_RENDER_CACHE:
        return _BOOK_RENDER_CACHE[root]
    try:
        limit = int(os.environ.get("QUALITY_QUARTO_TIMEOUT", "") or 120)
        if limit <= 0:
            limit = 120
    except ValueError:
        limit = 120
    try:
        result = subprocess.run(
            ["quarto", "render"],
            capture_output=True,
            text=True,
            timeout=limit,
            cwd=root,
        )
        if result.returncode != 0:
            err = (result.stderr or result.stdout or "")[:400]
            out = (False, err)
        else:
            out = (True, "")
    except subprocess.TimeoutExpired:
        out = (None, f"book render not verified — exceeded {limit}s")
    except FileNotFoundError:
        out = (None, "book render not verified — Quarto not installed")
    _BOOK_RENDER_CACHE[root] = out
    return out


def display_math_issues(content: str) -> List[Dict]:
    """Flag single display-math rows that will not wrap in KaTeX."""
    issues: List[Dict] = []
    lines = content.split("\n")
    in_math = False
    math_delim = None

    def consider(line_no: int, inner: str) -> None:
        inner = inner.strip()
        if not inner or inner.startswith("%"):
            return
        n_brace = len(_UNDERBRACE.findall(inner))
        wide = len(inner) > MATH_LINE_LIMIT or n_brace >= 2
        if not wide:
            return
        why = []
        if n_brace >= 2:
            why.append(f"{n_brace} under/overbraces on one row")
        if len(inner) > MATH_LINE_LIMIT:
            why.append(f"{len(inner)} characters (limit {MATH_LINE_LIMIT})")
        issues.append({
            "line": line_no,
            "reason": "; ".join(why),
            "inner": inner[:80],
        })

    for i, line in enumerate(lines, 1):
        stripped = line.strip()
        if "$$" in stripped and math_delim != "env":
            if not in_math:
                in_math = True
                math_delim = "$$"
                if stripped.count("$$") >= 2:
                    consider(i, stripped.split("$$")[1])
                    in_math = False
                    math_delim = None
                continue
            in_math = False
            math_delim = None
            continue

        env_begin = re.match(
            r"\\begin\{(equation|align|gather|multline|eqnarray)\*?\}", stripped
        )
        if env_begin and not in_math:
            in_math = True
            math_delim = "env"
            continue
        if re.match(
            r"\\end\{(equation|align|gather|multline|eqnarray)\*?\}", stripped
        ):
            in_math = False
            math_delim = None
            continue

        if in_math:
            code = line.split("%")[0] if "%" in line else line
            for row in re.split(r"\\\\", code):
                consider(i, row.replace("&", " "))

    return issues


def _num(attrs: str, name: str, default: float = 0.0) -> float:
    m = re.search(rf"""\b{name}\s*=\s*["']([^"']+)["']""", attrs)
    if not m:
        return default
    try:
        return float(re.sub(r"[a-z%]+$", "", m.group(1).strip(), flags=re.I))
    except ValueError:
        return default


def _attr(attrs: str, name: str, default: str = "") -> str:
    m = re.search(rf"""\b{name}\s*=\s*["']([^"']*)["']""", attrs)
    return m.group(1) if m else default


def _boxes_overlap(a: Tuple[float, float, float, float],
                   b: Tuple[float, float, float, float]) -> bool:
    ax0, ay0, ax1, ay1 = a
    bx0, by0, bx1, by1 = b
    return ax0 < bx1 and ax1 > bx0 and ay0 < by1 and ay1 > by0


def svg_layout_issues(content: str) -> List[Dict]:
    """Title-band vs shape overlap, and in-SVG titles smaller than 24px."""
    issues: List[Dict] = []
    for html in _HTML_FENCE.findall(content):
        for svg in _SVG.findall(html):
            shapes: List[Tuple[float, float, float, float]] = []
            texts: List[Dict] = []
            for m in _TAG.finditer(svg):
                kind = m.group(1).lower()
                attrs = m.group(2) or ""
                body = (m.group(3) or "").strip()
                if kind == "circle":
                    cx, cy, r = _num(attrs, "cx"), _num(attrs, "cy"), _num(attrs, "r")
                    shapes.append((cx - r, cy - r, cx + r, cy + r))
                elif kind == "rect":
                    x, y = _num(attrs, "x"), _num(attrs, "y")
                    w, h = _num(attrs, "width"), _num(attrs, "height")
                    shapes.append((x, y, x + w, y + h))
                elif kind == "ellipse":
                    cx, cy = _num(attrs, "cx"), _num(attrs, "cy")
                    rx, ry = _num(attrs, "rx"), _num(attrs, "ry")
                    shapes.append((cx - rx, cy - ry, cx + rx, cy + ry))
                elif kind == "text":
                    x, y = _num(attrs, "x"), _num(attrs, "y")
                    fs = _num(attrs, "font-size", 12)
                    anchor = _attr(attrs, "text-anchor", "start")
                    weight = _attr(attrs, "font-weight", "")
                    width = 0.6 * fs * max(len(body), 1)
                    if anchor == "middle":
                        x0 = x - width / 2
                    elif anchor == "end":
                        x0 = x - width
                    else:
                        x0 = x
                    # SVG y is baseline; box from roughly y-fs to y+0.2*fs
                    box = (x0, y - fs, x0 + width, y + 0.2 * fs)
                    texts.append({
                        "body": body,
                        "box": box,
                        "y": y,
                        "fs": fs,
                        "weight": weight,
                    })

            title = None
            for t in texts:
                longish = len(t["body"]) >= 18
                styled = t["weight"] in ("600", "700", "bold") and t["fs"] >= 16
                if styled and longish:
                    title = t
                    break

            if title is not None:
                if title["fs"] < TITLE_MIN_PX:
                    issues.append({
                        "kind": "title_too_small",
                        "detail": (
                            f'in-SVG title "{title["body"][:40]}" is '
                            f'{title["fs"]}px (need >={TITLE_MIN_PX})'
                        ),
                    })
                band = (
                    title["box"][0] - 2000,
                    title["y"] - title["fs"],
                    title["box"][2] + 2000,
                    title["y"] + 8,
                )
                for sh in shapes:
                    if _boxes_overlap(band, sh):
                        issues.append({
                            "kind": "title_band_overlap",
                            "detail": (
                                f'a shape intersects the title band of '
                                f'"{title["body"][:40]}" '
                                f"(band y {band[1]:.0f}–{band[3]:.0f})"
                            ),
                        })
                        break
    return issues


def katex_css_ok(css_text: str) -> bool:
    m = re.search(
        r"\.katex-display\s*\{([^}]+)\}",
        css_text,
        re.S,
    )
    if not m:
        return False
    body = m.group(1)
    return (
        "overflow-x" in body
        and "auto" in body
        and "max-width" in body
        and "100%" in body
    )


def css_contract_issues(book_root: Optional[Path]) -> List[str]:
    if book_root is None:
        return []
    css_path = book_root / "styles" / "custom.css"
    if not css_path.is_file():
        return [f"missing {css_path}"]
    text = css_path.read_text(encoding="utf-8")
    if not katex_css_ok(text):
        return [
            f"{css_path}: need .katex-display {{ overflow-x: auto; "
            f"max-width: 100%; }} so KaTeX cannot paint into the sidebar"
        ]
    return []
