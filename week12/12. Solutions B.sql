-- Task 1. -> classicmodels database
-- A new product is being added to the product catalog, and you also need to insert
-- corresponding records in the productlines table to ensure product categories are updated.
-- If the product insertion or productline update fails, rollback the entire transaction.
START TRANSACTION;

INSERT INTO
    products (
        productCode,
        productName,
        productLine,
        productScale,
        productVendor,
        productDescription,
        quantityInStock,
        buyPrice,
        MSRP
    )
VALUES (
        'S24_9999',
        'New Porsche',
        'Classic Cars',
        '1:24',
        'Vendor Y',
        'A high-quality german car',
        150,
        50.00,
        95.00
    );

UPDATE productlines
SET
    textDescription = 'Updated Classic Cars Description'
WHERE
    productLine = 'Classic Cars';

COMMIT;
-- In case of an error:
ROLLBACK;

-- Task 2. -> classicmodels database
-- A customer made a payment, but it was recorded incorrectly. You need to correct the payment amount
-- in the payments table. After correcting the payment, update the status of the associated order.
-- Both updates must succeed, and the operation must roll back if any part fails.
START TRANSACTION;

UPDATE payments
SET
    amount = 3500.00
WHERE
    customerNumber = 103
    AND checkNumber = 'HQ336336';

UPDATE orders SET status = 'Paid' WHERE orderNumber = 10100;

COMMIT;
-- In case of an error:
ROLLBACK;

-- Task 3. -> sakila database
-- A customer rents a movie but requests an extension on the rental period. You need to update
-- the rental table to reflect the new return date, and if an additional charge is applied
-- for the extension, update the payment table accordingly. If either update fails,
-- the entire transaction should be rolled back.
START TRANSACTION;

UPDATE rental
SET
    return_date = DATE_ADD(return_date, INTERVAL 5 DAY)
WHERE
    rental_id = 1000;
-- Specific rental_id to be updated

INSERT INTO
    payment (
        customer_id,
        staff_id,
        rental_id,
        amount,
        payment_date
    )
VALUES (300, 2, 1000, 2.99, NOW());

COMMIT;
-- In case of an error:
ROLLBACK;

-- Task 4. -> sakila database
-- You need to update the last name of an actor in the actor table.
-- If the update fails, you should roll back to a savepoint.
START TRANSACTION;

SAVEPOINT before_update;

UPDATE actor SET last_name = 'Smith' WHERE actor_id = 100;

ROLLBACK TO before_update;

COMMIT;

-- Task 5. -> employees database
-- An employee is transferred to a new department. You need to update the dept_emp
-- and dept_manager tables. Use a savepoint to ensure that if the second update (to dept_manager) fails,
-- you can roll back to the first update (in dept_emp), without losing the transfer in dept_emp.
START TRANSACTION;

UPDATE dept_emp
SET
    dept_no = 'd004',
    to_date = CURDATE()
WHERE
    emp_no = 10005
    AND to_date = '9999-01-01';

SAVEPOINT after_dept_emp_update;

UPDATE dept_manager
SET
    dept_no = 'd004',
    to_date = CURDATE()
WHERE
    emp_no = 10005
    AND to_date = '9999-01-01';

ROLLBACK TO after_dept_emp_update;

COMMIT;

-- Task 6. -> employees database
-- An employee is leaving the company, and you need to delete their records from the employees,
-- salaries, and titles tables. Use transaction chaining to delete each record one at a time,
-- committing after each successful step, and rolling back if any step fails.
START TRANSACTION;

DELETE FROM salaries WHERE emp_no = 10007;

COMMIT AND CHAIN;

DELETE FROM titles WHERE emp_no = 10007;

COMMIT AND CHAIN;

DELETE FROM employees WHERE emp_no = 10007;

COMMIT;