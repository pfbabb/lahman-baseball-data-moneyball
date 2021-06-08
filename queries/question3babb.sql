SELECT namefirst, namelast, SUM(COALESCE(salary,0))::int::money AS earnings
FROM people
LEFT JOIN salaries
USING (playerid)
WHERE playerid IN (SELECT playerid FROM collegeplaying WHERE schoolid = 'vandy')
GROUP BY playerid
ORDER BY earnings DESC