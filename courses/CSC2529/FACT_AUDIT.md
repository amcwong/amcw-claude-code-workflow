# Fact audit: CSC2529

**Last audited:** 2026-09-17
**Summary:** 108 claims audited — 95 confirmed / 7 corrected / 6 unverifiable
**Internal consistency / Wikipedia links:** listed below

Written only by `/course-notes audit`. Regenerated in full each run (current state, not accumulated history). The `fact-auditor` agent reports findings; the skill applies accepted corrections. All 7 corrections below have been applied to the source files. Confirmed claims (95) are not listed individually; every numeric worked example in the chapter (dpi/visual-angle chain, CSF frequency conversions, FFT worked examples, diffraction-limit example) was independently recomputed and matched.

| ID | Claim | File | Verdict | Source | Before → after (if corrected) |
| --- | --- | --- | --- | --- | --- |
| C1 | Monocular field of view ~190° | `lectures/week01.qmd` §1.7, §1.17 | Corrected | [Visual field](https://en.wikipedia.org/wiki/Visual_field), [Field of view](https://en.wikipedia.org/wiki/Field_of_view) | "Monocular (one eye) spans roughly 190°" → clarified as the two-eye horizontal total; one eye alone is ~160° (~100° temporal + ~60° nasal) |
| C2 | Etymology of "stereoscopic" | `lectures/week01.qmd` §1.15 | Corrected | [Stereoscopy](https://en.wikipedia.org/wiki/Stereoscopy) | "*stereo* ('two' or 'solid')... literally, two-eyed viewing" → *stereos* means "firm, solid"; literally "solid viewing" |
| C3 | Blur-sum minimization "gives exactly" $d=2\sqrt{f\lambda}$ | `lectures/week01.qmd` §3.2 | Corrected | [Pinhole camera](https://en.wikipedia.org/wiki/Pinhole_camera) (Rayleigh 1891 vs. Petzval 1857) | Minimization as described yields only $d \propto \sqrt{f\lambda}$; the constant 2 is Rayleigh's (wave optics), not derivable from the sketched argument alone (which gives Petzval's $\sqrt{2f\lambda}$) |
| C4 | Michelson contrast normalization | `lectures/week01.qmd` §1.11 | Corrected | [Contrast (vision)](https://en.wikipedia.org/wiki/Contrast_(vision)) | "normalized by the average of $I_{\max}$ and $I_{\min}$" contradicted the formula's sum-denominator → corrected to "normalized by the sum" |
| C5 | Why colour is a 3-number space | `lectures/week01.qmd` §1.4 | Corrected | [CIE 1931 color space](https://en.wikipedia.org/wiki/CIE_1931_color_space) | "M/L overlap is the main reason" → trichromacy (three cone classes) is the reason; M/L overlap explains red/green correlation only |
| C6 | Glossary CSF definition (threshold vs. sensitivity) | `glossary.qmd` | Corrected | [Contrast (vision)](https://en.wikipedia.org/wiki/Contrast_(vision)) | "How the minimum detectable contrast varies..." → "Contrast sensitivity, the reciprocal of the minimum detectable contrast, plotted..." (matches week01 §1.12, which already had this right) |
| C7 | Broken Wikipedia anchor | `lectures/week01.qmd` §1.4 | Corrected | [CIE 1931 color space](https://en.wikipedia.org/wiki/CIE_1931_color_space) | `#Definition_of_the_CIE_XYZ_color_space` (no such section) → `#CIE_XYZ_color_space` |
| U1 | 0.5 arcmin foveal cone spacing attributed to Roorda & Williams (1999) | `lectures/week01.qmd` §1.3 | Unverifiable | paper exists and is correctly cited generally; full text paywalled | Number itself independently confirmed (25-31 arcsec in modern AO literature); exact attribution to this paper's own reported figure not confirmed |
| U2 | "Held et al. 2006 SIGGRAPH" illusion demonstrations | `lectures/week01.qmd` §1.14 | Unverifiable | no matching 2006 paper found; closest match is Held, Cooper, O'Brien & Banks, SIGGRAPH 2010 | Needs a check against the actual lecture slide deck |
| U3 | "~6.5 f-stops instantaneous" dynamic range figure | `lectures/week01.qmd` §1.17 | Unverifiable | no independent source found for this exact figure | Chapter already flags the tension with §1.10's ~5-orders figure rather than hiding it |
| U4 | Toronto grain silo camera-obscura anecdote | `lectures/week01.qmd` §2.2 | Unverifiable | slide-sourced anecdote, no independent source found | — |
| U5 | "Sharper detail at 3mm than 0.1mm or 5mm" pinhole comparison | `lectures/week01.qmd` §2.2 | Unverifiable | slide-sourced empirical result from a specific box geometry | Reported as what the slides show, not endorsed as general |
| U6 | Homework 1 structure (tasks, pinhole sizes, quoted starter-code advice) | `lectures/week01.qmd` §2.1, §2.2, §2.4 | Unverifiable | course-internal; source files present but outside the four audited files | Follow-up pass against `sources/week1/homework1/` would settle it |

## Consistency

- The chapter's own numeric chain (§1.3 cone spacing → §1.8 acuity → §1.12 CSF cutoff) is internally consistent and physically correct.
- Fixed: glossary's CSF entry (threshold-based) disagreed with week01 §1.12 (sensitivity-based, correct) — see C6.
- Fixed: week01 §1.11's Michelson-contrast prose disagreed with the formula printed directly above it — see C4.
- Wikipedia links: 64 distinct links checked, 63 resolved correctly; 1 broken anchor found and fixed (C7).
- Non-claim structural finding (fixed, not a factual correction): `README.md` was still the unfilled `/course-notes init` template despite the rest of the book being written for CSC2529; updated to match `COURSE.md`/`index.qmd`.
