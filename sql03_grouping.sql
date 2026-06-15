-- 1. Group smartphones by brand and then count,avg price,max rating

select brand_name,count(*) as cnt from smartphones
group by brand_name
order by cnt desc;

select brand_name,count(*) as cnt,round(avg(price)) as avg_price ,max(rating)
from smartphones
group by brand_name
order by avg_price desc;


-- 2. Group smartphones by wheather they have NFC and get the average price and rating
select has_nfc,avg(price) as avg_price, avg(rating) as rtng 
from smartphones
group by has_nfc;


-- 3. Group smartphone by extended memory available and get the average price
select extended_memory_available ,avg(price) as avg_price, avg(rating) as rtng 
from smartphones
group by extended_memory_available;


-- We can do groupping on the basis of multiple column
-- 4. Group smartphones by brand and processor and get count of models and the average of primary camera resolution(rear).
select brand_name,processor_brand ,count(*) as 'number of phone',
round(avg(primary_camera_rear)) as 'avg_camera'
from smartphones
group by brand_name,processor_brand;


-- 5. Find top 5 most costly phone brands
select brand_name, avg(price) as avg_price from smartphones
group by brand_name
order by avg_price desc limit 5;


-- 6.Group smartphones by brand and find the brand with highest number model that have both nfc and ir bluster
select brand_name,count(*) as 'count' from smartphones
where has_nfc='True' and has_ir_blaster='True'
group by brand_name
order by count desc limit 1;

-- 7. Find all samsung 5g enabled phone and find out the avg price for nfc and non nfc phones.alter
select has_nfc, avg(price) from smartphones
where brand_name='samsung' and has_5g='True'
group by has_nfc;
