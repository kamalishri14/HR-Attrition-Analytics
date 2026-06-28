-- ============================================================
-- HR Employee Attrition Analytics — PostgreSQL Schema
-- ============================================================

DROP TABLE IF EXISTS employees CASCADE;

CREATE TABLE employees (
    employee_number             INT PRIMARY KEY,
    age                         INT,
    attrition                   VARCHAR(5),
    business_travel             VARCHAR(20),
    daily_rate                  INT,
    department                  VARCHAR(30),
    distance_from_home          INT,
    education                   INT,
    education_field             VARCHAR(30),
    environment_satisfaction    INT,
    gender                      VARCHAR(10),
    hourly_rate                 INT,
    job_involvement             INT,
    job_level                   INT,
    job_role                    VARCHAR(30),
    job_satisfaction            INT,
    marital_status              VARCHAR(15),
    monthly_income              INT,
    monthly_rate                INT,
    num_companies_worked        INT,
    overtime                    VARCHAR(5),
    percent_salary_hike         INT,
    performance_rating          INT,
    relationship_satisfaction   INT,
    stock_option_level          INT,
    total_working_years         INT,
    training_times_last_year    INT,
    work_life_balance           INT,
    years_at_company            INT,
    years_in_current_role       INT,
    years_since_last_promotion  INT,
    years_with_curr_manager     INT,
    attrition_flag              INT,
    tenure_band                 VARCHAR(15),
    income_band                 VARCHAR(15),
    job_satisfaction_label      VARCHAR(15),
    work_life_balance_label     VARCHAR(15)
);

CREATE INDEX idx_emp_department ON employees(department);
CREATE INDEX idx_emp_attrition ON employees(attrition);
CREATE INDEX idx_emp_jobrole ON employees(job_role);

-- ============================================================
-- Load data (run from psql with \copy, paths relative to client)
-- ============================================================
-- \copy employees FROM 'data/hr_attrition_clean_for_sql.csv' WITH (FORMAT csv, HEADER true)
