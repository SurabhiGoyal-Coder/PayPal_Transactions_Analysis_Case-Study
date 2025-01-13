create database paypal;
use paypal;
select * from countries;
select * from currencies;
select * from merchants;
select * from transactions;
select * from users;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* 1.Problem statement 
Determine the top 5 countries by total transaction amount for both sending and receiving funds in the last quarter of 2023 (October to December 2023). 
Provide separate lists for the countries that sent the most funds and those that received the most funds. 
Additionally, round the totalsent and totalreceived amounts to 2 decimal places.*/
select c.country_name, round(sum(t.transaction_amount),2) as total_sent from transactions t join users u
on t.sender_id = u.user_id join countries c on u.country_id = c.country_id
where t.transaction_date between "2023-10-01 00:00:00" and "2024-01-01 00:00:00" group by 1 order by 2 desc limit 5;

select c.country_name, round(sum(t.transaction_amount),2) as total_received from transactions t join users u
on t.recipient_id = u.user_id join countries c on u.country_id = c.country_id
where t.transaction_date between "2023-10-01 00:00:00" and "2024-01-01 00:00:00" group by 1 order by 2 desc limit 5;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* 2.Problem statement 
To effectively manage risk, it's crucial to identify and monitor high-value transactions.
Find transactions exceeding $10,000 in the year 2023 and include transaction ID, sender ID, 
recipient ID (if available), transaction amount, and currency used.*/
select transaction_id, sender_id, recipient_id, transaction_amount, currency_code from transactions where transaction_amount > 10000 and 
date_format(transaction_date, "%Y") = 2023;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* 3.Problem statement
The sales team is interested in identifying the top-performing merchants based on the number of payments received. The analysis will help the sales team to better understand 
the performance of these key merchants during the specified timeframe.
Your task is to analyze the transaction data and determine the top 10 merchants, sorted by the total transaction
amount they received, within the period from November 2023 to April 2024. For each of these top 10 merchants, 
provide the following details: merchant ID, business name, the total transaction amount received, and the average transaction amount.*/
select m.merchant_id , m.business_name , sum(t.transaction_amount) as total_received , avg(t.transaction_amount) as average_transaction
from transactions t join merchants m on m.merchant_id = t.recipient_id 
where t.transaction_date >= '2023-11-01' and t.transaction_date < '2024-05-01'
group by 1, 2 order by 3 desc limit 10; 

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* 4.Problem statement
The finance team wants to analyze the company's exposure to currency risks.
Analyze currency conversion trends from 22 May 2023 to 22 May 2024. Calculate the total amount 
converted from each source currency to the top 3 most popular destination currencies.*/
select currency_code, sum(transaction_amount) as total_converted from transactions where transaction_date >= '2023-05-22' and 
transaction_date < '2024-05-22' group by 1 order by 2 desc limit 3;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* 5.Problem statement
The finance team is evaluating transaction classifications.
Categorize transactions as 'High Value' (above $10,000) or 'Regular' (below $10,000) and calculate the total amount for each category for the year 2023.*/
select transaction_category, sum(transaction_amount) as total_amount from 
(select transaction_amount, case when transaction_amount > 10000 then 'High Value' 
when transaction_amount < 10000 then 'Regular' end as transaction_category from transactions where date_format(transaction_date, '%Y') = 2023) temp
group by 1 order by 2 desc;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* 6.Problem statement
To meet compliance requirements, the finance team needs to identify the nature of transactions conducted by the company. 
Specifically, you are required to analyze transaction data for the first quarter of 2024 (January to March).
Your task is to create a new column in the dataset that indicates whether each transaction is international (where the sender and recipient are 
from different countries) or domestic (where the sender and recipient are from the same country). Additionally, provide a count of the number of international 
and domestic transactions for this period.
This classification will assist in ensuring compliance with relevant regulations and provide insights into the distribution of transaction types. 
Please include a detailed summary of the counts for each type of transaction.*/
with cte as
(select t1.sender_id, u1.country_id as sender_country, t1.recipient_id, u2.country_id as receiver_country from transactions t1 join users u1 on 
t1.sender_id = u1.user_id join users u2 
on t1.recipient_id = u2.user_id where transaction_date >= "2024-01-01" and transaction_date < "2024-04-01")
select case when sender_country <> receiver_country then "International" when sender_country = receiver_country then "Domestic" end as transaction_type, 
count(*) as transaction_count from cte group by 1 order by 2 desc;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* 7.Problem statement
To improve user segmentation, the finance team needs to analyze user transaction behavior.
Your task is to calculate the average transaction amount per user for the past six months, covering the period from November 2023 to April 2024. 
Once you have the average transaction amount for each user, identify and list the users whose average transaction amount exceeds $5,000.
This analysis will help the finance team to better understand high-value users and tailor strategies to meet their needs.*/
WITH avg_transaction AS (
SELECT sender_id, AVG(transaction_amount) AS avg_amount FROM transactions WHERE transaction_date >= "2023-11-01" 
AND transaction_date < "2024-05-01" GROUP BY sender_id)
SELECT u.user_id, u.email, t.avg_amount FROM avg_transaction t JOIN users u ON t.sender_id = u.user_id
WHERE t.avg_amount > 5000;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* 8.Problem statement
As part of the financial review, the finance team requires detailed monthly transaction reports for the year 2023.
Your task is to extract the month and year from each transaction date and then calculate the total transaction amount for each month-year combination. 
This will involve summarizing the total transactions on a monthly basis to provide a clear view of financial activities throughout the year. 
Please ensure that your report includes a breakdown of the total transaction amounts for each month and year combination for 2023, helping the finance team 
to review and analyze the company's monthly financial performance comprehensively.*/
select year(transaction_date) as transaction_year, month(transaction_date) as transaction_month, 
sum(transaction_amount) as total_amount from transactions 
where year(transaction_date) = 2023 group by 1,2 order by 2;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* 9.Problem statement
As part of identifying top customers for a new loyalty program, the finance team needs to find the most valuable customer over the past year. 
Specifically, your task is to determine the user who has the highest total transaction amount from May 22, 2023, to May 22, 2024.
Please provide the details of this user, including their user ID, name, and total transaction amount. This information will help the finance team to 
select the most deserving customer for the loyalty program based on their transaction behavior over the specified period.*/
SELECT u.user_id, u.email, u.name, t.total_amount FROM Users u 
JOIN (SELECT sender_id, SUM(transaction_amount) AS total_amount FROM Transactions WHERE transaction_date > '2023-05-22' AND transaction_date <= '2024-05-22'
GROUP BY sender_id ORDER BY total_amount DESC LIMIT 1) t ON u.user_id = t.sender_id;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* 10.Problem statement
The finance team is analyzing currency conversion trends to manage exposure to currency risks. Which currency had the highest transaction amount from 
in the past one year up to today indicating the greatest exposure? (assume today is 22-05-2024)*/
select currency_code, sum(transaction_amount) as currency_sum from transactions where transaction_date >= "2023-05-22" 
and transaction_date < "2024-05-23" group by 1 order by 2 desc limit 1;
-- Euro is the currency which had the highest transaction amount from in the past one year up to today

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* 11.Problem statement
The sales team wants to identify top-performing merchants. Which merchant should be considered as the most successful in terms of total 
transaction amount received between November 2023 and April 2024?*/
select m.merchant_id, m.business_name, sum(t.transaction_amount) as total_amount, avg(t.transaction_amount) as avg_amount
from transactions t join merchants m on m.merchant_id = t.recipient_id
where transaction_date >= "2023-11-01" and transaction_date < "2024-05-01" group by 1,2 order by 3 desc limit 1;
-- Gould LLC is the merchant which is considered as the most successful in terms of total transaction amount.

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* 12.Problem statement
As part of a financial analysis, the team needs to categorize transactions based on multiple criteria. Create a report that categorizes transactions 
into 'High Value International', 'High Value Domestic', 'Regular International', and 'Regular Domestic' based on the following criteria:
High Value: transaction amount > $10,000
International: sender and recipient from different countries
Write a query to categorize each transaction and count the number of transactions in each category for the year 2023.*/
with cte as
(select t.transaction_date, t.sender_id, u1.country_id as sender_country, t.recipient_id, u2.country_id as receiver_country, t.transaction_amount
from transactions t join users u1 on t.sender_id = u1.user_id join users u2 on t.recipient_id = u2.user_id where year(t.transaction_date) = 2023)
select case when sender_country <> receiver_country and transaction_amount > 10000 then "High Value International" 
when sender_country = receiver_country and transaction_amount > 10000 then "High Value Domestic" 
when sender_country <> receiver_country and transaction_amount < 10000 then "Regular International"
else "Regular Domestic"
end as transaction_category, count(*) as transaction_count from cte group by 1;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* 13.Problem statement
The finance department requires a comprehensive monthly report for the year 2023 that segments transactions by type and nature. 
Specifically, the report should classify transactions into 'High Value' (above $10,000) and 'Regular' (below $10,000), and further 
differentiate them as either 'International' (sender and recipient from different countries) or 'Domestic' (sender and recipient from the same country).
Your task is to write a query that groups transactions by year, month, value_category, location_category, and then calculates both the total transaction 
amount and the average transaction amount for each group. This detailed analysis will provide valuable insights into transaction patterns and help 
the finance department in their review and planning processes.*/
with cte as
(select t.transaction_date, t.sender_id, u1.country_id as sender_country, t.recipient_id, u2.country_id as receiver_country, t.transaction_amount
from transactions t join users u1 on t.sender_id = u1.user_id join users u2 on t.recipient_id = u2.user_id where year(t.transaction_date) = 2023)
select year(transaction_date) as transaction_year, month(transaction_date) as transaction_month, case when transaction_amount > 10000 then 
'High Value' else 'Regular' end as value_category, case when sender_country = receiver_country then 'Domestic' else 'International' end as location_category, 
sum(transaction_amount) as total_amount, avg(transaction_amount) as average_amount from cte group by 1,2,3,4 order by 2;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* 14.Problem statement
The sales team wants to evaluate the performance of merchants by creating a score based on their transaction amounts. The score is calculated as follows:
If total transactions exceed $50,000, the score is 'Excellent'
If total transactions are greater than $20,000 and lesser than or equal to $50,000, the score is 'Good'
If total transactions are greater than $10,000 and lesser than or equal to $20,000, the score is 'Average'
If total transactions are lesser than or equal to $10,000, the score is 'Below Average'
Write a query to assign a performance score to each merchant and calculate the average transaction amount for each performance category 
for the period from November 2023 to April 2024. */
select m.merchant_id, m.business_name, sum(t.transaction_amount) as total_received , case when sum(t.transaction_amount)> 50000 then 'Excellent'
when sum(t.transaction_amount)> 20000 and sum(t.transaction_amount)<= 50000 then 'Good'
when sum(t.transaction_amount)> 10000 and sum(t.transaction_amount) <= 20000 then 'Average'
else 'Below Average'
end as performance_score , avg(t.transaction_amount) as average_transaction from merchants m join transactions t on m.merchant_id = t.recipient_id
where t.transaction_date >= '2023-11-01' and t.transaction_date < '2024-05-01' group by 1,2 order by 4 desc, 3 desc;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* 15.Problem statement
The marketing team wants to identify users who have been consistently engaged over the last year (from May 2023 to April 2024). A consistently engaged user is defined as one 
who has made at least one transaction in at least 6 out of the 12 months during this period.
Write a query to list user IDs and their email addresses for users who have made at least one transaction in at least 6 out of 12 months from May 2023 to April 2024.*/
with cte as
(select u.user_id, u.email, DATE_FORMAT(t.transaction_date, '%Y-%m') AS transaction_month, count(*) from transactions t join users u 
on t.sender_id = u.user_id where t.transaction_date >= '2023-05-01' and t.transaction_date < '2024-05-01' group by 1,2,3),
cte2 as
(select user_id, email, count(transaction_month) as active_month_count from cte group by 1,2)
select user_id, email from cte2 where active_month_count >= 6 order by 1 asc;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* 16.Problem statement
The sales team wants to analyze the performance of each merchant by tracking their monthly total transaction amounts and identifying months 
where their transactions exceeded $50,000.
Write a query that calculates the total transaction amount for each merchant by month, and then create a column to indicate whether the merchant 
exceeded $50,000 in that month. The transaction date range should be considered from 1st Nov 2023 to 1st May 2024. The new column should 
contain the values 'Exceeded $50,000' or 'Did Not Exceed $50,000'. Display the merchant ID, business name, transaction year, 
transaction month, total transaction amount, and the new column indicating performance status.*/
with cte as
(select m.merchant_id, m.business_name, year(t.transaction_date) as transaction_year, month(t.transaction_date) as transaction_month, sum(t.transaction_amount) as
total_transaction_amount from transactions t join merchants m on m.merchant_id = t.recipient_id where t.transaction_date >= '2023-11-01' 
and t.transaction_date < '2024-05-01' group by 1,2,3,4)
select merchant_id, business_name, transaction_year, transaction_month, total_transaction_amount, case when total_transaction_amount > 50000 then 'Exceeded $50,000'
else 'Did Not Exceed $50,000' end as performance_status from cte order by 1,3,4;











