use capstones;
show tables;
select * from accounts;
select * from loans;
select * from credit_cards;
select * from customers;
select * from transactions;

# Before making primary keys we have to check null values and duplicate values for all the tables
-- Null values in customer table in customer_id column is 0
-- Duplicate values are not present in customer_id column  

select count(*) from customers where Customer_ID is null;

-- Null values in loans table in loan_id column is 0
-- Duplicate values are in loan_id column are 0

select count(*)  from loans;
select count(*) from loans where loan_id is null;

-- Null values in transactions table in transaction_id column is 0
-- Duplicate values are in transaction_id column are 0

select count(*)  from transactions;
select count(*) from transactions where transaction_id is null;

-- Null values in accounts table in account_id column is 0
-- Duplicate values are in account_id column are 0

select count(*)  from accounts;
select count(*) from accounts where account_id is null;

-- Null values in credit_cards table in card_id column is 0
-- Duplicate values are in card_id column are 0

select count(*)  from credit_cards;
select count(*) from credit_cards where card_id is null;

# we have check all the tables there are no duplicates in the tables 

# Adding primary key to the table
-- Adding primary key to customers table  
alter table customers 
add primary key(Customer_ID);
-- Adding primary key to loans table  
alter table loans 
add primary key(Loan_ID);
-- Adding primary key to accounts table  
alter table accounts 
add primary key(Account_ID);
-- Adding primary key to credit_cards table  
alter table credit_cards 
add primary key(Card_ID);
-- Adding primary key to transactions table  
alter table transactions 
add primary key(transaction_ID);

# Adding Foreign keys (Relationship between tables)
-- for Accounts  
ALTER TABLE accounts
ADD CONSTRAINT fk_accounts_customer
FOREIGN KEY (Customer_ID)
REFERENCES customers(Customer_ID);

ALTER TABLE transactions
ADD CONSTRAINT fk_transactions_account
FOREIGN KEY (Account_ID)
REFERENCES accounts(Account_ID);

ALTER TABLE loans
ADD CONSTRAINT fk_loans_customer
FOREIGN KEY (Customer_ID)
REFERENCES customers(Customer_ID);

ALTER TABLE credit_cards
ADD CONSTRAINT fk_cards_customer
FOREIGN KEY (Customer_ID)
REFERENCES customers(Customer_ID);
 
 # we have connected all the tables
desc accounts;
desc loans;
desc credit_Cards;
desc transactions;
desc customers;

# Changing Datatype of columns where needed
# Now all the columns have correct datatype

alter table accounts modify open_date date;
alter table transactions modify transaction_date date;
alter table customers modify join_date date;

-- Transactions Table
# Now we make changes in channel column assigning empty cell with unknown because they have transaction amount so we can not delete them 
update transactions 
set channel ='unknown' where Channel='';
commit;

# Adding another column cash flow type 
alter table transactions add  CashFlow_type varchar(20);

#updating cashflow type where there is deposit it is inflow else outflow

update transactions set cashflow_type=case when transaction_type='Deposit' then 'Inflow' when transaction_type in ('Withdrawal','Transfer') then 'Outflow' end;
commit;

# Loans Table 
select * from loans;
# Checking null values in every column 
select 
    SUM(case when Loan_Type is null or Loan_Type = '' then 1 else 0 end) as LoanType_Null,
    SUM(case when Loan_Amount is null then 1 else 0 end) as LoanAmount_Null,
    SUM(case when Interest_Rate is null then 1 else 0 end) as InterestRate_Null,
    sum(case when loan_term_months is null or loan_term_months='' then 1 else 0 end)as Months_null
from loans;

# Filling null values in loan_type with unknown 
update loans set 
loan_Type='unknwon'  where loan_type is null or loan_type='';
commit;

# Filling values  with most times repeat values in loan_term_months
select loan_term_months,count(*) from loans group by  loan_term_months order by count(*) desc;
update loans set 
loan_term_months=36 where loan_term_months is null or loan_term_months ='';
commit;

# Customers Table

# Checking missing values
select 
sum(case when gender is null or gender='' then 1 else 0 end) as gender_null,
sum(case when city is null or city='' then 1 else 0 end) as city_null,
sum(case when income is null or income='' then 1 else 0 end) as income_null,
sum(case when credit_score is null or credit_score='' then 1 else 0 end) as creditscore_null
from customers;

# checking gender counts :  Male-2405 Female-2393 null-202  
select gender,count(*) from customers group by  gender order by count(*) desc;

# providing 'others' in gender
update customers
set gender ='others'
where gender is null or gender ='';
commit;

# checking city count (Null-1028)
select city,count(*) from customers group by  city order by count(*) desc;

update customers set city ='unknown' where city is null or city ='';
commit;

# Checking income column 
#Income column is label as text convert to decimal or int
alter table customers modify income decimal(10,2);
update customers set income=null where income='';

# Filling missing values of income with medain

update customers set income=(select avg_income from (select avg(income) as avg_income from customers)as temp )
where income is null ;
commit;

# filling null values with median in credit_score column
update customers set credit_score=(select avg_score from (select avg(credit_score) as avg_score from customers)as temp )
where credit_score is null or credit_score='';
commit;

# Distibuting income based on their income into low, middle, high 
alter table customers add Income_category varchar(20);
update customers set Income_category=case
when income <=40000 then 'Low Income' 
when income between 40000 and 80000 then 'Middle Income' else 'High Income' end;
commit;

# Credit_cards Table

# Checking null values or missing values
select 
sum(case when card_type is null or card_type='' then 1 else 0 end) as card_null,
sum(case when credit_limit is null or credit_limit='' then 1 else 0 end) as credit_null,
sum(case when current_balance is null or current_balance='' then 1 else 0 end) as balance_null,
sum(case when late_payments is null or late_payments='' then 1 else 0 end) as payments_null
from credit_cards;

# Filling null values with unknown
update credit_cards set 
card_type='unknown' where card_type is null or card_type='';
commit;
select late_payments ,count(*) from credit_cards group by late_payments  ;
# updating late_payments with -1 where there is null which will means that there is no record for that
update credit_Cards set late_payments=-1 where late_payments is null;
commit;

# Accounts Table

#Checking Null values 
select 
sum(case when Account_Type is null or Account_Type=''  then 1 else 0 end) as account_null,
sum(case when balance is null or balance='' then 1 else 0 end) as balance_null,
sum(case when status is null or status='' then 1 else 0 end) as status_null from accounts;

# Filling null values with unknown in account_type column

update accounts set account_type='unknown' where account_type is null or account_type ='';
commit;

select status ,count(*) from accounts group by status ;
# Fiiling status with unknown where is null to avoid any confusion
update accounts set status ='unknown' where status is null or status ='';
commit;


--       Questions 

# 1) How many total customers are registered in the bank?
select count(*) as total_customers from  customers;

# 2) How many total accounts exist?
select count(*) Total_Account from accounts;

# 3) What is the total loan amount issued by the bank?
select sum(loan_amount) as Total_Loan_Amount from loans;

# 4) What is the average loan amount?
select avg(loan_amount) as Average_Loan_Amount from loans;

# 5) What is the total number of transactions?
select count(*) as Total_transactions from transactions;

# 6) What is the total credit amount issued?
select sum(current_balance) as Total_Credit_Amount from credit_cards;

# 7) What is the average transaction amount?
select avg(amount) as Average_Transaction_Amount from transactions;

# 8) List all customers who currently have loans.
select  distinct c.customer_id,a.account_id from customers c join accounts a on a.customer_id=c.customer_id 
join loans l on l.customer_id=a.customer_id;

#9) Show all accounts that do not have any loans.
select a.account_id ,l.loan_id from accounts a 
left join loans l on a.customer_id=l.customer_id where l.loan_id is null;

# 10) How many active vs closed accounts exist?
select status,count(*) from accounts group by status;

# 11) What is the average account balance by Account_Type?
select account_type,avg(balance)  as Average_Amount from accounts group by account_type;

# 12) What is the average Income by Income_category?
select income_category , avg(income) as Average_Income from customers group by income_category;

# 13) What is the average balance by Income_category?
select c.income_category , avg(a.balance) as Average_Balance from customers c 
join accounts a on a.customer_id=c.customer_id group by income_category; 

# 14) Which city has the highest number of customers?
select city ,count(*) as customers from customers group by city  order by customers desc limit 1;

# 15) 
select city ,round(avg(credit_score),2) as Average_Credit_score from customers group by city ;

# 16) How many customers have both an active account and a credit card?
select distinct c.customer_id ,a.status from customers c 
join accounts a on a.customer_id=c.customer_id 
 join credit_cards ca on ca.customer_id=a.customer_id  where a.status ='Active' ;
 
# 17) What percentage of customers have more than one account?
select customer_id, count(account_id) as Total_Account from accounts
 group by customer_id having Total_Account >1;
 
 # 18) Average Balance for Customers with Loans
 select avg(balance) as Average_Balance from accounts a
 where exists (select 1 from loans l where l.customer_id=a.customer_id) ;
 
 # 19)  Highest Total Balance by Income Category
 select c.income_category,round(sum(a.balance),2) as Total_Balance from customers c join
 accounts a on c.customer_id=a.customer_id group by c.income_category order by Total_Balance desc;
 
 # 20) find sum of income by income_category for gender wise 
 select gender,income_category,sum(income) as Total_Income from customers group by income_Category,gender order by income_category  ;
 
 # 21) Find averge loan by loan type 
 select loan_type,round(avg(loan_amount),2) as Average_Loan from loans group by loan_type;

# 22) Total Loan by Income Category 
select c.income_category,sum(l.loan_Amount) as Total_Loan from customers c join
loans l on l.customer_id=c.customer_id  group by c.income_category;

# 23) which city has highest default loan rate 
select c.city ,count(case when l.default_status=1 then 1 end) * 100.0/count(*) as Default_rate from customers c 
join loans l on l.customer_id=c.customer_id group by c.city order by Default_rate desc ;

# 24) What is the default rate by loan_term_months
select loan_term_months ,count(case when default_status =1 then 1 end) *100.0/count(*) as Default_Rate 
from loans group by loan_term_months;

# 25) Do customers with lower Credit_Score have higher default rates? 
-- Very less but yes customer with low credit score hace more default rate
select case when credit_Score<600 then 'Low' 
when credit_score between 600 and 700 then 'Medium'
else 'High' end as Credit_Category ,count(case when default_status=1 then 1 end) *100.0/count(*)as Default_Rate 
from customers c join loans l on l.customer_id=c.customer_id group by 
case when credit_Score<600 then 'Low' 
when credit_score between 600 and 700 then 'Medium' 
else 'High' end;

# 26) What is the average income of customers who defaulted?
select avg(c.income) as Average_Income_Defaulted
from loans l join customers c on  l.customer_id=c.customer_id where l.default_status =1;

# 27) Which Loan_Type has the highest average interest rate?
select loan_type,avg(Interest_rate) as Avg_Interest_Rate from loans group by loan_type order by Avg_Interest_Rate desc limit 2;

# 28) What is the total loan exposure per city?
select c.city,round(sum(l.loan_amount),2) as Total_Loan from customers c 
join loans l on l.customer_id=c.customer_id group by c.city ;

# 29) What percentage of customers have at least one loan?
select round(count(distinct l.customer_id)*100.0/(select count(*) from customers ),2) as Percentage_with_Loan
from loans l; 
-- when Customers have no loan
select round(sum( case when l.customer_id is null then 1 end) *100.0/count(*),2) as Percentage_without_Loan from customers c left join loans l
 on l.customer_id=c.customer_id;
 
 # 30) What percentage of customers exceeeds their credit limit 
 select count(*) *100.0 /(select count(*) from credit_Cards) as Percentage_exceed 
 from credit_cards where current_balance > credit_limit;
 
 # 31) Is there a relationship between Late_Payments and Credit_Score?
-- no there is no relationship betweeen them 
select l.late_payments,avg(c.credit_score) as Avg_Score from credit_cards l join customers c on l.customer_id=c.customer_id group by l.late_payments ;

# 32) Which city has the highest average credit utilization?
select c.city,avg(cr.current_balance/cr.credit_limit)*100.0 as Average_Utilization_percent from customers c 
join credit_Cards cr on cr.customer_id=c.customer_id group by c.city order by Average_Utilization_percent desc;

# 33) How many customers have both high loan amount AND high credit usage?
select count(distinct c.customer_id) as High_Risk_Customer 
from customers c join loans l on c.customer_id=l.customer_id 
join credit_cards cr on c.customer_id=cr.customer_id 
where l.loan_amount>(select avg(loan_amount) from loans) and (cr.current_balance/cr.credit_limit)>0.8;

# 34) Which Income_category has the highest Late_Payments rate?
select c.Income_category, sum(case when cr.Late_Payments > 0 then 1 else 0 end) * 100.0/
SUM(case when cr.Late_Payments >= 0 then 1 else 0 end) as late_payment_rate
from customers c join credit_cards cr on c.Customer_ID = cr.Customer_ID
group by c.Income_category order by late_payment_rate DESC LIMIT 1;

# 35) Which customers earn more than the average income?
select customer_id,income from customers where income>(select avg(income) from customers) ;

# 36) Customers who have the maximum loan amount
select customer_id ,loan_amount from loans where loan_Amount=(select max(loan_amount) from loans);

