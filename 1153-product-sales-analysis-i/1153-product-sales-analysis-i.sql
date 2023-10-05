# Write your MySQL query statement below
SELECT Product.product_name, year, price FROM Sales LEFT JOIN Product USING(product_id);