--appeared on WS winning team in WS game

SELECT playerid, COUNT(*)
FROM teams
LEFT JOIN (
		SELECT playerid, yearid, teamid
		FROM battingpost
		WHERE round = 'WS'
		UNION
		SELECT playerid, yearid, teamid
		FROM fieldingpost
		WHERE round = 'WS'
		UNION
		SELECT playerid, yearid, teamid
		FROM pitchingpost
		WHERE round = 'WS'
		)  AS WSplayers
		USING (yearid, teamid)
WHERE WSwin = 'Y'
GROUP BY playerid
ORDER BY playerid
