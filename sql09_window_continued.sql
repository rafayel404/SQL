
-- Find top 5 batsman of each team in ipl

SELECT * FROM (SELECT BattingTeam,batter,SUM(batsman_run) AS 'total_runs',
DENSE_RANK() OVER(PARTITION BY BattingTeam ORDER BY SUM(batsman_run) DESC) AS 'rank_within_team'
FROM ipl
GROUP BY BattingTeam,batter) t
WHERE t.rank_within_team < 6
ORDER BY t.BattingTeam,t.rank_within_team;


-- cumulative sum
-- Find the total run of v.kohli after 50th match

select * from 
(SELECT 
CONCAT("Match-",CAST(ROW_NUMBER() OVER(ORDER BY ID) AS CHAR)) AS 'match_no',
SUM(batsman_run) AS 'runs_scored',
SUM(SUM(batsman_run)) OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 'career_runs'
FROM ipl
WHERE batter = 'V Kohli'
GROUP BY ID ) t
where match_no='Match-50';

-- another way of writing window funciton :
select * from 
(SELECT 
CONCAT("Match-",CAST(ROW_NUMBER() OVER(ORDER BY ID) AS CHAR)) AS 'match_no',
SUM(batsman_run) AS 'runs_scored',
SUM(SUM(batsman_run)) OVER w AS 'career_runs'
FROM ipl
WHERE batter = 'V Kohli'
GROUP BY ID 
window w as (order by ID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) t
where match_no='Match-50';


-- cumulative average:

select * from 
(SELECT 
CONCAT("Match-",CAST(ROW_NUMBER() OVER(ORDER BY ID) AS CHAR)) AS 'match_no',
SUM(batsman_run) AS 'runs_scored',
avg(SUM(batsman_run)) OVER w AS 'career_runs'
FROM ipl
WHERE batter = 'V Kohli'
GROUP BY ID 
window w as (order by ID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) t;


-- running average of 10 match

SELECT * FROM (SELECT 
CONCAT("Match-",CAST(ROW_NUMBER() OVER(ORDER BY ID) AS CHAR)) AS 'match_no',
SUM(batsman_run) AS 'runs_scored',
SUM(SUM(batsman_run)) OVER w AS 'career_runs',
AVG(SUM(batsman_run)) OVER w AS 'career_avg',
AVG(SUM(batsman_run)) OVER(ROWS BETWEEN 9 PRECEDING AND CURRENT ROW) AS 'running_avg'
FROM ipl
WHERE batter = 'V Kohli'
GROUP BY ID
WINDOW w AS (order by ID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) t;


-- percentile

SELECT *,
PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY marks) OVER(PARTITION BY branch) AS 'median_marks',
PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY marks) OVER(PARTITION BY branch) AS 'median_marks_cont'
FROM marks;


-- segmentation

SELECT *,
NTILE(3) OVER(ORDER BY marks DESC) AS 'buckets'
FROM marks;

-- Case: this is if else in sql
-- I want to divide the whole smartphone dataset into 3 segments.

SELECT brand,model,price, 
CASE 
	WHEN bucket = 1 THEN 'budget'
    WHEN bucket = 2 THEN 'mid-range'
    WHEN bucket = 3 THEN 'premium'
END AS 'phone_type'
FROM
(SELECT brand,model,price,
NTILE(3) OVER(PARTITION BY brand ORDER BY price) AS 'bucket' 
FROM smartphone) t;


-- cumulative distribution

SELECT * FROM (SELECT *,
CUME_DIST() OVER(ORDER BY marks) AS 'Percentile_Score'
FROM marks) t
WHERE t.Percentile_Score > 0.90;


SELECT * FROM (SELECT source,destination,airline,AVG(price) AS 'avg_fare',
DENSE_RANK() OVER(PARTITION BY source,destination ORDER BY AVG(price)) AS 'rank'
FROM flights
GROUP BY source,destination,airline) t
WHERE t.rank < 2





