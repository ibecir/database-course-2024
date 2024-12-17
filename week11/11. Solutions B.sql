-- **** classicmodels database ****

-- Task 01.
-- Using subqueries, list customers who have placed orders for more than 5 different product lines.
SELECT customerName
FROM customers
WHERE customerNumber IN (
    SELECT customerNumber
    FROM orders
    JOIN orderdetails USING(orderNumber) 
    JOIN products USING (productCode)
    GROUP BY customerNumber
    HAVING COUNT(DISTINCT productLine) > 5
);

-- Task 02.
-- List all products that have never been ordered using subqueries.
SELECT productName
FROM products
WHERE productCode NOT IN (
    SELECT productCode
    FROM orderdetails
);

-- Task 03.
-- Find the average number of orders per customer for customers who have placed orders
-- for products at prices greater than the average product price using subqueries.
SELECT AVG(order_count) AS "Avg. orders per customer"
FROM (
    SELECT COUNT(*) AS order_count
    FROM orders
    WHERE customerNumber IN (
        SELECT customerNumber
        FROM orderdetails
        JOIN products USING(productCode)
        WHERE buyPrice > (
            SELECT AVG(buyPrice)
            FROM products
        )
    )
    GROUP BY customerNumber
) AS subquery;

-- Task 04.
-- List all customers whose total order amount exceeds the average total order amount across all customers.
SELECT c.customerName
FROM customers c
WHERE (
    SELECT SUM(od.quantityOrdered * od.priceEach)
    FROM orders o
    JOIN orderdetails od ON o.orderNumber = od.orderNumber
    WHERE o.customerNumber = c.customerNumber
) > (
    SELECT AVG(totalOrder)
    FROM (
        SELECT SUM(od.quantityOrdered * od.priceEach) AS totalOrder
        FROM orders o
        JOIN orderdetails od ON o.orderNumber = od.orderNumber
        GROUP BY o.customerNumber
    ) AS avgOrders
);

-- Task 05.
-- Using subqueries, write a query to find the employee with the highest total sales 
-- (sum of quantityOrdered * priceEach) across all their managed customers.
-- Display the employee's first and last name, office city, and their total sales amount.
SELECT e.firstName, e.lastName, o.city AS officeCity, 
       (SELECT SUM(od.quantityOrdered * od.priceEach)
        FROM customers c
        JOIN orders o ON c.customerNumber = o.customerNumber
        JOIN orderdetails od ON o.orderNumber = od.orderNumber
        WHERE c.salesRepEmployeeNumber = e.employeeNumber
       ) AS totalSales
FROM employees e
JOIN offices o ON e.officeCode = o.officeCode
ORDER BY totalSales DESC
LIMIT 1;


-- **** sakila database ****

-- Task 06.
-- List customers who have rented films in more than one category using subqueries.
SELECT DISTINCT customer_id, first_name, last_name 
FROM rental
JOIN customer USING(customer_id)
WHERE customer_id IN (
    SELECT customer_id
    FROM rental
    JOIN inventory USING (inventory_id)
    JOIN film_category USING (film_id)
    GROUP BY customer_id
    HAVING COUNT(DISTINCT category_id) > 1
);

-- Task 07.
-- Using subqueries, write a query to calculate the average rental duration of films for each city.
-- Include only those cities where the average rental duration is greater than 4 days.
SELECT film_id, title
FROM film
WHERE film_id IN (
    SELECT f.film_id
	FROM rental r
	JOIN inventory i ON i.inventory_id = r.inventory_id
	JOIN film f ON f.film_id = i.film_id 
	GROUP BY f.film_id, customer_id 
    HAVING COUNT(*) > 2
);

-- Task 08.
-- Write a query to find films that share the same rental duration as at least one 
-- other film in their category. Display the category name, film title, and rental duration.
SELECT DISTINCT c.name AS categoryName, f.title AS filmTitle, f.rental_duration
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
WHERE f.rental_duration IN (
    SELECT f2.rental_duration
    FROM film f2
    JOIN film_category fc2 ON f2.film_id = fc2.film_id
    WHERE fc2.category_id = c.category_id AND f2.film_id <> f.film_id
);

-- Task 09.
-- Using subqueries, write a query to display each film, its rental rate, and its rank within its 
-- category based on the rental rate (descending order).
-- Include the film title, category name, rental rate, and rank.
SELECT c.name AS categoryName, f.title AS filmTitle, f.rental_rate, 
       (SELECT COUNT(DISTINCT f2.rental_rate)
        FROM film f2
        JOIN film_category fc2 ON f2.film_id = fc2.film_id
        WHERE fc2.category_id = fc.category_id AND f2.rental_rate >= f.rental_rate
       ) AS rentalRateRank
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
ORDER BY c.name, rentalRateRank;


-- **** employees database ****

-- Task 10.
-- Using subqueries, list the department with the highest number of employees.
SELECT dept_name, COUNT(*) AS num_employees
FROM departments
JOIN dept_emp USING (dept_no)
GROUP BY dept_name
HAVING COUNT(*) = (
    SELECT MAX(emp_count)
    FROM (
        SELECT COUNT(*) AS emp_count
        FROM dept_emp
        GROUP BY dept_no
    ) AS subquery
);

-- Task 11.
-- List departments with more employees than the average number of employees in
-- all departments using subqueries.
SELECT dept_name, COUNT(*) AS "Employee num."
FROM departments
JOIN dept_emp USING (dept_no)
GROUP BY dept_name
HAVING COUNT(*) > (
    SELECT AVG(emp_count)
    FROM (
        SELECT COUNT(*) AS emp_count
        FROM dept_emp
        GROUP BY dept_no
    ) AS subquery
);

-- Task 12.
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

-- Task 13.
-- Write a query to list all employees whose first name and last name
-- match with another employee in the database using subqueries.
SELECT DISTINCT e1.first_name, e1.last_name
FROM employees e1
WHERE (e1.first_name, e1.last_name) IN (
    SELECT e2.first_name, e2.last_name
    FROM employees e2
    WHERE e1.emp_no <> e2.emp_no
);