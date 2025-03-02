-- 1. What is the total amount each customer spent at the restaurant?
-- Use GROUP BY to group customers and calculate SUM of price for each of them.
select customer_id,
    sum(price) as total_amount
from sales
left join menu 
    on sales.product_id = menu.product_id
group by customer_id

--------------------------------------------------------------------------------------------
--2. How many days has each customer visited the restaurant?
-- Use GROUP BY to group customers and COUNT order_date to find the number of days each customer visited.
select customer_id, 
    count(distinct order_date) as number_days
from sales
group by customer_id

--------------------------------------------------------------------------------------------
-- 3. What was the first item from the menu purchased by each customer? 
-- Step 1: Use row_number to rank order_date of each customers for each items
-- Step 2: Take out the fist item of each customer by row_number = 1
select customer_id, product_name
from (
    select customer_id, product_name,
        row_number() over (partition by customer_id order by order_date asc) as row_number
    from sales
    left join menu 
        on sales.product_id = menu.product_id
) as table_join -- join two table and ranking for customers by order_date column
where row_number = 1 -- take out first item of each customers

--------------------------------------------------------------------------------------------
-- 4.What is the most purchased item on the menu and how many times was it purchased by all customers? 
-- Step 1: Count number of orders per customer (group by product_name and customer_id)
-- Step 2: Use windown function SUM to calculate total orders per product_name
-- Step 3: Ranking total orders per product name by dense_rank (use dense_rank because some product_name have the same number of orders)
-- Step 4: Take out the most purchased item by dense_rank = 1 
with table_group as (
    select product_name, customer_id,
        count(product_id) as number_orders_by_customer
    from (
        select customer_id, product_name, sales.product_id
        from sales
        left join menu 
            on sales.product_id = menu.product_id
    ) as table_join
    group by product_name, customer_id
)
, table_sum as (
    select *,
        sum(number_orders_by_customer) over (partition by product_name) as total_orders
    from table_group
)
select *
from (
    select *,
            dense_rank() over (order by total_orders desc) as row_number
    from table_sum
) as table_row 
where row_number = 1

--------------------------------------------------------------------------------------------
-- 5.Which item was the most popular for each customer?
-- Step 1: Count number of orders per product_name
-- Step 2: Ranking number of orders by row_number() partition by customer_id 
-- Step 3: Take out the most popular item for each customer by row_number = 1
with table_group as (  
    select customer_id, product_name,
        count(product_id) as number_orders
    from (
        select customer_id, product_name, sales.product_id
        from sales
        left join menu 
            on sales.product_id = menu.product_id
    ) as table_join
    group by customer_id, product_name 
) -- group customer_id & product_name and count number of orders per product
select *
from (
    select *,
        row_number() over (partition by customer_id order by number_orders desc) as row_number
    from table_group
) as table_row -- ranking number of orders of customers
where row_number = 1

--------------------------------------------------------------------------------------------
-- 6.Which item was purchased first by the customer after they became a member? 
-- Step 1: Join three tables and remove customers who are not member of restaurant
-- Step 2: Calculate distance of join_date and order_date to distinguish before and after became a member orders (>0 is after member and <0 is before)
-- Step 3: Take out the data which have distance > 0 and use row_number to rank the distance -> rank = 1 is the first orders after became a member
with table_join as (
    select sales.customer_id, order_date, product_name, join_date
    from sales 
    left join members
        on sales.customer_id = members.customer_id
    left join menu 
        on sales.product_id = menu.product_id
    where join_date IS NOT NULL
)
, table_dis as (
    select *,
        datediff(day,join_date,order_date) as distance
    from table_join
)
select *
from (
    select *,
        row_number() over (partition by customer_id order by distance asc) as rank
    from table_dis 
    where distance > 0
) as table_row 
where rank = 1

--------------------------------------------------------------------------------------------
-- 7.Which item was purchased just before the customer became a member? 
-- Step 1: Join three tables and remove customers who are not member of restaurant
-- Step 2: Calculate distance of join_date and order_date to distinguish before and after became a member orders (>0 is after member and <0 is before)
-- Step 3: Take out the data which have distance < 0 and use rank function to rank the distance -> rank = 1 is the first orders after became a member
with table_join as (
    select sales.customer_id, order_date, product_name, join_date
    from sales 
    left join members
        on sales.customer_id = members.customer_id
    left join menu 
        on sales.product_id = menu.product_id
    where join_date IS NOT NULL
)
, table_dis as (
    select *,
        datediff(day, join_date, order_date) as distance
    from table_join
)
select *
from (
    select *,
        rank() over (partition by customer_id order by distance asc) as rank
    from table_dis 
    where distance < 0
) as table_row 
where rank = 1

--------------------------------------------------------------------------------------------
-- 8.What is the total items and amount spent for each member before they became a member?
-- Step 1: Join three tables and remove customers who are not member of restaurant
-- Step 2: Calculate distance of join_date and order_date to distinguish before and after became a member orders (>0 is after member and <0 is before)
-- Step 3: Take out the data which have distance < 0 and GROUP BY customer, calculate total amount, number of items
with table_join as (
    select sales.customer_id, order_date, product_name, join_date, price
    from sales 
    left join members
        on sales.customer_id = members.customer_id
    left join menu 
        on sales.product_id = menu.product_id
    where join_date IS NOT NULL
)
, table_dis as (
    select *,
        datediff(day, join_date, order_date) as distance
    from table_join
)
select customer_id,
    sum(price) as total_amount,
    count(product_name) as number_items
from table_dis
where distance < 0 
group by customer_id

--------------------------------------------------------------------------------------------
-- 9.If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have? 
-- Step 1: Add in new column point
-- Step 2: GROUP BY customer and calculate total point
select customer_id,
    sum([point]) as total_point
from (
    select customer_id,
        case when product_name = 'sushi' then price*20 else price*10 end as [point]
    from sales 
    left join menu
        on sales.product_id = menu.product_id
) as table_point
group by customer_id

--------------------------------------------------------------------------------------------
-- 10.In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi, how many points do customer A and B have at the end of January?
-- Step 1: Join three tables, filter orders in January and remove customers who are not member of restaurant
-- Step 2: Calculate distance of join_date and order_date to distinguish before and after became a member orders (>0 is after member and <0 is before)
-- Step 3: Add in new column point with condition about distance, price and product_name
-- Step 4: GROUP BY customer and calculate total point
with table_join as (
    select sales.customer_id, order_date, join_date, product_name, price
    from sales 
    left join menu
        on sales.product_id = menu.product_id
    left join members
        on sales.customer_id = members.customer_id
    where month(order_date) = 1 and join_date IS NOT NULL
)
, table_dis as (
    select *,
        datediff(day,order_date,join_date) as distance
    from table_join
)
, table_point as (
    select *,
        case when distance < 1 then price*20
            when distance > 0 and product_name = 'sushi' then price*20
            else price*10
            end as [point]
    from table_dis
)
select customer_id,
    sum([point]) as total_point
from table_point
group by customer_id
