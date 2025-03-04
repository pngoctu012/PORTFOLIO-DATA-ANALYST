Case Study #1 - Data Bank 🏦
--------------------------------------------------------------------------------
![image](https://github.com/user-attachments/assets/ea3b3601-7857-46c6-8287-0f98c842dfb7)
View the case study [here](https://8weeksqlchallenge.com/case-study-4/)

**📝 Table of contents**
-------------------------------------------------------------------
- [Introduction](https://github.com/pngoctu012/DATA-ANALYST-PORTFOLIO/tree/main/SQL%20Project/Case%20Study%20%233%20-%20Data%20Bank#introduction)
- [Dataset](https://github.com/pngoctu012/DATA-ANALYST-PORTFOLIO/tree/main/SQL%20Project/Case%20Study%20%233%20-%20Data%20Bank#dataset)
- [Entity Relationship Diagram](https://github.com/pngoctu012/DATA-ANALYST-PORTFOLIO/tree/main/SQL%20Project/Case%20Study%20%233%20-%20Data%20Bank#entity-relationship-diagram)
- [Case Study Questions](https://github.com/pngoctu012/DATA-ANALYST-PORTFOLIO/tree/main/SQL%20Project/Case%20Study%20%233%20-%20Data%20Bank#case-study-questions)
- [Case Study Solutions](https://github.com/pngoctu012/DATA-ANALYST-PORTFOLIO/blob/main/SQL%20Project/Case%20Study%20%233%20-%20Data%20Bank/Data%20Bank.sql)

-------------------------------------------------------------------
# Introduction
  There is a new innovation in the financial industry called Neo-Banks: new aged digital only banks without physical branches.
  
  Danny thought that there should be some sort of intersection between these new age banks, cryptocurrency and the data world…so he decides to launch a new initiative - Data Bank!
  
  Data Bank runs just like any other digital bank - but it isn’t only for banking activities, they also have the world’s most secure distributed data storage platform!
  
  Customers are allocated cloud data storage limits which are directly linked to how much money they have in their accounts. There are a few interesting caveats that go with this business model, and this is where the Data Bank team need your help!
  
  The management team at Data Bank want to increase their total customer base - but also need some help tracking just how much data storage their customers will need.
  
  This case study is all about calculating metrics, growth and helping the business analyse their data in a smart way to better forecast and plan for their future developments!

-------------------------------------------------------------------
# Dataset
The Data Bank team have prepared a data model for this case study as well as a few example rows from the complete dataset below to get you familiar with their tables:
- **Table 1 - regions:** Just like popular cryptocurrency platforms - Data Bank is also run off a network of nodes where both money and data is stored across the globe. In a traditional banking sense - you can think of these nodes as bank branches or stores that exist around the world. This regions table contains the region_id and their respective region_name values

|region_id|region_name|
|---------|-----------|
|1|Africa|
|2|America|
|3|Asia|
|4|Europe|
|5|Oceania|

- **Table 2 - customer_nodes:** Customers are randomly distributed across the nodes according to their region - this also specifies exactly which node contains both their cash and data. This random distribution changes frequently to reduce the risk of hackers getting into Data Bank’s system and stealing customer’s money and data!
Below is a sample of the top 10 rows of the data_bank.customer_nodes

|customer_id|region_id|node_id|start_date|end_date|
|-----------|---------|-------|----------|--------|
|1|3|4|2020-01-02|2020-01-03|
|2|3|5|2020-01-03|2020-01-17|
|3|5|4|2020-01-27|2020-02-18|
|4|5|4|2020-01-07|2020-01-19|
|5|3|3|2020-01-15|2020-01-23|
|6|1|1|2020-01-11|2020-02-06|
|7|2|5|2020-01-20|2020-02-04|
|8|1|2|2020-01-15|2020-01-28|
|9|4|5|2020-01-21|2020-01-25|
|10|3|4|2020-01-13|2020-01-14|

- **Table 3 - customer_transactions:** This table stores all customer deposits, withdrawals and purchases made using their Data Bank debit card.

|customer_id|txn_date|txn_type|txn_amount|
|-----------|--------|--------|----------|
|429|2020-01-21|deposit|82|
|155|2020-01-10|deposit|712|
|398|2020-01-01|deposit|196|
|255|2020-01-14|deposit|563|
|185|2020-01-29|deposit|626|
|309|2020-01-13|deposit|995|
|312|2020-01-20|deposit|485|
|376|2020-01-03|deposit|706|
|188|2020-01-13|deposit|601|
|138|2020-01-11|deposit|520|

-------------------------------------------------------------------
# Entity Relationship Diagram
![image](https://github.com/user-attachments/assets/e4585840-189f-42ad-a8da-5dfcf0d0f02d)

-------------------------------------------------------------------
# Case Study Questions
**A. Customer Nodes Exploration**
1. How many unique nodes are there on the Data Bank system?
2. What is the number of nodes per region?
3. How many customers are allocated to each region?
4. How many days on average are customers reallocated to a different node?
5. What is the median, 80th and 95th percentile for this same reallocation days metric for each region?

**B. Customer Transactions**
1. What is the unique count and total amount for each transaction type?
2. What is the average total historical deposit counts and amounts for all customers?
3. For each month - how many Data Bank customers make more than 1 deposit and either 1 purchase or 1 withdrawal in a single month?
4. What is the closing balance for each customer at the end of the month?

Click [here](https://github.com/pngoctu012/DATA-ANALYST-PORTFOLIO/blob/main/SQL%20Project/Case%20Study%20%233%20-%20Data%20Bank/Data%20Bank.sql) to view my solutions for this case study!
