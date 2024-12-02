use classicmodels;

-- Task 1
-- Create a query combining customer information with payment details. Display customer name, contact information, payment amount, and payment date. Combine data from the customers and payments tables. Order the results by payment date in descending order. 
SELECT 
    c.customerName,
    c.phone,
    c.addressLine1,
    c.city,
    c.country,
    p.amount,
    p.paymentDate
FROM 
    customers c
JOIN 
    payments p ON c.customerNumber = p.customerNumber
ORDER BY 
    p.paymentDate DESC;

 -- Task 2
 -- Create a query showcasing the sales performance of each employee. Include employee number, first name, last name, and total sales amount generated by each employee. Ensure that the report lists all employees, regardless of their sales records (if they do not have sales, show 0), and order the results by total sales amount in descending order.
SELECT e.employeeNumber, e.firstName, e.lastName, IFNULL(od.quantityOrdered * od.priceEach, 0) AS total_sales
FROM employees e
LEFT JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN orders o ON c.customerNumber = o.customerNumber
LEFT JOIN orderdetails od ON o.orderNumber = od.orderNumber
ORDER BY total_sales DESC;

 -- Task 3
SELECT 
    customers.customerName, 
    customers.country, 
    orders.orderNumber, 
    orders.orderDate
FROM customers
JOIN orders ON customers.customerNumber = orders.customerNumber
ORDER BY orders.orderDate DESC;

 -- Task 4
SELECT 
    products.productName, 
    products.productLine, 
    products.quantityInStock, 
    products.buyPrice
FROM products
JOIN productlines ON products.productLine = productlines.productLine
ORDER BY products.productLine;

 -- Task 5
SELECT 
    customers.customerName, 
    orders.orderNumber, 
    orders.status AS orderStatus, 
    orders.orderDate
FROM customers
JOIN orders ON customers.customerNumber = orders.customerNumber
ORDER BY orders.status ASC;


 -- Task 6
SELECT customerName
FROM customers
WHERE country = 'USA'
UNION
SELECT customerName
FROM customers
WHERE creditLimit > 50000;

 -- Task 7
SELECT customerName
FROM customers
JOIN orders ON customers.customerNumber = orders.customerNumber
INTERSECT
SELECT customerName
FROM customers
JOIN payments ON customers.customerNumber = payments.customerNumber;

 -- Task 8
SELECT customerName
FROM customers
EXCEPT
SELECT DISTINCT customerName
FROM customers
JOIN payments ON customers.customerNumber = payments.customerNumber;


USE sakila;
-- Task 9
-- Create a query that will combine customer and staff information with payment details. Display customer ID, first name, last name, payment amount, and payment date. Combine data from the customers and payments tables. Order the results by payment date in descending order. 
(SELECT customer_id, first_name, last_name, amount AS payment_amount, payment_date
FROM customer
JOIN payment USING(customer_id))

UNION

(SELECT staff_id, first_name, last_name, amount AS payment_amount, payment_date
FROM staff
JOIN payment USING(staff_id))
ORDER BY payment_date DESC;

-- Task 10
SELECT customer.customer_id
FROM customer
JOIN rental ON customer.customer_id = rental.customer_id
WHERE YEAR(rental_date) = 2005
INTERSECT
SELECT customer.customer_id
FROM customer
JOIN payment ON customer.customer_id = payment.customer_id
WHERE YEAR(payment_date) = 2005;

-- Task 11
SELECT title
FROM film
JOIN inventory ON film.film_id = inventory.film_id
EXCEPT
SELECT title
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id;

-- Task 12
SELECT staff.staff_id
FROM staff
JOIN payment ON staff.staff_id = payment.staff_id
UNION
SELECT staff.staff_id
FROM staff
JOIN rental ON staff.staff_id = rental.staff_id;

USE employees;

-- Task 13
-- Calculate the length of service for each employee in years, rounded to the nearest integer, and display it alongside the department names they belong to. You can calculate this by calculating the difference between the current date and hire date and result divided by 365.
SELECT e.emp_no , e.first_name, e.last_name, 
       ROUND(DATEDIFF(CURRENT_DATE(), e.hire_date)/365) AS length_of_service_years, 
       d.dept_name 
FROM employees e
JOIN dept_emp de on e.emp_no = de.emp_no 
JOIN departments d ON de.dept_no  = d.dept_no;
