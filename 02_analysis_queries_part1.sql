-- ============================================================
-- HR Employee Attrition Analytics — Analysis Queries (Part 1 of 2)
-- PostgreSQL syntax. All queries validated against the dataset.
-- ============================================================

-- Q1: Overall attrition rate
SELECT COUNT(*) AS total_employees,
       SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
       ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate_pct
FROM employees;


-- Q2: Attrition rate by department
SELECT department,
       COUNT(*) AS total,
       SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS left_count,
       ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate_pct
FROM employees
GROUP BY department
ORDER BY attrition_rate_pct DESC;


-- Q3: Attrition rate by job role
SELECT job_role,
       COUNT(*) AS total,
       ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate_pct
FROM employees
GROUP BY job_role
ORDER BY attrition_rate_pct DESC;


-- Q4: Attrition rate by overtime status (the single strongest driver)
SELECT overtime,
       COUNT(*) AS total,
       ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate_pct
FROM employees
GROUP BY overtime
ORDER BY attrition_rate_pct DESC;


-- Q5: Average income, age, and tenure split by attrition status
SELECT attrition,
       ROUND(AVG(monthly_income), 2) AS avg_income,
       ROUND(AVG(age), 1) AS avg_age,
       ROUND(AVG(years_at_company), 1) AS avg_tenure
FROM employees
GROUP BY attrition;


-- Q6: Attrition rate by job satisfaction level
SELECT job_satisfaction_label,
       COUNT(*) AS total,
       ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate_pct
FROM employees
GROUP BY job_satisfaction_label
ORDER BY attrition_rate_pct DESC;


-- Q7: Attrition rate by work-life balance rating
SELECT work_life_balance_label,
       COUNT(*) AS total,
       ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate_pct
FROM employees
GROUP BY work_life_balance_label
ORDER BY attrition_rate_pct DESC;


-- Q8: Attrition rate by tenure band (identifies the highest-risk tenure window)
SELECT tenure_band,
       COUNT(*) AS total,
       ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate_pct
FROM employees
GROUP BY tenure_band
ORDER BY attrition_rate_pct DESC;


-- Q9: Attrition rate by income band
SELECT income_band,
       COUNT(*) AS total,
       ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate_pct
FROM employees
GROUP BY income_band
ORDER BY attrition_rate_pct DESC;
