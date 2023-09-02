-- create a table called employee
CREATE TABLE Employee (
    Employee_ID VARCHAR(10) PRIMARY KEY,
    Full_Name VARCHAR(100),
    Job_Title VARCHAR(100),
    Department VARCHAR(100),
    Business_Unit VARCHAR(100),
    Gender VARCHAR(10),
    Ethnicity VARCHAR(50),
    Age INTEGER,
    Hire_Date DATE,
    Annual_Salary MONEY,
    Bonus_Percent INT,
    Country VARCHAR(50),
    City VARCHAR(50),
    Exit_Date DATE
);

SELECT * FROM employee;


-- 1. Employees in each department
SELECT COUNT(employee_id) AS Total_employees, department
FROM employee
GROUP BY department;
 

-- 2. Average age of employee in sales department
SELECT ROUND(AVG(age)::numeric, 2) AS Average_age, department
FROM employee
WHERE department = 'Sales'
GROUP BY department;


-- 3. Top 5 highest paid employees in the company
SELECT full_name, job_title, department, business_unit, country, MAX(annual_salary) AS Annual_Salary
FROM employee
GROUP BY full_name, job_title, department, business_unit, country, annual_salary 
ORDER By annual_salary DESC
LIMIT 5;
           -- OR--
SELECT full_name, job_title, MAX(annual_salary) AS Annual_Salary
FROM employee
GROUP BY full_name, job_title, annual_salary 
ORDER By annual_salary DESC
LIMIT 5;


-- 4. Distribution of employees across different genders and ethnicities
SELECT Gender, Ethnicity, COUNT(*) AS Total_employees
FROM employee
GROUP BY Gender, Ethnicity;


-- 5. Average salary changed over the years
SELECT EXTRACT(YEAR FROM hire_Date) AS hire_year, ROUND(AVG(annual_Salary::numeric)::numeric, 2) AS average_salary
FROM employee
GROUP BY hire_year, annual_salary
ORDER BY hire_year, annual_salary;


-- 6. Department with the highest average bonus percentage
SELECT department, ROUND(AVG(bonus_percent)::numeric, 2) AS Average_bonus_percentage
FROM employee
GROUP BY department
ORDER BY Average_bonus_percentage DESC
LIMIT 1;


-- 7. Employees who left the company within their first year
SELECT full_name, exit_date, hire_date
FROM employee
WHERE exit_date IS NOT NULL AND exit_date::timestamp - hire_date::timestamp <= interval '1 year';


-- 8. Total annual salary expenditure for each business unit
SELECT business_unit, SUM(annual_salary) AS Total_annual_salary_expenditure
FROM employee
GROUP BY business_unit
ORDER BY Total_annual_salary_expenditure DESC;


-- 9. Average age of employees in each city
SELECT ROUND(AVG(age)::numeric, 2) AS Average_age_of_employees, city
FROM employee
GROUP BY city


-- 10. Average salary for each job
SELECT job_title, ROUND(AVG(annual_salary::numeric)::numeric, 2) AS Average_annual_salary
FROM employee
GROUP BY job_title;

-- 11. Comparison between average bonus percentage and different departments
SELECT department, ROUND(AVG(bonus_percent)::numeric, 2) AS Average_bonus_percent
FROM employee
GROUP BY department;


-- 12. Employees who left the company and their average tenure
SELECT full_name, hire_date, exit_date, 
       AGE(exit_date, hire_date) AS Average_tenure
FROM employee
WHERE exit_date IS NOT NULL;


-- 13. Employees who have been at the company for more than 10 years
SELECT full_name, hire_date, EXTRACT(YEAR FROM AGE(NOW(), hire_date)) AS years_of_service
FROM employee
WHERE AGE(hire_date) > interval '10 years';


-- 14. Average bonus percentage for employees under age 30
SELECT age, ROUND(AVG(bonus_percent)::numeric, 2) AS Average_Bonus_percent
FROM employee 
WHERE age < 30
GROUP BY age;


-- 15. Comparison between distribution of bonus percentages across different ethnicities
SELECT ethnicity,
AVG(bonus_percent) AS Average_bonus_percent,
MIN(bonus_percent) AS Min_bonus_percent,
MAX(bonus_percent) AS Max_bonus_percent,
COUNT(*) AS total_count
FROM employee
GROUP BY ethnicity
ORDER BY total_count;










