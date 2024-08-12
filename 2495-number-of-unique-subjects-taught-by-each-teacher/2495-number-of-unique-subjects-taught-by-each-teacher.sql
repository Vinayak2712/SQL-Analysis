# Write your MySQL query statement below
SELECT teacher_id, COUNT(DISTINCT Subject_id) AS cnt
FROM Teacher 
GROUP BY 1;