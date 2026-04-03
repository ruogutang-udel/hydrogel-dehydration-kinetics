# Hydrogel Dehydration Kinetics

## Objective
This project provides an R-based workflow for analyzing dehydration kinetics of hydrogel and biochar–hydrogel composite systems.

The goal is to:
- Quantify dehydration behavior
- Extract kinetic parameters
- Compare performance across formulations

---

## Data Structure
The input dataset should include:
- Time (h)
- Water retention (%)
- Standard deviation (optional)

Example columns:
- Placing time
- Biochar/hydrogel 90:10
- Biochar/hydrogel 80:20
- Biochar/hydrogel 70:30
- Pure hydrogel

---

## Methodology

### 1. Visualization
Raw dehydration curves are plotted for all samples.

### 2. Model
Dehydration kinetics are modeled using:

y(t) = y0 + (100 − y0) * exp(−k * t)

Where:
- y(t): water retention (%)
- y0: residual water content
- k: dehydration rate constant

### 3. Fitting
Nonlinear least squares (nls) is used to estimate parameters.

### 4. Output
- k (rate constant)
- y0 (residual water)
- Comparative plots

---

## Output Figures
- Dehydration curves
- Model fitting curves
- Bar plot of rate constants

---

## Script
Main script:
`kinetics_analysis_template.R`

---

## Notes
This workflow can be extended to:
- Weibull modeling
- Peleg model (rehydration)
- Confidence interval analysis
