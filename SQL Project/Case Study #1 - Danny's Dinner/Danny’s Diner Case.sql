-- 1. What is the total amount each customer spent at the restaurant?
-- Use GROUP BY to group customers and calculate SUM of price for each of them.
SELECT customer_id,
    sum(price) AS total_amount
FROM sales
LEFT JOIN menu 
    ON sales.product_id = menu.product_id
GROUP BY customer_id

--------------------------------------------------------------------------------------------
--2. How many days has each customer visited the restaurant?
-- Use GROUP BY to group customers and COUNT order_date to find the number of days each customer visited.
SELECT customer_id, 
    COUNT(distinct order_date) AS number_days
FROM sales
GROUP BY customer_id

--------------------------------------------------------------------------------------------
-- 3. What was the first item from the menu purchased by each customer? 
-- Step 1: Use row_number to rank order_date of each customers for each items
-- Step 2: Take out the fist item of each customer by row_number = 1
SELECT customer_id, product_name
FROM (
    SELECT customer_id, product_name,
        row_number() over (partition BY customer_id ORDER BY order_date ASC) AS row_number
    FROM sales
    LEFT JOIN menu 
        ON sales.product_id = menu.product_id
) AS table_join -- join two table and ranking for customers by order_date column
WHERE row_number = 1 -- take out first item of each customers

--------------------------------------------------------------------------------------------
-- 4.What is the most purchased item on the menu and how many times was it purchased by all customers? 
-- Step 1: Count number of orders per customer (group by product_name and customer_id)
-- Step 2: Use windown function SUM to calculate total orders per product_name
-- Step 3: Ranking total orders per product name by dense_rank (use dense_rank because some product_name have the same number of orders)
-- Step 4: Take out the most purchased item by dense_rank = 1 
WITH table_group AS (
    SELECT product_name, customer_id,
        COUNT(product_id) AS number_orders_by_customer
    FROM (
        SELECT customer_id, product_name, sales.product_id
        FROM sales
        LEFT JOIN menu 
            ON sales.product_id = menu.product_id
    ) AS table_join
    GROUP BY product_name, customer_id
)
, table_sum AS (
    SELECT *,
        sum(number_orders_by_customer) over (partition BY product_name) AS total_orders
    FROM table_group
)
SELECT *
FROM (
    SELECT *,
            dense_rank() over (ORDER BY total_orders DESC) AS row_number
    FROM table_sum
) AS table_row 
WHERE row_number = 1

--------------------------------------------------------------------------------------------
-- 5.Which item was the most popular for each customer?
-- Step 1: Count number of orders per product_name
-- Step 2: Ranking number of orders by row_number() partition by customer_id 
-- Step 3: Take out the most popular item for each customer by row_number = 1
WITH table_group AS (  
    SELECT customer_id, product_name,
        COUNT(product_id) AS number_orders
    FROM (
        SELECT customer_id, product_name, sales.product_id
        FROM sales
        LEFT JOIN menu 
            ON sales.product_id = menu.product_id
    ) AS table_join
    GROUP BY customer_id, product_name 
) -- group customer_id & product_name and count number of orders per product
SELECT *
FROM (
    SELECT *,
        row_number() over (partition BY customer_id ORDER BY number_orders DESC) AS row_number
    FROM table_group
) AS table_row -- ranking number of orders of customers
WHERE row_number = 1

--------------------------------------------------------------------------------------------
-- 6.Which item was purchased first by the customer after they became a member? 
-- Step 1: Join three tables and remove customers who are not member of restaurant
-- Step 2: Calculate distance of join_date and order_date to distinguish before and after became a member orders (>0 is after member and <0 is before)
-- Step 3: Take out the data which have distance > 0 and use row_number to rank the distance -> rank = 1 is the first orders after became a member
WITH table_join AS (
    SELECT sales.customer_id, order_date, product_name, join_date
    FROM sales 
    LEFT JOIN members
        ON sales.customer_id = members.customer_id
    LEFT JOIN menu 
        ON sales.product_id = menu.product_id
    WHERE join_date IS NOT NULL
)
, table_dis AS (
    SELECT *,
        datediff(DAY,join_date,order_date) AS distance
    FROM table_join
)
SELECT *
FROM (
    SELECT *,
        row_number() over (PARTITION BY customer_id ORDER BY distance ASC) AS rank
    FROM table_dis 
    WHERE distance > 0
) AS table_row 
WHERE rank = 1

