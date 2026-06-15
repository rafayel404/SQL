-- Having run filter on group by operation. It is like where operation. Where operation works on all rows, but having works on rows of each group.

select brand_name,count(*) as cnt,round(avg(price)) as avg_price ,max(rating)
from smartphones
group by brand_name
having cnt>20
order by avg_price desc;

-- Find the top 3 brands with the highest agv ram that have a refresh rate of at least 90 Hz and fast charging available and don't consider brans which have less than 10 phones.
select brand_name, avg(ram_capacity) as 'ram'
from  smartphones
where refresh_rate>90 and fast_charging_available=1
group by brand_name
having count(*) >10
order by ram desc limit 3;