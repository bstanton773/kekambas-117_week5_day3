SELECT *
FROM actor;

SELECT *
FROM film;

SELECT *
FROM film_actor;

-- Join the actor table to the film_actor via the actor_id 
SELECT *
FROM film_actor fa 
JOIN actor a
ON a.actor_id = fa.actor_id;

-- Join the film table to the film_actor via the film_id
SELECT *
FROM film_actor fa
JOIN film f
ON f.film_id = fa.film_id;


-- Multi Join 
SELECT f.title, f.release_year, f.film_id, fa.film_id, fa.actor_id, a.actor_id, a.first_name, a.last_name
FROM film_actor fa
JOIN actor a 
ON fa.actor_id = a.actor_id 
JOIN film f
ON fa.film_id = f.film_id;

SELECT a.first_name, a.last_name, MAX(f.release_year)
FROM film_actor fa
JOIN actor a 
ON fa.actor_id = a.actor_id 
JOIN film f
ON fa.film_id = f.film_id
GROUP BY a.first_name, a.last_name;


-- Display customer name and film they rented -- customer -> rental -> inventory -> film
SELECT *
FROM rental;

SELECT r.rental_id, r.rental_date, r.customer_id, c.customer_id, c.first_name, c.last_name, r.inventory_id, i.inventory_id, i.film_id, f.film_id, f.title
FROM rental r
JOIN customer c
ON r.customer_id = c.customer_id 
JOIN inventory i 
ON i.inventory_id = r.inventory_id 
JOIN film f
ON i.film_id = f.film_id;


SELECT *
FROM inventory;



-- SUBQUERIES!!!
-- Subqueries are queries that happen within another query

-- Ex. Which films have exactly 12 actors in them?

-- Step 1. Get the IDs of the films that have exactly 12 actors
SELECT film_id, COUNT(*)
FROM film_actor
GROUP BY film_id
HAVING COUNT(*) = 12;

--film_id|
---------+
--    529|
--    802|
--     34|
--    892|
--    414|
--    517|

-- Step 2. Get the films from the film table that have those IDs
SELECT *
FROM film 
WHERE film_id IN (
	529,
	802,
	34,
	892,
	414,
	517
);


-- Create a subquery: Combine the two steps into one query. The query that you want to execute FIRST
-- is the subquery.  ** Subquery must return only ONE column **    *unless used in a FROM clause 

SELECT *
FROM film 
WHERE film_id IN (
	SELECT film_id
	FROM film_actor
	GROUP BY film_id
	HAVING COUNT(*) = 12
);


-- What employee sold the most rentals (use the rental table)?
SELECT *
FROM staff 
WHERE staff_id = (
	SELECT staff_id
	FROM rental
	GROUP BY staff_id
	ORDER BY COUNT(*) DESC
	LIMIT 1
);

-- Show the employee and the number of rentals
SELECT first_name, last_name, COUNT(*)
FROM staff 
JOIN rental
ON staff.staff_id = rental.staff_id
GROUP BY first_name, last_name
ORDER BY COUNT(*) DESC 
LIMIT 1;


-- Use subqueries for calculations
-- List out all of the payments that are more thatn the average payment amount
SELECT *
FROM payment 
WHERE amount > (
	SELECT AVG(amount)
	FROM payment
);


-- Subqueries with the FROM clause
-- *Subquery in FROM must have an alias*

-- Find the average number of rentals per customer.

-- Step 1. Get the count of customer rentals
SELECT customer_id, COUNT(*) AS num_rentals
FROM rental
GROUP BY customer_id;

-- Step 2. Use the temp table from step 1 as a subquery to query from
SELECT AVG(num_rentals)
FROM ( 
	SELECT customer_id, COUNT(*) AS num_rentals
	FROM rental
	GROUP BY customer_id
) AS customer_rental_totals;



-- Setup for Example - Add loyalty_member boolean column to customer table
ALTER TABLE customer 
ADD COLUMN loyalty_member BOOLEAN;

UPDATE customer
SET loyalty_member = FALSE;

-- Using subqueries in DML Statements

-- Update all customers who have made 25 or more rentals to be a loyalty member 

-- Step 1. Find all customer ids of the customers who have made 25 or more rentals
SELECT customer_id
FROM rental 
GROUP BY customer_id
HAVING COUNT(*) >= 25;

-- Step 2. Update the customer table by setting loyalty member = true if a customer is in the above subquery result
UPDATE customer 
SET loyalty_member = TRUE 
WHERE customer_id IN (
	SELECT customer_id
	FROM rental 
	GROUP BY customer_id
	HAVING COUNT(*) >= 25
);

-- Confirm update loyalty member status
SELECT *
FROM customer 
WHERE loyalty_member;



-- Multi Query

-- customers who have rented more than average
SELECT *
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM rental 
	GROUP BY customer_id 
	HAVING COUNT(*) > (
		SELECT AVG(num_rentals)
		FROM (
			SELECT customer_id, COUNT(*) AS num_rentals
			FROM rental
			GROUP BY customer_id
		) AS customer_rental_totals
	)
);


-- Join and Subqueries are friendly
SELECT c.first_name, c.last_name, COUNT(*)
FROM rental r
JOIN customer c
ON c.customer_id = r.customer_id
GROUP BY c.first_name, c.last_name 
HAVING COUNT(*) > (
	SELECT AVG(num_rentals)
	FROM (
		SELECT customer_id, COUNT(*) AS num_rentals
		FROM rental
		GROUP BY customer_id
	) AS customer_rental_totals
);

