--creating a new database 
create database p1_retail_db
use p1_retail_db


select * from dbo.retailSales

--to rename the column
sp_rename 'dbo.retailSales.quantiy', 'quantity'
select count(*) from dbo.retailsales

--To check is there are any null values 
select * from dbo.retailsales
where transactions_id is null
or sale_date is null
or sale_time is null or customer_id is null or gender is null or age is null
or category is null or quantity is null or price_per_unit is null or cogs is null or total_sale is null

-- we have null values in age, quantity, price_per_unit, cogs, total_sale. In total we have 13 rows of null values.
-- we can delete them . 

delete from dbo.retailsales
where transactions_id is null
or sale_date is null
or sale_time is null or customer_id is null or gender is null or age is null
or category is null or quantity is null or price_per_unit is null or cogs is null or total_sale is null

-- Data Exploration

-- How many sales we have?
select Count(*) as total_sales from dbo.retailsales

-- How many uniuque customers we have ?
select  Count(distinct customer_id ) as unique_customer from dbo.retailsales

-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'
select * from dbo.retailsales where sale_date ='2022-11-05'

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' 
--and the quantity sold is more than 10 in the month of Nov-2022
select * from dbo.retailsales where category ='Clothing'  
 and FORMAT(sale_date, 'yyyy-MM') = '2022-11'
and quantity>10

select * from dbo.retailsales where category ='Clothing'  
and quantity>=4
and year(sale_date)='2022'
and MONTH(sale_date)='11'


-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select sum(total_sale) net_sale , COUNT(*) as total_orders from dbo.retailsales 
group by category 


-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select round(avg(age),2) average_age , COUNT(*) as total_orders from dbo.retailsales 
where category='Beauty'
group by category 

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * FROM dbo.retailsales 
WHERE total_sale > 1000

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT 
    category,gender, COUNT(*) as total_trans
FROM dbo.retailsales
GROUP  BY  category, gender

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

select sale_year, sale_month, avg_sale from 
(select year(sale_date) sale_year,month(sale_date) sale_month , avg(total_sale) avg_sale, 
RANK() over(partition by year(sale_date)  order by avg(total_sale) desc) as rnk
FROM dbo.retailsales
group by month(sale_date) , year(sale_date)) as t1
where rnk=1

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT top  5
    customer_id,
    SUM(total_sale) as total_sales
FROM dbo.retailsales
GROUP BY customer_id
ORDER BY SUM(total_sale) DESC

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM dbo.retailsales
GROUP BY category

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN datepart(hour, sale_time)  < 12 THEN 'Morning'
        WHEN datepart(hour, sale_time)  BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM dbo.retailsales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift
