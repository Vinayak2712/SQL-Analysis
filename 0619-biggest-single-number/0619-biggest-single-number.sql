# Write your MySQL query statement below

SELECT 
MAX( CASE WHEN num IS NOT NULL THEN num ELSE null END) num
FROM (
SELECT num FROM
MyNumbers 
GROUP BY num
HAVING COUNT(num) = 1) AS x
