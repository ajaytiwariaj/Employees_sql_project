--To create database
create employees;

--To make it default schema
use employees;


-- Retrieve all employees 
SELECT 
    *
FROM
    employees;


-- Retrieve all employees hired on and after 2000.
SELECT 
    *
FROM
    employees
WHERE
    hire_date >= '2000-01-01';


-- List all employees with their first and last names.
SELECT 
    first_name, last_name
FROM
    employees;


--  Find the total number of departments in the company.
SELECT 
    COUNT(*)
FROM
    departments;


-- Get the distinct job titles available in the company.
SELECT DISTINCT
    (title)
FROM
    titles;


-- Retrieve employees working in the "Sales" department.
SELECT 
    e.emp_no, e.first_name, e.last_name, d.dept_no, d.dept_name
FROM
    dept_emp de
        JOIN
    employees e ON de.emp_no = e.emp_no
        JOIN
    departments d ON de.dept_no = d.dept_no
WHERE
    d.dept_name = 'sales';


-- Find the current salary of a specific employee by their ID (10009).
SELECT 
    *
FROM
    salaries
WHERE
    emp_no = '10009'
        AND to_date = '9999-01-01';


-- Find the highest salary of a specific employee by their ID(10005).
SELECT 
    emp_no, MAX(salary) AS highest_salary
FROM
    salaries
WHERE
    emp_no = '10005';


-- Find the second highest salary
SELECT MAX(SALARY)
   FROM SALARIES
   WHERE SALARY < (SELECT MAX(SALARY) FROM SALARIES)

-- Find the 10th highest salary
   SELECT SALARY 
   FROM (SELECT SALARY,
   DENSE_RANK () OVER (ORDER BY SALARY DESC) AS SALARY_10TH
   FROM SALARIES) AS SALARY
   WHERE SALARY_10TH = 10


-- List employees who have been managers at some point.
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CONCAT(e.first_name, ' ', e.last_name) AS full_name,
    d.dept_name,
    dm.from_date,
    dm.to_date
FROM
    employees e
        JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
        JOIN
    departments d ON dm.dept_no = d.dept_no;


-- Retrieve the highest-paid employee with first and last name.
SELECT 
    e.emp_no, e.first_name, e.last_name, s.salary
FROM
    salaries s
        JOIN
    employees e ON e.emp_no = s.emp_no
WHERE
    salary = (SELECT 
            MAX(salary)
        FROM
            salaries);


-- Find the average salary of employees per department. 
SELECT 
    d.dept_no, d.dept_name, AVG(s.salary) AS average_salary
FROM
    salaries s
        JOIN
    dept_emp de ON s.emp_no = de.emp_no
        JOIN
    departments d ON de.dept_no = d.dept_no
GROUP BY d.dept_name , d.dept_no;



-- Identify employees who have been in the company for more than 35 years.
SELECT 
    emp_no,
    first_name,
    last_name,
    hire_date,
    TIMESTAMPDIFF(YEAR,
        hire_date,
        CURDATE()) AS years
FROM
    employees
WHERE
    TIMESTAMPDIFF(YEAR,
        hire_date,
        CURDATE()) > 35;


-- Get the number of employees hired per year.
SELECT 
    YEAR(hire_date) AS hire_date, COUNT(emp_no) AS emp_hired
FROM
    employees
GROUP BY YEAR(hire_date)
ORDER BY hire_date;
