# Fact audit: ml-int

**Last audited:** 2026-11-04
**Summary:** 283 confirmed / 6 corrected / 3 unverifiable (292 claims)
**Internal consistency / Wikipedia links:** 55 of 55 Wikipedia links resolve to the intended concept. One stale cross-reference was fixed (listed below).

Written only by `/course-notes audit`. Regenerated in full each run (current state, not accumulated history). The `fact-auditor` agent reports findings; the skill applies accepted corrections.

**Scope this run.**
- *Files audited:* `README.md`, `lectures/mlsd-amd-practice.qmd`, `glossary.qmd`, `index.qmd`. This course has no `weekNN.qmd` chapters, so the practice chapter is the only content chapter. The README, glossary, and index are still unfilled templates.
- *Sources checked against:* the chapter attributes claims to the book *Machine Learning System Design Interview* (Aminian and Xu) and to the AMD Project 17, 18, and 19 briefs, so those were supplied as cited sources.

**What was checked.**

| Category | Claims | Confirmed |
| --- | --- | --- |
| Numeric worked answers (recomputed) | 54 | 52 |
| Attributions to the book | 138 | 133 (2 corrected, 3 unverifiable) |
| Project-brief claims | 17 | 17 |
| General ML claims | 28 | 27 |
| Wikipedia links | 55 | 55 |

| ID | Claim | File | Verdict | Source | Before → after |
| --- | --- | --- | --- | --- | --- |
| C1 | Observed-only MF loss is weak because "embeddings of all ones" also score 0 | `lectures/mlsd-amd-practice.qmd` Problem 29 | Corrected | Google ML, Matrix factorization; recomputed in the problem's 2-D setup | "embeddings of all ones would also score 0" → "embeddings whose dot products are all 1 (for example, every embedding equal to $(1, 0)$) would also score 0" |
| C2 | The negative pair's gradient is "correspondingly larger" (about 13 times) | Problem 42 | Corrected | Derivative of the sigmoid cross-entropy | → gradient magnitudes 0.818 against 0.119, about 7 times |
| C3 | "Three of [the book's four objectives] have loopholes" | Problem 28 | Corrected | Book ch. 6 (loopholes named only for clicks and completed videos) | → "names a loophole in two of them" |
| C4 | Normalizing `Montréal.cfg` gives `montreal cfg` | Problem 21 (stem walkthrough and Answer) | Corrected | Book ch. 4 ("remove punctuation") | → `montrealcfg`, with the bullet noting that deletion glues the name and extension together |
| C5 | The +0.75 interaction "contributes more than any single linear term" | Problem 36 | Corrected | The problem's own bias $w_0 = -1$ is larger in magnitude | → "more than any single feature's linear term (0.3, 0.2, and 0.2)" |
| C6 | nDCG@5 ≈ 0.665 with IDCG from the retrieved items only | Problem 14 | Corrected (caveat added) | Wikipedia, Discounted cumulative gain (IDCG sorts all relevant items in the collection) | Added a caveat: if the missed item's rating were 1, IDCG ≈ 5.193 and nDCG@5 ≈ 0.610. The Answer now says the IDCG is over retrieved items only |
| U1 | "Because user behaviour shifts quickly" as the book's reason for the 5-minute update delay | Problem 38 | Unverifiable | Book ch. 8 states the 5-minute fact only, with no reason | Left unchanged |
| U2 | "Because predicted probabilities feed into money decisions" as the book's reason for calibration | Problem 38 | Unverifiable | Book ch. 8 lists calibration as a talking point, with no reason | Left unchanged |
| U3 | "Error rate" in the book's operational-metrics list | Problem 11 | Unverifiable | Book ch. 1 lists serving time, throughput, prediction requests, and CPU/GPU utilization | Left unchanged |

## Consistency

- **Fixed:** Problem 1's table pointed to "the online metric (Problem 9)", but Problem 9 covers Project 17. It now points to Problem 27, the pre-check's online metrics.
- **Agrees:** the chapter-to-problem table matches the problem headers. Numbers reused across problems agree. All "(Problem N)" cross-references point to the right problem.
- **Nothing to cross-check:** the glossary has no entries.
