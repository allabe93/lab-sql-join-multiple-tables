-- 1. Write a query to display for each store its store ID, city, and country.
select s.store_id, c.city, co.country
from store as s join address
using (address_id)
join city as c
using (city_id)
join country as co
using (country_id); 

-- 2. Write a query to display how much business, in dollars, each store brought in.
select s.store_id, sum(p.amount)
from store as s join staff
using (store_id)
join payment as p
using (staff_id)
group by store_id;

-- 3. What is the average running time of films by category?
select c.name, avg(f.length)
from film f join film_category 
using (film_id)
join category c 
using (category_id) 
group by name;

-- 4. Which film categories are longest?
-- The exercise asks which ARE the longest, but does not specify how many longest film categories is requesting, it is the longest TOP 3, the longest TOP 5? It is ambiguous...
-- Therefore I will give the TOP 3. 
select c.name, avg(f.length)
from film f join film_category 
using (film_id)
join category c 
using (category_id) 
group by name order by avg(f.length) desc limit 3;

-- 5. Display the most frequently rented movies in descending order.
select f.title, count(r.rental_id)
from film f join inventory using (film_id)
join rental r using (inventory_id)
group by title order by count(r.rental_id) desc;

-- 6. List the top five genres in gross revenue in descending order.
select c.name, sum(p.amount)
from category c join film_category using (category_id)
join film using (film_id)
join inventory using (film_id)
join rental using (inventory_id)
join payment p using (rental_id)
group by name order by sum(p.amount) desc
limit 5;

-- 7. Is "Academy Dinosaur" available for rent from Store 1?
select f.film_id, f.title, i.store_id, r.inventory_id, r.rental_date, r.return_date
from film f join inventory i using (film_id) 
join rental r using (inventory_id)
where title = 'Academy Dinosaur' and store_id = 1
group by inventory_id;

-- Yes, four copies of 'Academy Dinosaur' are available for rent in Store 1. 