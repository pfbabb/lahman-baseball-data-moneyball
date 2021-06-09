WITH teamwinper AS (
	SELECT DISTINCT s.yearid, s.teamid,
		(ROUND((w::DECIMAL/g::DECIMAL)*100,0)::INT)/5*5 AS winper,
		sum(salary) OVER(PARTITION BY (s.yearid, s.teamid)) AS teamsal
	FROM salaries AS s
	LEFT JOIN teams
	ON s.yearid = teams.yearid
		AND s.teamid = teams.teamid
	WHERE s.yearid >= 2000
	ORDER BY teamsal
	)
SELECT yearid, winper, avg(teamsal)::DECIMAL::MONEY, COUNT(teamid)
FROM teamwinper
GROUP BY yearid, ROLLUP (winper)
ORDER BY yearid, winper