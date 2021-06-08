/*
WITH games AS (
SELECT (yearid/10)*10 as decade, SUM(ghome) AS sum_games
FROM teams
GROUP BY decade
ORDER BY decade
	)
,
sum_stat AS (SELECT (yearid /10)*10 as decade, 
	SUM(so)::DECIMAL  AS so_per_decade
FROM teams
GROUP BY decade
ORDER BY decade)

SELECT games.decade, so_per_decade/sum_games
FROM games
INNER JOIN sum_stat
USING (decade)
WHERE decade >= 1920
*/
SELECT (yearid/10)*10 as decade, ROUND(SUM(so)::DECIMAL / SUM(ghome)::DECIMAL,2) AS so_per_game
FROM teams
WHERE yearid >=1920
GROUP BY decade
ORDER BY decade