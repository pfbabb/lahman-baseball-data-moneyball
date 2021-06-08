WITH WSwins AS (
	SELECT teamid, yearid
	FROM teams
	WHERE WSwin = 'Y'
	)
,
college AS (
	SELECT DISTINCT playerid, schoolid
FROM collegeplaying )
	
SELECT *
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