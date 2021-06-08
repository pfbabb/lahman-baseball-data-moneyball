WITH fielding_ext AS ( SELECT *, (
CASE WHEN pos IN ('SS', '1B', '2B', '3B') THEN 'infield'
WHEN pos IN ('OF') THEN 'outfield'
WHEN pos IN ('P', 'C') THEN 'battery'
ELSE 'other' END) AS posgroup
FROM fielding)

SELECT posgroup, SUM(PO) AS sum_po
FROM fielding_ext
WHERE yearid = 2016
GROUP BY posgroup


SELECT (
CASE WHEN pos IN ('SS', '1B', '2B', '3B') THEN 'infield'
WHEN pos IN ('OF') THEN 'outfield'
WHEN pos IN ('P', 'C') THEN 'battery'
ELSE 'other' END) AS posgroup , SUM(PO) AS sum_po
FROM fielding
WHERE yearid = 2016
GROUP BY posgroup