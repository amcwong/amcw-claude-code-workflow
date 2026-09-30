# Fact audit: CSC2516

**Last audited:** 2026-09-29
**Summary:** 116 confirmed / 12 corrected / 10 unverifiable
**Internal consistency / Wikipedia links:** 7 consistency conflicts (all resolved by corrections below); no broken Wikipedia links

Written only by `/course-notes audit`. Regenerated in full each run (current state, not accumulated history). The `fact-auditor` agent reports findings; the skill applies accepted corrections.

| ID | Claim | File | Verdict | Source | Before → after (if corrected) |
| --- | --- | --- | --- | --- | --- |
| C1 | When deep learning resurged | week01.qmd:178 | Corrected | Wikipedia: Deep learning | "early 2000s" → "late 2000s and early 2010s" |
| C2 | Age of core techniques | week01.qmd:306 | Corrected | Wikipedia: Gradient descent; Deep learning | "since the 1950s" → gradient descent from Cauchy (1847), perceptron from Rosenblatt (1958) |
| C3 | Cross-entropy double sum | week01.qmd:743 | Corrected | Wikipedia: Cross-entropy | $\log P(y^{(i)} \mid x^{(i)})$ → $\log P(y = j \mid x^{(i)})$ |
| C4 | Author name | week01.qmd:777 | Corrected | Wikipedia: Michael Nielsen | "Nielson" → "Nielsen" |
| C5 | Gradient Descent Explorer divergence | week01.qmd:469, 526 | Corrected | Derivation: iteration contracts iff $\lvert 1-\eta \rvert < 1$ | η max 1.95 → 2.5; "diverged" when final loss > 4 → when final loss > initial loss (plot now clipped) |
| C6 | ReLU derivative at 0 | week02.qmd:194, 285-288 | Corrected | Wikipedia: Rectified linear unit; PyTorch forums | "1 by convention" → any value in [0,1] is a subgradient; PyTorch uses 0, matching Week 3 |
| C7 | UAT domain and scope | week02.qmd:743, 1271; glossary.qmd:46 | Corrected | Wikipedia: Universal approximation theorem | "bounded" → "compact (closed and bounded)"; "fit any function" → "approximate any continuous function on a compact domain" |
| C8 | Bump approximation error | week02.qmd:988-990 | Corrected | Derivation; counterexample $f(x)=\sqrt{x}$ | $O(1/K)$ for any continuous $f$ → $O(1/K)$ when Lipschitz; uniform convergence via uniform continuity |
| C9 | Tower combining weights | week02.qmd:1141-1146 | Corrected | Derivation from Step 2 bump | weights $+1$ ×4, $b=-3.5$ (gives a quadrant) → weights $+1,-1,+1,-1$, $b=-1.5$ |
| C10 | Framework default initialization | week03.qmd:302 | Corrected | keras.io Dense; PyTorch issue #57109 | "default to Xavier or He" → Keras uses Glorot uniform; PyTorch uses $U(-1/\sqrt{n_\text{in}}, 1/\sqrt{n_\text{in}})$ |
| C11 | Convex loss minima | glossary.qmd:22 | Corrected | Wikipedia: Convex function | "has one minimum" → "every local minimum is a global minimum" |
| C12 | Sigmoid + cross-entropy gradient | glossary.qmd:53 | Corrected | Derivation; Wikipedia: Cross-entropy | $a^L - y$ → $h^L - y$ |
| U1 | 0-vs-1 middle-row pixel heuristic | week01.qmd:19-30 | Unverifiable | none found | |
| U2 | Convexity implies good generalization | week01.qmd:309 | Unverifiable | none found | |
| U3 | Small training errors cause large test errors | week01.qmd:312 | Unverifiable | none found | |
| U4 | Nielsen chapter 3 link is live | week01.qmd:777 | Unverifiable | fetch failed (TLS) | |
| U5 | Slides use $z^m$/$a^m$ notation | week03.qmd:20-25, 652 | Unverifiable | slides not available | |
| U6 | Other "the slides …" attributions | week03.qmd (several) | Unverifiable | slides not available; maths confirmed | |
| U7 | What Homework 3 assumes and asks | week03.qmd:302, 494 | Unverifiable | homework not checked | |
| U8 | Week 4 covers optimization | week03.qmd:662 | Unverifiable | schedule not checked | |
| U9 | Part 3 provenance (course-provided) | week03-practice.qmd:450-452 | Unverifiable | answers recomputed correct | |
| U10 | Part 4 from past Week 4 quiz | week03-practice.qmd:550 | Unverifiable | answers recomputed correct | |

The remaining 116 claims were confirmed. They include every worked example and every practice answer, each recomputed by hand.

## Consistency

- glossary said $a^L - y$, week03 said $h^L - y$, resolved to $h^L - y$ (C12).
- week02 set ReLU'(0) = 1, week03 and week03-practice used 0, resolved to 0 (C6).
- week01 said "early 2000s", week02 said "around 2010–2012", resolved to late 2000s / early 2010s (C1).
- week01 cross-entropy line 743 disagreed with line 752, resolved (C3).
- week02 Step 4 tower did not follow from the Step 2 bump, resolved (C9).
- UAT stated with varying precision, resolved to "compact domain" wording (C7).
- week01 widget could not show the divergence the prose describes, resolved (C5).

## Wikipedia links

- None broken. Redirects: Rectifier_(neural_networks) → Rectified linear unit; Tikhonov_regularization and Weight_decay both → Ridge regression (same sentence, week03.qmd:630).
- Imprecise target: Matrix_norm (week03.qmd:635) for "Frobenius norm"; `Matrix_norm#Frobenius_norm` would be more precise. Left unchanged.
