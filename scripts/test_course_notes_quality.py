#!/usr/bin/env python3
"""Red/green fixtures for scripts/course_notes_quality.py.

Run: python3 scripts/test_course_notes_quality.py
"""
from __future__ import annotations

import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))

from course_notes_quality import (  # noqa: E402
    display_math_issues,
    katex_css_ok,
    svg_layout_issues,
)

# Current CSC2506 Week 2 Step 2 line (must fail).
WIDE_MATH = r"""
$$\mathbb{E}[L] = \underbrace{\int\!\!\int \big(y(x) - \mathbb{E}[t\mid x]\big)^2 p(x,t)\, dx\, dt}_{\text{term A}} \;+\; \underbrace{\int\!\!\int \big(\mathbb{E}[t\mid x] - t\big)^2 p(x,t)\, dx\, dt}_{\text{term B}} \;+\; \underbrace{2\int\!\!\int \big(y(x) - \mathbb{E}[t\mid x]\big)\big(\mathbb{E}[t\mid x] - t\big) p(x,t)\, dx\, dt}_{\text{term C}}.$$
"""

SPLIT_MATH = r"""
$$\mathbb{E}[L] = A + B + C,$$

$$\text{term A} = \int\!\!\int u^2 p(x,t)\,dx\,dt,$$

$$\text{term B} = \int\!\!\int v^2 p(x,t)\,dx\,dt,$$

$$\text{term C} = 2\int\!\!\int u v\, p(x,t)\,dx\,dt.$$
"""

# Title y=24 fs=17; x4 circle cy=40 r=26 (top y=14) — current Week 2 DAG.
DAG_RED = r'''```{=html}
<svg viewBox="0 0 520 260">
  <text x="260" y="24" text-anchor="middle" font-size="17" font-weight="600">A DAG and its factorization</text>
  <circle cx="340" cy="40" r="26"/>
</svg>
```'''

DAG_GREEN = r'''```{=html}
<svg viewBox="0 0 520 310">
  <text x="260" y="32" text-anchor="middle" font-size="24" font-weight="600">A DAG and its factorization</text>
  <circle cx="340" cy="90" r="26"/>
</svg>
```'''

CSS_BAD = ".math.display { overflow-x: auto; margin: 1.2rem 0; }\n"
CSS_GOOD = """.katex-display {
  overflow-x: auto;
  overflow-y: hidden;
  max-width: 100%;
  margin: 1.2rem 0;
}
"""


def main() -> int:
    fails = 0

    def check(name: str, cond: bool) -> None:
        nonlocal fails
        if cond:
            print(f"  ok  {name}")
        else:
            print(f"  FAIL {name}")
            fails += 1

    print("display math")
    wide = display_math_issues(WIDE_MATH)
    check("wide three-underbrace line is flagged", len(wide) >= 1)
    split = display_math_issues(SPLIT_MATH)
    check("split A+B+C terms are clean", len(split) == 0)

    print("svg title band")
    red = svg_layout_issues(DAG_RED)
    kinds = {i["kind"] for i in red}
    check("red DAG flags title_band_overlap", "title_band_overlap" in kinds)
    check("red DAG flags title_too_small", "title_too_small" in kinds)
    green = svg_layout_issues(DAG_GREEN)
    check("green DAG is clean", green == [])

    print("katex css")
    check("old .math.display rule is not enough", not katex_css_ok(CSS_BAD))
    check("katex-display overflow+max-width passes", katex_css_ok(CSS_GOOD))

    if fails:
        print(f"\n{fails} fixture(s) failed")
        return 1
    print("\nall fixtures passed")
    return 0


if __name__ == "__main__":
    sys.exit(main())
