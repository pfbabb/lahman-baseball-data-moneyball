/*
SELECT salaries.playerid, (SUM(salary) / COUNT(DISTINCT salaries.yearid)) AS avg_salary,  COUNT(awardid) AS numawards
FROM salaries
LEFT JOIN awardsplayers
ON salaries.playerid = awardsplayers.playerid
AND salaries.yearid = awardsplayers.yearid
GROUP BY salaries.playerid
ORDER BY avg_salary DESC
*/
WITH WSwins AS (
	SELECT teamid, yearid
	FROM teams
	WHERE WSwin = 'Y'
	)
,
college AS (
	SELECT playerid, schoolid
FROM collegeplaying)

SELECT schoolname,
	(SUM(salary) / COUNT(DISTINCT salaries.yearid) / COUNT(DISTINCT salaries.playerid))::DECIMAL::MONEY AS avg_salary,
	COUNT(awardid) AS numawards,
	COUNT(DISTINCT salaries.playerid) as players,
	COUNT( CASE WHEN salaries.yearid = WSwins.yearid AND salaries.teamid = WSwins.teamid THEN 1 ELSE 0 END) AS playerWSwins
FROM salaries
LEFT JOIN awardsplayers
ON salaries.playerid = awardsplayers.playerid
AND salaries.yearid = awardsplayers.yearid
LEFT JOIN college
ON college.playerid = salaries.playerid
LEFT JOIN schools
ON schools.schoolid = college.schoolid
LEFT JOIN WSwins
ON salaries.yearid = WSwins.yearid
AND salaries.teamid = WSwins.teamid
WHERE college.schoolid IN (SELECT schoolid FROM schools WHERE schoolstate = 'TN')
GROUP BY schoolname
ORDER BY avg_salary DESC