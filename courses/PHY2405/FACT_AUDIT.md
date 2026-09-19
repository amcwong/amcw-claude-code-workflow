# Fact audit: PHY2405

**Last audited:** 2026-09-19
**Summary:** 34 confirmed / 15 corrected / 9 unverifiable (58 claims)
**Internal consistency / Wikipedia links:** listed below

Written only by `/course-notes audit`. Regenerated in full each run (current state, not accumulated history). The `fact-auditor` agent reports findings; the skill applies accepted corrections. Files audited: `README.md`, `index.qmd`, `lectures/week01.qmd`, `lectures/week02.qmd`, `glossary.qmd`.

## Corrected

Each finding was opened against the source before it was applied. Thirteen were applied as reported, one was applied in part, and one was held back (C8).

| ID | Claim | File | Verdict | Source | Before → after |
| --- | --- | --- | --- | --- | --- |
| C1 | CDF detector mass | week01 | Corrected | Wikipedia "Collider Detector at Fermilab"; cdf.fnal.gov | "about 10 000 tons" → the handout's 10 000 tons kept, with "other sources give about 5000 tons" |
| C2 | Tevatron Run II bunch spacing | week02 | Corrected | arXiv hep-ex/0302016, hep-ex/0305027 | "second run used 132 ns" → lecture quotes 132 ns; the machine ran 36 bunches at 396 ns, 132 ns plan not carried out |
| C3 | Tevatron peak luminosity | week02 | Corrected | Wikipedia "Tevatron" | "a few ×10³¹" → lecture value matches Run I (near 2×10³¹); Run II reached about 4×10³² |
| C4 | LHC design luminosity | week02 | Corrected | LHC Machine, JINST 3 S08001 | "above 10³⁴" → nominal design is 10³⁴; the lecture update quotes higher, which Run 2 reached |
| C5 | LHC bunch intensity | week02 | Corrected | arXiv 1410.5990; JINST 3 S08001 | "1.2 to 1.5×10¹¹" → 1.1 to 1.3×10¹¹, nominal 1.15×10¹¹; the handwritten update's 1.5×10¹¹ is reported as the lecture's figure |
| C6 | Weak focusing and early machines | week02 | Corrected (partly) | Stony Brook accelerator notes, ch. 9 | "basis of early cyclotrons" → "cyclotrons and the weak-focusing synchrotrons and betatrons that followed". The Cyclotron link stays, since a falling field does give a cyclotron its weak focusing |
| C7 | SPS bunches in practice | week02 | Corrected | Schmidt, *The CERN SPS proton-antiproton collider*; arXiv 1410.3317 | "no more than four" → three bunches per beam, later six |
| C8 | Course title | index, README | Not applied | Outline PDF versus course page | Auditor reported the course page title as "Experimental Methods in Particle Physics". The instructor's outline PDF says "Experimental Methods in High Energy Physics" and the slides say "Experimental Methods in Particle Physics (a.k.a. eHEP)". The two sources disagree, so the title was left for the owner to decide |
| C9 | Meaning of $n_b f$ | week02 | Corrected | Internal; luminosity definition | "$n_b f$ is the rate each bunch meets its partner" → $f$ is the per-bunch rate and $n_b f$ the total crossing rate |
| C10 | Wikipedia link for emittance | week02 | Corrected | Wikipedia | `Emittance` (disambiguation page) → `Beam_emittance` |
| C11 | Wikipedia link for betatron function | week02 | Corrected | Wikipedia | `Betatron` (the machine) link removed from "betatron function" |
| C12 | Energy span in the Week 1 summary | week01 | Corrected | Internal | "eV to 100 GeV" → "eV to hundreds of GeV" |
| C13 | Charge missing from RF energy gain | week02 | Corrected | Internal; Edwards and Syphers ch. 2 | $E_s = V_0\sin\phi_s$ → $eV_0\sin\phi_s$, and the same for $\Delta E$ |
| C14 | Meaning of $\omega_0$ | week02 | Corrected | Internal | "base RF frequency" → revolution angular frequency, with $\omega_{\text{rf}} = h\omega_0$ |
| C15 | FODO | week02 | Corrected | Internal; glossary | "alternating F, D, F, D" → focusing, drift, defocusing, drift |

