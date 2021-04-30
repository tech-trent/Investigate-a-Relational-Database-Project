/*Question 1
We want to understand more about the movies that families are watching.The following categories are considered family movies: Animation, Children, Classics, Comedy, Family and Music. Create a query that lists each movie, the film category it is classified in, and the number of times it has been rented out.
*/

SELECT DISTINCT
    category_name,
    COUNT(*)  AS rental_count
FROM (SELECT
  film.title AS film_title,
  category.name AS category_name,
  rental.rental_id AS rentalid
FROM film
JOIN film_category
  ON film.film_id = film_Category.film_id
JOIN category
  ON category.category_id = film_category.category_id
JOIN inventory
  ON film.film_id = inventory.film_id
JOIN rental
  ON inventory.inventory_id = rental.inventory_id
WHERE category.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')) flim_table
GROUP by 1
ORDER BY 2 DESC;


/*Question 2
Finally, provide a table with the family-friendly film category, each of the quartiles, and the corresponding count of movies within each combination of film category for each corresponding rental duration category.
*/


WITH family_movies
AS (SELECT
  category.name AS category_name,
  NTILE(4) OVER (ORDER BY film.rental_duration) AS standard_quartile
FROM category
JOIN film_category
  ON category.category_id = film_category.category_id
JOIN film
  ON film.film_id = film_Category.film_id
WHERE category.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
ORDER BY standard_quartile)

SELECT   family_movies.category_name,
         family_movies.standard_quartile,
         COUNT(*)
FROM family_movies
GROUP BY 1, 2
ORDER BY 1, 2;


/*Question 3:
We want to find out how the two stores compare in their count of rental orders during every month for all the years we have data for. Write a query that returns the store ID for the store, the year and month and the number of rental orders each store has fulfilled for that month. Your table should include a column for each of the following: year, month, store ID and count of rental orders fulfilled during that month.
*/

SELECT
  DATE_PART('month', rental.rental_date) AS rental_month,
  DATE_PART('year', rental.rental_date) AS rental_year,
  store.store_id, COUNT(rental.rental_id) AS count_rentals
FROM rental
JOIN staff
  ON rental.staff_id = staff.staff_id
JOIN store
  ON staff.store_id = store.store_id
GROUP BY 1, 2, 3
ORDER BY 4 DESC ;



/*Question 4:
Finally, for each of these top 10 paying customers, I would like to find out the difference across their monthly payments during 2007. Please go ahead and write a query to compare the payment amounts in each successive month. Repeat this for each of these 10 paying customers.
Also, it will be tremendously helpful if you can identify the customer name who paid the most difference in terms of payments.
*/


WITH top_10_payment_tab
AS (SELECT
  p.customer_id,
  SUM(p.amount) AS sum_payment
FROM payment p
WHERE payment_date BETWEEN '2007-01-01' AND '2007-12-31'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10),

payment_table
AS (SElECT
  DATE_TRUNC('month',p.payment_date) AS payment_month,
  c.first_name || ' '|| c.last_name AS customer_fullname,
  COUNT(p.amount) AS payment_per_month,
  SUM(p.amount) AS monthly_total
FROM customer c
JOIN  top_10_payment_tab
  ON c.customer_id =top_10_payment_tab.customer_id
JOIN payment p
  ON top_10_payment_tab.customer_id=p.customer_id
GROUP BY 1,2
ORDER BY 2,1 )

SELECT
  *,
  LEAD(monthly_total) OVER (PARTITION BY customer_fullname) AS LEAD,
  LEAD(monthly_total) OVER (PARTITION BY customer_fullname) - payment_table.monthly_total AS monthly_difference
FROM payment_table;
