# 🧑‍💼 HR Employee Attrition Analytics Platform

End-to-end data analytics project identifying the key drivers of employee attrition — from
raw, messy HR data to a cleaned dataset, SQL-driven insights, Python EDA, and an interactive
live dashboard.

**🔗 Live Dashboard:** [https://hr-attrition-analytics-xuyuzhpjphflep5mv6fw82.streamlit.app/]
**📁 Dataset:** 1,470 employees · same schema as the well-known IBM HR Analytics dataset

---

## 🛠️ Tech Stack

| Layer | Tools |
|---|---|
| Data Cleaning | Excel (formulas, PivotTables), Python/Pandas |
| Database | PostgreSQL |
| Analysis | Python (Pandas, NumPy), SQL (CASE WHEN aggregations, grouping) |
| Visualization | Matplotlib, Seaborn, Power BI, Plotly |
| Dashboard | Streamlit (deployed live) |

---

## 📂 Project Structure

```
hr-attrition/
├── data/
│   ├── generate_data.py              # synthetic data generator
│   ├── clean_data.py                 # cleaning pipeline (raw -> clean)
│   ├── hr_attrition_raw.csv          # raw data (with intentional messiness)
│   ├── hr_attrition_clean.csv        # cleaned, analysis-ready dataset
│   └── hr_attrition_clean_for_sql.csv
├── excel/
│   └── HR_Attrition_Analysis.xlsx    # Raw data, cleaning log, KPIs, pivot-style summary + chart
├── sql/
│   ├── 01_schema.sql                  # PostgreSQL table schema
│   ├── 02_analysis_queries_part1.sql  # 9 business questions (Q1-Q9)
│   └── 03_analysis_queries_part2.sql  # 9 more business questions (Q10-Q18)
├── notebooks/
│   └── hr_attrition_eda.ipynb         # Full EDA notebook with 8 charts
├── powerbi/
│   ├── fact_employees.csv             # Cleaned dataset for Power BI
│   ├── POWERBI_BUILD_GUIDE.md         # Step-by-step build guide + DAX measures
│   └── DASHBOARD_ANALYSIS.md          # Verified findings from each dashboard page
├── dashboard/
│   ├── app.py                         # Streamlit dashboard (deployable)
│   ├── data/hr_attrition_clean.csv    # bundled copy for self-contained deployment
│   └── requirements.txt
└── images/                            # Generated charts from the EDA notebook
```

---

## 🔍 Project Overview

This project simulates a real HR analyst workflow at a mid-sized company:

1. **Excel** — Explored and cleaned raw employee data (removed duplicates, fixed
   inconsistent text formatting, imputed missing values, dropped constant columns), built a
   KPI summary using live formulas (`COUNTIFS`, `AVERAGEIF`) and a department-level
   attrition-rate breakdown with chart.
2. **SQL (PostgreSQL)** — Designed a single denormalized employee table (the natural shape
   for this data — a deliberate modeling choice, not a missed star schema) and wrote 18
   analysis queries covering department, role, overtime, satisfaction, tenure, income, travel,
   and combined risk-factor breakdowns.
3. **Python (Pandas/Seaborn)** — Performed exploratory data analysis, validated the cleaning
   logic, and visualized the strongest attrition drivers.
4. **Power BI** — Built an interactive multi-page dashboard with DAX measures for attrition
   rate, high-risk employee counts, and segment-level breakdowns.
5. **Streamlit** — Deployed a live, filterable web dashboard so anyone can explore the
   findings without opening any local tool.

---

## 📈 Key Insights

- **OverTime is the single strongest attrition driver** — employees working overtime leave at
  **37.6%** vs **22.1%** for those who don't (nearly 1.7x).
- **First-year employees are the highest flight risk** — **38.3%** attrition in year one,
  declining steadily to **19.4%** for 10+ year veterans.
- A small **"High Risk" segment** — employees working overtime **with** low/medium job
  satisfaction — is only **9% of the workforce** but represents the highest-leverage group for
  a targeted retention conversation.
- **Department-level attrition is fairly uniform** (~20–27%) — the cause is not team-specific;
  it's distributed across individual working conditions present in every department.
- **Frequent travelers (32.7%) and long commutes (30.4%)** both show elevated attrition,
  pointing toward flexible-work policy as a cost-effective retention lever.

*(See `notebooks/hr_attrition_eda.ipynb`, `sql/`, and `powerbi/DASHBOARD_ANALYSIS.md` for the
full analysis behind these findings.)*

---

---

## 🚀 How to Run This Project

### 1. Clone the repo
```bash
git clone https://github.com/<your-username>/hr-attrition-analytics.git
cd hr-attrition-analytics
```

### 2. Regenerate the dataset (optional — already included as CSVs)
```bash
pip install pandas numpy faker
python data/generate_data.py
python data/clean_data.py
```

### 3. Load into PostgreSQL
```bash
psql -U postgres -d hr_db -f sql/01_schema.sql
psql -U postgres -d hr_db -c "\copy employees FROM 'data/hr_attrition_clean_for_sql.csv' WITH (FORMAT csv, HEADER true)"
psql -U postgres -d hr_db -f sql/02_analysis_queries_part1.sql
```

### 4. Run the Jupyter notebook
```bash
pip install jupyter pandas matplotlib seaborn
jupyter notebook notebooks/hr_attrition_eda.ipynb
```

### 5. Run the Streamlit dashboard locally
```bash
cd dashboard
pip install -r requirements.txt
streamlit run app.py
```

### 6. Build the Power BI dashboard
Open `powerbi/POWERBI_BUILD_GUIDE.md` for the full step-by-step guide (import data → add DAX
measures → build report pages). For the verified business findings to present alongside the
dashboard, see `powerbi/DASHBOARD_ANALYSIS.md`.

---



---

## 👤 Author

Kamali — Full-Stack & Data Analytics Developer
*This project was built as part of interview preparation and portfolio development.*
