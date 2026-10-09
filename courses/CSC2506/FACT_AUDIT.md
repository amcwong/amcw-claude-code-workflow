# Fact audit: CSC412/2506

**Last audited:** 2026-10-09
**Summary:** 97 confirmed / 23 corrected / 12 unverifiable (claim groups; some rows bundle related numbers)
**Internal consistency / Wikipedia links:** 10 inconsistencies (all resolved by corrections below); 2 failing links fixed (C6, C23); 51 of 64 links not individually fetched

Written only by `/course-notes audit`. Regenerated in full each run (current state, not accumulated history). The `fact-auditor` agent reports findings; the skill applies accepted corrections. Scope includes week chapters, optional `lectures/weekNN-practice.qmd` practice chapters (stems and collapsed solutions), glossary, and index.

Scope this run: `README.md`, `index.qmd`, `glossary.qmd`, `lectures/week01.qmd`–`week05.qmd`, `lectures/week01-practice.qmd`–`week03-practice.qmd`. Not in scope: `lectures/assignment01.qmd` (not a book chapter).

| ID | Claim | File | Verdict | Source | Before → after (if corrected) |
| --- | --- | --- | --- | --- | --- |
| C1 | d-separation is equivalent to conditional independence | week02 (Bayes Ball) | Corrected | Koller & Friedman (2009), Thms 3.3 and 3.5 | "if and only if" → d-separated implies CI in every distribution of the DAG; not d-separated implies dependence in almost every such distribution |
| C2 | Figure 2's savings come entirely from $x_6$ | week02 (practice question, Directed graphical models) | Corrected | recomputed: chain-rule costs 1,2,4,8,16,32 vs DAG 1,2,2,2,2,4 | "entirely from $x_6$" → every node from $x_3$ on saves; largest saving is $x_6$ (32 → 4) |
| C3 | $f$ is a chain node on $a\to e\leftarrow f\to b$ | week02 (Bayes Ball worked example) | Corrected | notes' own junction definitions | "chain node … actually a fork" → "fork node" |
| C4 | ALARM network needs 504 parameters vs $2^{37}-1$ | week02 (DGMs in the wild) | Corrected | bnlearn repository (37 nodes, 46 arcs, 509 parameters; 2–4 states) | 504 → 509 (tutorial's 504 noted); comparison → "far more than $2^{37}-1$" |
| C5 | A joint over $N$ variables needs $2^N-1$ parameters | week02 (Overview, Summary) | Corrected | same file, Free parameters section | inserted "binary" |
| C6 | autoresponder link | week02-practice (Problem 1) | Corrected | Wikipedia | `Automated_information_system` → `Autoresponder` |
| C7 | the two decision rules agree exactly for the symmetric 0/1 loss | week02-practice (Problem 1) | Corrected | argmin invariant to positive scaling | "exactly when … symmetric 0/1" → "whenever zero diagonal and equal off-diagonal costs" |
| C8 | Figure 2 draws $x_5\to x_6$ | week02 (Figure 2 SVG) | Corrected | caption, parameter count, Bayes-ball example | arrow started at $x_3$ → now starts at $x_5$ |
| C9 | first step of the chain proof is "Factorized ⇒ independent" | week03 (Hammersley-Clifford) | Corrected | the argument assumes $X\perp Z\mid Y$ | label → "Independent ⇒ factorized" |
| C10 | cancellation is the same as Week 2's regression decomposition | week03 (Hammersley-Clifford) | Corrected | week02: term C vanishes by an integral equal to zero | cross-ref → Week 2 causal-chain check (@sec-cistructures) |
| C11 | $\{3,5\}$ separates node 1 from node 4 | week03 (worked example practice question) | Corrected | path 1–2–4 stays open | $\{3,5\}$ → $\{2,5,6\}$ |
| C12 | the 4-cycle is $A-D-B-C-A$ with two maximal cliques | week03 (MRFs vs DAGs) | Corrected | the listed edges; a 4-cycle has four maximal cliques | → $A-D-C-B-A$; "two maximal cliques" → "two non-adjacent pairs" |
| C13 | non-minimal families fail $\nabla A=\mathbb{E}[\phi]$; $Z=1$ by construction | week03 (MRFs as exponential families); week03-practice (Tutorial question 3) | Corrected | Wainwright & Jordan (2008), Prop. 3.1 | identity holds for $A=\log Z$; non-minimality costs identifiability; $Z=1$ only under the tutorial's normalized-potential convention |
| C14 | $A(\bar\theta)=\log\psi_{1,2}(0,0)\psi_{2,3}(0,0)$ | week03 (MRFs as exponential families) | Corrected | recomputed | → $\log Z-\log(\psi_{1,2}(0,0)\psi_{2,3}(0,0))$, i.e. $-\log(\cdot)$ when $Z=1$ |
| C15 | elimination order "2,3,4,5" | week03 (Variable elimination with evidence) | Corrected | the nested sums eliminate $x_5$ first | → order $5,4,3,2$ |
| C16 | RBM conditional is "the origin" of the sigmoid activation | week03 (Restricted Boltzmann machines) | Corrected | Wikipedia, Logistic function | → "a probabilistic reading of the sigmoid activation" |
| C17 | Figure 3 has edge 5–7 | week03 (Figure 3 SVG) | Corrected | caption lists 13 edges; clique {4,5,6,7} | added the missing 5–7 edge |
| C18 | Figure 8 has $G\to H$ | week03 (Figure 8 SVG) | Corrected | factorization $p(H\mid J,G)$ | arrow ended near $J$ → now ends at $H$ |
| C19 | $\psi_{3,4}(x_3,x4)$ | week03 (MRFs, 4-cycle) | Corrected | typo | → $\psi_{3,4}(x_3,x_4)$ |
| C20 | "$\{4,5,6,7\}$ separates $\{1,2\}$ from nothing directly"; "node 5 is the only path…" | week03 (worked example) | Corrected | meaningless clauses | deleted; the valid separation statements kept |
| C21 | the Gaussian log-likelihood has a unique maximizer | week03 (Gaussian graphical models) | Corrected | unbounded above when $S_n$ is singular | → at most one, exactly one when $S_n$ is invertible |
| C22 | TrueSkill uses $\sigma(z_i-z_j)$ | week04 (TrueSkill); glossary | Corrected | Wikipedia, TrueSkill (Herbrich, Minka & Graepel 2006: probit) | labelled as the course's logistic simplification of TrueSkill |
| C23 | stationary distribution link | week05 (The stationary distribution) | Corrected | Wikipedia | disambiguation page → `Discrete-time_Markov_chain#Stationary_distributions` |
| U1 | 13 weeks, week 8 is reading week | index | Unverifiable | course site does not state it | |
| U2 | "carrying measure" for $h(x)$ | week01; glossary | Unverifiable | Wikipedia uses "base measure" | |
| U3 | lecture's 1000/1 cancer loss matrix | week02 | Unverifiable | PRML §1.5 not readable | |
| U4 | slide-number citations | week01-practice; week03; week04; week05 | Unverifiable | slides not in audit scope | |
| U5 | 10–20 loopy-BP iterations; 128×128 Mona Lisa | week04 | Unverifiable | tutorial not in audit scope ($n=16384$ correct) | |
| U6 | MH tutorial numbers (39%, 0.403, burn-in 200/5000, corr ≈ 0.9, 25–40%) | week05 | Unverifiable | tutorial not in audit scope | |
| U7 | HMC tutorial numbers ($H$ 4.12 → 4.17, $\epsilon$, $L$, 300 iterations) | week05 | Unverifiable | tutorial not in audit scope ($e^{-0.05}\approx0.95$ correct) | |
| U8 | MLPP section numbers §17.2.3, 24.3.2 | week05 | Unverifiable | theorem content confirmed elsewhere | |
| U9 | BDA figure details (ρ = 0.8, four chains, 10/500 iterations) | week05 | Unverifiable | | |
| U10 | $\hat n_{\text{eff}}>10$ per chain rule | week05 | Unverifiable | | |
| U11 | assignment contents and question numbers | week03; week04; week05 | Unverifiable | assignments not in audit scope | |
| U12 | course roadmap ("Gaussian mixtures later", "Next week") | week04; chapter endings | Unverifiable | | |
| F1–F11 | Week 1 chapter: diagnostic test, MLEs, exponential families, Multinomial and Gaussian | week01 | Confirmed | recomputed; standard references | |
| F12–F21 | Week 1 practice: every numeric answer, including the new Bayes and marginalization problems and tutorial questions | week01-practice | Confirmed | recomputed | |
| F22–F38 | Week 2 chapter and practice: decision rules, regression decomposition, parameter counts, three structures, Bayes-ball verdicts, Naive Bayes, HMM, noisy-OR, new conditional independence problems | week02; week02-practice | Confirmed | recomputed | |
| F39–F60 | Week 3 chapter and practice: grid Markov blanket, factorization example ($Z=18$, 2/3), Hammersley-Clifford, Ising, GGM, variable elimination, RBM, new marginalization problems | week03; week03-practice | Confirmed | recomputed; Wikipedia; CS228 notes | |
| F61–F76 | Week 4: logistic function, messages and beliefs, loopy BP, denoising $\beta$, Monte Carlo, importance and rejection sampling | week04 | Confirmed | recomputed; Wikipedia | |
| F77–F96 | Week 5: Markov chains, $A^2$, bigram MLE, stationary distribution, detailed balance, MH, Gibbs, HMC, $\hat R$, ESS | week05 | Confirmed | recomputed; Stan reference manual; Efron–Morris data | |
| F97 | course identity (CSC 412/2506, UofT, Fall 2026, Ohad Shamir) | index | Confirmed | course site | |

## Consistency

- week02 Figure 2 drew $x_3\to x_6$; caption and text use $x_5\to x_6$. Resolved by C8.
- week03 Figure 3 omitted edge 5–7 that the caption and clique {4,5,6,7} require. Resolved by C17.
- week03 Figure 8's $G\to H$ arrow ended beside $J$. Resolved by C18.
- week03 called the 4-cycle's cliques "two"; elsewhere four. Resolved by C12.
- week03 stated $\nabla\log Z=\mathbb{E}[\phi]$ for the indicator construction, then said it fails for the same construction. Resolved by C13.
- week03 $A(\bar\theta)$ sign disagreed with week03-practice. Resolved by C14; the practice note now refers only to the tutorial.
- week03 said order "2,3,4,5"; week03-practice said $x_5,x_4,x_3,x_2$. Resolved by C15.
- week02 stated d-separation as "iff", against its own faithfulness caveat. Resolved by C1.
- week02-practice cites Bayes Ball "rule (a)/(b)" and "tail-to-tail/head-to-head" (the tutorial's wording) while week02 uses unlabelled bullets with fork/collider. Left as is: it quotes the tutorial's rules, and each use names the junction type.
- week03 claimed a unique maximizer without the invertibility condition the practice page states. Resolved by C21.
