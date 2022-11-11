SELECT * FROM sakila.actor;

USE sakila;

SELECT * FROM actor;

SELECT first_name, actor_id FROM actor;

SELECT first_name, last_name FROM actor
ORDER BY first_name, last_name;

SELECT first_name, last_name FROM actor
ORDER BY first_name ASC, last_name DESC;

SELECT first_name, last_name FROM actor
ORDER BY first_name ASC, last_name DESC
LIMIT 3;

SELECT first_name AS "Nombre", last_name AS 'Apellido' FROM actor
ORDER BY 1 ASC, last_name DESC
LIMIT 3;

SELECT * FROM film;

SELECT title, release_year, length FROM film
WHERE length > 120;

SELECT title, release_year, length FROM film
WHERE length > 120 AND title LIKE '%S';

SELECT title, release_year, length FROM film
WHERE length > 120 AND title REGEXP '^B.A.*';

SELECT title, release_year, length FROM film
WHERE length > 120 AND title REGEXP 'B.A.*';

SELECT title, release_year, `length`, rental_duration FROM film
WHERE CAST(length AS DECIMAL) > 120 OR rental_duration IN (6, 7, 8);

SELECT title, release_year, `length`, rental_duration FROM film
WHERE CAST(length AS DECIMAL) > 120 OR rental_duration IN (6, 7, 8);

SELECT title, release_year, `length`, original_language_id, rental_duration FROM film
WHERE original_language_id IS NOT NULL;

SELECT * FROM film;

SELECT title, CASE WHEN title REGEXP '^[A-L]' THEN rental_rate ELSE replacement_cost*1000 END AS identifier, release_year FROM film;

SELECT title, CASE WHEN title REGEXP '^[A-L]' THEN rental_rate WHEN title REGEXP '^[W-Z]' THEN release_year END AS identifier, release_year FROM film;

SELECT AVG(rental_duration) FROM film;

SELECT AVG(rental_duration), rating FROM film
GROUP BY rating;

SELECT * FROM film;

SELECT AVG(rental_duration) AS renta_promedio, MAX(length), MIN(length), SUM(replacement_cost), rating, MIN(title)
FROM film
GROUP BY rating;


SELECT rating, rental_duration, MAX(length) AS duracion_maxima, MIN(length), SUM(replacement_cost), MIN(title), COUNT(rating), COUNT(rental_duration), COUNT(*), COUNT(1)
FROM film
GROUP BY rating, rental_duration
ORDER BY rating, rental_duration;

SELECT rating, rental_duration, MAX(length) AS duracion_maxima, MIN(length), SUM(replacement_cost), MIN(title), COUNT(rating), COUNT(rental_duration), COUNT(*), COUNT(1)
FROM film
GROUP BY rating, rental_duration
HAVING duracion_maxima > 180
ORDER BY rating, rental_duration;

SELECT rating, rental_duration, MAX(length) AS duracion_maxima, MIN(length), SUM(replacement_cost), MIN(title), COUNT(rating), COUNT(rental_duration), COUNT(*), COUNT(1)
FROM film
WHERE length > 150
GROUP BY rating, rental_duration
HAVING duracion_maxima > 180
ORDER BY rating, rental_duration;

SELECT * FROM film
WHERE release_year = 2006;

SELECT title, CASE WHEN title REGEXP '^[A-L]' THEN rental_rate
WHEN title REGEXP '^[W-Z]' THEN release_year END AS identifier, release_year
FROM film
HAVING identifier < 1;


SELECT * FROM film;

SELECT * FROM language;

SELECT title, release_year, f.language_id, rating, `name`, l.last_update
FROM film f
JOIN `language` l ON f.language_id = l.language_id
ORDER BY `name` DESC;

SELECT title, release_year, f.language_id, rating, `name`, l.last_update
FROM film f
RIGHT JOIN `language` l ON f.language_id = l.language_id
ORDER BY `name` DESC;

SELECT title, 
release_year as TOTAL, language_id, rating, `name`, l.last_update
FROM film f
RIGHT JOIN `language` l USING(language_id)
ORDER BY `name` DESC;

SELECT *
FROM film f
RIGHT JOIN `language` l USING(language_id)
ORDER BY `name` DESC;


SELECT first_name AS nombre, last_name AS apellido, rental_date as fecha, title as pelicula, f.last_update
FROM customer c
JOIN rental r USING(customer_id)
JOIN inventory i USING(inventory_id)
JOIN film f USING(film_id)
ORDER BY nombre;

