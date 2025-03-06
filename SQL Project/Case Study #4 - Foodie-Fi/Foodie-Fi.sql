/* 1.How many customers has Foodie-Fi ever had? */ 
-- Use count function to calculate number of customers that Foodie-Fi had
select count(distinct customer_id) as number_customers
from subscriptions

------------------------------------------------------------------------------------------------------------
/* 2.What is the monthly distribution of trial plan start_date values for our dataset */ 
-- Step 1: Join two tables to apply condition for plan_name
-- Step 2: Group by year and month of start_date and count number of events per month
select year([start_date]) as [year], month([start_date]) as [month],
    count(distinct [start_date]) as number_events
from subscriptions as sub 
left join plans 
    on sub.plan_id = plans.plan_id
where plan_name = 'trial'
group by year([start_date]), month([start_date])

------------------------------------------------------------------------------------------------------------
/* 3.What plan start_date values occur after the year 2020 for our dataset? Show the breakdown by count of events for each plan_name */ 
-- Step 1: Join two tables to use plan_name for grouping
-- Step 2: Group by plan_name and count number of events per plan
select plan_name, 
    count([start_date]) as number_events
from subscriptions as sub
left join plans
    on sub.plan_id = plans.plan_id
where year([start_date]) > 2020
group by plan_name

------------------------------------------------------------------------------------------------------------
/* 4.What is the customer count and percentage of customers who have churned rounded to 1 decimal place? */ 
-- Step 1: Join two tables to use plan_name for grouping
-- Step 2: Group by plan_name and count number of customers per plan
-- Step 3: Use windown function sum to calculate total customers and devide number of customers in step 2 for total customers to have percentage
select *,
    sum(number_customers) over () as total_customers,
    concat(round((cast(number_customers as float)/sum(number_customers) over ())*100, 1), '%') as [percentage]
from (
    select plan_name, 
        count(distinct customer_id) as number_customers
    from subscriptions as sub
    left join plans
        on sub.plan_id = plans.plan_id
    group by plan_name
) as table_group

------------------------------------------------------------------------------------------------------------
/* 5.How many customers have churned straight after their initial free trial - what percentage is this rounded to the nearest whole number? */ 
-- Step 1: Join two table to have column plan_name and filter plan_name by values: trial and churn, because this question only mention about this two plan name
-- Step 2: Ranking subscriptions of each customer_id by start_date to get information about the order of subscription 
-- Step 3: Use windown function lead to move column plan_name up
-- Step 4: Count number of churned customers by conditions that later plan = churn and count total customer use trial plan by normal count function. After that, devide number of churned customers for total number of customers to have percentage.
with table_join as (
    select customer_id, [start_date], plan_name,
        row_number() over (partition by customer_id order by [start_date]) as rank
    from subscriptions as sub
    left join plans
        on sub.plan_id = plans.plan_id
    where plan_name in ('trial', 'churn')
)
, table_lead as (
    select *,
        lead(plan_name, 1) over (partition by customer_id order by rank) as later_plan
    from table_join
)
select count(case when later_plan = 'churn' then customer_id end) as number_churned_cus,
    count(distinct customer_id) as total_cus,
    concat(cast(count(case when later_plan = 'churn' then customer_id end) as float)/count(distinct customer_id)*100, '%') as [percentage]
from table_lead

------------------------------------------------------------------------------------------------------------
/* 6.What is the number and percentage of customer plans after their initial free trial? */ 
-- Step 1: Join two table to have column plan_name and ranking subscriptions of each customer_id by start_date to get information about the order of subscription for each customer
-- Step 2: Group by plan_name and count number of customers per plan type (Only rank = 2 because this question mention about plans after initial free trial, so I take out the second subscription)
-- Step 3: Use windown function sum to calculate total number of customers and calculate percentage for each plan_name
with table_rank as (
    select customer_id, [start_date], plan_name,
        row_number() over (partition by customer_id order by [start_date]) as rank
    from subscriptions as sub
    left join plans
        on sub.plan_id = plans.plan_id
)
, table_group as (
    select plan_name,
        count(customer_id) as number_cus
    from table_rank
    where rank = 2
    group by plan_name
)
select *,
    sum(number_cus) over () as total_cus,
    concat((cast(number_cus as float)/sum(number_cus) over ()) *100, '%') as [percentage]
