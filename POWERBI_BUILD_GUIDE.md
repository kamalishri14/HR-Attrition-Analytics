# Power BI Dashboard — Build Guide (HR Attrition)

This folder contains the cleaned dataset ready to import into Power BI Desktop:

| File | Role | Rows |
|------|------|------|
| `fact_employees.csv` | Main employee table (one row per employee) | 1,470 |

Unlike the retail project, this dataset is naturally a single flat table — each row is one
employee with all their attributes. There's no separate fact/dimension split needed; this
itself is worth mentioning in an interview as a deliberate modeling decision, not an oversight.

---

## Step 1 — Import Data

1. Open **Power BI Desktop** → `Get Data` → `Text/CSV`
2. Import `fact_employees.csv`
3. In **Power Query Editor**, confirm data types:
   - `EmployeeNumber` → Whole Number
   - `MonthlyIncome`, `DailyRate`, `HourlyRate`, `MonthlyRate` → Whole Number
   - `Attrition`, `OverTime`, `Department`, `JobRole`, etc. → Text
4. Click **Close & Apply**

## Step 2 — Create DAX Measures

Go to **New Measure** on `fact_employees` and add each of these:

```dax
Total Employees = COUNTROWS(fact_employees)

Attrition Count = CALCULATE(COUNTROWS(fact_employees), fact_employees[Attrition] = "Yes")

Attrition Rate = DIVIDE([Attrition Count], [Total Employees])

Avg Monthly Income = AVERAGE(fact_employees[MonthlyIncome])

Avg Tenure (Years) = AVERAGE(fact_employees[YearsAtCompany])

OverTime Attrition Rate =
CALCULATE(
    DIVIDE(
        CALCULATE(COUNTROWS(fact_employees), fact_employees[Attrition]="Yes"),
        COUNTROWS(fact_employees)
    ),
    fact_employees[OverTime] = "Yes"
)

Avg Job Satisfaction = AVERAGE(fact_employees[JobSatisfaction])

High Risk Employees =
CALCULATE(
    COUNTROWS(fact_employees),
    fact_employees[OverTime] = "Yes",
    fact_employees[JobSatisfaction] <= 2
)
```

## Step 3 — Build the Report Pages

### Page 1: Executive Overview
- **KPI Cards**: `Total Employees`, `Attrition Count`, `Attrition Rate`, `Avg Monthly Income`, `Avg Tenure (Years)`
- **Donut chart**: Attrition breakdown (Yes/No)
- **Bar chart**: Attrition Rate by Department
- **Slicers**: Department, Gender, Job Role

### Page 2: Attrition Drivers
- **Bar chart**: Attrition Rate by OverTime (the strongest single driver)
- **Bar chart**: Attrition Rate by Job Satisfaction Label
- **Bar chart**: Attrition Rate by Work-Life Balance Label
- **Bar chart**: Attrition Rate by Tenure Band

### Page 3: Compensation & Tenure
- **Box plot or column chart**: Monthly Income by Attrition status
- **Bar chart**: Attrition Rate by Income Band
- **Scatter chart**: YearsAtCompany vs MonthlyIncome, colored by Attrition
- **Bar chart**: Attrition Rate by Years Since Last Promotion (grouped)

### Page 4: Demographics & Travel
- **Bar chart**: Attrition Rate by Business Travel
- **Bar chart**: Attrition Rate by Marital Status
- **Bar chart**: Attrition Rate by Distance From Home (banded)
- **Table**: Department × Job Role attrition matrix

## Step 4 — Formatting Tips

- Use a consistent theme (e.g. deep purple/teal — distinct from the retail project's navy)
- Highlight the OverTime chart with conditional color (red for high-risk, green for low)
- Add a **High Risk Employees** card prominently on Page 2 — this is the actionable number
  HR leadership cares about most
- Export each page as an image for your GitHub README

## Step 5 — Publish (optional)

If you have a free Power BI account: **Home → Publish** → select a workspace → get a
shareable link to add to your resume/LinkedIn.

---

**Once built, save the file as `HR_Attrition_Dashboard.pbix` in this folder and add
screenshots to `images/`.**
