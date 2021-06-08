SELECT park_name, teams.name, (homegames.attendance / games) AS avg_att
FROM homegames
LEFT JOIN parks
USING (park)
LEFT JOIN teams
ON homegames.team = teams.teamid 
	AND homegames.year = teams.yearid
WHERE homegames.games >=10
	AND year = 2016
ORDER BY avg_att DESC