WITH lrpitch AS (
	SELECT pitching.playerid, pitching.yearid, IPOuts, ERA, throws, awardid, inducted
	FROM pitching
	LEFT JOIN people
	USING (playerid)
	LEFT JOIN (SELECT * FROM awardsplayers WHERE awardid ILIKE 'CY%') AS awards
	ON pitching.playerid = awards.playerid
	AND pitching.yearid = awards.yearid
	LEFT JOIN (SELECT playerid, inducted FROM halloffame WHERE inducted = 'Y') AS fame
	ON pitching.playerid = fame.playerid
	WHERE pitching.yearid >1970
	ORDER BY awardid, playerid
	)
SELECT throws, SUM(IPouts) AS Outsplayed, AVG(ERA) AS ERAavg,
	COUNT(DISTINCT playerid) AS numplayers,
	COUNT(awardid) AS CYwinners,
	COUNT(inducted) AS HoF
FROM lrpitch
GROUP BY ROLLUP (throws)