from table_group

------------------------------------------------------------------------------------------------------------
/* 7.How many customers have upgraded to an annual plan in 2020? */ 
-- Join tables, filter by year = 2020 and plan_name = 'pro annual', and count number of customers have upgraded to an annual plan
select count(distinct customer_id) as number_cus
from subscriptions as sub 
left join plans 
    on sub.plan_id = plans.plan_id
where year([start_date]) = 2020 and plan_name = 'pro annual'

------------------------------------------------------------------------------------------------------------
/* 8.How many days on average does it take for a customer to an annual plan from the day they join Foodie-Fi? */ 
-- Step 1: Join two tables and extract subscriptions in pro annual and trial plan
-- Step 2: Use lag function to move start_date down and calculate number of days to convert from trial to pro annual of each customer. After that, calculate average days
with table_lag as (
    select customer_id, plan_name, [start_date],
        lag([start_date], 1) over (partition by customer_id order by [start_date]) as previous_time
    from subscriptions as sub 
    left join plans 
        on sub.plan_id = plans.plan_id
    where plan_name in ('pro annual', 'trial')
)
, table_gap as (
    select *,
        datediff(day, previous_time, [start_date]) as gap
    from table_lag
    where previous_time is not null
) 
select avg(gap) as avg_days
from table_gap

------------------------------------------------------------------------------------------------------------
/* 9.Can you further breakdown this average value into 30 day periods (i.e. 0-30 days, 31-60 days etc) */ 
-- Step 1: Join two tables and extract subscriptions in pro annual and trial plan
-- Step 2: Use lag function to move start_date down and calculate number of days to convert from trial to pro annual of each customer
-- Step 3: Create new column category about breakdown gap value into 30 day periods (total have 12 groups)
-- Step 4: Group by category and calculate average days of each category
with table_lag as (
    select customer_id, plan_name, [start_date],
        lag([start_date], 1) over (partition by customer_id order by [start_date]) as previous_time
    from subscriptions as sub 
    left join plans 
        on sub.plan_id = plans.plan_id
    where plan_name in ('pro annual', 'trial')
)
, table_gap as (
    select *,
        datediff(day, previous_time, [start_date]) as gap
    from table_lag
    where previous_time is not null
)
, table_cate as ( 
    select *,
        case when gap < 30 then 'Period 1(0-30)'
            when gap < 60 then 'Period 2(31-60)'
            when gap < 90 then 'Period 3(61-90)'
            when gap < 120 then 'Period 4(91-120)'
            when gap < 150 then 'Period 5(121-150)'
            when gap < 180 then 'Period 6(151-180)'
            when gap < 210 then 'Period 7(181-210)'
            when gap < 240 then 'Period 8(211-240)'
            when gap < 270 then 'Period 9(241-270)'
            when gap < 300 then 'Period 10(271-300)'
            when gap < 330 then 'Period 11(301-330)'
            else 'Period 12(331-360)'
            end as category
    from table_gap
    where previous_time is not null
)
select category,
    avg(gap) as avg_cate
from table_cate
group by category

------------------------------------------------------------------------------------------------------------
/* 10.How many customers downgraded from a pro monthly to a basic monthly plan in 2020? */ 
-- Step 1: Join two tables and filter data with condition in question
-- Step 2: Move plan_name up to have new column about later plan
-- Step 3: Apply condition that later plan is basic monthly and plan name is pro monthly, count number of customers
with table_lead as (
    select customer_id, plan_name, [start_date],
        lead(plan_name, 1) over (partition by customer_id order by [start_date]) as later_plan
    from subscriptions as sub 
    left join plans 
        on sub.plan_id = plans.plan_id
    where plan_name in ('pro monthly', 'basic monthly') and year([start_date]) = 2020
)
select count(customer_id) as number_cus
from table_lead
where later_plan = 'basic monthly' and plan_name = 'pro monthly'