SELECT * FROM customer
JOIN rental ON customer.store_id != rental.rental_id AND customer.customer_id > rental.customer_id;


SELECT cust.customer_id AS codigo_cliente, cust.first_name as nombre, inventory.film_id AS id_pelicula, r.return_date AS fecha_regreso
FROM (customer AS cust
JOIN rental r ON cust.customer_id = r.customer_id
JOIN inventory ON cust.store_id = inventory.store_id AND cust.store_id < r.rental_id AND cust.customer_id != cust.store_id);

SELECT MIN(first_name), store_id FROM customer
GROUP BY store_id;

SELECT * FROM customer
WHERE store_id = 1;

SELECT * FROM customer
WHERE store_id = 2;

SELECT * FROM customer
ORDER BY store_id;

SELECT title, language_id, original_language_id, IFNULL(original_language_id, title) FROM film;

 select concat(`c`.`city`,_utf8mb4',',`cy`.`country`) AS `store`,concat(`m`.`first_name`,_utf8mb4' ',`m`.`last_name`) AS `manager`,sum(`p`.`amount`) AS `total_sales`
 from (((((((`sakila`.`payment` `p`
 join `sakila`.`rental` `r` on((`p`.`rental_id` = `r`.`rental_id`)))
 join `sakila`.`inventory` `i` on((`r`.`inventory_id` = `i`.`inventory_id`)))
 join `sakila`.`store` `s` on((`i`.`store_id` = `s`.`store_id`)))
 join `sakila`.`address` `a` on((`s`.`address_id` = `a`.`address_id`)))
 join `sakila`.`city` `c` on((`a`.`city_id` = `c`.`city_id`)))
 join `sakila`.`country` `cy` on((`c`.`country_id` = `cy`.`country_id`)))
 join `sakila`.`staff` `m` on((`s`.`manager_staff_id` = `m`.`staff_id`)))
 group by `s`.`store_id`
 order by `cy`.`country`,`c`.`city`;
 
 SELECT * FROM sales_by_store;
 
 SELECT * FROM actor_info;
 
CREATE TEMPORARY TABLE rentas_clientes
SELECT customer_id, first_name AS nombre, last_name AS apellido, rental_date as fecha, title as pelicula
FROM customer c
JOIN rental r USING(customer_id)
JOIN inventory i USING(inventory_id)
JOIN film f USING(film_id)
ORDER BY nombre;

CREATE TABLE rentas_clientes2
SELECT customer_id, first_name AS nombre, last_name AS apellido, rental_date as fecha, title as pelicula
FROM customer c
JOIN rental r USING(customer_id)
JOIN inventory i USING(inventory_id)
JOIN film f USING(film_id)
ORDER BY nombre;

SELECT * FROM rentas_clientes;

SELECT * FROM customer
JOIN rentas_clientes USING(customer_id);


SELECT * FROM customer
JOIN (SELECT customer_id, first_name AS nombre, last_name AS apellido, rental_date as fecha, title as pelicula
FROM customer c
JOIN rental r USING(customer_id)
JOIN inventory i USING(inventory_id)
JOIN film f USING(film_id)
ORDER BY nombre) ren
 USING(customer_id);
 
SELECT * FROM customer
JOIN (SELECT customer_id, first_name AS nombre, last_name AS apellido, rental_date as fecha, title as pelicula
FROM customer c
JOIN rental r USING(customer_id)
JOIN inventory i USING(inventory_id)
JOIN film f USING(film_id)
ORDER BY nombre) ren
 USING(customer_id);
 
DROP TABLE rentas_clientes2;

CREATE TABLE rentas_clientes2
SELECT customer_id, first_name AS nombre, last_name AS apellido, rental_date as fecha, title as pelicula
FROM customer c
JOIN rental r USING(customer_id)
JOIN inventory i USING(inventory_id)
JOIN film f USING(film_id)
ORDER BY nombre;

SELECT * FROM rentas_clientes2;

DELETE FROM rentas_clientes2;

DROP TABLE rentas_clientes2;

TRUNCATE TABLE rentas_clientes2;

DELETE FROM rentas_clientes2
WHERE customer_id < 400;

SELECT * FROM rentas_clientes2
ORDER BY customer_id;

INSERT INTO rentas_clientes2
VALUES (399, "ALGO", "APELLIDO", DATE("2005-02-28"), "UNA PELICULA");

INSERT INTO rentas_clientes2
VALUES (399, "ALGO", "APELLIDO", "2005-02-28", "UNA PELICULA");

SELECT COUNT(*) FROM rentas_clientes2;

