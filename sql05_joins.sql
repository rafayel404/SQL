-- JOINS

/*
Think of it like matching two spreadsheets together: one spreadsheet has a list of employees with a "Department ID," and
the other has a list of "Department IDs" and their corresponding names. A JOIN lets you connect those IDs so you can see 
the employee's name and their department's name in one unified view.

The Main Types of Joins
Here are the most common joins you will use in MySQL:

INNER JOIN: The most common type. It returns records only if there is a match in both tables. If an employee doesn't have a department
or a department doesn't have any employees, they won't show up.

LEFT JOIN (or LEFT OUTER JOIN): Returns all records from the left table (the first one you mention), and the matched records from the right table.
If there is no match, the result is NULL on the right side.

RIGHT JOIN (or RIGHT OUTER JOIN): The exact opposite. It returns all records from the right table, and the matched records 
from the left table. If there is no match, the result is NULL on the left side.

CROSS JOIN: Returns the Cartesian product of the tables. It joins every row of the left table with every row of the
 right table. (Use with caution on large tables!)

A Quick Note on FULL OUTER JOIN: Unlike some other database systems (like PostgreSQL or SQL Server), 
MySQL does not have a built-in FULL OUTER JOIN command. To get all records from both tables regardless of matches,
 you simulate it by using a UNION to combine the results of a LEFT JOIN and a RIGHT JOIN.

*/

-- Cross join
select * from users 
cross join `groups`; 

-- Inner join
select * from users t1
inner join membership t2
on t1.user_id= t2.user_id;

-- Right join
select * from users t1
right join membership t2
on t1.user_id= t2.user_id;

-- Left join
select * from users t1
left join membership t2
on t1.user_id= t2.user_id;


-- Outer join
-- There is no direct outer join in mysql. We will do it by Union operation.

select * from users t1
right join membership t2
on t1.user_id= t2.user_id
UNION
select * from users t1
left join membership t2
on t1.user_id= t2.user_id;


-- Self join
-- When we need to compare or find within the same table

select * from users1 t1
join users1 t2
on t1.emergency_contact=t2.user_id;


-- Join can performed base on more than one column by AND operation, we can join more than two table also

-- Find all the profitable orders
select t1.order_id, sum(t2.profit) from orders t1
join order_details t2
on t1.order_id=t2.order_id
group by t1.order_id
having sum(t2.profit)>0;


-- Find customer who has placed maximum number of order.
SELECT t1.name, COUNT(t2.order_id) AS total_orders
FROM users t1
JOIN orders t2 ON t1.user_id = t2.user_id
GROUP BY t1.name 
ORDER BY total_orders DESC 
LIMIT 1;