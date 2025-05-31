Project Title: Retail Sales Analysis
Level: Beginner
Database: p1_retail_db

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid fo
Foundation in SQL.

Objectives
Set up a retail sales database: Create and populate a retail sales database with the provided sales data.
Data Cleaning: Identify and remove any records with missing or null values.
Exploratory Data Analysis (EDA): Perform basic exploratory data analysis to understand the dataset.
Business Analysis: Use SQL to answer specific business questions and derive insights from the sales data.

Project Structure
1. Database Setup
Database Creation: The project starts by creating a database named p1_retail_db.
Table Creation: A table named retail_sales is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.
CREATE DATABASE p1_retail_db;

CREATE TABLE retailsales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);

2. Data Exploration & Cleaning
Record Count: Determine the total number of records in the dataset.
SELECT COUNT(*) FROM retail_sales;

Customer Count: Find out how many unique customers are in the dataset.
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;

Category Count: Identify all unique product categories in the dataset.
SELECT DISTINCT category FROM retail_sales;

Null Value Check: Check for any null values in the dataset and delete records with missing data.
SELECT * 
FROM dbo.retailSales
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantity IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;


DELETE FROM dbo.retailSales
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantity IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;

  
3. Data Analysis & Findings
The following SQL queries were developed to answer specific business questions:

-- Write a SQL query to retrieve all columns for sales made on '2022-11-05:
SELECT * 
FROM dbo.retailSales 
WHERE sale_date = '2022-11-05';

--Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
SELECT * 
FROM dbo.retailSales 
WHERE category = 'Clothing'  
  AND FORMAT(sale_date, 'yyyy-MM') = '2022-11'
  AND quantity > 10;

  SELECT * 
FROM dbo.retailSales 
WHERE category = 'Clothing'  
  AND quantity >= 4
  AND YEAR(sale_date) = 2022
  AND MONTH(sale_date) = 11;

--Write a SQL query to calculate the total sales (total_sale) for each category.:
SELECT 
    category,
    SUM(total_sale) AS net_sale, 
    COUNT(*) AS total_orders 
FROM dbo.retailSales 
GROUP BY category;

--Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
SELECT
    ROUND(AVG(age), 2) as avg_age
FROM dbo.retailsales
WHERE category = 'Beauty'

--Write a SQL query to find all transactions where the total_sale is greater than 1000.:
SELECT * 
FROM dbo.retailSales 
WHERE total_sale > 1000;

--Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
SELECT 
    category,
    gender, 
    COUNT(*) AS total_transactions
FROM dbo.retailSales
GROUP BY category, gender;

--Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
SELECT 
    sale_year, 
    sale_month, 
    avg_sale 
FROM (
    SELECT 
        YEAR(sale_date) AS sale_year,
        MONTH(sale_date) AS sale_month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS rnk
    FROM dbo.retailSales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
) AS ranked_sales
WHERE rnk = 1;

--Write a SQL query to find the top 5 customers based on the highest total sales :
SELECT TOP 5
    customer_id,
    SUM(total_sale) AS total_sales
FROM dbo.retailSales
GROUP BY customer_id
ORDER BY total_sales DESC;

--Write a SQL query to find the number of unique customers who purchased items from each category.:
SELECT 
    category,    
    COUNT(DISTINCT customer_id) AS unique_customers
FROM dbo.retailSales
GROUP BY category;

--Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
WITH hourly_sale AS (
    SELECT *,
        CASE
            WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
            WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM dbo.retailSales
)
SELECT 
    shift,
    COUNT(*) AS total_orders    
FROM hourly_sale
GROUP BY shift;

Findings
Customer Demographics: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
High-Value Transactions: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
Sales Trends: Monthly analysis shows variations in sales, helping identify peak seasons.
Customer Insights: The analysis identifies the top-spending customers and the most popular product categories.
Reports
Sales Summary: A detailed report summarizing total sales, customer demographics, and category performance.
Trend Analysis: Insights into sales trends across different months and shifts.
Customer Insights: Reports on top customers and unique customer counts per category.
Conclusion
This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.


This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!
Thank you for your support, and I look forward to connecting with you!
