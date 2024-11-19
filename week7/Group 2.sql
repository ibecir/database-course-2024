-- Task 1
SELECT orderNumber, orderDate, customerNumber, status
FROM orders
WHERE orderDate BETWEEN '2003-01-13' AND '2004-06-09'
  AND status != 'Cancelled';

-- Task 2
SELECT orderNumber, orderDate, customerNumber, status
FROM orders
WHERE customerNumber IN (103, 112, 114);

-- Task 3
SELECT productCode, quantityOrdered
FROM orderdetails
ORDER BY quantityOrdered DESC;

-- Task 4
SELECT customerNumber, checkNumber, paymentDate, amount
FROM payments
WHERE amount > 5000;

-- Task 5
SELECT * 
FROM customers 
WHERE country = 'Germany';

-- Task 6
SELECT customerNumber, customerName, phone 
FROM customers 
WHERE creditLimit < 50000;

-- Task 7
SELECT * 
FROM orders 
WHERE status = 'On Hold';

-- Task 8
SELECT customerName 
FROM customers 
WHERE customerName LIKE 'A%';

-- Task 9
SELECT * 
FROM products 
WHERE productScale = '1:18';

-- Task 10
SELECT * 
FROM payments 
WHERE amount BETWEEN 5000 AND 10000 AND checkNumber LIKE "H%";

-- Task 11
SELECT productName, MSRP 
FROM products 
WHERE MSRP > 200 AND productName  LIKE "%1%";

-- Task 12
SELECT customerName, contactFirstName 
FROM customers 
WHERE contactFirstName LIKE 'M%' AND customerName LIKE "%Co.";

-- Task 13
SELECT * 
FROM employees 
WHERE officeCode = '1';

-- Task 14
SELECT * 
FROM orders 
WHERE YEAR(orderDate) = 2003 AND status <> "Cancelled";

-- Task 15
SELECT * 
FROM offices 
WHERE country <> 'USA' AND city LIKE "%y%";








