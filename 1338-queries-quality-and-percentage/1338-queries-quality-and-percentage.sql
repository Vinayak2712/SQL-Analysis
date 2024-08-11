# Write your MySQL query statement below
SELECT query_name,
ROUND(AVG(rating/position),2) AS quality,
ROUND(100 * SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) / COUNT(rating),2) AS poor_query_percentage
FROM Queries
WHERE query_name IS NOT NULL
GROUP BY 1