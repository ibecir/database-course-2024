-- Task 1. -> classicmodels database
-- Calculate the percentage contribution of each product to the total sales revenue.
SELECT
    p.productName,
    SUM(od.quantityOrdered * od.priceEach) AS totalRevenue,
    (SUM(od.quantityOrdered * od.priceEach) / SUM(SUM(od.quantityOrdered * od.priceEach)) OVER ()) * 100 AS revenueContributionPercentage
FROM orderdetails od
JOIN products p ON od.productCode = p.productCode
GROUP BY p.productCode
ORDER BY totalRevenue DESC;

-- Task 2. -> sakila database
-- Rank customers based on their total rental revenue.
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    SUM(p.amount) AS total_rental_revenue,
    RANK() OVER (ORDER BY SUM(p.amount) DESC) AS revenue_rank
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN customer c ON r.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY total_rental_revenue DESC;

-- Task 3. -> employees database
-- Rank employees based on the number of departments they have worked in. 
-- Display the rank along with the number of departments for each employee.
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    COUNT(de.dept_no) AS departmentCount,
    RANK() OVER (ORDER BY COUNT(de.dept_no) DESC) AS departmentRank
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
GROUP BY e.emp_no
ORDER BY departmentRank;

-- Task 4. -> employees database
-- Find the average salary for each employee's job title, and rank the employees 
-- within each job title based on their salary. Use an appropriate window function to assign ranks,
-- ensuring no gaps in the sequence.
SELECT
    e.emp_no,
    e.first_name,
    e.last_name,
    t.title,
    s.salary,
    DENSE_RANK() OVER (PARTITION BY t.title ORDER BY s.salary DESC) AS salaryRank
FROM employees e
JOIN titles t ON e.emp_no = t.emp_no
JOIN salaries s ON e.emp_no = s.emp_no
GROUP BY e.emp_no, t.title, s.salary
ORDER BY t.title, salaryRank;