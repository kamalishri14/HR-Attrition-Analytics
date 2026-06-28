# Power BI Dashboard — Analysis & Findings (HR Attrition)

This document summarizes the insights from each page of the HR Attrition Power BI dashboard
(see `POWERBI_BUILD_GUIDE.md` for how to build it). All figures below were verified directly
against `fact_employees.csv` — they will match what you see in Power BI once built, and they
also match the SQL queries in `sql/`, the Excel `KPI_Summary`/`Pivot_Summary` sheets, and the
Python EDA in `notebooks/`.

**Dataset:** 1,470 employees · IBM HR Analytics schema (synthetic data, same structure as the
well-known public dataset)

---

## Page 1 — Executive Overview

| Metric | Value |
|---|---|
| Total Employees | 1,470 |
| Attrition Count | 385 |
| Attrition Rate | 26.19% |
| Avg Monthly Income | ₹8,761.67 |
| Avg Tenure | 6.07 years |

**Attrition rate by department:**

| Department | Employees | Attrition Rate |
|---|---|---|
| Sales | 462 | 26.84% |
| Research & Development | 949 | 26.24% |
| Human Resources | 59 | 20.34% |

**Key insight:** Attrition is fairly uniform across departments (~20–27%) — this is **not** a
department-specific problem. Whatever is driving attrition is broadly distributed across the
organization, which means HR should focus on individual risk factors (covered on Page 2)
rather than singling out one team.

---

## Page 2 — Attrition Drivers

This is the page that does the real diagnostic work — it isolates which factors actually
separate people who leave from people who stay.

**By OverTime status (the single strongest driver):**

| OverTime | Attrition Rate |
|---|---|
| Yes | **37.60%** |
| No | 22.06% |

Employees working overtime leave at **nearly 1.7x the rate** of those who don't.

**By Job Satisfaction:**

| Satisfaction | Attrition Rate |
|---|---|
| Low | 36.10% |
| Medium | 31.08% |
| High | 22.02% |
| Very High | 22.13% |

**By Work-Life Balance:**

| Rating | Attrition Rate |
|---|---|
| Bad | 32.22% |
| Good | 31.97% |
| Better | 23.42% |
| Best | 26.09% |

**By Tenure Band:**

| Tenure | Attrition Rate |
|---|---|
| 0-1 yrs | **38.28%** |
| 2-3 yrs | 23.33% |
| 4-6 yrs | 25.33% |
| 7-10 yrs | 26.19% |
| 10+ yrs | 19.39% |

**Key insight — the "High Risk" segment:** Employees who **both** work overtime **and** report
low/medium job satisfaction make up **133 employees (9.0% of the workforce)**. This is the
single most actionable number on the dashboard — a small, identifiable group worth a targeted
retention conversation rather than a company-wide policy change.

**Key insight — early tenure risk:** Attrition peaks in the first year (38.3%) and is lowest
among 10+ year veterans (19.4%) — a classic early-career flight-risk curve. Onboarding quality
and first-year manager check-ins are likely the highest-leverage intervention point.

---

## Page 3 — Compensation & Tenure

**Attrition rate by income band:**

| Income Band | Attrition Rate |
|---|---|
| Below 3K | **36.96%** |
| 6K-10K | 27.26% |
| 15K+ | 25.58% |
| 3K-6K | 25.28% |
| 10K-15K | 24.32% |

**Average income by attrition status:**

| Status | Mean Income | Median Income |
|---|---|---|
| Stayed (No) | ₹8,809.92 | ₹8,671 |
| Left (Yes) | ₹8,625.67 | ₹8,616 |

The gap in average income between stayers and leavers is small (~2%) — income alone is a weak
predictor *except at the bottom band* (Below 3K shows a clearly elevated 37% attrition rate).
This nuance matters: a blanket salary increase is a blunt instrument, but a floor-level
adjustment for the lowest income band is a targeted, defensible intervention.

**Attrition rate by time since last promotion:**

| Promotion Gap | Attrition Rate |
|---|---|
| 0 yrs (just promoted) | 30.59% |
| 3+ yrs | 28.37% |
| 1-2 yrs | 23.15% |

Interestingly, employees who were *just* promoted (0 years since last promotion) still show
elevated attrition — likely overlapping with the early-tenure effect (new promotions often
coincide with new role transitions, which carry their own risk). The 1-2 year window after a
promotion is the most stable period.

---

## Page 4 — Demographics & Travel

**Attrition rate by business travel frequency:**

| Travel Frequency | Attrition Rate |
|---|---|
| Travel_Frequently | **32.67%** |
| Travel_Rarely | 24.75% |
| Non-Travel | 23.03% |

**Attrition rate by marital status:**

| Status | Attrition Rate |
|---|---|
| Single | 29.61% |
| Married | 25.56% |
| Divorced | 22.08% |

**Attrition rate by commute distance:**

| Distance | Attrition Rate |
|---|---|
| 16+ km | **30.39%** |
| 0-5 km | 26.01% |
| 6-15 km | 24.81% |

**Department × Job Role — top 5 highest-attrition combinations:**

| Department | Job Role | Employees | Attrition Rate |
|---|---|---|---|
| Research & Development | Laboratory Technician | 159 | 28.93% |
| Sales | Manager | 156 | 28.21% |
| Research & Development | Healthcare Representative | 153 | 28.10% |
| Research & Development | Manufacturing Director | 165 | 27.88% |
| Sales | Sales Executive | 149 | 26.85% |

**Key insight:** Frequent business travel and long commutes both show meaningfully elevated
attrition — both point toward flexible-work and remote/hybrid policy levers as cost-effective
retention tools, since they don't require salary changes.

---

## How These Numbers Were Verified

Every figure in this document was computed directly from `fact_employees.csv` — the same data
your Power BI `.pbix` will use. These numbers also cross-check against:
- The SQL queries in `sql/02_analysis_queries_part1.sql` and `03_analysis_queries_part2.sql`
- The Python EDA in `notebooks/hr_attrition_eda.ipynb`
- The Excel `KPI_Summary` and `Pivot_Summary` sheets

All four tools (Excel, SQL, Python, Power BI) agree on the same underlying numbers.

---

## Suggested Talking Points for Interviews

- *"What's the single most actionable insight from this dashboard?"* → The "High Risk"
  segment — employees working overtime with low/medium job satisfaction — is only 9% of the
  workforce but represents the highest-leverage group for a targeted retention conversation,
  rather than a costly company-wide policy change.
- *"What would you recommend to leadership first?"* → Focus on first-year onboarding (38.3%
  attrition in year one) and overtime workload management (37.6% vs 22.1%) — these two levers
  alone touch the two strongest drivers in the data.
- *"Why is department-level attrition so similar across teams?"* → Be ready to explain that
  uniform department rates mean the cause isn't team-specific — it's about individual working
  conditions (overtime, satisfaction, tenure) that exist within every department, not a
  Sales-only or R&D-only issue.
- *"How would this differ with real company data?"* → Be transparent that the attrition
  *patterns* here were deliberately engineered into a synthetic dataset to mirror well-known,
  realistic HR drivers — the analysis methodology (SQL grouping, RFM-style segmentation, DAX
  measures) is what transfers directly to a real dataset, even if the exact percentages would
  differ.