# 37) Customers who live in the city with most customers
select * from customers where city=(select city from customers group by city order by count(*) desc limit 1);

# 38) Find Customers who have both loan and credit card (Using EXISTS)
select c.customer_id from customers c where exists (select 1 from loans l where l.customer_id=c.customer_id) 
and exists(select 1 from credit_Cards cr where  cr.customer_id=c.customer_id) ;

# 39) find Customers without loans
select customer_id from customers c where not exists (select 1 from loans l where l.customer_id=c.customer_id) ;

--     Window + CTE + Ranking
# 40) Rank customers by total loan amount
select customer_id ,sum(loan_amount) ,rank() over (order by sum(loan_Amount) desc ) as Loan_Rank 
from loans group by customer_id;

# 41) Find Top 5% highest loan borrowers 
-- Using rank_percent() 
select * from 
(select customer_id,sum(loan_amount) ,percent_rank()
over (order by sum(loan_amount) desc) as rank_percent from loans group by customer_id) t where rank_percent <=0.05;

-- Using CTE
with rank_per as ( 
select customer_id,sum(loan_amount) as total_loan ,row_number() over (order by sum(loan_amount) desc ) as rn 
,count(*) over() as Total_customers from loans group by customer_id )
select customer_id,total_loan from rank_per
where rn<=Total_customers*0.05;

# 42) Find Running Total of Transactions
with Year_Total as (
select year(transaction_date) as years,sum(Amount) as Year_Sum from transactions group by year(transaction_date) ) 
select years,Year_sum,sum(Year_Sum) 
over ( order by years rows between unbounded preceding and current row) as running_total from Year_Total ;

# 43) Monthly Transaction Growth (Using LAG)
with monthly as (
select year(transaction_date)as Year ,month(transaction_date) as Month ,sum(amount) as Monthly_Sum from transactions
group by year(transaction_date),month(transaction_date)) 
select * ,Monthly_Sum  -lag(Monthly_Sum) over (order by Year,Month ) as growth from monthly;

# 44) Identify customers who are classified as high-risk borrowers, defined as customers with a Credit_Score below 600 and
# a Loan_Amount greater than the average loan amount in the bank.

select c.customer_id,c.credit_Score ,l.loan_Amount from customers c join loans l on c.customer_id=l.customer_id 
where c.credit_Score<600 and  l.loan_amount>(select avg(loan_amount) from loans) ;

# 45) Create Customer Financial Profile View
-- In this we will use customers,loans, credit_cards

create view Customer_Profile_change as
select c.customer_id,c.city,c.income_category ,sum(l.loan_amount)as Total_loan ,sum(cr.current_balance) as Total_balance from customers c 
 left join loans l on  c.customer_id=l.customer_id left join credit_Cards cr on cr.customer_id=c.customer_id 
group by c.income_category,c.customer_id,c.city;
select * from Customer_Profile_change order by income_category;

# 46) Calculate Fraud Count
with fruad as(
select account_id ,count(case when is_fraud =1 then 1 end) over (partition by account_id ) as fraud_count from transactions),count as(
select * from fruad where fraud_count>=1) select count(*) from count;

-- /\/\\/\/\\/\/\\\//\/\\/\/\//\\/\/\/\/\\\\///\\\\/\\//\/\//\\\/\-- 
# Find each customer's highest loan.
with ranked_loans as(
select customer_id,loan_amount,row_number() over (partition by customer_id order by loan_amount desc) as rn from loans)
select * from ranked_loans where rn=1;

# Calculate 3-year moving average of yearly loans
with year_loan as (
select year(join_Date) as Year ,sum(l.loan_amount) as yearly_total_amount  from customers
c join loans l on l.customer_id=c.customer_id group by year(join_Date))
select Year,yearly_total_amount,avg(yearly_total_amount) over (order by Year rows between 2 preceding and current row) as moving_Avg
from year_loan;

# Compare current year's loan total to next year.
with current_l as (
select year(join_date) as Year,sum(l.loan_amount)as Total_loan_amount from customers c
join loans l on l.customer_id=c.customer_id group by year(join_date))
select Year,round(Total_loan_amount,2),lead(round(Total_loan_amount),2) over (order by Year ) as next_year from current_l;

# Detect Transaction Spikes (Anomaly Detection)
with daily_totals as (
select transaction_Date ,sum(amount)as daily_total from transactions group by transaction_Date)
select *, daily_total-avg(daily_total) over () as deviaation_from_average  from daily_totals;


