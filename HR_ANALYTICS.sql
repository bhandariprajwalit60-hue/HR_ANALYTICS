create database hr_analytics ;
use hr_analytics ;

-- IMPORT THE DATA FROM CSV FILE USING SCHEMA IMPORT 

show tables ;

-- VIEW ALL THE DATA INSIDE TABLE 

select * from hr_analytics;

-- CHANGING THE NAME OF A COLUMN 

ALTER TABLE hr_analytics
CHANGE ï»¿EmpID EmpID VARCHAR(10);

--Question: How many employees are there?
SELECT COUNT(*) AS total_employees
FROM hr_analytics;

--Employees Who Left the Company (Attrition)
SELECT COUNT(*) AS employees_left
FROM hr_analytics
WHERE attrition = 'Yes';

Attrition Rate (%)
SELECT 
ROUND(
(COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) * 100.0) / COUNT(*),2
) AS attrition_rate
FROM hr_analytics;

Department-wise Employee Count

SELECT department, COUNT(*) AS total_employees
FROM hr_analytics
GROUP BY department;

Department-wise Attrition Count

SELECT department, COUNT(*) AS attrition_count
FROM hr_analytics
WHERE attrition = 'Yes'
GROUP BY department;

Average salary by department
SELECT department, ROUND(AVG(monthlyincome), 0) AS avg_salary
FROM hr_analytics
GROUP BY department;

Highest paid employee
SELECT EmpID, monthlyincome
FROM hr_analytics
ORDER BY monthlyincome DESC
LIMIT 1;
Employees with more than 10 years in company
SELECT COUNT(*) AS senior_employees
FROM hr_analytics
WHERE yearsatcompany > 10;
Gender-wise employee distribution
SELECT gender, COUNT(*) AS total_employees
FROM hr_analytics
GROUP BY gender;
Attrition by gender
SELECT gender, COUNT(*) AS attrition_count
FROM hr_analytics
WHERE attrition = 'Yes'
GROUP BY gender;

Top 3 job roles with highest attrition
SELECT jobrole, COUNT(*) AS attrition_count
FROM hr_analytics
WHERE attrition = 'Yes'
GROUP BY jobrole
ORDER BY attrition_count DESC
LIMIT 3;

--Average age of employees who left

SELECT ROUND(AVG(age), 1) AS avg_age_attrition
FROM hr_analytics
WHERE attrition = 'Yes';

 --Salary rank within each department (WINDOW FUNCTION)
 
SELECT 
EmpID,
department,
monthlyincome,
RANK() OVER (PARTITION BY department ORDER BY monthlyincome DESC) AS salary_rank
FROM hr_analytics;

--Highest paid employee in each department

SELECT EmpID, department, monthlyincome
FROM (
    SELECT 
    EmpID,
    department,
    monthlyincome,
    RANK() OVER (PARTITION BY department ORDER BY monthlyincome DESC) AS rnk
    FROM hr_analytics
) t
WHERE rnk = 1;

