# Write your MySQL query statement below
SELECT a.name, b.bonus
FROM Employee a 
LEFT JOIN Bonus b ON a.empId = b.empId
WHERE bonus < 1000 OR Bonus IS NULL;

-- SELECT Employee.name,Bonus.bonus FROM Employee 
-- LEFT JOIN Bonus ON Employee.empID = Bonus.empID
-- WHERE bonus < 1000 OR Bonus IS NULL ;