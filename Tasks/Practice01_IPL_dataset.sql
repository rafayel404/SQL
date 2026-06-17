-- Find the top 5 batsman in ipl

select batter,sum(batsman_run) as 'total_run' from ipl
group by batter
order by total_run desc limit 5;


-- Find the second highest 6 hitter in ipl
select batter ,count(*) as 'number_of_six' from ipl
where batsman_run=6
group by batter
order by number_of_six desc limit 1,1;


-- Find  batsman with centuries in ipl
select batter,ID, sum(batsman_run) as score from ipl
group by batter,ID
having score>=100
order by score desc


