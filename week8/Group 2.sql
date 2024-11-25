USE classicmodels;

-- Task 1
SELECT
    c.customerName,
    c.city,
    o.orderNumber,
    o.orderDate
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
WHERE YEAR(o.orderDate) = 2005
ORDER BY c.customerName ASC;



-- Task 2
SELECT
    p.productCode,
    p.productName,
    o.orderNumber,
    o.orderDate,
    od.quantityOrdered
FROM products p
JOIN orderdetails od ON p.productCode = od.productCode
JOIN orders o ON od.orderNumber = o.orderNumber
WHERE o.status = 'Shipped'
ORDER BY p.productCode ASC;


USE sakila;

-- Task 3
SELECT
    c.first_name AS customerFirstName,
    c.last_name AS customerLastName,
    r.rental_date,
    r.return_date,
    f.title AS filmTitle
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
ORDER BY r.rental_date DESC;


-- Task 4
SELECT
    s.first_name  AS staffFirstName,
    s.last_name  AS staffLastName,
    s.email AS staffEmail,
    st.manager_staff_id,
    m.first_name  AS managerFirstName,
    m.last_name  AS managerLastName
FROM staff s
JOIN store st ON s.store_id = st.store_id
JOIN staff m ON st.manager_staff_id = m.staff_id
ORDER BY s.first_name  ASC, s.last_name  ASC;

-- Task 5
SELECT 
    customer.customer_id,
    customer.first_name,
    customer.last_name,
    store.store_id
FROM 
    customer
JOIN 
    store ON customer.store_id = store.store_id
ORDER BY 
    customer.last_name ASC;


-- Task 6
SELECT 
    rental.rental_id,
    rental.rental_date,
    customer.first_name,
    customer.last_name
FROM 
    rental
JOIN 
    customer ON rental.customer_id = customer.customer_id
ORDER BY 
    rental.rental_date DESC;

   
-- Task 7
SELECT 
    film.film_id,
    film.title,
    category.name AS category_name,
    film.description
FROM 
    film
JOIN 
    film_category ON film.film_id = film_category.film_id
JOIN 
    category ON film_category.category_id = category.category_id
ORDER BY 
    film.title ASC;

-- Task 8
SELECT 
    actor.actor_id,
    actor.first_name,
    actor.last_name,
    film.title
FROM 
    actor
JOIN 
    film_actor ON actor.actor_id = film_actor.actor_id
JOIN 
    film ON film_actor.film_id = film.film_id
WHERE 
    film.title = 'Academy Dinosaur';

-- Task 9
SELECT 
    staff.staff_id,
    staff.first_name,
    staff.last_name,
    staff.store_id,
    address.address
FROM 
    staff
JOIN 
    address ON staff.address_id = address.address_id;

-- Task 10
SELECT 
    film.title,
    rental.rental_date,
    rental.return_date
FROM 
    film
JOIN 
    inventory ON film.film_id = inventory.film_id
JOIN 
    rental ON inventory.inventory_id = rental.inventory_id
ORDER BY 
    rental.rental_date DESC;
   
-- Task 11
SELECT 
    film.title,
    actor.first_name,
    actor.last_name
FROM 
    film
JOIN 
    film_category ON film.film_id = film_category.film_id
JOIN 
    category ON film_category.category_id = category.category_id
JOIN 
    film_actor ON film.film_id = film_actor.film_id
JOIN 
    actor ON film_actor.actor_id = actor.actor_id
WHERE 
    category.name = 'Action';

-- Task 12
SELECT 
    customer.first_name,
    customer.last_name,
    film.title,
    rental.rental_date
FROM 
    customer
JOIN 
    rental ON customer.customer_id = rental.customer_id
JOIN 
    inventory ON rental.inventory_id = inventory.inventory_id
JOIN 
    film ON inventory.film_id = film.film_id
ORDER BY 
    rental.rental_date ASC;
  
-- Task 13
SELECT 
    film.title,
    inventory.store_id,
    inventory.inventory_id
FROM 
    film
JOIN 
    inventory ON film.film_id = inventory.film_id;


-- Task 14
SELECT 
    film.title,
    customer.first_name,
    customer.last_name,
    rental.rental_date
FROM 
    film
JOIN 
    inventory ON film.film_id = inventory.film_id
JOIN 
    rental ON inventory.inventory_id = rental.inventory_id
JOIN 
    customer ON rental.customer_id = customer.customer_id
JOIN 
    address ON customer.address_id = address.address_id
JOIN 
    city ON address.city_id = city.city_id
WHERE 
    city.city = 'Aurora';

-- Task 15
SELECT 
    film.title,
    customer.first_name,
    customer.last_name,
    city.city,
    rental.rental_date
FROM 
    film
JOIN 
    inventory ON film.film_id = inventory.film_id
JOIN 
    rental ON inventory.inventory_id = rental.inventory_id
JOIN 
    customer ON rental.customer_id = customer.customer_id
JOIN 
    address ON customer.address_id = address.address_id
JOIN 
    city ON address.city_id = city.city_id
JOIN 
    country ON city.country_id = country.country_id
WHERE 
    country.country = 'Canada'
ORDER BY 
    city.city ASC, rental.rental_date DESC;

