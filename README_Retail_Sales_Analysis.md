
# 🛍️ Retail Sales Analysis

**Level:** Beginner  
**Database:** `p1_retail_db`  

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. It involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those beginning their journey in data analysis and aiming to build a strong foundation in SQL.

---

## 🎯 Objectives

- **Set up a retail sales database:** Create and populate a retail sales database with sales data.
- **Data Cleaning:** Identify and remove any records with missing or null values.
- **Exploratory Data Analysis (EDA):** Understand the dataset with basic EDA.
- **Business Analysis:** Use SQL to answer specific business questions and derive insights.

---

## 🗂️ Project Structure

### 1. Database Setup

- **Database Creation:**  
```sql
CREATE DATABASE p1_retail_db;
```

- **Table Creation:**  
```sql
CREATE TABLE retailsales (
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
```

---

### 2. Data Exploration & Cleaning

- **Record Count:**  
```sql
SELECT COUNT(*) FROM retail_sales;
```

- **Customer Count:**  
```sql
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
```

- **Category Count:**  
```sql
SELECT DISTINCT category FROM retail_sales;
```

- **Null Value Check & Deletion:**  
```sql
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
```

---

### 3. Data Analysis & Findings

#### 🔹 Specific Business Queries

- Sales on a specific date  
```sql
SELECT * FROM dbo.retailSales WHERE sale_date = '2022-11-05';
```

- Clothing category sales in Nov-2022  
```sql
SELECT * FROM dbo.retailSales 
WHERE category = 'Clothing'  
  AND FORMAT(sale_date, 'yyyy-MM') = '2022-11'
  AND quantity > 10;

SELECT * FROM dbo.retailSales 
WHERE category = 'Clothing'  
  AND quantity >= 4
  AND YEAR(sale_date) = 2022
  AND MONTH(sale_date) = 11;
```

- Total sales per category  
```sql
SELECT category, SUM(total_sale) AS net_sale, COUNT(*) AS total_orders 
FROM dbo.retailSales GROUP BY category;
```

- Average age of customers in Beauty category  
```sql
SELECT ROUND(AVG(age), 2) as avg_age
FROM dbo.retailsales
WHERE category = 'Beauty';
```

- High-value transactions  
```sql
SELECT * FROM dbo.retailSales WHERE total_sale > 1000;
```

- Gender-wise transactions per category  
```sql
SELECT category, gender, COUNT(*) AS total_transactions
FROM dbo.retailSales
GROUP BY category, gender;
```

- Best-selling month in each year  
```sql
SELECT sale_year, sale_month, avg_sale 
FROM (
    SELECT YEAR(sale_date) AS sale_year,
           MONTH(sale_date) AS sale_month,
           AVG(total_sale) AS avg_sale,
           RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS rnk
    FROM dbo.retailSales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
) AS ranked_sales
WHERE rnk = 1;
```

- Top 5 customers by sales  
```sql
SELECT TOP 5 customer_id, SUM(total_sale) AS total_sales
FROM dbo.retailSales
GROUP BY customer_id
ORDER BY total_sales DESC;
```

- Unique customers per category  
```sql
SELECT category, COUNT(DISTINCT customer_id) AS unique_customers
FROM dbo.retailSales
GROUP BY category;
```

- Shift-based order counts  
```sql
WITH hourly_sale AS (
    SELECT *,
        CASE
            WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
            WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM dbo.retailSales
)
SELECT shift, COUNT(*) AS total_orders FROM hourly_sale GROUP BY shift;
```

---

## 📌 Findings

- **Customer Demographics:** Diverse age groups and popular categories like Clothing and Beauty.
- **High-Value Transactions:** Many orders over 1000 indicate premium spending.
- **Sales Trends:** Monthly and shift-wise analysis helps identify peak times.
- **Customer Insights:** Top spenders and most engaged categories are highlighted.

---

## 📄 Reports

- **Sales Summary:** Overview of sales, customer distribution, and category performance.
- **Trend Analysis:** Month-wise and shift-wise sales patterns.
- **Customer Insights:** Unique customers and high-value customers insights.

---

## ✅ Conclusion

This project is a comprehensive introduction to SQL for data analysts. It covers database creation, cleaning, EDA, and business insights using SQL. The results help understand customer behavior, product performance, and sales patterns—key for data-driven decision-making.

---

## 💼 About This Project

This project is part of my portfolio to demonstrate SQL proficiency for data analyst roles.

**Let’s connect!** Feel free to reach out with feedback, collaboration ideas, or questions.  
Thanks for your support! 🙌
