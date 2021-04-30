# Investigate-a-Relational-Database-Project
Queried a relational database about a company that rents DVD movies using PostgreSQL.

    ##Introduction

In this project, you will query the Sakila DVD Rental database. The Sakila Database holds information about a company that rents movie DVDs. For this project, you will be querying the database to gain an understanding of the customer base, such as what the patterns in movie watching are across different customer groups, how they compare on payment earnings, and how the stores compare in their performance. To assist you in the queries ahead, the schema for the DVD Rental database is provided below. 

    ###Dataset

The DVD rental database has many objects including:

    15 tables
    1 trigger
    7 views
    8 functions
    1 domain
    13 sequences


    ###Tables:

    actor – stores actors data including first name and last name.
    film – stores films data such as title, release year, length, rating, etc.
    film_actor – stores the relationships between films and actors.
    category – stores film’s categories data.
    film_category- stores the relationships between films and categories.
    store – contains the store data including manager staff and address.
    inventory – stores inventory data.
    rental – stores rental data.
    payment – stores customer’s payments.
    staff – stores staff data.
    customer – stores customers data.
    address – stores address data for staff and customers
    city – stores the city names.
    country – stores the country names.

![ERD](https://video.udacity-data.com/topher/2018/September/5ba95d23_dvd-rental-erd-2/dvd-rental-erd-2.png)

    ##Questions Posed

  - We want to understand more about the movies that families are watching.The following categories are considered family movies: Animation, Children, Classics, Comedy, Family and Music. Create a query that lists each movie, the film category it is classified in, and the number of times it has been rented out.
  - Finally, provide a table with the family-friendly film category, each of the quartiles, and the corresponding count of movies within each combination of film category for each corresponding rental duration category.
  - We want to find out how the two stores compare in their count of rental orders during every month for all the years we have data for. Write a query that returns the store ID for the store, the year and month and the number of rental orders each store has fulfilled for that month. Your table should include a column for each of the following: year, month, store ID and count of rental orders fulfilled during that month.
  - Finally, for each of these top 10 paying customers, I would like to find out the difference across their monthly payments during 2007. Please go ahead and write a query to compare the payment amounts in each successive month. Repeat this for each of these 10 paying customers. Also, it will be tremendously helpful if you can identify the customer name who paid the most difference in terms of payments.

