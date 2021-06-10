WITH countawards AS (
	SELECT playerid,  COUNT(awardid) AS numawards
	FROM awardsplayers
	--WHERE awardid IN ('Most Valuable Player', 'Rookie of the Year' ,'Gold Glove', 'TSN Major League Player of the Year', 'ALCS MVP', 'NLCS MVP' )
	GROUP BY playerid
	ORDER BY numawards DESC
	)
	,
WSplayers AS (
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
			)
			,
wsplayer AS (
	SELECT playerid, COUNT(*) AS wsapp
	FROM (
		SELECT *
		FROM WSplayers
		UNION
		SELECT playerid, yearid, teamid
	FROM (
		SELECT yearid, teamid
		FROM managers
		INTERSECT
		SELECT yearid, teamid
		FROM WSplayers
			) as sub
	LEFT JOIN managers
	USING (yearid, teamid)
		) AS sub
		GROUP BY playerid
	),	
avgsalary AS (
	SELECT salaries.playerid, (SUM(salary) / COUNT(DISTINCT salaries.yearid)) AS avg_salary
	FROM salaries
		GROUP BY salaries.playerid
	ORDER BY avg_salary DESC
)
,
tnplayers AS (
	SELECT collegeplaying.playerid, collegeplaying.schoolid
	FROM collegeplaying
	INNER JOIN ( SELECT playerid, max(yearid) AS yearmax
			   FROM collegeplaying
				GROUP BY playerid
			   ) AS maxyear
		ON collegeplaying.playerid = maxyear.playerid
		AND collegeplaying.yearid = maxyear.yearmax
	WHERE collegeplaying.schoolid IN (SELECT schoolid FROM schools WHERE schoolstate = 'TN')
	)
	

SELECT schoolname, count(playerid),
	(sum(avg_salary)::DECIMAL / COUNT(playerid))::MONEY, 
	sum(numawards) AS sumawards, sum(wsapp) AS WSapp
FROM tnplayers
INNER JOIN avgsalary
USING (playerid)
LEFT JOIN countawards
USING (playerid)
LEFT JOIN wsplayer
USING (playerid)
LEFT JOIN schools
USING (schoolid)
GROUP BY schoolname
ORDER BY sum(avg_salary) DESC;