## Unverifiable

Left untouched.

| ID | Claim | File | Verdict | Source | Note |
| --- | --- | --- | --- | --- | --- |
| U1 | "Smash things together…" attributed to D. C. Bailey, circa 1990 | week01 | Unverifiable | None found | Already hedged as "attributed" |
| U2 | Effort split of 25% / 50% / 25% | week01 | Unverifiable | None found | The handout's own estimate |
| U3 | Tevatron tune near 19.4 | week02 | Unverifiable | Run II literature gives about 20.58 | Do not change without the handout or the 1983 design report |
| U4 | Iron quadrupoles at about 12 T/m for a "10 GeV" CESR | week02 | Unverifiable | CESR beam energy is about 5 to 6 GeV | "10 GeV" only holds as centre-of-mass energy; the gradient is not corroborated |
| U5 | Tevatron quadrupoles at about 75 T/m | week02 | Unverifiable | arXiv 1302.2587 gives about 70 T/m | Right neighbourhood, exact figure not corroborated |
| U6 | 0νββ line "about 3 MeV in this example" | week01 | Unverifiable | Q-values range from 2.0 to 4.3 MeV by isotope | The hedge "in this example" is doing the work |
| U7 | CDF cross-section labelled η = 0, 0.9, 2.4, 4.2 | week01 | Unverifiable | Run I documentation: plug to 2.4, forward to 4.2, central/plug boundary at 1.1 | The 0.9 label is read from a scan the auditor could not see |
| U8 | Synchrotron frequency up to about 1000 Hz; several hundred turns per oscillation | week02 | Unverifiable | LHC gives about 490 turns | Upper bound not sourced |
| U9 | $F\approx L$, $\ell\approx L/10$; fixed-target luminosity about 10³⁷ | week02 | Unverifiable | Order-of-magnitude check supports both | Rules of thumb with no quoted source |

## Confirmed

