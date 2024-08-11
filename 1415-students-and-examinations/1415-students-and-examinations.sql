# Write your MySQL query statement below
SELECT s.student_id,s.student_name,su.subject_name, COUNT(e.subject_name) AS attended_exams
FROM Students s CROSS JOIN subjects su LEFT OUTER JOIN Examinations e 
ON s.student_id = e.student_id AND su.subject_name = e.subject_name
GROUP BY 1,2,3 ORDER BY 

s.student_id, su.subject_name;