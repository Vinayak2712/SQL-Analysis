# Write your MySQL query statement below
Select  ROUND((100 * COUNT(CASE WHEN order_date = customer_pref_delivery_date THEN 1 END) / COUNT(order_date)),2) AS immediate_percentage
from Delivery
WHERE (customer_id,order_date ) IN (
    SELECT customer_id, MIN(order_date) FROM Delivery
    GROUP BY 1
);