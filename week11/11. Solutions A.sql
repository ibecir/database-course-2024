-- **** classicmodels database ****

-- Task 01.
-- Using subqueries, list customers who have placed orders for products from more than 3 different 
-- product lines and have ordered at least one product with a quantity greater than 10. 
SELECT customerName, customerNumber, addressLine1 
FROM customers
WHERE customerNumber IN (
    SELECT customerNumber
    FROM orders
    JOIN orderdetails USING(orderNumber)
    JOIN products USING(productCode)
    WHERE productCode IN (
        SELECT productCode
        FROM products
        WHERE productLine IN (
            SELECT DISTINCT productLine
            FROM orderdetails
            JOIN products USING(productCode)
        )
    )
    AND quantityOrdered > 10
    GROUP BY customerNumber
    HAVING COUNT(DISTINCT productLine) > 3
);

-- Task 02.
-- Find the product line with the highest total revenue across all products.
-- List the product line and its total revenue using subqueries.
SELECT p.productLine, SUM(od.quantityOrdered * od.priceEach) AS totalRevenue
FROM products p
JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.productLine
HAVING SUM(od.quantityOrdered * od.priceEach) = (
    SELECT MAX(totalLineRevenue)
    FROM (
        SELECT SUM(od.quantityOrdered * od.priceEach) AS totalLineRevenue
        FROM products p
        JOIN orderdetails od ON p.productCode = od.productCode
        GROUP BY p.productLine
    ) AS lineRevenues
);

-- Task 03.
-- Using subqueries, list customers who have placed orders for products from more than 2 different product lines.
SELECT c.customerName
FROM customers c
WHERE (
    SELECT COUNT(DISTINCT p.productLine)
    FROM orders o
    JOIN orderdetails od ON o.orderNumber = od.orderNumber
    JOIN products p ON od.productCode = p.productCode
    WHERE o.customerNumber = c.customerNumber
) > 2;

-- Task 04.
-- Find the product with the lowest total revenue among all products.
-- Display the product code, product name, and its total revenue.
-- Use subqueries to solve the task.
SELECT p.productCode, p.productName, 
       SUM(od.quantityOrdered * od.priceEach) AS totalRevenue
FROM products p
JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.productCode, p.productName
HAVING totalRevenue = (
    SELECT MIN(productRevenue)
    FROM (
        SELECT SUM(od.quantityOrdered * od.priceEach) AS productRevenue
        FROM products p
        JOIN orderdetails od ON p.productCode = od.productCode
        GROUP BY p.productCode
    ) AS productRevenues
);


-- **** employees database ****

-- Task 05.
-- Find the average salary for employees hired after the average hiring date using subqueries.
SELECT AVG(salary) AS "Avg. salary"
FROM salaries
WHERE emp_no IN (
    SELECT emp_no
    FROM employees
    WHERE hire_date > (
        SELECT AVG(hire_date)
        FROM employees
    )
);

-- Task 06.
-- Write a query to find employees who have held the same title more than once
-- (at different times). Display the employee's first and last name
-- along with the title. Use subqueries.
SELECT DISTINCT e.first_name, e.last_name, t.title
FROM employees e
JOIN titles t ON e.emp_no = t.emp_no
WHERE (t.emp_no, t.title) IN (
    SELECT emp_no, title
    FROM titles
    GROUP BY emp_no, title
    HAVING COUNT(*) > 1
);

-- Task 07.
-- List employees who have worked in more than one department.
-- Solve the task using subqueries.
SELECT emp_no, first_name, last_name
FROM employees
WHERE emp_no IN (
    SELECT emp_no
    FROM dept_emp
    GROUP BY emp_no
    HAVING COUNT(DISTINCT dept_no) > 1
);

-- Task 08.
-- Write a query to find employees who have earned their maximum salary more than once.
-- Display the employee’s first and last name, the maximum salary, and the number of times they earned it.
-- Order the results by the number of times they earned the maximum salary.
-- Solve the task using subqueries.
SELECT e.first_name, e.last_name, s.salary AS max_salary, COUNT(*) AS times_earned
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
WHERE s.salary = (
    SELECT MAX(s2.salary)
    FROM salaries s2
    WHERE s2.emp_no = s.emp_no
)
GROUP BY e.emp_no, e.first_name, e.last_name, s.salary
HAVING COUNT(*) > 1
ORDER BY times_earned;


-- **** sakila database ****

-- Task 09.
-- Find the films with the longest duration that has been rented using subqueries.
-- Present film ID, title, and length and order results in descending order based on the film title.
SELECT f.film_id, f.title, f.length
FROM film f
WHERE f.length = (
    SELECT MAX(f2.length)
    FROM film f2
    WHERE f2.film_id IN (
        SELECT i.film_id
        FROM inventory i
        WHERE i.inventory_id IN (
            SELECT r.inventory_id
            FROM rental r
        )
    )
)
ORDER BY f.title DESC;

-- Task 10.
-- List customers who have rented more movies than the average number of rentals per customer.
-- Use subqueries to solve the task.
SELECT customer_id, first_name, last_name
FROM customer
WHERE (
    SELECT COUNT(*)
    FROM rental
    WHERE rental.customer_id = customer.customer_id) > (
    SELECT AVG(num_rentals)
    FROM (
        SELECT customer_id, COUNT(*) AS num_rentals
        FROM rental
        GROUP BY customer_id
    ) AS avg_rentals
);

-- Task 11.
-- List all actors who have appeared in films with an average rental duration above the 
-- overall average rental duration. Use subqueries to solve the task.
SELECT a.first_name, a.last_name
FROM actor a
WHERE (
    SELECT AVG(f.rental_duration)
    FROM film_actor fa
    JOIN film f ON fa.film_id = f.film_id
    WHERE fa.actor_id = a.actor_id
) > (
    SELECT AVG(rental_duration)
    FROM film
);

-- Task 12.
-- Using subqueries, find the film category with the highest total revenue.
-- Display the category name and its total revenue.
SELECT c.name AS categoryName, 
       SUM(p.amount) AS totalRevenue
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN inventory i ON fc.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.name
HAVING SUM(p.amount) = (
    SELECT MAX(categoryRevenue)
    FROM (
        SELECT SUM(p.amount) AS categoryRevenue
        FROM category c
        JOIN film_category fc ON c.category_id = fc.category_id
        JOIN inventory i ON fc.film_id = i.film_id
        JOIN rental r ON i.inventory_id = r.inventory_id
        JOIN payment p ON r.rental_id = p.rental_id
        GROUP BY c.name
    ) AS categoryRevenues
);

-- Task 13.
-- Find the film with the highest rental count. Display the film title and the 
-- total number of rentals. Solve the task using subqueries.
SELECT f.title, COUNT(r.rental_id) AS totalRentals
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
HAVING totalRentals = (
    SELECT MAX(rentalCount)
    FROM (
        SELECT COUNT(r.rental_id) AS rentalCount
        FROM film f
        JOIN inventory i ON f.film_id = i.film_id
        JOIN rental r ON i.inventory_id = r.inventory_id
        GROUP BY f.film_id
    ) AS rentalCounts
);


