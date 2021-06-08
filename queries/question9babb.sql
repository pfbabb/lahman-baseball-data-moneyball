SELECT CONCAT(namefirst,' ', namelast) AS fullname, teams.name, awardid, awardsmanagers.lgid, awardsmanagers.yearid
FROM awardsmanagers
LEFT JOIN people
	ON awardsmanagers.playerid = people.playerid
LEFT JOIN managers
	ON managers.playerid = awardsmanagers.playerid
	AND managers.yearid = awardsmanagers.yearid
LEFT JOIN teams
	ON managers.teamid = teams.teamid
	AND managers.yearid = teams.yearid
WHERE awardsmanagers.playerid IN (
			SELECT playerid
			FROM awardsmanagers
			WHERE awardid ILIKE 'TSN%'
			AND lgid = 'AL'
			INTERSECT
			SELECT playerid
			FROM awardsmanagers 
			WHERE awardid ILIKE 'TSN%' 
			AND lgid = 'NL'
			)
AND awardid ILIKE 'TSN%'
