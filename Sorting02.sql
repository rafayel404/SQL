-- 1. Find top 5 samsunng phone with biggest screen size

select brand_name,screen_size 
from smartphones where brand_name='samsung'
order by screen_size desc limit 5;


-- 2. Sort all the phone in descending order of number of total cameras

select brand_name,num_front_cameras+num_rear_cameras as total_camera 
from smartphones
order by total_camera desc;

-- 3. Sort data on the basis of ppi

select model, round(sqrt(resolution_width* resolution_width + resolution_height * resolution_height)/screen_size) as ppi 
from smartphones
order by ppi desc;

-- 4. Find the name and rating of worst apple phone
select model, rating from smartphones
where brand_name='apple'
order by rating asc;


-- 5. Find the phone with second largest battery
-- limit x,y means skip first x number of rows, and then print y number of row. indexing starts at 0.
select model,battery_capacity from smartphones
order by battery_capacity desc
limit 1,1;


-- Sort on the basis of name ,then price
SELECT brand_name, model, price	
FROM smartphones
ORDER BY brand_name ASC, price DESC;

