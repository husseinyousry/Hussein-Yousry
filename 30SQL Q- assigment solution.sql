-- 1.	Select all columns from the actor table.
select * from actor;

-- 2.	Get the first 10 actors by last_name in alphabetical order.

select first_name , last_name from actor
order by actor.last_name asc
limit 10 ;


-- 3.	Find all films that were released in the year 2006.

select title from film
where release_year = 2006;


-- 4.	Count how many actors are in the database.

select count(actor_id)
from actor;

-- 5.	Retrieve the first and last names of all customers.

select first_name , last_name
from customer;

-- 6.	Find all customers who have an active status.

select customer.customer_id , customer.first_name , customer.last_name  , payment.amount
from customer
inner join payment
on customer.customer_id = payment.customer_id
where payment.amount  = 'null';

-- 7.	Find the email of a customer with customer_id = 5.

select customer_id , first_name , last_name , email from customer
where customer_id = 5;


-- 8.	Get the store_id and count how many films each store has in inventory.

select store.store_id ,  count(inventory.film_id)
from store
inner join inventory
on store.store_id = inventory.store_id
group by inventory.store_id;


-- 9.	Show titles of films in the Action category.

select film.title as film_title , category.name as film_category
from film
inner join film_category
on film.film_id = film_category.film_id
inner join category
on film_category.category_id = category.category_id
where category.name = 'action';


-- 10.  Retrieve names of customers who rented a film on '2005-05-25'.

select customer.customer_id , customer.first_name ,  customer.last_name  ,  rental.rental_date
from customer
inner join rental
on customer.customer_id = rental.customer_id
where date(rental.rental_date) = '2005-05-25';

select customer.customer_id , customer.first_name , customer.last_name , rental.rental_date
from customer
inner join rental
on customer.customer_id = rental.customer_id
where rental_date in (select rental_date from rental where date (rental.rental_date) = '2005-05-25');


-- 11.  Find 5 films with the highest rental rates.

select title , rental_rate
from film
order by rental_rate desc
limit 5;


-- 12.  Get a list of unique countrys where customers live.

select distinct country.country  
from customer
inner join address
on customer.address_id = address.address_id
inner join city
on address.city_id = city.city_id
inner join country
on country.country_id = city.country_id;


-- 13.	Count how many films were released after 2005.

select count(film.film_id) from film
where release_year > 2005;


--  14.	 Find the total amount spent by each customer


select customer.customer_id ,customer.first_name , customer.last_name , customer.store_id ,  sum(payment.amount) as total_cust_pay from payment
inner join customer
on payment.customer_id  = customer.customer_id
group by customer.customer_id ,customer.first_name , customer.last_name , customer.store_id;


-- 15.  Retrieve the list of stores and total films in each store.

select store_id , count(film_id)
from inventory
group by store_id;


-- 17.  Retrieve customers' names and the total number of rentals they made.

select customer.customer_id , customer.first_name , customer.last_name , count(rental.customer_id) as count_cst_rental
from rental
inner join customer
on rental.customer_id =  customer.customer_id
group by customer.customer_id , customer.first_name , customer.last_name;


-- 18.	 Find films that have not been rented at all.
select film.film_id , film.title as list_of_unrented_films
from film
inner join inventory
on film.film_id = inventory.film_id
inner join rental
on inventory.inventory_id =  rental.inventory_id
where rental_id not in (film.film_id)
group by film_id ; 




-- 19.  List the top 5 customers who spent the most on rentals.

select customer.customer_id, customer.first_name , customer.last_name , payment.amount as customer_payment
from customer
inner join payment
on customer.customer_id = payment.customer_id
group by customer.customer_id, customer.first_name , customer.last_name , payment.amount
order by amount desc
limit 5 ;



-- 20.	Q: Find the average length of films in the Comedy category.

select round(avg(film.length),2) as avg_lenght , category.name as category_name
from film
inner join film_category
on film.film_id = film_category.film_id
inner join category
on  film_category.category_id = category.category_id
where category.name = 'comedy';


-- 21.	 List films rented by customer name Jose  or Karl.

select customer.customer_id, customer.first_name , customer.last_name , film.film_id , film.title
from customer
inner join rental
on customer.customer_id = rental.customer_id
inner join film
where customer.first_name in ( 'jose' , 'karl')
group by customer.customer_id, customer.first_name , customer.last_name , film.film_id , film.title ;


-- 22.	Find the category with the most films.


select category.name ,  count(film_category.film_id) as film_cat
from category
inner join film_category
on category.category_id  = film_category.category_id
group by category.name
order by film_cat desc
limit 1









































