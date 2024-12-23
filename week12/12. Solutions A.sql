-- Task 1. -> classicmodels database
-- A customer changed their billing address after an order was placed.
-- You need to update the customer's address in the customers table and
-- ensure the corresponding shipping information in the orders table is updated as well. 
-- Ensure no partial updates occur, and roll back the transaction if any part fails.
START TRANSACTION;

UPDATE customers 
SET addressLine1 = 'New Street 22', city = 'New City 2'
WHERE customerNumber = 103;

UPDATE orders 
SET shipAddress = 'New Street 22', shipCity = 'New City 2'
WHERE customerNumber = 103;

COMMIT;
-- In case of an error:
ROLLBACK;

-- Task 2. -> classicmodels database
-- Let’s imagine the scenario where an order was mistakenly assigned to the wrong customer.
-- You need to update the orders table to reflect the correct customer and ensure no partial updates occur.
START TRANSACTION;

UPDATE orders 
SET customerNumber = 103
WHERE orderNumber = 10100

COMMIT;
-- In case of an error:
ROLLBACK;

-- Task 3. -> sakila database
-- A customer rents a movie from the store. You need to insert records into
-- the rental and payment tables, ensuring that both operations are completed successfully.
-- If any part of the transaction fails, roll back the entire operation.
START TRANSACTION;

INSERT INTO rental (rental_date, inventory_id, customer_id, return_date, staff_id)
VALUES (NOW(), 150, 300, NULL, 2);

INSERT INTO payment (customer_id, staff_id, rental_id, amount, payment_date)
VALUES (300, 2, LAST_INSERT_ID(), 4.99, NOW());

COMMIT;
-- In case of an error:
ROLLBACK;

-- Task 4. -> sakila database
-- Add a new film to the database, along with its categories and actors. Ensure that all records
-- are inserted consistently. If any part of the transaction fails, roll back the entire operation.
START TRANSACTION;

INSERT INTO film 
    (title, description, release_year, language_id, rental_duration, rental_rate, length, replacement_cost, rating, special_features)
VALUES 
    ('The Great Adventure', 'An epic adventure film', 2024, 1, 6, 4.99, 120, 19.99, 'PG', 'Behind the Scenes');

INSERT INTO film_category (film_id, category_id)
VALUES (LAST_INSERT_ID(), 5),
       (LAST_INSERT_ID(), 8);

INSERT INTO film_actor (actor_id, film_id)
VALUES (12, LAST_INSERT_ID()),
       (15, LAST_INSERT_ID()),
       (20, LAST_INSERT_ID());

COMMIT;
-- In case of an error:
ROLLBACK;

-- Task 5. -> employees database
-- An employee is promoted, and both their title and salary need to be updated.
-- Ensure that the promotion and salary changes are applied together. 
-- If either update fails, roll back the entire transaction.
START TRANSACTION;

UPDATE titles 
SET title = 'Senior Engineer', to_date = CURDATE()
WHERE emp_no = 10001 AND to_date = '9999-01-01';

UPDATE salaries 
SET salary = 90000, to_date = CURDATE()
WHERE emp_no = 10001 AND to_date = '9999-01-01';

COMMIT;
-- In case of an error:
ROLLBACK;

-- Task 6. -> employees database
-- A new employee is being added to the company. You need to insert records into
-- the employees, salaries, and titles tables. Use transaction chaining to ensure that
-- the employee is inserted first, and then the salary and title, sequentially.
-- If any step fails, rollback to avoid partial updates.
START TRANSACTION;

INSERT INTO employees (emp_no, birth_date, first_name, last_name, gender, hire_date)
VALUES (10050, '1985-08-23', 'John', 'Doe', 'M', CURDATE());

COMMIT AND CHAIN;

INSERT INTO salaries (emp_no, salary, from_date, to_date)
VALUES (10050, 60000, CURDATE(), '9999-01-01');

COMMIT AND CHAIN;

INSERT INTO titles (emp_no, title, from_date, to_date)
VALUES (10050, 'Engineer', CURDATE(), '9999-01-01');

COMMIT;
-- In case of an error:
ROLLBACK;

