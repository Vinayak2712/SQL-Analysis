# Write your MySQL query statement below
SELECT class FROM
(SELECT class, count(distinct student) AS students
FROM Courses
GROUP BY 1) AS x
WHERE students >= 5;