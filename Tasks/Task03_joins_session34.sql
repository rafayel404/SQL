/*
Freedom Ranking for Different Countries
You can get the dataset from here.

Some feature details of the dataset:

Feature	Description
A	Electoral Process
B	Political Pluralism and Participation
C	Functioning of Government
D	Freedom of Expression and Belief
E	Associational and Organizational Rights
F	Rule of Law
G	Personal Autonomy and Individual Rights
CL	Civil Liberties Scores
Status	F=Free, PF=Partly Free, NF=Not Free


Q-1 Find the top 10 countries with the highest combined score of Electoral Process (A) and 
Freedom of Expression and Belief (D) for the year 2022. Display the country name, region, 
individual A and D scores, and their combined total, sorted from highest to lowest.

Q-2 : Find the countries that achieved the absolute maximum score in Electoral Process (A) AND 
also achieved the absolute maximum score in Freedom of Expression and Belief (D) during the 2022 edition.

Q-3 :Our product teams want to identify sudden shifts in country metrics over time. Write a query to find all 
countries that experienced a drop of more than 5 points in their Civil Liberties score (CL) 
from one year to the next consecutive year. Display the country, the two years, and the point drop.

Q-4: Data integrity is critical when scaling infrastructure. Write a query to find out if there are any Country and 
Edition combinations present in the country_cl table that are completely missing from the country_ab table.

Q-5 : The policy team needs a unified 'Democracy Score' dashboard for the year 2022. Write a query to join country_ab, country_cd, 
and country_efg together to calculate a combined aggregate score of Electoral Process (A), Functioning of Government (C),
and Rule of Law (F) for each country.


*/

-- 1.
SELECT 
    ab.Country, 
    ab.Region, 
    ab.A, 
    cd.D, 
    (ab.A + cd.D) AS Total_A_D
FROM 
    country_ab ab
JOIN 
    country_cd cd ON ab.Country = cd.Country AND ab.Edition = cd.Edition
WHERE ab.Edition='2022'    
ORDER BY 
    Total_A_D DESC, 
    ab.Country ASC
LIMIT 10;

-- 2.
SELECT 
    ab.Country, 
    ab.A, 
    cd.D
FROM 
    country_ab ab
JOIN 
    country_cd cd ON ab.Country = cd.Country AND ab.Edition = cd.Edition
WHERE 
    ab.Edition = 2022
ORDER BY 
    ab.A DESC, 
    cd.D DESC 
LIMIT 10;


-- 3.
SELECT 
    current_year.Country,
    current_year.Edition AS original_year,
    next_year.Edition AS consecutive_year,
    current_year.CL AS original_CL,
    next_year.CL AS consecutive_CL,
    (current_year.CL - next_year.CL) AS point_drop
FROM 
    country_cl AS current_year
INNER JOIN 
    country_cl AS next_year 
    ON current_year.Country = next_year.Country 
    AND next_year.Edition = current_year.Edition + 1
WHERE 
    (current_year.CL - next_year.CL) > 5
ORDER BY 
    point_drop DESC;
    
-- 4.
SELECT 
    cl.Country, 
    cl.Edition
FROM 
    country_cl cl
LEFT JOIN 
    country_ab ab ON cl.Country = ab.Country AND cl.Edition = ab.Edition
WHERE 
    ab.Country IS NULL;
    
-- 5.
SELECT 
    ab.Country,
    ab.Region,
    ab.A AS Electoral_Process,
    cd.C AS Functioning_of_Government,
    efg.F AS Rule_of_Law,
    (ab.A + cd.C + efg.F) AS Combined_Democracy_Score
FROM 
    country_ab ab
INNER JOIN 
    country_cd cd ON ab.Country = cd.Country AND ab.Edition = cd.Edition
INNER JOIN 
    country_efg efg ON ab.Country = efg.Country AND ab.Edition = efg.Edition
WHERE 
    ab.Edition = 2022
ORDER BY 
    Combined_Democracy_Score DESC, 
    ab.Country ASC;    
    
    
    
 
 /*
 Tables:
Customer
Employee
Sales
Products

Q-3 Find top-5 most sold products.
Q-4: Find sales man who sold most no of products.
Q-5: Sales man name who has most no of unique customer.
Q-6: Sales man who has generated most revenue. Show top 5.
Q-7: List all customers who have made more than 10 purchases.
Q-8 : List all salespeople who have made sales to more than 5 customers.
Q-9: List all pairs of customers who have made purchases with the same salesperson.
 
 */
 
 -- 3.
 select t1.Name,count(*) from products t1
 join sales1 t2
 on t1.ProductID=t2.ProductID
 group by t1.ProductID,t1.Name
 order by count(*) desc limit 5;
 
 -- 4. 
select t1.FirstName,t1.LastName,sum(t2.Quantity) from employees t1
join sales1 t2
on t1.EmployeeID=t2.SalesPersonID
group by t1.EmployeeID,t1.FirstName,t1.LastName
order by sum(t2.Quantity) desc;

-- 5.
select t1.FirstName,t1.LastName,count(distinct CustomerID) from employees t1
join sales1 t2
on t1.EmployeeID=t2.SalesPersonID
group by t1.EmployeeID,t1.FirstName,t1.LastName
order by count(distinct CustomerID) desc;

-- 6.
select s.SalesPersonID,round(sum(s.Quantity*p.Price)) as revenue from sales1 s
join products p on p.ProductID= s.ProductID
group by s.SalesPersonID
order by revenue desc limit 5 ;
 