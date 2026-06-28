/* 
Window function: 
Performs calculations across a set of rows related to the current row. 
Unlike standard aggregate functions with GROUP BY, window functions 
keep individual rows intact and do not collapse the result set.

CORE SYNTAX: 
function_name() OVER ( [PARTITION BY column] [ORDER BY column] )

KEY COMPONENTS:
1. OVER()       : Defines the "window" of rows the function operates on.
2. PARTITION BY : Divides the result set into groups. The calculation 
                  restarts for each new partition.
3. ORDER BY     : Sorts rows within the partition. Essential for 
                  ranking or running totals.

COMMON EXAMPLES:
- RANK()        : Assigns a rank within a partition, with gaps for ties.
- ROW_NUMBER()  : Assigns a unique sequential integer to rows.
- MAX() / AVG() : Used with OVER() to show aggregate data next to 
                  individual row data.
======================================================================
*/


select *,avg(marks) over(),min(marks) over(),max(marks) over(),
avg(marks) over(partition by branch) from marks;


-- Find all students who have marks greater than average mark of their department.

select * from (select *,avg(marks) over(partition by branch) as branch_avg
				from marks) t
where t.marks>t.branch_avg;           


-- Rank and dense rank
-- If two students's mark is equal , rank will put both of them same rank and next student will get rank skipping one rank.

select *,rank() over(partition by branch order by marks desc) ,
dense_rank() over(partition by branch order by marks desc) 
from marks;


-- Row numer assigns a row number to each row of each group
select *,row_number() over(partition by branch) from marks;
select *,concat(branch,'-',row_number() over(partition by branch)) from marks;

select date,month(date),monthname(date) from orders ;


-- Find top two most paying customer of each month.
select * from 
(SELECT 
    MONTHNAME(date) AS 'month', user_id,SUM(amount) AS 'total',
    RANK() OVER(PARTITION BY MONTHNAME(date) ORDER BY SUM(amount) DESC) AS 'monthly_rank'
FROM orders
GROUP BY 
   MONTH(date), MONTHNAME(date), user_id
ORDER BY 
    MONTH(date)) t
where t.monthly_rank<3;





-- Frame 
/*
In MySQL, a frame is a subset of rows within a window that a window function operates on.

Think of it this way:

PARTITION BY → divides the data into groups.
ORDER BY → sorts rows within each group.
Frame → specifies which rows around the current row should be included in the calculation.


ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW: This is the default for many window functions. It creates a cumulative effect. 
If you are on row 5, it looks at rows 1 through 5.

ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING: This creates a strict rolling window of 3 rows. 
If you are on row 5, the frame includes rows 4, 5, and 6.

ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING: This includes every row in the partition. 
It's useful when you want to compare a single row's value against the grand total or overall average of the entire group.

ROWS BETWEEN 3 PRECEDING AND 2 FOLLOWING: A custom asymmetrical rolling window. 
If you are on row 5, the frame grabs rows 2, 3, 4, 5, 6, and 7.
*/

-- First value, last value, nth value

select *, first_value(marks) over(partition by branch order by marks desc) from marks;

select *, last_value(marks) over(partition by branch order by marks desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) from marks;

select *, nth_value(marks,2) over(partition by branch order by marks desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) from marks;


-- Find the topper of each branch
SELECT * FROM (
    SELECT *,
    FIRST_VALUE(name) OVER(PARTITION BY branch ORDER BY marks DESC) AS 'topper_name',
    FIRST_VALUE(marks) OVER(PARTITION BY branch ORDER BY marks DESC) AS 'topper_marks'
    FROM marks
) t
WHERE t.name = t.topper_name AND t.marks = t.topper_marks;


-- Lag and lead
SELECT *,
LAG(marks) OVER(PARTITION BY branch ORDER BY student_id),
LEAD(marks) OVER(PARTITION BY branch ORDER BY student_id)
FROM marks;


-- Find monthly revenue growth
SELECT MONTHNAME(date),SUM(amount),
((SUM(amount) - LAG(SUM(amount)) OVER(ORDER BY MONTH(date)))/LAG(SUM(amount)) OVER(ORDER BY MONTH(date)))*100 as monthly_growth
FROM orders
GROUP BY MONTHNAME(date),MONTH(date)
ORDER BY MONTH(date) ASC
     
 