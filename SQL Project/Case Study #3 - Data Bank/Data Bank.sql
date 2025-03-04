------------------------------------- A. Customer Nodes Exploration ----------------------------------------

------------------------------------------------------------------------------------------------------------
/* 1.How many unique nodes are there on the Data Bank system? */ 
-- Count number of nodes
select count(distinct node_id) as number_nodes
from customer_nodes

------------------------------------------------------------------------------------------------------------
/* 2.What is the number of nodes per region? */ 
-- Step 1: Join two tables to have both region_name and node_id
-- Step 2: Group by region_name and count number of nodes per region
select region_name,
  count(distinct node_id) as number_nodes
from customer_nodes as node
left join regions as reg 
  on node.region_id = reg.region_id
group by region_name

------------------------------------------------------------------------------------------------------------
/* 3.How many customers are allocated to each region? */
-- Step 1: Join two tables to have both region_name and customer_id
-- Step 2: Group by region_name and count number of customers per region
select region_name,
  count(distinct customer_id) as number_customers
from customer_nodes as node
left join regions as reg 
  on node.region_id = reg.region_id
group by region_name

-----------------------------------------------------------------------------------------------------------
/* 4.How many days on average are customers reallocated to a different node? */
-- Step 1: Calculate gaps between start date and end date of each reallocation. But some data in end_date column has error end_date = '9999-31-12' (it's current time, mean that customers are not being reallocated), so we have to remove this value.
-- Step 2: Calculate average days
with table_gap as (
  select *,
    datediff(day, [start_date],end_date) as gap
  from customer_nodes
  where end_date != '9999-12-31'
)
select avg(gap) as avg_days
from table_gap

------------------------------------------------------------------------------------------------------------
/* 5.What is the median, 80th and 95th percentile for this same reallocation days metric for each region? */
-- Step 1: Join two tables to have column region_name and remove end_date = '9999-31-12'
-- Step 2: Calculate gaps between start date and end date
-- Step 3: Use percentile_cont() to find median, 80th and 95th percentile for each region
with table_gap as (
  select customer_id, node_id, region_name, [start_date], end_date,
    datediff(day, [start_date],end_date) as gap
  from customer_nodes as node 
  left join regions as reg 
    on node.region_id = reg.region_id
  where end_date != '9999-12-31'
)
select distinct region_name,
  PERCENTILE_CONT(0.5) within group (order by gap) over (partition by region_name) as median,
  PERCENTILE_CONT(0.8) within group (order by gap) over (partition by region_name) as [80th_percentile],
  PERCENTILE_CONT(0.95) within group (order by gap) over (partition by region_name) as [95th_percentile]
from table_gap

------------------------------------- B. Customer Transactions ----------------------------------------

------------------------------------------------------------------------------------------------------------
/* 1.What is the unique count and total amount for each transaction type? */
-- Group by transaction type, count number of transactions and calculate total amount by sum function
select txn_type,
  count(customer_id) as number_trans,
  sum(txn_amount) as total_amount
from customer_transactions
group by txn_type

select * from regions
select * from customer_nodes
select * from customer_transactions

------------------------------------------------------------------------------------------------------------
/* 2.What is the average total historical deposit counts and amounts for all customers? */
-- Step 1: Group by customer, count number of trans per customer and calculate total amount
-- Step 2: Calculate average count and amount
with table_group as (
  select customer_id,
    count(txn_date) as number_trans,
    sum(txn_amount) as total_amount
  from customer_transactions
  where txn_type = 'deposit'
  group by customer_id
)
select 
  avg(number_trans) as avg_trans,
  avg(total_amount) as avg_amount
from table_group

------------------------------------------------------------------------------------------------------------
/* 3.For each month - how many Data Bank customers make more than 1 deposit and either 1 purchase or 1 withdrawal in a single month? */
-- Step 1: Group by month, customer_id, txn_type and count number of transactions
-- Step 2: Create new column with txn_type = 'deposit' then, txn_type = 'purchase' then 2 and txn_type = 'withdrawal' then 3 to rank them
-- Step 3: Remove customers have less than 1 trans each type and lead txn_type up 1 row partition by month and customer_id clarify who have other transaction type different from 'deposit' (It's also a reason that I create column at Step 2)
-- Step 4: Group by month and count distinct customer after remove customer just have deposit
with table_group as ( 
  select month(txn_date) as [month], customer_id, txn_type,
    count(txn_date) as number_trans,
    case when txn_type = 'deposit' then 1
      when txn_type = 'purchase' then 2
      else 3 end as type_id
  from customer_transactions
  group by month(txn_date), customer_id, txn_type
)
, table_lead as (
  select *,
    lead(txn_type, 1) over (partition by [month], customer_id order by type_id) as n_type
  from table_group
  where number_trans > 1
)
select [month],
  count(distinct customer_id) as number_cus
from table_lead
where n_type is not null
group by [month]

------------------------------------------------------------------------------------------------------------
/* 4.What is the closing balance for each customer at the end of the month? */
-- Step 1: Create new column weight to clarify that transaction is increase or reduce closing balance
-- Step 2: Calculate closing balance per customer and month by windown function sum
with table_weight as (  
  select month(txn_date) as [month], customer_id, txn_type, txn_amount,
    case when txn_type = 'deposit' then 1
      else -1 end as [weight]
  from customer_transactions
)
select distinct [month], customer_id,
  sum(txn_amount*[weight]) over (partition by [month], customer_id) as closing_balance
from table_weight

