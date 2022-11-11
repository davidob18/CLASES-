SELECT * FROM actor;

SELECT first_name, actor_id FROM actor;

SELECT first_name, last_name FROM actor
ORDER BY first_name ASC, last_name DESC;

SELECT first_name, last_name FROM actor
ORDER BY first_name ASC, last_name DESC
LIMIT 3;

SELECT first_name, last_name FROM actor
ORDER BY 1 ASC, last_name DESC
LIMIT 3;


SELECT first_name as "Nombres" , last_name AS 'Apellido' FROM actor
ORDER BY 1 ASC, last_name DESC
LIMIT 10;

SELECT title, release_year, `length`, rental_duration FROM film
WHERE CAST(length AS DECIMAL) > 120 OR rental_duration IN (6, 7, 8);


SELECT title, CASE WHEN title REGEXP '^[A-L]' 
THEN rental_rate ELSE replacement_cost*1000 
END AS identifier, 
release_year FROM film;

SELECT AVG(rental_duration) AS renta_promedio, MAX(length), MIN(length), SUM(replacement_cost), rating, MIN(title)
FROM film
GROUP BY rating;


SELECT rating, rental_duration, MAX(length), MIN(length), SUM(replacement_cost), MIN(title), COUNT(rating), COUNT(rental_duration), COUNT(*), COUNT(1)
FROM film
GROUP BY rating, rental_duration
ORDER BY rating, rental_duration;





