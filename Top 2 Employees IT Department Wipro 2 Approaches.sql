CREATE TABLE employees (employee_id INT PRIMARY KEY, employee_name VARCHAR(100), company_name VARCHAR(100), department VARCHAR(50), salary DECIMAL(10,2)); 

INSERT INTO employees VALUES
	(1, 'Amit Gupta', 'Wipro', 'IT', 90000.00), 
	(2, 'Neha Reddy', 'Wipro', 'IT', 85000.00),
	(3, 'Sanjay Kapoor', 'Wipro', 'HR', 60000.00);


SELECT * FROM EMPLOYEES


/*
Find the top 2 employees with the highest salaries in the IT department of Wipro.
*/

--APPROACH 1

WITH CTE AS
(SELECT EMPLOYEE_NAME,
       COMPANY_NAME,
	   DEPARTMENT,
	   SALARY,
       DENSE_RANK()OVER(PARTITION BY COMPANY_NAME,DEPARTMENT ORDER BY SALARY DESC)AS DRNK
FROM EMPLOYEES
)
SELECT EMPLOYEE_NAME,
       COMPANY_NAME,
       DEPARTMENT,
       SALARY
FROM CTE WHERE COMPANY_NAME = 'Wipro'
AND DEPARTMENT = 'IT'
AND DRNK <=2

--APPROACH 2

SELECT EMPLOYEE_NAME,
       COMPANY_NAME,
       DEPARTMENT,
       SALARY
FROM EMPLOYEES
WHERE COMPANY_NAME = 'Wipro'
  AND DEPARTMENT = 'IT'
  AND SALARY IN (
      SELECT DISTINCT SALARY
      FROM EMPLOYEES
      WHERE COMPANY_NAME = 'Wipro' AND DEPARTMENT = 'IT'
      ORDER BY SALARY DESC
      LIMIT 2
  );