--------------------------------------------------------------------------------------------
-- 7.Which item was purchased just before the customer became a member? 
-- Step 1: Join three tables and remove customers who are not member of restaurant
-- Step 2: Calculate distance of join_date and order_date to distinguish before and after became a member orders (>0 is after member and <0 is before)
-- Step 3: Take out the data which have distance < 0 and use rank function to rank the distance -> rank = 1 is the first orders after became a member
WITH table_join AS (
    SELECT sales.customer_id, order_date, product_name, join_date
    FROM sales 
    LEFT JOIN members
        ON sales.customer_id = members.customer_id
    LEFT JOIN menu 
        ON sales.product_id = menu.product_id
    WHERE join_date IS NOT NULL
)
, table_dis AS (
    SELECT *,
        datediff(day, join_date, order_date) AS distance
    FROM table_join
)
SELECT *
FROM (
    SELECT *,
        rank() over (PARTITION BY customer_id ORDER BY distance ASC) AS rank
    FROM table_dis 
    WHERE distance < 0
) AS table_row 
WHERE rank = 1

--------------------------------------------------------------------------------------------
-- 8.What is the total items and amount spent for each member before they became a member?
-- Step 1: Join three tables and remove customers who are not member of restaurant
-- Step 2: Calculate distance of join_date and order_date to distinguish before and after became a member orders (>0 is after member and <0 is before)
-- Step 3: Take out the data which have distance < 0 and GROUP BY customer, calculate total amount, number of items
WITH table_join AS (
    SELECT sales.customer_id, order_date, product_name, join_date, price
    FROM sales 
    LEFT JOIN members
        ON sales.customer_id = members.customer_id
    LEFT JOIN menu 
        ON sales.product_id = menu.product_id
    WHERE join_date IS NOT NULL
)
, table_dis AS (
    SELECT *,
        DATEDIFF(day, join_date, order_date) AS distance
    FROM table_join
)
SELECT customer_id,
    SUM(price) AS total_amount,
    COUNT(product_name) AS number_items
FROM table_dis
WHERE distance < 0 
GROUP BY customer_id

--------------------------------------------------------------------------------------------
-- 9.If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have? 
-- Step 1: Add in new column point
-- Step 2: GROUP BY customer and calculate total point
SELECT customer_id,
    SUM([point]) AS total_point
FROM (
    SE,ECT customer_id,
        CASE WHEN product_name = 'sushi' THEN price*20 ELSE price*10 END AS [point]
    FROM sales 
    LEFT JOIN menu
        ON sales.product_id = menu.product_id
) AS table_point
GROUP BY customer_id

--------------------------------------------------------------------------------------------
-- 10.In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi, how many points do customer A and B have at the end of January?
-- Step 1: Join three tables, filter orders in January and remove customers who are not member of restaurant
-- Step 2: Calculate distance of join_date and order_date to distinguish before and after became a member orders (>0 is after member and <0 is before)
-- Step 3: Add in new column point with condition about distance, price and product_name
-- Step 4: GROUP BY customer and calculate total point
WITH table_join AS (
    SELECT sales.customer_id, order_date, join_date, product_name, price
    FROM sales 
    LEFT JOIN menu
        ON sales.product_id = menu.product_id
    LEFT JOIN members
        ON sales.customer_id = members.customer_id
    WHERE MONTH(order_date) = 1 AND join_date IS NOT NULL
)
, table_dis AS (
    SELECT *,
        DATEDIFF(day,order_date,join_date) AS distance
    FROM table_join
)
, table_point AS (
    SELECT *,
        CASE WHEN distance < 1 THEN price*20
            WHEN distance > 0 AND product_name = 'sushi' THEN price*20
            ELSE price*10
            END AS [point]
    FROM table_dis
)
SELECT customer_id,    
    sum([point]) AS total_point
FROM table_point
GROUP BY customer_id