| ID | Claim | File | Verdict | Source |
| --- | --- | --- | --- | --- |
| K1 | $\rho = p/0.3B$ and $B\rho = p/0.3$ | week02 | Confirmed | Standard relation |
| K2 | Dipole worked example: 10 m radius, 0.1 rad bend | week02 | Confirmed | Arithmetic |
| K3 | Quadrupole field components and gradient | week02 | Confirmed | Wikipedia "Quadrupole magnet" |
| K4 | LHC main quadrupole gradient of 223 T/m | week02 | Confirmed | JINST 3 S08001; JACoW |
| K5 | Weak-focusing index range $0<n<1$ | week02 | Confirmed | Stony Brook notes |
| K6 | Strong focusing gives net focusing | week02 | Confirmed | Standard optics |
| K7 | Thin-lens focal length and $F\propto p$ | week02 | Confirmed | Derived |
| K8 | $K$ definition and the two equations of motion | week02 | Confirmed | Standard lattice theory |
| K9 | Drift, focusing and defocusing matrices | week02 | Confirmed | Standard |
| K10 | Product of the defocus, drift, focus matrices | week02 | Confirmed | Multiplied out |
| K11 | $L=f$ worked example | week02 | Confirmed | Arithmetic |
| K12 | Hill's equation and the amplitude-phase ansatz | week02 | Confirmed | Wikipedia "Hill differential equation" |
| K13 | Courant-Snyder parameters | week02 | Confirmed | Wikipedia "Beam emittance" |
| K14 | Courant-Snyder invariant and ellipse area | week02 | Confirmed | Wikipedia "Beam emittance" |
| K15 | $y=\sqrt{\epsilon\beta}\cos(\phi+\delta)$ and $\sigma=\sqrt{\epsilon\beta}$ | week02 | Confirmed | Standard |
| K16 | Beam-size worked example (5 mm and 10 mm) | week02 | Confirmed | Arithmetic |
| K17 | Tune definition and resonance condition | week02 | Confirmed | Standard |
| K18 | Tevatron revolution frequency about 50 kHz | week02 | Confirmed | Fermilab TM-1328 (47.7 kHz) |
| K19 | LHC 2015 tunes 64.28 / 59.31 and 64.31 / 59.32 | week02 | Confirmed | arXiv 1410.5990 |
| K20 | Closed-orbit distortion $\propto 1/(2\sin\pi\nu)$ | week02 | Confirmed | Standard |
| K21 | Rate $=\mathcal{L}\sigma$ and its units | week01, week02 | Confirmed | Wikipedia "Luminosity (scattering theory)" |
| K22 | Gaussian-bunch luminosity formulas | week02 | Confirmed | Algebra verified |
| K23 | $\beta(s)\approx\beta^*+s^2/\beta^*$ | week02 | Confirmed | Standard |
| K24 | Tevatron Run I: six bunches at 3.5 μs | week02 | Confirmed | arXiv 2210.13565, 1106.5182 |
| K25 | LHC about 2500 bunches, 25 ns, up to 2748 in 2015 | week02 | Confirmed | arXiv 1410.5990 |
| K26 | Beam-beam force and its two limits | week02 | Confirmed | Standard |
| K27 | Tune shift and beam-beam tune-shift formula | week02 | Confirmed | Standard |
| K28 | Beam-beam limits about 0.005 (hadrons) and 0.05 (leptons) | week02 | Confirmed | arXiv 1205.3087 |
| K29 | $\sqrt{s}$ for fixed target and collider, 43 GeV versus 2000 GeV | week02 | Confirmed | Arithmetic |
| K30 | Dry-air breakdown about 3 MV/m | week02 | Confirmed | Wikipedia "Electrical breakdown" |
| K31 | SPS $h=4620$, Main Ring $h=1113$ | week02 | Confirmed | arXiv 2210.00080 |
| K32 | Momentum, speed and path-length relations and arrival time | week02 | Confirmed | Re-derived |
| K33 | $\bar\Phi$, stability condition, phase jump, $n_{\text{sync}}$, energy integral | week02 | Confirmed | Edwards and Syphers ch. 2 |
| K34 | Edwards and Syphers reference exists | week02 | Confirmed | Wiley |
| K35 | Rutherford setup (radium alphas, gold foil, ZnS screen) | week01 | Confirmed | Rutherford scattering experiments |
| K36 | Tevatron Run I at 900 GeV per beam and the ratio of about 2×10⁵ | week01 | Confirmed | arXiv 2210.13565 |
| K37 | LEP points: L3 at 2, ALEPH at 4, OPAL at 6, DELPHI at 8 | week01 | Confirmed | CERN |
| K38 | DELPHI barrel layer order | week01 | Confirmed | DELPHI detector pages |
| K39 | Pseudorapidity definition and the three angles | week01 | Confirmed | Wikipedia "Pseudorapidity" |
| K40 | SuperCDMS at SNOLAB, about 2 km down | week01 | Confirmed | Wikipedia "SNOLAB" |
| K41 | Higgs at 125 GeV | week01 | Confirmed | Standard |
| K42 | Figure 3 marker positions on the log axis | week01 | Confirmed | Checked against the scale |
| K43 | CEvNS as scattering off a nucleus as a whole | week01 | Confirmed | Wikipedia |

The auditor's own count is 34 confirmed claims; the rows above split several combined claims, so the row count is higher.

## Wikipedia links

29 distinct links: 26 resolve and match. Two were wrong and are fixed (C10, C11). One soft mismatch is left: `Center-of-momentum_frame` is attached to "centre-of-mass energy" and describes the frame but not $\sqrt{s}$; the auditor suggested `Mandelstam_variables`. `Geiger–Marsden_experiment` redirects to "Rutherford scattering experiments" and is fine.

## Consistency

- week01 summary said eV to 100 GeV while the chapter marks 125 GeV and the figure axis runs to 1 TeV: resolved to "hundreds of GeV" (C12).
- week02 wrote the RF energy gain without $e$ in one place and with $e$ elsewhere: resolved to $eV_0$ throughout (C13).
- week02 called $\omega_0$ the base RF frequency while the equation above it defined the revolution frequency: resolved (C14).
- week02 described FODO without the drift, glossary had it right: resolved (C15).
- week02 reused $\epsilon$ for a closed-orbit amplitude and for the beam emittance: a sentence now separates them.
- `README.md` was the unfilled template: title and placeholder sentence filled in.
- Course title differs between the two sources (see C8): open.
