SELECT namefirst, namelast, playerid, height, batting.yearid, batting.G as batinggame, name
FROM people
INNER JOIN batting
USING (playerID)
LEFT JOIN teams
ON teams.teamid = batting.teamid AND batting.yearid = teams.yearid
WHERE height = (SELECT min(height) FROM people)
