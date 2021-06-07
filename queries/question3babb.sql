SELECT namefirst, namelast, SUM(salary)::int::money AS earnings
FROM people
LEFT JOIN salaries
USING (playerid)
WHERE playerid IN (SELECT playerid FROM collegeplaying WHERE schoolid = 'vandy')
GROUP BY playerid
ORDER BY earnings DESC