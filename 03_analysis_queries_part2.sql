-- ============================================================
-- HR Employee Attrition Analytics — Analysis Queries (Part 2 of 2)
-- PostgreSQL syntax. All queries validated against the dataset.
-- ============================================================

-- Q10: Attrition rate by business travel frequency
SELECT business_travel,
       COUNT(*) AS total,
       ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate_pct
FROM employees
GROUP BY business_travel
ORDER BY attrition_rate_pct DESC;


-- Q11: Attrition rate by marital status
SELECT marital_status,
       COUNT(*) AS total,
       ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate_pct
FROM employees
GROUP BY marital_status
ORDER BY attrition_rate_pct DESC;


-- Q12: Attrition rate by commute distance band
SELECT
  CASE
    WHEN distance_from_home <= 5 THEN '0-5 km'
    WHEN distance_from_home <= 15 THEN '6-15 km'
    ELSE '16+ km'
  END AS distance_band,
  COUNT(*) AS total,
  ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate_pct
FROM employees
GROUP BY distance_band
ORDER BY attrition_rate_pct DESC;


-- Q13: Highest-risk combinations — overtime x job satisfaction (top 5 by attrition rate)
SELECT overtime, job_satisfaction_label,
       COUNT(*) AS total,
       ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate_pct
FROM employees
GROUP BY overtime, job_satisfaction_label
ORDER BY attrition_rate_pct DESC
LIMIT 5;


-- Q14: Gender distribution and attrition rate
SELECT gender,
       COUNT(*) AS total,
       ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate_pct
FROM employees
GROUP BY gender;


-- Q15: Average salary hike and performance rating by attrition status
SELECT attrition,
       ROUND(AVG(percent_salary_hike), 2) AS avg_hike,
       ROUND(AVG(performance_rating), 2) AS avg_performance
FROM employees
GROUP BY attrition;


-- Q16: Attrition rate by stock option level
SELECT stock_option_level,
       COUNT(*) AS total,
       ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate_pct
FROM employees
GROUP BY stock_option_level
ORDER BY stock_option_level;


-- Q17: Attrition rate by education field
SELECT education_field,
       COUNT(*) AS total,
       ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate_pct
FROM employees
GROUP BY education_field
ORDER BY attrition_rate_pct DESC;


-- Q18: Attrition rate by time since last promotion
SELECT
  CASE
    WHEN years_since_last_promotion = 0 THEN '0 yrs (just promoted)'
    WHEN years_since_last_promotion <= 2 THEN '1-2 yrs'
    ELSE '3+ yrs'
  END AS promo_gap,
  COUNT(*) AS total,
  ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate_pct
FROM employees
GROUP BY promo_gap
ORDER BY attrition_rate_pct DESC;
