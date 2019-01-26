-- SQL Homework 1 --

use sakila;

-- 1a.
describe actor;
select first_name, last_name
from actor;

-- 1b. 
select concat(first_name, " ", last_name) as "Actor Name"
from actor;

-- 2a. 
select actor_id, first_name, last_name
from actor
where first_name = "Joe";

-- 2b.
select actor_id, first_name, last_name
from actor
where last_name like "%GEN%";

-- 2c. 
select last_name, first_name
from actor
where last_name like "%LI%"
order by last_name, first_name;

-- 2d.
describe country;
select country_id, country
from country
where country in ("Afghanistan", "Bangladesh", "China");

-- 3a.
alter table actor
add description blob;

-- 3b.
alter table actor
drop description;

-- 4a.
select last_name, count(last_name) as "Number of Actors"
from actor
group by last_name;

-- 4b.
select last_name, count(last_name) as "Number of Actors"
from actor
group by last_name
having count(last_name) >= 2;

-- 4c. 
update actor
set first_name = "HARPO"
where first_name = "GROUCHO" and last_name = "WILLIAMS";

-- 4d.
update actor
set first_name = "GROUCHO"
where first_name = "HARPO" and last_name = "WILLIAMS";

-- 5a.
show create table address;

-- 6a.
describe staff;
describe address;

select staff.first_name, staff.last_name, address.address
from staff
join address
on (address.address_id = staff.address_id);

-- 6b.
describe payment;

select staff.first_name, staff.last_name, sum(payment.amount) as "Total Amount Rung Up"
from staff
join payment
on payment.staff_id = staff.staff_id
where extract(month from payment.payment_date) = 8 and extract(year from payment.payment_date) = 2005
group by staff.first_name, staff.last_name;

-- 6c.
describe film_actor;
describe film;

select film.title, count(distinct film_actor.actor_id) as "Number of Actors"
from film
inner join film_actor
on (film.film_id = film_actor.film_id)
group by film.title;

-- 6d.
describe inventory;

select count(film.title) as "Copies of Hunchback Impossible"
from film
join inventory
on (inventory.film_id = film.film_id)
where film.title = "Hunchback Impossible";

-- 6e.
describe customer;

select customer.first_name, customer.last_name, sum(payment.amount) as "Total Amount Paid"
from customer
join payment
on (payment.customer_id = customer.customer_id)
group by customer.first_name, customer.last_name
order by customer.last_name;

-- 7a.
describe language;

select film.title 
from film 
join language
on (language.language_id = film.language_id)
where (film.title like "K%" or film.title like "Q%") and language.name = "English";

-- 7b.
select actor.first_name, actor.last_name
from actor
join film_actor on (film_actor.actor_id = actor.actor_id)
join film on (film.film_id = film_actor.film_id)
where film.title = "Alone Trip";

-- 7c.
describe customer;
describe country;
describe address;
describe city;

select customer.first_name, customer.last_name, customer.email
from customer
join address on (address.address_id = customer.address_id)
join city on (city.city_id = address.city_id)
join country on (country.country_id = city.country_id)
where country.country = "Canada";

-- 7d.
describe film;
describe category;
describe film_text;
describe film_category;

select film.title
from film
join film_category on (film_category.film_id = film.film_id)
join category on (category.category_id = film_category.category_id)
where category.name = "family";

-- 7e.
describe film;
describe rental;
describe inventory;

select film.title, count(rental.rental_id) as "Number of Times Rented"
from film
join inventory on (inventory.film_id = film.film_id)
join rental on (rental.inventory_id = inventory.inventory_id)
group by film.title
order by count(rental.rental_id) desc;

-- 7f.
describe store;
describe payment;
describe customer;

select store.store_id, sum(payment.amount) as "Total Business Brought In"
from store
join customer on (customer.store_id = store.store_id)
join payment on (payment.customer_id = customer.customer_id)
group by store.store_id;

-- 7g.
describe address;
describe city;
describe country;

select store.store_id, city.city, country.country
from store
join address on (address.address_id = store.address_id)
join city on (city.city_id = address.city_id)
join country on (country.country_id = city.country_id)
group by store.store_id;

-- 7h.
describe category;
describe film_category;
describe inventory;
describe rental;
describe payment;

select category.name, sum(payment.amount) as "Gross Revenue"
from category
join film_category on (film_category.category_id = category.category_id)
join inventory on (inventory.film_id = film_category.film_id)
join rental on (rental.inventory_id = inventory.inventory_id)
join payment on (payment.customer_id = rental.customer_id)
group by category.name
order by sum(payment.amount) desc
limit 5;

-- 8a.
create view top_five_genres as 
select category.name, sum(payment.amount) as "Gross Revenue"
from category
join film_category on (film_category.category_id = category.category_id)
join inventory on (inventory.film_id = film_category.film_id)
join rental on (rental.inventory_id = inventory.inventory_id)
join payment on (payment.customer_id = rental.customer_id)
group by category.name
order by sum(payment.amount) desc
limit 5;

-- 8b.
-- To display the created view, one can write a query. The view is under the "Views" category located under the database.
select * from top_five_genres;

-- 8c.
drop view top_five_genres;