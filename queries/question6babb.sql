WITH stolenbases AS (
	SELECT playerid, SUM(SB) AS stolen, SUM(CS) AS caught, SUM(SB + COALESCE(CS,0)) AS attempt
	FROM batting
	WHERE yearid = 2016
	GROUP BY playerid
	ORDER BY playerid
	)
SELECT namefirst, namelast, ROUND((stolen::decimal/attempt::decimal)*100,2) AS success
FROM stolenbases
LEFT JOIN people
ON stolenbases.playerid = people.playerid
WHERE attempt > 20
ORDER BY success DESC