SELECT * FROM rentas_clientes2
WHERE fecha  > DATE("2005-08-11");

SELECT * FROM rentas_clientes2
WHERE CONCAT(YEAR(fecha),"-", MONTH(fecha)) >= "2005-8";

SELECT * FROM rentas_clientes2
WHERE DATE_FORMAT(fecha, '%Y-%m') BETWEEN "2005-07" AND "2006-01";

SELECT * FROM rentas_clientes2;

SELECT * FROM rentas_clientes
WHERE customer_id < 400;

INSERT INTO rentas_clientes2
SELECT * FROM rentas_clientes
WHERE customer_id < 400;

SELECT * FROM rentas_clientes2
ORDER BY customer_id;

SELECT renta.nombre AS otro FROM rentas_clientes2 renta
ORDER BY customer_id;

SELECT * FROM rentas_clientes;

ALTER TABLE rentas_clientes
RENAME COLUMN fecha TO fecha_renta;

SELECT * FROM rentas_clientes;

ALTER TABLE rentas_clientes2
RENAME COLUMN fecha TO fecha_renta;

SELECT nombre, apellido, MIN(fecha_renta) AS primer_renta, COUNT(*) AS numero_rentas
FROM rentas_clientes2
GROUP BY nombre, apellido;

-- Min para sacar minimo fechas es decir primera renta
-- Count para contar cuantas veces aparece cada nombre, apellido es decir cuantas veces ha rentado la persona
CREATE TABLE numero_rentas_clientes
SELECT nombre, apellido, MIN(fecha_renta) AS primer_renta, COUNT(*) AS numero_rentas
FROM rentas_clientes2
GROUP BY nombre, apellido;

SELECT * FROM numero_rentas_clientes;

UPDATE numero_rentas_clientes
SET numero_rentas = numero_rentas + 1;

SELECT * FROM numero_rentas_clientes;

UPDATE numero_rentas_clientes
SET numero_rentas = numero_rentas - 1
WHERE apellido LIKE 'C%';

SELECT * FROM numero_rentas_clientes;

SELECT ADDDATE(primer_renta, INTERVAL 1 MONTH) FROM numero_rentas_clientes;

-- ADDDATE para agregar mes (se puede cambiar month por otra unidad)
UPDATE numero_rentas_clientes
SET primer_renta = ADDDATE(primer_renta, INTERVAL 1 MONTH)
WHERE numero_rentas >= 30;

SELECT * FROM numero_rentas_clientes;

SELECT * FROM rentas_clientes2;

SELECT nombre, apellido, MIN(fecha_renta) AS primer_renta, COUNT(*) AS numero_rentas
FROM rentas_clientes2
GROUP BY nombre, apellido
ORDER BY nombre, apellido;

-- Window functions
SELECT nombre, apellido, fecha_renta, pelicula,
MIN(fecha_renta) OVER(PARTITION BY nombre, apellido) AS primer_renta,
COUNT(*) OVER(PARTITION BY nombre, apellido) AS numero_rentas
FROM rentas_clientes2
ORDER BY nombre, apellido;

SELECT nombre, apellido, fecha_renta, pelicula,
MIN(fecha_renta) OVER(PARTITION BY nombre, apellido) AS primer_renta,
COUNT(*) OVER(PARTITION BY nombre, apellido) AS numero_rentas,
ROW_NUMBER() OVER(PARTITION BY nombre, apellido ORDER BY fecha_renta) AS flag
FROM rentas_clientes2
ORDER BY nombre, apellido;

-- Se agrega columna primer_renta, numero_rentas y flag (flag se usa para filtrar posteriormente)
CREATE TEMPORARY TABLE rentas_info_extra
SELECT nombre, apellido, fecha_renta, pelicula,
MIN(fecha_renta) OVER(PARTITION BY nombre, apellido) AS primer_renta,
COUNT(*) OVER(PARTITION BY nombre, apellido) AS numero_rentas,
ROW_NUMBER() OVER(PARTITION BY nombre, apellido ORDER BY fecha_renta) AS flag
FROM rentas_clientes2
ORDER BY nombre, apellido;

SELECT * FROM rentas_info_extra;

SELECT * FROM rentas_info_extra
WHERE flag = 1;

-- Guardar window en variable clientes
SELECT nombre, apellido, fecha_renta, pelicula,
MIN(fecha_renta) OVER(clientes) AS primer_renta,
COUNT(*) OVER(clientes) AS numero_rentas
FROM rentas_clientes2
WINDOW clientes AS(PARTITION BY nombre, apellido)
ORDER BY nombre, apellido;