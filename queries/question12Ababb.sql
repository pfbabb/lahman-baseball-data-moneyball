WITH winatt AS (	
	SELECT year, team, teams.name,
		(ROUND((w::DECIMAL/g::DECIMAL)*100,0)::INT)/5*5 AS winper,
		ROUND(teams.attendance::DECIMAL / GHome::DECIMAL) AS attgame
	FROM homegames AS h
	LEFT JOIN teams
	ON h.year = teams.yearid
	AND h.team = teams.teamid
	WHERE year >=1970
	--GROUP BY year, team
	ORDER BY year, team
	)
SELECT year, winper, avg(attgame)::INT, COUNT(team)
FROM winatt
GROUP BY year, ROLLUP (winper)
ORDER BY year, winper