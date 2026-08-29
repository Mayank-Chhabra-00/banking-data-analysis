# banking-data-analysis

# 🏦 Banking Data Analysis

An end-to-end banking data analytics project focused on analyzing customers, accounts, loans, credit cards, and transactions using **SQL, Python, Excel, and Power BI**.

The project demonstrates data cleaning, relational database design, exploratory analysis, financial analysis, customer segmentation, credit risk analysis, transaction analysis, and dashboard development.

---

## 📌 Project Overview

This project analyzes banking data from multiple interconnected datasets to generate meaningful business insights.

The analysis covers:

- Customer demographics and income
- Bank accounts and balances
- Loans and loan defaults
- Credit cards and credit utilization
- Banking transactions
- Customer financial profiles
- Credit and loan risk
- Transaction trends and anomalies

The SQL analysis contains **46+ business and analytical questions**, ranging from basic aggregations to advanced SQL concepts such as CTEs, subqueries, `EXISTS`, window functions, ranking, and anomaly analysis.

---

## 🎯 Project Objectives

The main objectives of this project are to:

- Analyze customer and account information
- Understand loan distribution and exposure
- Analyze loan default behavior
- Examine credit scores and credit utilization
- Identify high-risk customers
- Analyze transaction activity and growth
- Compare financial behavior across income categories and cities
- Identify potential transaction anomalies
- Build a customer financial profile
- Create meaningful business insights for banking decision-making

---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|------|---------|
| **MySQL / SQL** | Data cleaning, transformation, relational analysis and business queries |
| **Python** | Data analysis and exploratory analysis |
| **Pandas** | Data manipulation and analysis |
| **Excel** | Source datasets and data preparation |
| **Power BI** | Interactive dashboard and visualization |
| **Jupyter Notebook** | Python-based analysis |

---

## 📂 Dataset

The project contains five major banking datasets:

### 👥 Customers
Contains customer-level information such as:

- Customer ID
- Gender
- City
- Income
- Credit Score
- Income Category
- Join Date

### 🏦 Accounts
Contains information about customer bank accounts:

- Account ID
- Customer ID
- Account Type
- Balance
- Status
- Open Date

### 💰 Loans
Contains loan-related information:

- Loan ID
- Customer ID
- Loan Type
- Loan Amount
- Interest Rate
- Loan Term
- Default Status

### 💳 Credit Cards
Contains credit-card information:

- Card ID
- Customer ID
- Card Type
- Credit Limit
- Current Balance
- Late Payments

### 💸 Transactions
Contains banking transaction information:

- Transaction ID
- Account ID
- Transaction Date
- Transaction Type
- Amount
- Channel
- Fraud Indicator
- Cash Flow Type

---

## 🧹 Data Cleaning & Preparation

The SQL workflow includes:

- Checking NULL values
- Checking duplicate records
- Creating primary keys
- Creating foreign-key relationships
- Correcting data types
- Handling missing categorical values
- Standardizing unknown values
- Creating a `CashFlow_type` column
- Categorizing transaction inflow and outflow

The five tables are connected through customer and account relationships to create a relational banking dataset. 

---

## 📊 SQL Analysis

The project includes **46+ analytical questions** covering:

### Customer & Account Analysis
- Total number of customers
- Total number of accounts
- Active vs. closed accounts
- Average account balance
- Customer distribution by city
- Income-category analysis
- Customers with multiple accounts

### Loan Analysis
- Total loan amount issued
- Average loan amount
- Average loan by loan type
- Loan exposure by city
- Loan distribution by income category
- Loan default rates
- Default rate by loan term
- Highest loan amount
- Top borrowers

### Credit Card Analysis
- Total credit amount
- Credit utilization by city
- Customers exceeding credit limits
- Late-payment analysis
- Credit-score analysis
- High credit-usage customers

### Risk Analysis
The project identifies customers with combinations of:

- Low credit score
- High loan amount
- High credit utilization

It also analyzes default behavior across credit-score categories. 

### Transaction Analysis
The project includes:

- Total transaction count
- Average transaction amount
- Running transaction totals
- Monthly transaction growth
- Fraud-count analysis
- Transaction spike detection

---

## 🧠 Advanced SQL Concepts

This project demonstrates practical use of:

- `JOIN`
- `LEFT JOIN`
- `GROUP BY`
- `HAVING`
- Subqueries
- CTEs
- `EXISTS`
- `NOT EXISTS`
- `CASE`
- Aggregate functions
- `RANK()`
- `ROW_NUMBER()`
- `PERCENT_RANK()`
- `LAG()`
- `LEAD()`
- Window functions
- Running totals
- Moving averages
- Anomaly detection

For example, window functions are used to rank customers by total loan amount, identify the top 5% of borrowers, calculate running transaction totals, analyze monthly growth, and calculate moving averages. :contentReference[oaicite:1]{index=1} :contentReference[oaicite:2]{index=2}

---

## 📈 Power BI Dashboard

The project also includes an interactive **Power BI dashboard** developed using the banking datasets.

The dashboard provides a visual representation of banking performance and customer financial behavior.

📁 Dashboard file:

`PowerBI/Mayank_capstone_project.pbix`

---

## 🐍 Python Analysis

Python/Jupyter Notebook is included for analytical exploration and data analysis.

📁 Notebook:

`Python/capstone.ipynb`

---

## 📁 Project Structure

```text
banking-data-analysis/
│
├── 📁 Data/
│   ├── accounts.xlsx
│   ├── customers.xlsx
│   ├── loans.xlsx
│   ├── credit card.xlsx
│   └── transsaction.xlsx
│
├── 📁 SQL/
│   └── capstones.sql
│
├── 📁 Python/
│   └── capstone.ipynb
│
├── 📁 PowerBI/
│   └── Mayank_capstone_project.pbix
│
└── README.md
