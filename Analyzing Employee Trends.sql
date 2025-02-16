-- USE employee;

-- 1) Count the number of employees in each department---
SELECT department,COUNT(*) FROM employees
GROUP BY department;

-- 2)Calculate the average age for each department ---

SELECT department,round(AVG(age)) FROM employees
GROUP BY department;

-- 3)Identify the most common job roles in each department ---
SELECT department,job_role,COUNT(*) FROM employees
GROUP BY department,job_role;

-- 4)  Calculate the average job satisfaction for each education level ---
SELECT education_field,AVG(job_satisfaction) FROM employees
GROUP BY education_field;

-- 5)Determine the average age for employees with different levels of job satisfaction ---
SELECT AVG(age),job_satisfaction FROM employees
GROUP BY job_satisfaction;

-- 6)Calculate the attrition rate for each age band --
SELECT age_band,SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)/COUNT(*)*100 as 'attrition rate' FROM employees 
GROUP BY age_band;

-- 7)Identify the departments with the highest and lowest average job satisfaction ---
SELECT department,AVG(job_satisfaction) FROM employees
GROUP BY department;

-- 8)Find the age band with the highest attrition rate among employees with a specific education level---
SELECT education,age_band,SUM(CASE WHEN attrition = 'YES' THEN 1 ELSE 0 END)/COUNT(*)*100 AS 'Attrition rate' FROM employees
GROUP BY education,age_band
ORDER BY `Attrition rate` DESC
LIMIT 1;

-- 9)Find the education level with the highest average job satisfaction among employees who travel frequently ---
SELECT education,AVG(job_satisfaction) FROM employees
WHERE business_travel = 'Travel_Frequently'
GROUP BY education;

-- 10)Identify the age band with the highest average job satisfaction among married employees ----
SELECT age_band,AVG(job_satisfaction) as job_satis FROM employees
WHERE marital_status = 'Married'
GROUP BY age_band
ORDER BY job_satis DESC
LIMIT 1;






















