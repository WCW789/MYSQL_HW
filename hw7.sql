USE sakila;

-- 1a
select first_name, last_name 
from actor;

-- 1b
select 
	concat(first_name,' ',last_name) `Actor Name`
from actor;

-- 2a
select actor_id, first_name, last_name 
from actor
where first_name = "Joe";

-- 2b
select
	concat(first_name,' ',last_name) `Actor Name`
from actor
where last_name like "%GEN%";

-- 2c
select
	concat(last_name,', ',first_name) `Actor Name`
from actor
where last_name like "%LI%";

-- 2d
select country_id, country
from country
where country in ('Afghanistan', 'Bangladesh', 'China');

-- 3a
ALTER TABLE actor ADD description BLOB(100);

-- 3b
ALTER TABLE actor DROP COLUMN description;

-- 4a
SELECT last_name , COUNT(*) AS count 
FROM actor 
GROUP BY last_name 
ORDER BY count DESC;

-- 4b
SELECT last_name , COUNT(*) AS count 
FROM actor 
GROUP BY last_name 
having COUNT(*) > 1
ORDER BY count DESC;

-- 4c
update actor 
set first_name="HARPO"
where first_name = "GROUCHO" and LAST_NAME = "WILLIAMS";

-- 4d
update actor 
set first_name="GROUCHO"
where first_name = "HARPO" and LAST_NAME = "WILLIAMS";

-- 5a
SHOW CREATE TABLE address;

-- 6a
SELECT first_name, last_name, address
FROM staff
	JOIN address USING (address_id);
    
-- 6b
SELECT concat(first_name,' ',last_name) `Staff Name`, SUM(amount), payment_date
FROM staff
	JOIN payment USING (staff_id)
WHERE payment_date LIKE "%05-08%"
GROUP BY `Staff Name`;

-- 6c
SELECT title, COUNT(actor_id)
FROM film_actor
	INNER JOIN film USING (film_id)
GROUP BY title;

-- 6d
SELECT title, count(inventory_id)
FROM film
	INNER JOIN inventory USING (film_id)
WHERE title = "Hunchback Impossible";

-- 6e
SELECT concat(first_name,' ',last_name) `Customer Name`, SUM(amount)
FROM payment
	JOIN customer USING (customer_id)
GROUP BY `Customer Name`
ORDER BY last_name ASC;

-- 7a
select title
from film 
where title LIKE "K%" or title LIKE "Q%" and language_id in 
(
	select language_id
	from language
	where name = 'English'
);

-- 7b
select concat(first_name,' ',last_name) `Actor`
from actor
where actor_id in 
(
	select actor_id
	from film_actor
	where film_id in
    (
		select film_id
		from film
		where title = 'Alone Trip'
	)
);

-- 7c
select first_name, last_name, email
from customer
	INNER JOIN address USING (address_id)
	INNER JOIN city USING (city_id)
    INNER JOIN country USING (country_id)
where country = "Canada";

select country 
from country;

-- 7d
select title, name
from film
	INNER JOIN film_category USING (film_id)
    INNER JOIN category USING (category_id)
where name = "Family";

-- 7e
select title, count(rental_id)
from film
	INNER JOIN inventory USING (film_id)
	INNER JOIN rental USING (inventory_id)
group by title
order by count(rental_id) desc;

-- 7f
select store_id, sum(amount)
from store
	INNER JOIN inventory USING (store_id)
	INNER JOIN rental USING (inventory_id)
	INNER JOIN payment USING (rental_id)
group by store_id;

-- 7g
select store_id, city, country
from store
	INNER JOIN address USING (address_id)
	INNER JOIN city USING (city_id)
	INNER JOIN country USING (country_id)
group by store_id;

-- 7h
select name, sum(amount)
from payment
	INNER JOIN rental USING (rental_id)
	INNER JOIN inventory USING (inventory_id)
	INNER JOIN film_category USING (film_id)
    INNER JOIN category USING (category_id)
group by name
ORDER BY sum(amount) DESC
LIMIT 5;

-- 8a
Create View Top_Five_Genres as
	select name, sum(amount)
	from payment
		INNER JOIN rental USING (rental_id)
		INNER JOIN inventory USING (inventory_id)
		INNER JOIN film_category USING (film_id)
		INNER JOIN category USING (category_id)
	group by name
	ORDER BY sum(amount) DESC
	LIMIT 5;
    
-- 8b
SELECT *
FROM Top_Five_Genres;

-- 8c
DROP VIEW IF EXISTS
    Top_Five_Genres
