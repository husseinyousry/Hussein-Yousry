--- 1.	How many customers are there in each country?


select count(customer.customer_id) as num_of_cust , country.country
from customer
inner join address
on customer.address_id = address.address_id
inner join city
on  address.city_id = city.city_id
inner join country
on city.country_id = country.country_id
group by country.country
order by count(customer.customer_id) desc;

--- 2.	What are the total sales per country per city?

select sum(payment.amount) as total_payment , country.country , city.city 
from payment
inner join staff
on payment.staff_id = staff.staff_id
inner join address
on staff.address_id = address.address_id
inner join city
on address.city_id = city.city_id
inner join country
on city.country_id  = country.country_id
group by country.country , city.city
order by total_payment  desc;


--- 3.	Which customers rent the most films?

select customer.customer_id , count(film.film_id), category.name as film_cate
from film
inner join film_category
on film.film_id = film_category.film_id
inner join category
on film_category.category_id = category.category_id
inner join inventory
on film.film_id = inventory.film_id
inner join rental
on inventory.inventory_id = rental.inventory_id
inner join customer
on rental.customer_id = customer.customer_id
group by  film_cate ,  customer.customer_id
order by count(film.film_id) desc ;



--- 4.	What are the peak rental hours?

select count(rental.customer_id) as num_of_cust , hour(rental.rental_date) as rent_hours  
from rental
group by hour(rental.rental_date) 
order by num_of_cust desc ; 

--- 5.	Which are the top 10 most rented films?

select film.title as move_name ,  count(rental.inventory_id) as count_of_move
from film
inner join inventory
on film.film_id =  inventory.film_id
inner join rental
on inventory.inventory_id = rental.inventory_id
group by move_name
order by count_of_move desc
limit 10 ;

--- 6.	Which film categories are the least rented by customers?

select count(film_category.category_id) as category_id , category.name as category_name
from film_category
inner join category
on film_category.category_id = category.category_id
group by film_category.category_id
order by category_id asc ;


--- 7.  identify the lowest rented film categories?

select category.name as category_name, count(rental.rental_id) as rental_count
from category
left join film_category
on category.category_id = film_category.category_id
left join film
on film_category.film_id = film.film_id
left join inventory
on film.film_id = inventory.film_id
left join rental
on inventory.inventory_id = rental.inventory_id
group by category.category_id, category.name
order by rental_count asc
limit 5;



--- 8. Which films are sitting in inventory the longest without being rented?

select film.title, datediff(now(), max(rental.return_date)) as days_in_inventory
from film
join inventory on film.film_id = inventory.film_id
join rental on inventory.inventory_id = rental.inventory_id
group by film.title
order by days_in_inventory desc
limit 10;



--- 9. What is the average time a film spends in inventory before being rented?

select film.title, avg(datediff(rental.rental_date, inventory.inventory_date)) as avg_days_in_inventory
from film
join inventory on film.film_id = inventory.film_id
join rental on inventory.inventory_id = rental.inventory_id
group by film.title
order by avg_days_in_inventory desc
limit 10;


--- 10. Which film categories generate the most revenue?

select category.name, sum(payment.amount) as total_revenue
from category
join film_category on category.category_id = film_category.category_id
join inventory on film_category.film_id = inventory.film_id
join rental on inventory.inventory_id = rental.inventory_id
join payment on rental.rental_id = payment.rental_id
group by category.name
order by total_revenue desc;


--- 11. Which film categories are most commonly rented together?

select c1.name as category1, c2.name as category2, count(*) as together_rentals
from rental r1
join inventory i1 on r1.inventory_id = i1.inventory_id
join film_category fc1 on i1.film_id = fc1.film_id
join category c1 on fc1.category_id = c1.category_id
join rental r2 on r1.customer_id = r2.customer_id and r1.rental_id <> r2.rental_id
join inventory i2 on r2.inventory_id = i2.inventory_id
join film_category fc2 on i2.film_id = fc2.film_id
join category c2 on fc2.category_id = c2.category_id
where r1.rental_date = r2.rental_date
group by category1, category2
order by together_rentals desc;


--- 12. What is the total revenue from rentals by month?

select date_format(payment.payment_date, '%y-%m') as month, sum(payment.amount) as total_revenue
from payment
group by month
order by month;



--- 13. Which films have generated the most revenue?

select film.title, sum(payment.amount) as total_revenue
from film
join inventory
on film.film_id = inventory.film_id
join rental
on inventory.inventory_id = rental.inventory_id
join payment
on rental.rental_id = payment.rental_id
group by film.title
order by total_revenue desc
limit 10;


--- 14. Which customers are generating the most revenue?

select customer.first_name, customer.last_name, sum(payment.amount) as total_revenue
from customer
join rental
on customer.customer_id = rental.customer_id
join payment
on rental.rental_id = payment.rental_id
group by customer.first_name, customer.last_name
order by total_revenue desc
limit 10;



--- 15. Which staff members generate the most revenue?

select staff.first_name, staff.last_name, sum(payment.amount) as total_revenue
from staff
join payment
on staff.staff_id = payment.staff_id
group by staff.first_name, staff.last_name
order by total_revenue desc
limit 10;


--- 16. Which stores have the highest average revenue per customer?

select store.store_id, avg(total_revenue) as avg_revenue_per_customer
from (
    select customer.store_id, customer.customer_id, sum(payment.amount) as total_revenue
    from customer
    join rental on customer.customer_id = rental.customer_id
    join payment on rental.rental_id = payment.rental_id
    group by customer.store_id, customer.customer_id
) as customer_revenue
group by store_id
order by avg_revenue_per_customer desc;



--- 17. Which stores have the lowest rental volume?

select store.store_id, count(rental.rental_id) as rental_count
from rental
join inventory
on rental.inventory_id = inventory.inventory_id
join store
on inventory.store_id = store.store_id
group by store.store_id
order by rental_count asc;



--- 18. Which store is generating the most revenue?

select store.store_id, sum(payment.amount) as total_revenue
from store
join inventory
on store.store_id = inventory.store_id
join rental
on inventory.inventory_id = rental.inventory_id
join payment
on rental.rental_id = payment.rental_id
group by store.store_id
order by total_revenue desc
limit 1;


--- 19. Which stores have the lowest sales?

select store.store_id, sum(payment.amount) as total_revenue
from store
join inventory
on store.store_id = inventory.store_id
join rental
on inventory.inventory_id = rental.inventory_id
join payment
on rental.rental_id = payment.rental_id
group by store.store_id
order by total_revenue asc
limit 1;


--- 20. Which actors appear in the most films, and how can this data help improve content strategies?

select actor.first_name, actor.last_name, count(film_actor.film_id) as film_count
from actor
join film_actor
on actor.actor_id = film_actor.actor_id
group by actor.first_name, actor.last_name
order by film_count desc
limit 10;



--- 21. Which actors are linked to the most popular films?

select actor.first_name as actor_first_name , actor.last_name as actor_last_name, count(rental.rental_id) as rental_count
from actor
join film_actor
on actor.actor_id = film_actor.actor_id
join film
on film_actor.film_id = film.film_id
join inventory
on film.film_id = inventory.film_id
join rental
on inventory.inventory_id = rental.inventory_id
group by actor.first_name, actor.last_name
order by rental_count desc
limit 10;
















