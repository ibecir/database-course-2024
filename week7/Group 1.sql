-- Task 1
SELECT customerName, country
FROM customers
WHERE country IN ('France', 'USA');

-- Task 2
SELECT customerNumber, customerName, addressLine1, addressLine2, city, state, postalCode, country
FROM customers
WHERE contactFirstName LIKE '__%ne ';

-- Task 3
SELECT orderNumber, orderDate, customerNumber, status
FROM orders
WHERE orderDate > '2004-12-31';

-- Task 4
SELECT DISTINCT city
FROM customers;

-- Task 5
SELECT * 
FROM orders 
WHERE status IN ('Shipped', 'Resolved');

-- Task 6
SELECT * 
FROM employees 
WHERE jobTitle IN ('Sales Rep', 'Sales Manager');

-- Task 7
SELECT customerNumber, customerName, country 
FROM customers 
WHERE country IN ('Canada', 'Australia');

-- Task 8
SELECT productCode, productName 
FROM products 
WHERE MSRP > 100;

-- Task 9
SELECT orderNumber, orderDate, requiredDate 
FROM orders 
WHERE DATEDIFF(requiredDate, orderDate) >= 7;

-- Task 10
SELECT productLine 
FROM productlines 
WHERE productLine LIKE '%Classic%';

-- Task 11
SELECT customerName, creditLimit 
FROM customers 
WHERE creditLimit > 100000 
ORDER BY creditLimit DESC;

-- Task 12
SELECT employeeNumber, lastName, firstName, officeCode, jobTitle 
FROM employees 
WHERE jobTitle <> 'Sales Rep' AND officeCode = '4';

-- Task 13
SELECT productCode, productName, MSRP 
FROM products 
WHERE productName LIKE '%Mercedes%' AND MSRP < 100;

-- Task 14
SELECT customerNumber, customerName, contactLastName 
FROM customers 
WHERE contactLastName LIKE '%y';

-- Task 15
SELECT orderNumber, status 
FROM orders 
WHERE status IN ('In Process', 'On Hold');








