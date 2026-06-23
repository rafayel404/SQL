/*
Problem 1:
The question is:
Find out the average sleep duration of top 15 male candidates who's sleep duration are equal to 7.5 or greater than 7.5.

Problem 2: 
Show avg deep sleep time for both gender. Round result at 2 decimal places.
Note: sleep time and deep sleep percentage will give you, deep sleep time.

Problem 3:
The question is:
Find out the lowest 10th to 30th light sleep percentage records where deep sleep percentage values are between 25 to 45. Display age,
light sleep percentage and deep sleep percentage columns only.

Problem 4: 
Group by on exercise frequency and smoking status and show average deep sleep time, average light sleep time and avg rem sleep time.
Note the differences in deep sleep time for smoking and non smoking status

Problem 5: 
Group By on Awekning and show AVG Caffeine consumption, AVG Deep sleep time and AVG Alcohol consumption only for people 
who do exercise atleast 3 days a week. Show result in descending order awekenings
*/

-- 1.
select avg( `Sleep duration`) from sleep_efficiency
where Gender='male' and `Sleep duration`>=7.5
order by `Sleep duration` desc limit 15;

-- 2.
select Gender,round(avg((`Deep sleep percentage` /100)* `Sleep duration`),2) as average from sleep_efficiency
group by Gender;

-- 3.
select Age, `Light sleep percentage`,`Deep sleep percentage` from sleep_efficiency
where `Deep sleep percentage` between 25 and 45
order by `Light sleep percentage` asc
limit 10,20;

-- 4.
select `Smoking status`,`Exercise frequency`,avg((`Deep sleep percentage` /100)* `Sleep duration`),
avg((`Light sleep percentage` /100)* `Sleep duration` ) from sleep_efficiency
group by `Smoking status`,`Exercise frequency`;



/*
From power grid dataset
Problem 6:

Display those power stations which have average 'Monitored Cap.(MW)' (display the values) between 1000 and 2000 and 
the number of occurance of the power stations (also display these values)
are greater than 200. Also sort the result in ascending order.
*/
-- 6.
select `Power Station`,count(`Power Station`) as occurance ,avg(`Monitored Cap.(MW)`) as aver from powergeneration
group by `Power Station`
having( aver between 1000 and 2000) and count(`Power Station`)>200
order by aver desc;


/*
Avg Cost of Undergrad College by State(USA) Dataset-
Year:The Digest year this information comes from
State: The U.S. State
Type: Type of University, Private or Public and in-state or out-of-state. Private colleges charge the same for in/out of state
Length: Whether the college mainly offers 2-year (Associates) or 4-year (Bachelors) programs
Expense: The Expense being described, tuition/fees or on-campus living expenses
Value: The average cost for this particular expense, in USD ($)

Problem 7:
Display top 10 lowest "value" State names of which the Year either belong to 2013 or 2017 or 2021 and type is 'Public In-State'. 
Also the number of occurance should be between 6 to 10. Display the average value upto 2 decimal places, state names and the occurance of the states.

Problem 8: 
Best state in terms of low education cost (Tution Fees) in 'Public' type university.

Problem 9:
2nd Costliest state for Private education in year 2021. Consider, Tution and Room fee both.

Problem 10:
For this, you can find the dataset from here.

The question is:

Display total and average values of Discount_offered for all the combinations of 'Mode_of_Shipment' (display this feature) 
and 'Warehouse_block' (display this feature also) for all male ('M') and 'High' Product_importance. Also sort the values in 
descending order of Mode_of_Shipment and ascending order of Warehouse_block.
*/

-- 7. 
select State,round(avg(`Value`),2) as aver,count(*) as occurance from cost_of_undergrad
where Year in (2013,2017,2021) and (Type='Public In-State')
group by State
having occurance between 6 and 10
order by aver asc limit 10 ;


-- 8
select State,avg(Value) from cost_of_undergrad
where Type like '%Public%' and Expense like '%Tuition%'
group by state
order by avg(Value) asc limit 1;













