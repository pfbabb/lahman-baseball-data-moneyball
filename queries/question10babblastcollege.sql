
--last college attended in TN

SELECT collegeplaying.playerid, collegeplaying.schoolid
FROM collegeplaying
INNER JOIN ( SELECT playerid, max(yearid) AS yearmax
		   FROM collegeplaying
			GROUP BY playerid
		   ) AS maxyear
	ON collegeplaying.playerid = maxyear.playerid
	AND collegeplaying.yearid = maxyear.yearmax
WHERE collegeplaying.schoolid IN (SELECT schoolid FROM schools WHERE schoolstate = 'TN')
