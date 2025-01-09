create database paypal;
use paypal;
select * from countries;
select * from currencies;
select * from merchants;
select * from transactions;
select * from users;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Problem statement 
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
/* Problem statement 
To effectively manage risk, it's crucial to identify and monitor high-value transactions.
Find transactions exceeding $10,000 in the year 2023 and include transaction ID, sender ID, 
recipient ID (if available), transaction amount, and currency used.*/
select transaction_id, sender_id, recipient_id, transaction_amount, currency_code from transactions where transaction_amount > 10000 and 
date_format(transaction_date, "%Y") = 2023;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Problem statement
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
/* Problem statement
The finance team wants to analyze the company's exposure to currency risks.
Analyze currency conversion trends from 22 May 2023 to 22 May 2024. Calculate the total amount 
converted from each source currency to the top 3 most popular destination currencies.*/
select currency_code, sum(transaction_amount) as total_converted from transactions where transaction_date >= '2023-05-22' and 
transaction_date < '2024-05-22' group by 1 order by 2 desc limit 3;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Problem statement
The finance team is evaluating transaction classifications.
Categorize transactions as 'High Value' (above $10,000) or 'Regular' (below $10,000) and calculate the total amount for each category for the year 2023.*/
select transaction_category, sum(transaction_amount) as total_amount from 
(select transaction_amount, case when transaction_amount > 10000 then 'High Value' 
when transaction_amount < 10000 then 'Regular' end as transaction_category from transactions where date_format(transaction_date, '%Y') = 2023) temp
group by 1 order by 2 desc;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Problem statement


