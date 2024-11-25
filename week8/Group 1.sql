-- Task 1
SELECT
    c.customerName AS name,
    c.city,
    o.orderDate,
    o.status
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
WHERE c.city = 'Madrid'
  AND o.status = 'In Process'
ORDER BY o.orderDate DESC;

-- Task 2
SELECT customerNumber, customerName, addressLine1, addressLine2
FROM customers
WHERE contactFirstName LIKE '__%ne ';

USE sakila;

-- Task 3
SELECT c.*
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
WHERE ci.city = 'Abu Dhabi';

-- Task 4
SELECT DISTINCT a.actor_id, a.first_name, a.last_name
FROM actor a
JOIN film_actor fa USING (actor_id)
JOIN film f USING (film_id)
WHERE f.release_year = 2006
  AND a.first_name LIKE 'A%';

-- Task 5
SELECT 
    customers.customerName AS name,
    customers.city,
    orders.orderDate,
    orders.status,
    orders.comments
FROM 
    customers
JOIN 
    orders ON customers.customerNumber = orders.customerNumber
WHERE 
    customers.city = 'San Francisco' 
    AND orders.status = 'Shipped'
ORDER BY 
    orders.orderDate DESC;

-- Task 6
SELECT 
    employees.employeeNumber,
    employees.lastName,
    employees.firstName,
    employees.jobTitle
FROM 
    employees
JOIN 
    offices ON employees.officeCode = offices.officeCode
WHERE 
    offices.city = 'Paris';
   
-- Task 7
SELECT 
    customers.customerName,
    customers.salesRepEmployeeNumber,
    employees.lastName AS salesRepLastName,
    employees.firstName AS salesRepFirstName
FROM 
    customers
LEFT JOIN 
    employees ON customers.salesRepEmployeeNumber = employees.employeeNumber
ORDER BY 
    customers.customerName;

-- Task 8
SELECT 
    orders.orderNumber,
    orders.orderDate,
    customers.customerName,
    orders.status
FROM 
    orders
JOIN 
    customers ON orders.customerNumber = customers.customerNumber
ORDER BY 
    orders.orderDate DESC;

-- Task 9
SELECT 
    orderdetails.orderNumber,
    orderdetails.productCode,
    orderdetails.quantityOrdered,
    orderdetails.priceEach,
    orders.status
FROM 
    orderdetails
JOIN 
    orders ON orderdetails.orderNumber = orders.orderNumber
WHERE 
    orders.status = 'Shipped';

-- Task 10
SELECT 
    employees.employeeNumber,
    employees.lastName,
    employees.firstName,
    offices.city,
    offices.country
FROM 
    employees
JOIN 
    offices ON employees.officeCode = offices.officeCode;
   
-- Task 11
SELECT 
    products.productCode,
    products.productName,
    products.productLine,
    products.productDescription
FROM 
    products
JOIN 
    productlines ON products.productLine = productlines.productLine;

-- Task 12
SELECT 
    customers.customerName,
    orders.orderNumber,
    orders.orderDate,
    orders.status
FROM 
    customers
JOIN 
    orders ON customers.customerNumber = orders.customerNumber
ORDER BY 
    customers.customerName, orders.orderDate DESC;
  
-- Task 13
SELECT 
    employees.employeeNumber AS salesRepEmployeeNumber,
    employees.lastName,
    employees.firstName,
    COUNT(customers.customerNumber) AS customerCount
FROM 
    employees
LEFT JOIN 
    customers ON employees.employeeNumber = customers.salesRepEmployeeNumber
GROUP BY 
    employees.employeeNumber
ORDER BY 
    customerCount DESC;

-- Task 14
SELECT 
    products.productName,
    orderdetails.orderNumber,
    orderdetails.quantityOrdered
FROM 
    products
JOIN 
    orderdetails ON products.productCode = orderdetails.productCode
ORDER BY 
    products.productName;

-- Task 15
SELECT 
    e1.employeeNumber,
    CONCAT(e1.firstName, ' ', e1.lastName) AS employeeName,
    e1.reportsTo,
    CONCAT(e2.firstName, ' ', e2.lastName) AS managerName
FROM 
    employees e1
LEFT JOIN 
    employees e2 ON e1.reportsTo = e2.employeeNumber;

