# CSC413/2516 Neural Networks and Deep Learning: Course Notes

## Purpose

Running course notes for CSC413/2516 (Neural Networks and Deep Learning, University of Toronto, Fall 2026, instructor Colin Raffel): one Quarto chapter per lecture week plus a cumulative glossary. The goal is to help the user learn the field from scratch over the term, not to solve homework.

## Who these notes are for

The user is a complete beginner to deep learning. Assume general math and programming literacy (multivariable calculus, linear algebra, basic probability and statistics, Python), but define every deep-learning-specific term from scratch.

## Source material

- Course site: https://r-three.github.io/deep-learning-lecture-notes/
- Syllabus and schedule: https://github.com/craffel/csc413-2516-deep-learning-fall-2026
- Lecture slides and readings live in `sources/weekN/` (gitignored binaries).
- Week 3 slides are handwritten scans (no text layer); the transcript file holds only chat logistics.

## Book

- **Project:** `_quarto.yml` (Quarto book). Preview with `quarto preview` from this directory, or open `_site/index.html` after `quarto render`.
- **Title:** "Neural Networks and Deep Learning"
- **Expected week count:** 12 lecture weeks (fall reading week, Oct 28, has no lecture). Topics by week: 1 regression; 2 MLPs and backprop; 3 under/overfitting, regularization, numerical stability, autodiff; 4 gradient descent and adaptive methods; 5 CNNs, normalization, residual connections; 6 RNNs and seq2seq; 7 attention; 8 Transformers 1; 9 Transformers 2 and LLMs; 10 LoRA, GNNs, MoEs; 11 transposed convolution, UNet, autoencoders, VAEs; 12 engineering, fairness, accountability, transparency.
- **Chapters:** `lectures/weekNN.qmd` (source of truth). Do not keep a parallel week markdown file.
- **Published URL:** `https://amcwong.github.io/claude-code-my-workflow/courses/CSC2516/` (after `/deploy-course-notes` + push + GitHub Pages enabled)

## Design system (book page)

Reuse this exactly every week; never redesign per week.

- Fonts: Source Serif 4 for body and headings, Source Code Pro for code, system-ui for sidebar and tables
- Colours: navy `#002A5C` (headings, links, table headers, definition borders) on a white reading column and light-grey `#f0f0f0` left sidebar; hover `#1E3A6E`; gold `#E8B400` used sparingly. Surfaces stay light (do not auto-apply `custom-dark.css`).

## Recurring corrections

<!-- Fold repeat feedback here so later weeks inherit it. Generic lessons go to MEMORY.md via `/learn` as `[LEARN:course-notes]`. -->
