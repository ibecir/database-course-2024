use classicmodels;

-- Task 1
-- Create a query combining customer information with payment details. Display customer name, contact information, payment amount, and payment date. Combine data from the customers and payments tables. Order the results by payment date in descending order. 
SELECT DISTINCT p.productCode, p.productName, p.quantityInStock,
       CASE WHEN od.productCode IS NOT NULL THEN 'In Stock' ELSE 'Out of Stock' END AS status
FROM products p
LEFT JOIN orderdetails od ON p.productCode = od.productCode
ORDER BY p.productName;

-- Task 2
SELECT customerName
FROM customers
JOIN orders ON customers.customerNumber = orders.customerNumber
WHERE YEAR(orderDate) = 2005
UNION
SELECT customerName
FROM customers
JOIN payments ON customers.customerNumber = payments.customerNumber
WHERE YEAR(paymentDate) = 20232005;

USE sakila;

 -- Task 3
 -- Create a detailed contact list containing the names and contact details of all customers and staff members. Display the contact type ('Customer' or 'Staff'), name, phone number, and email address. Order the results alphabetically by contact type and then by name.
(SELECT 'Customer' AS contact_type, CONCAT(first_name, ' ', last_name) AS name, email
FROM customer)

UNION

(SELECT 'Staff' AS contact_type, CONCAT(first_name, ' ', last_name) AS name, email
FROM staff)
ORDER BY contact_type, name;

-- Task 4
-- Calculate the length of service for each employee in years, rounded to the nearest integer, and display it alongside the department names they belong to. You can calculate this by calculating the difference between the current date and hire date and result divided by 365.
SELECT f.title AS film_title, r.rental_date, r.return_date
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.return_date < CURDATE() AND r.return_date IS NOT NULL
ORDER BY r.rental_date;

-- Task 5
SELECT DISTINCT title
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
WHERE MONTH(rental_date) IN (1, 2, 3)
UNION
SELECT DISTINCT title
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
WHERE MONTH(rental_date) IN (4, 5, 6);

-- Task 6
SELECT DISTINCT customer_id
FROM rental
UNION
SELECT DISTINCT customer_id
FROM payment
WHERE amount > 100;


USE employees;

-- Task 7
-- Retrieve list of all employees and their corresponding numbers, names and surnames as well as department number whose length of first name after adding x to the end of the name is greater than 8 and whose department name is ending with “e”.
SELECT e.emp_no, e.first_name, e.last_name, d.dept_name 
FROM employees e
join dept_emp de on de.emp_no = e.emp_no 
join departments d on d.dept_no = de.dept_no 
WHERE LENGTH(CONCAT(e.first_name, "x")) > 0 AND RIGHT(d.dept_name, 1) = "e";

-- Task 8
SELECT employees.emp_no
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'HR'
UNION
SELECT employees.emp_no
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Finance';

-- Task 9
SELECT emp_no
FROM salaries
WHERE salary BETWEEN 60000 AND 70000
INTERSECT
SELECT emp_no
FROM salaries
WHERE salary BETWEEN 80000 AND 90000;

-- Task 10
SELECT emp_no
FROM employees
WHERE hire_date BETWEEN '2000-01-01' AND '2009-12-31'
UNION
SELECT emp_no
FROM employees
WHERE hire_date BETWEEN '2010-01-01' AND '2019-12-31';

-- Task 11
SELECT employees.emp_no
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Development'
UNION
SELECT employees.emp_no
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales';

-- Task 12
SELECT employees.emp_no
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Development'
EXCEPT
SELECT employees.emp_no
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales';

-- Task 13
SELECT emp_no
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
UNION
SELECT emp_no
FROM employees
WHERE hire_date BETWEEN '2000-01-01' AND '2009-12-31';
