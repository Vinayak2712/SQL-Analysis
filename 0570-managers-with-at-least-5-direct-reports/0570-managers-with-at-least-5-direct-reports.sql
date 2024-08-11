# Write your MySQL query statement below
-- SELECT a.name
-- FROM Employee a 
-- INNER JOIN Employee Manager ON a.id = manager.managerId
-- GROUP BY manager.managerId HAVING COUNT(*) >= 5;

SELECT name FROM Employee
WHERE id IN (SELECT managerId FROM Employee GROUP BY 1 HAVING COUNT(*) >= 5);