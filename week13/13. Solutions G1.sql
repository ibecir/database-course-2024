-- Task 1. -> classicmodels database
-- Calculate the customer retention rate by identifying the percentage of customers 
-- who have made repeat purchases.
SELECT
    c.customerNumber,
    COUNT(o.orderNumber) AS totalOrders,
    COUNT(DISTINCT YEAR(o.orderDate)) AS yearsActive,
    COUNT(DISTINCT YEAR(o.orderDate)) / NULLIF(COUNT(o.orderNumber), 0) AS retentionRate
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
GROUP BY c.customerNumber
HAVING COUNT(o.orderNumber) > 1;

-- Task 2. -> sakila database
-- Find the films with the longest average rental duration, and rank them
-- based on their average rental duration.
SELECT 
    f.film_id,
    f.title,
    AVG(DATEDIFF(r.return_date, r.rental_date)) AS avgRentalDuration,
    RANK() OVER (ORDER BY AVG(DATEDIFF(r.return_date, r.rental_date)) DESC) AS rentalDurationRank
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.film_id
ORDER BY avgRentalDuration DESC;

-- Task 3. -> sakila database
-- Calculate the customer churn rate by identifying the percentage of customers
-- who have not made any rentals within the last 90 days.
SELECT
    customer_id,
    SUM(DATEDIFF(CURRENT_DATE, rental_date) > 90) AS churnedRentals,
    COUNT(DISTINCT rental_id) AS totalRentals,
    100 * SUM(DATEDIFF(CURRENT_DATE, rental_date) > 90) / NULLIF(COUNT(DISTINCT rental_id), 0) AS churnRate
FROM rental
GROUP BY customer_id;

-- Task 4. -> employees database
-- Calculate the cumulative salary distribution across all employees. Use an appropriate window
-- function to show the cumulative distribution for each employee based on their salary.
SELECT
    e.emp_no,
    e.first_name,
    e.last_name,
    s.salary,
    CUME_DIST() OVER (ORDER BY s.salary DESC) AS salaryDistribution
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
GROUP BY e.emp_no, s.salary
ORDER BY salaryDistribution DESC;