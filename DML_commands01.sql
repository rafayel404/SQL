# INCERT

INSERT INTO users (user_id,name,email,password) 
VALUES (NULL,'Naimur','naimur@gmail.com','5620'),
		(NULL,'Pappu','pappu@gmail.com','5488'),
        (NULL,'Atik','atik@gmail.com','0349'),
        (NULL,'Inan','inan@gmail.com','4583');
        

# Select
# Select all column by *
SELECT * FROM smartphones;
SELECT brand_name,price,rating FROM smartphones;

# Alias
SELECT brand_name As b_name, price AS Dam FROM smartphones;
        

# Expression creating: i can run mathematical opeartion
SELECT brand_name,rating/10 AS rating_in_10th_scale from smartphones;


# Adding constant
SELECT brand_name, 'constant' AS 'This is constant' from smartphones;

# Select distinct
SELECT DISTINCT brand_name FROM smartphones;
SELECT DISTINCT brand_name,processor_brand FROM smartphones;

# Where , Between
SELECT * from smartphones WHERE brand_name='samsung';
SELECT * from smartphones WHERE price>50000;
SELECT * from smartphones WHERE price>50000;
-- SELECT * from smartphones WHERE price>20000 AND price<50000;
SELECT * from smartphones WHERE price BETWEEN 20000 AND 30000;
select * from smartphones where price <15000 and rating>80 and processor_brand='snapdragon';

-- Order of query execution:
/* 
	From
    Join
    Where
    Group by
    Having
    Select
    Distinct
    Order by
    
    F  J   W   G  H    S   D  O
 */
 
 
 -- IN , NOT IN operation -> when too much or operation
 select * from smartphones
 where processor_brand='snapdragon' or processor_brand='exynos' or processor_brand='bionic';
 
 select * from smartphones where processor_brand IN ('snapdragon','exynos','bionic');



-- UPDATE
-- let's assume we will change processor name from mediatek to dimensity
UPDATE smartphones
SET processor_brand='dimensity'
where processor_brand='mediatek';

UPDATE users
SET email='shaha@gmail.com',password='3578'
where name='Antu';

-- Delete works the same way
-- DELETE * FROM campusx.smartphones
-- where processor_brand='mediatek';


# count - it counts the total number of rows including null 
select count(*) from smartphones 
where brand_name='samsung';

select count(brand_name) from smartphones  # total number of rows at that column 
where brand_name='samsung';

select count(distinct brand_name) from smartphones ;