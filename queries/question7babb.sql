/*
SELECT teamID, name, yearID, W, WSWin, G
FROM teams
WHERE WSWin = 'Y'
AND yearid >= 1970 AND yearid <> 1981
ORDER BY W DESC
*/

/*
SELECT teamID, name, yearID, W, WSWin, G
FROM teams
WHERE WSWin = 'N'
AND yearid >= 1970 AND yearid <> 1981
ORDER BY W DESC
*/

WITH winworld AS (
	SELECT yearID, name, (CASE WHEN W = MAX(W) OVER(PARTITION BY yearID) AND WSwin = 'Y' THEN 1 ELSE 0 END) AS max_wins, WSwin
	FROM teams
	WHERE yearid >= 1970 AND yearid <> 1981
	)
SELECT ROUND(SUM(max_wins)::DECIMAL / COUNT(WSwin) * 100,1) as max_win_percent
FROM winworld
WHERE WSwin = 'Y'