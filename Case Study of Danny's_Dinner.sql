-- 1. What is the total amount each customer spent at the restaurant?
SELECT s.customer_id, SUM(price) AS total_amnt
FROM sales s 
INNER JOIN menu m ON s.product_id = m.product_id
GROUP BY s.customer_id
ORDER BY customer_id ASC;


-- 2. How many days has each customer visited the restaurant?
SELECT customer_id, COUNT(DISTINCT order_date) AS visit_days
FROM sales 
GROUP BY customer_id;


-- 3. What was the first item from the menu purchased by each customer?
WITH my_cte AS (
SELECT s.customer_id, s.order_date, m.product_name,
DENSE_RANK() OVER(PARTITION BY s.customer_id ORDER BY s.ordeR_date) AS rnk
FROM sales s 
INNER JOIN menu m ON s.product_id = m.product_id)

SELECT DISTINCT customer_id, product_name FROM my_cte 
WHERE rnk = 1;

SELECT DISTINCT s.customer_id, m.product_name
FROM sales s 
INNER JOIN menu m USING(product_id)
WHERE s.order_date IN (SELECT MIN(order_date) FROM sales);


-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?
SELECT m.product_name, COUNT(s.product_id) AS total_orders
FROM sales s INNER JOIN menu m USING(product_id) 
GROUP BY m.product_name 
ORDER BY total_orders DESC 
LIMIT 1;


-- 5. Which item was the most popular for each customer?
WITH my_cte AS (
SELECT s.customer_id, m.product_name, 
COUNT(s.product_id) AS total_orders,
DENSE_RANK() OVER(PARTITION BY s.customer_id ORDER BY COUNT(s.product_id) DESC) AS rnk
FROM sales s INNER JOIN menu m USING(product_id)
GROUP BY s.customer_id, m.product_name)

SELECT customer_id, product_name, total_orders FROM my_cte WHERE rnk = 1;

-- 6. Which item was purchased first by the customer after they became a member?
WITH my_cte AS (
SELECT s.customer_id,m.product_name,
DENSE_RANK() OVER(PARTITION BY s.customer_id ORDER BY s.order_date) AS rnk
FROM sales s 
INNER JOIN menu m ON s.product_id = m.product_id
INNER JOIN members mb ON s.customer_id = mb.customer_id
WHERE s.order_date >= mb.join_date)

SELECT customer_id, product_name FROM my_cte WHERE rnk = 1;



-- 7. Which item was purchased just before the customer became a member?
WITH my_cte AS(
SELECT s.customer_id, s.order_date,m.product_name,mb.join_date,
DENSE_RANK() OVER(PARTITION BY s.customer_id ORDER BY s.order_date DESC) AS rnk 
FROM sales s 
INNER JOIN menu m ON s.product_id = m.product_id
INNER JOIN members mb ON s.customer_id = mb.customer_id
WHERE s.order_date < mb.join_date)

SELECT customer_id, product_name, order_date, join_date FROM my_cte WHERE rnk = 1;


-- 8. What is the total items and amount spent for each member before they became a member?
SELECT s.customer_id, 
COUNT(s.product_id) AS total_orders,
SUM(m.price) AS total_amt
FROM sales s 
INNER JOIN menu m ON s.product_id = m.product_id
JOIN members mb ON s.customer_id = mb.customer_id
WHERE s.order_date < mb.join_date
GROUP BY s.customer_id
ORDER BY s.customer_id ASC;

-- 9.  If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
SELECT  s.customer_id,
        SUM(CASE WHEN m.product_name = "sushi" THEN price * 20 ELSE price*10 END) AS points
FROM sales s 
	INNER JOIN menu m USING (product_id)
GROUP BY s.customer_id;


-- 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items,
-- not just sushi - how many  points do customer A and B have at the end of January?

WITH my_cte AS (
SELECT *,
	DATE_ADD(join_date, INTERVAL 6 DAY) AS valid_date,
    LAST_DAY('2021-01-31') AS last_day
    FROM members
)

SELECT s.customer_id,
	SUM( CASE WHEN s.order_date BETWEEN join_date AND valid_date THEN m.price * 20 ELSE m.price*10 END) AS total_points  

FROM my_cte INNER JOIN sales s USING(customer_id)
INNER JOIN menu m ON s.product_id = m.product_id
WHERE s.order_date <= last_day
GROUP BY s.customer_id
ORDER BY total_points DESC;

