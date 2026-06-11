/* 
1. Show records of 'male' patient from 'southwest' region.
2. Show all records having bmi in range 30 to 45 both inclusive.
3. Show minimum and maximum bloodpressure of diabetic patient who smokes. Make column names as MinBP and MaxBP respectively.
4. Find no of unique patients who are not from southwest region.
5. Total claim amount from male smoker.
6. Select all records of south region.
7. No of patient having normal blood pressure. Normal range[90-120]
8. No of pateint belo 17 years of age having normal blood pressure as per below formula -
    BP normal range = 80+(age in years × 2) to 100 + (age in years × 2)

Note: Formula taken just for practice, don't take in real sense.

9. What is the average claim amount for non-smoking female patients who are diabetic?
10. Write a SQL query to update the claim amount for the patient with PatientID = 1234 to 5000.
11. Write a SQL query to delete all records for patients who are smokers and have no children.
*/



-- 1. Show records of 'male' patient from 'southwest' region.
select * from insurance_data
where gender='male'and region='southeast';

-- 2. Show all records having bmi in range 30 to 45 both inclusive.
select * from insurance_data
where bmi between 30 and 45;

-- 3. Show minimum and maximum bloodpressure of diabetic patient who smokes. Make column names as MinBP and MaxBP respectively.
select max(bloodpressure) as MaxBp ,min(bloodpressure) as MinBp from insurance_data
where diabetic='Yes' and smoker='Yes';

-- 4. Find no of unique patients who are not from southwest region.
select  count(distinct(PatientID)) from insurance_data
where region!= 'southwest';

-- 5. Total claim amount from male smoker.
select sum(claim) from insurance_data
where gender='male' and smoker='Yes';

-- 6. Select all records of south region.
select distinct region from insurance_data;
select * from insurance_data where region like 'south%';


-- 7. No of patient having normal blood pressure. Normal range[90-120]
SELECT COUNT(*) FROM insurance_data
WHERE bloodpressure BETWEEN 90 AND 120;


-- 8. No of pateint belo 17 years of age having normal blood pressure as per below formula -
--    BP normal range = 80+(age in years × 2) to 100 + (age in years × 2)
-- Note: Formula taken just for practice, don't take in real sense.

SELECT COUNT(*) FROM insurance_data
WHERE age < 17 
AND (bloodpressure BETWEEN 80+(age * 2) AND 100 + (age * 2));


-- 9. What is the average claim amount for non-smoking female patients who are diabetic?
SELECT AVG(claim) FROM insurance_data
WHERE gender = 'female'
AND smoker = 'No';


-- 10. Write a SQL query to update the claim amount for the patient with PatientID = 1234 to 5000.
UPDATE insurance_data SET claim = 5000
WHERE PatientID = 1234;

SELECT * FROM insurance_data WHERE PatientID = 1234;

-- 11. Write a SQL query to delete all records for patients who are smokers and have no children.
DELETE FROM insurance 
WHERE smoker = 'Yes' AND children = 0






