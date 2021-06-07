WITH games AS (
SELECT (year/10)*10 as decade, SUM(games) AS sum_games
FROM homegames
GROUP BY decade
ORDER BY decade
	)
,
sum_stat AS (SELECT (yearid /10)*10 as decade, 
	SUM(so)::DECIMAL  AS so_per_decade
FROM batting
WHERE yearid >=1920
GROUP BY decade
ORDER BY decade)

SELECT games.decade, so_per_decade/sum_games
FROM games
INNER JOIN sum_stat
USING (decade)



