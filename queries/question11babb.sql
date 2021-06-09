SELECT DISTINCT s.yearid, s.teamid, w, sum(salary) OVER(PARTITION BY (s.yearid, s.teamid))
FROM salaries AS s
LEFT JOIN teams
ON s.yearid = teams.yearid
	AND s.teamid = teams.teamid
WHERE s.yearid >= 2000
ORDER BY w

