Case Study #2 - Online Payment App 🏦
------------------------------------------------------------------

📝 Table of contents
--------------------------------------------------------------------
- [Introduction](https://github.com/pngoctu012/DATA-ANALYST-PORTFOLIO/blob/main/SQL%20Project/Case%20Study%20%232%20-%20Online%20Payment%20App/Online%20Payment%20App.md#introduction)
- [Dataset](https://github.com/pngoctu012/DATA-ANALYST-PORTFOLIO/blob/main/SQL%20Project/Case%20Study%20%232%20-%20Online%20Payment%20App/Online%20Payment%20App.md#dataset)
- [Entity Relationship Diagram](https://github.com/pngoctu012/DATA-ANALYST-PORTFOLIO/blob/main/SQL%20Project/Case%20Study%20%232%20-%20Online%20Payment%20App/Online%20Payment%20App.md#entity-relationship-diagram)
- [Case Study Questions](https://github.com/pngoctu012/DATA-ANALYST-PORTFOLIO/blob/main/SQL%20Project/Case%20Study%20%232%20-%20Online%20Payment%20App/Online%20Payment%20App.md#case-study-questions)
- [Case Study Solutions](https://github.com/pngoctu012/DATA-ANALYST-PORTFOLIO/blob/main/SQL%20Project/Case%20Study%20%232%20-%20Online%20Payment%20App/Online%20Payment%20App%20Case.sql)

----------------------------------------------------------------------
# Introduction
This dataset come from *Apply SQL For Data Analytics* course of **MazHocData**.
The data describe about the history of transactions on one Online Payment App in 2017 and 2018. 

----------------------------------------------------------------------
# Dataset
This data have five tables:
- **Table 1 - payment_history_17:** This table captures all customer_id with transactions (order_id) by some method (payment_id) in some type of product_id, promotion_id, message_id with some amount of discount_price, final_price in all days (transaction_date) of 2017.
- **Table 2 - payment_history_18:** This table captures all customer_id with transactions (order_id) by some method (payment_id) in some type of product_id, promotion_id, message_id with some amount of discount_price, final_price in all days (transaction_date) of 2018.
- **Table 3 - table_message:** This table includes message_id and description for message_id with message_id = 1 then description = 'success'.
- **Table 4 - paying_method:** This table describes about paying method of customer with method_id and name of method
- **Table 5 - product:** This table captures all product_number of transactions with one product_group will have some category and one category have some sub_category

------------------------------------------------------------------
# Entity Relationship Diagram
![image](https://github.com/user-attachments/assets/4acd2aa5-9e52-4122-b6b3-e09af08f28d9)

-------------------------------------------------------------------------------
# Case Study Questions
1. Retrieve a report containing the following information: customer_id, order_id, product_id, product_group, sub_category, category. These orders must meet the following conditions:
- Incurred in January 2017
- product_group is not 'payment'
2. Retrieve a report that includes the following information: customer_id, order_id, product_id, product_group, category, payment name. These orders must meet the following conditions:
- Occurred between January and June 2017
- Have a category type of shopping
- Paid via Bank Account
3. In 2017, what is the number of orders and the proportion of each product category in each product_group? (Only count successful orders)
4. Please indicate in 2017, how many orders did each customer buy, how many product categories, how many sub_categories, and how much did they pay? (Only count successful orders with product_group "payment"). From the above results, please indicate how many customers have a total amount greater than the average amount of all customers?
5. Assuming you are a product manager for billing products (category = 'Billing'), how many orders were successfully completed and how many orders were unsuccessful each month in 2017?
6. In 2017 and 2018, find out the TOP 3 months (in each year) with the most unsuccessful payment orders?
7. To be able to track the business situation on a daily basis, create a detailed report calculating the total number of orders (successful) by month, quarter, year as suggested below: Only calculate data for 2017 and product group (product_group) is "top-up account"
8. How many days is the gap between the first and second orders for each customer? (Only 2017 data and "top-up account" product_group are calculated)
9. Tell me the trend of the number of successful payment transactions with promotion (promotion_trans) on a monthly basis and account for how much of the total number of successful payment transactions (promotion_rate)?
10. Out of the total number of successful paying customer enjoy the promotion, how many % of customer have incurred any other successful payment orders that are not promotional orders?
11. COHORT ANALYSIS 
As you know that 'Electric bill' is the most popular product in the Billing group. You want to evaluate the quality of user acquisition in 2017 by the retention metric.
12. In 2017, the MKT team launched many promotional campaigns for customers but did not limit the number of uses/person. You need to evaluate how the number of promotions/person is distributed? Is there a phenomenon of 1 group participating too many times and creating a lot of costs?

Click [here](https://github.com/pngoctu012/DATA-ANALYST-PORTFOLIO/blob/main/SQL%20Project/Case%20Study%20%232%20-%20Online%20Payment%20App/Online%20Payment%20App%20Case.sql) to view my solutions for this case study!
