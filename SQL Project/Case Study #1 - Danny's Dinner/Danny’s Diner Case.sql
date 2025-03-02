--------------------------------------------------------------------------------------------
/* What is the total amount each customer spent at the restaurant? */
select customer_id,
    sum(price) as total_amount
from sales
left join menu 
    on sales.product_id = menu.product_id
group by customer_id

--------------------------------------------------------------------------------------------
/* How many days has each customer visited the restaurant? */ 
select customer_id, 
    count(distinct order_date) as number_days
from sales
group by customer_id

--------------------------------------------------------------------------------------------
/* What was the first item from the menu purchased by each customer? */ 
select customer_id, product_name
from (
    select customer_id, product_name,
        row_number() over (partition by customer_id order by order_date asc) as row_number
    from sales
    left join menu 
        on sales.product_id = menu.product_id
) as table_join
where row_number = 1

--------------------------------------------------------------------------------------------
/* What is the most purchased item on the menu and how many times was it purchased by all customers? */
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
/* Which item was the most popular for each customer? */
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
)
select *
from (
    select *,
        row_number() over (partition by customer_id order by number_orders desc) as row_number
    from table_group
) as table_row
where row_number = 1

--------------------------------------------------------------------------------------------
/* Which item was purchased first by the customer after they became a member? */ 
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
/* Which item was purchased just before the customer became a member? */
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
        datediff(day,order_date, join_date) as distance
    from table_join
)
select *
from (
    select *,
        rank() over (partition by customer_id order by distance asc) as rank
    from table_dis 
    where distance > 0
) as table_row 
where rank = 1

--------------------------------------------------------------------------------------------
/* What is the total items and amount spent for each member before they became a member? */
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
        datediff(day,order_date, join_date) as distance
    from table_join
)
select customer_id,
    sum(price) as total_amount,
    count(product_name) as number_items
from table_dis
where distance > 0 
group by customer_id

--------------------------------------------------------------------------------------------
/* If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have? */ 
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
/* In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi, 
how many points do customer A and B have at the end of January? */ 
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
