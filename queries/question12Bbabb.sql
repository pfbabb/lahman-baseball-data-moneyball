/*
SELECT *
FROM teams AS w1
INNER JOIN teams AS w2
USING ( teamid)
WHERE w1.wswin= 'Y'
AND w1.yearid >=1970
AND w1.yearid+1 = w2.yearid
AND w1.attendance < w2.attendance


SELECT  w1.wswin, w1.divwin, w1.wcwin, COUNT(*)
FROM teams AS w1
INNER JOIN teams AS w2
USING ( teamid)
WHERE w1.yearid >=1970
AND w1.yearid+1 = w2.yearid
AND w1.attendance < w2.attendance
GROUP BY ROLLUP (w1.wswin, w1.divwin, w1.wcwin)
*/

SELECT COUNT(DISTINCT years), SUM(wscount), SUM(ploffcount)
FROM (


SELECT *, w1.yearid AS years, (CASE WHEN w1.wswin = 'Y' THEN 1 ELSE 0 END) AS wscount,
	(CASE WHEN w1.divwin = 'Y' OR w1.wcwin = 'Y' THEN 1 ELSE 0 END) AS ploffcount
FROM teams AS w1
INNER JOIN teams AS w2
USING ( teamid)
WHERE w1.yearid >=1970
AND w1.yearid+1 = w2.yearid
AND w1.attendance < w2.attendance
	) AS moreatt
	