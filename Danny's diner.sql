SELECT * FROM members 

SELECT * FROM menu 

SELECT * FROM sales 

#1.What is the total amount each customer spent at the restaurant?
SELECT s.customer_id, sum(m.price)
FROM sales as s
LEFT JOIN menu as m
USING(product_id)
GROUP BY 1
ORDER BY 2

#2.How many days has each customer visited the restaurant?
SELECT customer_id, COUNT(DISTINCT order_date) as Times
FROM sales
GROUP BY 1

#3.What was the first item from the menu purchased by each customer?
WITH A AS (SELECT s.customer_id, m.product_name, s.order_date,
ROW_NUMBER () OVER (
PARTITION BY s.customer_id ORDER BY s.order_date) as row_no
FROM sales as s
LEFT JOIN menu as m
USING(product_id))
SELECT * FROM A 
WHERE row_no = 1

/*4.What is the most purchased item on the menu and how many times was it purchased
by all customers?*/

SELECT m.product_name, COUNT(s.product_id) as times
FROM sales as s
LEFT JOIN menu as m 
USING(product_id)
GROUP BY 1
ORDER BY times DESC
LIMIT 1

#5.Which item was the most popular for each customer?
WITH A AS (SELECT s.customer_id, m.product_name, COUNT(s.product_id),
ROW_NUMBER () OVER (
PARTITION BY s.customer_id ORDER BY COUNT(s.product_id) DESC  ) as row_no
FROM sales as s
LEFT JOIN menu as m 
USING (product_id)
GROUP BY 1, 2)
SELECT A.customer_id, A.product_name FROM A WHERE row_no = 1

#6.Which item was purchased first by the customer after they became a member?
WITH A AS (SELECT s.customer_id, s.order_date, m.product_name,
ROW_NUMBER () OVER (
PARTITION BY s.customer_id ORDER BY s.order_date) as row_no
FROM sales as s
LEFT JOIN menu as m 
USING(product_id)
INNER JOIN members as mb 
USING(customer_id)
WHERE mb.join_date <= s.order_date)
SELECT A.customer_id, A.order_date, A.product_name
FROM A WHERE row_no = 1

#7.Which item was purchased just before the customer became a member?
WITH A AS (SELECT s.customer_id, s.order_date, m.product_name,
ROW_NUMBER () OVER(
PARTITION BY s.customer_id ORDER BY s.order_date DESC) as row_no
FROM sales as s
LEFT JOIN menu as m 
USING(product_id)
INNER JOIN members as mb 
USING(customer_id)
WHERE mb.join_date > s.order_date)
SELECT A.customer_id, A.order_date, A.product_name
FROM A WHERE row_no = 1

/*8.What is the total items and amount spent for each member before 
they became a member?*/
WITH A AS (
SELECT s.customer_id,s.order_date, s.product_id, m.price
FROM sales as s
LEFT JOIN menu as m 
USING(product_id))
SELECT A.customer_id, COUNT(A.product_id) 
as total_items, SUM(A.price) as total_money
FROM A 
INNER JOIN members as mb
USING(customer_id)
WHERE A.order_date < mb.join_date 
GROUP BY 1

/*9.If each $1 spent equates to 10 points and sushi has a 2x points multiplier 
 * - how many points would each customer have?*/
WITH A AS(
SELECT s.customer_id, 
 CASE WHEN s.product_id = 1 then m.price*20
      ELSE m.price*10
 END AS points
FROM sales as s
LEFT JOIN menu as m 
USING(product_id))
SELECT A.customer_id, SUM(A.points)
FROM A
GROUP BY A.customer_id
