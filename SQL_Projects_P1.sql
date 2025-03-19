-- SQL Retail Sales Analysis 
create database Sql_Project_P1;
CREATE TABLE Retail_sales (
    transactions_id INT,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(50),
    age INT,
    category VARCHAR(50),
    quantiy INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);
-- Data Cleaning
select count(*)from Retail_sales;
select * from retail_sales;

select * from Retail_sales 
where 
transactions_id is Null
or
    sale_date is Null
    or
    sale_time is Null
    or
    customer_id is Null
    or
    gender is Null
    or
    age is Null
    or
    category is Null
    or
    quantiy is Null
    or
    price_per_unit is Null
    or
    cogs is Null
    or
    total_sale is Null;

-- Data Exploration
 
 -- How Many Sales We Have?
 select count(*)  as Total_sales from retail_sales;
 
 -- how many unique customers we have?
  select count(Distinct customer_id)  as unique_Customers from retail_sales;
  
  -- how many category we Have?
  select distinct category from retail_sales;
  
  -- Data Analysis & Business Key Problems & Answers 
  
-- 1.Write a SQL query to retrieve all columns for sales made on 2022-11-05?
select *from retail_sales
where sale_date='2022-11-05';
-- 2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
SELECT 
    *
FROM
    retail_sales
WHERE
    category = 'Clothing' AND quantiy >= 4
        AND sale_date BETWEEN '2022-11-01' AND '2022-11-30';

-- 3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:

SELECT 
    category,
    SUM(Total_sale) AS Net_sale,
    COUNT(*) AS Total_orders
FROM
    retail_sales
GROUP BY category;

-- 4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
select * from retail_sales;
select round(Avg(age),2) as Avg_age from retail_sales
where category = 'Beauty';

-- 5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
select * from retail_sales
where total_sale >= 1000;

-- 6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
select category, gender, count(*)  as Transactions from retail_sales group by category, gender order by category;

-- 7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
select * from retail_sales;
select Avg_year,Avg_month, Avg_sale from
(select year(sale_date) as Avg_Year,
month(sale_date) as avg_month,
Round(avg(total_sale),2) as Avg_sale,
Rank()over(partition by year(sale_date) Order by avg(total_sale) desc) as Rn
from retail_sales
group by year(sale_date),
month(sale_date)) as T1
Where Rn = 1;


-- 8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
SELECT 
    Customer_id, SUM(total_sale) AS Total_Sales
FROM
    retail_sales
GROUP BY Customer_id
ORDER BY SUM(total_sale) DESC
LIMIT 5;


-- 9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
select category,count(distinct( customer_id)) as unique_id from retail_sales group by category;

-- 10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
select * from retail_sales;
with hourly_sales as(select *,
case
when Hour(sale_time) <12 Then 'Morning'
When hour(sale_time) between 12 And 17 Then 'Afternoon'
Else 'Evening'
END as shift
from retail_sales)
select shift,
count(*) as total_orders
from hourly_sales
group by shift;