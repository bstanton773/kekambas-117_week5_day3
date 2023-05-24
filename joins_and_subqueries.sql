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

