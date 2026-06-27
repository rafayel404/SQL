
-- Independent subquery: Inner query can perform without outer query independently.alter
-- Scalar subquery: It returns only a scalar value.
-- Examples are given below of these two.


-- Find the movie with highest profit

select name from movies
where (gross-budget)=(select max(gross-budget) from movies);
-- It can be done by using order by also.
select name from movies
order by gross- budget desc limit 1;


-- Find how many movies have a rating greater than avg movie rating

select count(*) from movies
where score> (select avg(score) from movies);


-- Find the highest rated movie of year 2000

select * from movies
where year=2000 and score=(select max(score) from movies where year=2000);


-- Find the highest rated move among all movies whose number of votes are greater than avg vote of dataset.

select * from movies
where score=(select max(score) from movies
		     where votes> (select avg(votes) from movies ));
             


             
             
-- Row subquery: It returns a column with multiple row.alter

-- Find all users who never ordered.
select * from users 
where user_id not in (select distinct user_id from orders);


-- Find all movies made by top three directors (In terms of total gross income)

-- first find top three director as row sub query and then find their movies
with top_directors as (select director from movies         # this is common table expression. we can not write limit inside subquery.
				       group by director
                       order by sum(gross) desc limit 3)
select * from movies
where director in (select * from top_directors);


-- Table subquery or multi col multi row subquery

-- Find the most profitable movie of each year.alter

select * from movies
where (year, gross-budget) in (select year,max(gross-budget) from movies
                              group by year
                              order by max(gross-budget) desc);
                              
                              

-- Find the highest rated movie of each genre votes cut off of 25000

select * from movies
where (genre,score) in (select genre, max(score) from movies   
                          where votes>25000
                          group by genre
						)       
and votes>25000;


                        
-- Correlated subquery -> Inner query depends on outer query.

-- Find all the movies that have a rating higher than the average rating of movies
-- in the same genre.alter

select * from movies m1
where score> (select avg(score) from movies m2 
				where m2.genre=m1.genre	);
                



-- Find favourite food of each customer.

with fav_food as (
	select t1.name, t2.user_id,t4.f_name,t3.f_id,count(*) as `frequency` from users t1
	join orders t2 on t1.user_id=t2.user_id
	join order_details t3 on t3.order_id =t2.`order id`
	join food t4 on t4.`f id` =t3.f_id   
	group by t2.user_id,t1.name,t3.f_id,t4.f_name )
    
select * from fav_food f1
where frequency = ( select max(frequency) from fav_food f2
					where f1.user_id=f2.user_id)   ;
                    
                    
                    
-- Using sub query in select.
-- Display all movie names,genre,score,avg score of that genre.

select name,genre,score,(select avg(score) from movies m2 where m2.genre=m1.genre ) as avg_score
from movies m1;                  
                    
          
          
-- Using subquery in `from`      
-- Display average rating of all restaurants.

select r_name,avg_rating from (
							select r_id,avg(restaurant_rating) as `avg_rating` from orders  
							group by r_id  ) t1
join restaurants on restaurants.`r id`=t1.r_id;



-- Find genres having avg score greater than avg score of all the movies.

select genre,avg(score) from movies
group by genre
having avg(score) > (select avg(score) from movies);


-- We can do insert and update operation using subquery
-- Customers who placed order more than 3 times are loyal, make a table for them

insert into loyal_user
(user_id,user_name)
select t1.user_id ,t2.name from orders t1
join users t2 on t1.user_id=t2.user_id
group by t1.user_id,t2.name
having count(*) >=3






















             