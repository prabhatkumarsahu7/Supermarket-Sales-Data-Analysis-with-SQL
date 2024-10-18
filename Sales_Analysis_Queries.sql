1.Total Number of Transactions:

SELECT COUNT(*) AS total_transactions FROM sales;


2.Total Sales Amount:

SELECT SUM(sales) AS total_sales FROM sales;


3.Sales by Branch:

SELECT branch, SUM(sales) AS total_sales 
FROM sales 
GROUP BY branch;


4.Total Quantity Sold by Product:

SELECT product_name, SUM(quantity) AS total_quantity_sold 
FROM sales 
GROUP BY product_name 
ORDER BY total_quantity_sold DESC 
LIMIT 10;


5. Average Unit Price of Products:

SELECT AVG(unit_price) AS average_unit_price FROM sales;


6.Sales by Customer Type:

SELECT customer_type, SUM(sales) AS total_sales 
FROM sales 
GROUP BY customer_type;


7. Total Sales by Payment Method:

SELECT payment, SUM(sales) AS total_sales 
FROM sales 
GROUP BY payment;


8.Count of Unique Customers:

SELECT COUNT(DISTINCT invoice_id) AS unique_customers FROM sales;


9. Sales on Weekdays vs. Weekends:

SELECT 
    CASE 
        WHEN DAYOFWEEK(time) IN (1, 7) THEN 'Weekend' 
        ELSE 'Weekday' 
    END AS day_type,
    SUM(sales) AS total_sales 
FROM sales 
GROUP BY day_type;


10. Top 5 Highest Gross Income Products:

SELECT product_name, SUM(gross_income) AS total_gross_income 
FROM sales 
GROUP BY product_name 
ORDER BY total_gross_income DESC 
LIMIT 5;


11. Sales by Gender:

SELECT gender, SUM(sales) AS total_sales 
FROM sales 
GROUP BY gender;


12. Average Rating by Branch:

SELECT branch, AVG(rating) AS average_rating 
FROM sales 
GROUP BY branch;


13. Sales Trend Over Time (Monthly):

SELECT MONTH(time) AS month, SUM(sales) AS total_sales 
FROM sales 
GROUP BY month 
ORDER BY month;


14. Products Sold by City:

SELECT city, product_name, SUM(quantity) AS total_quantity_sold 
FROM sales 
GROUP BY city, product_name;


15. Top 3 Payment Methods by Sales:

SELECT payment, SUM(sales) AS total_sales 
FROM sales 
GROUP BY payment 
ORDER BY total_sales DESC 
LIMIT 3;


16. Sales Distribution by Gender and Customer Type:

SELECT gender, customer_type, SUM(sales) AS total_sales 
FROM sales 
GROUP BY gender, customer_type;


17. Sales for the Highest Rating Products:

SELECT product_name, SUM(sales) AS total_sales 
FROM sales 
WHERE rating > 4.5 
GROUP BY product_name 
ORDER BY total_sales DESC;


18. Total Tax Collected:

SELECT SUM(tax_5_percent) AS total_tax_collected FROM sales;
Advanced Queries


19. Percentage Contribution of Each Branch to Total Sales:

SELECT branch, 
       SUM(sales) AS branch_sales,
       (SUM(sales) / (SELECT SUM(sales) FROM sales) * 100) AS percentage_contribution
FROM sales 
GROUP BY branch;


20.Cumulative Sales Over Time:


SELECT time, 
       SUM(sales) OVER (ORDER BY time) AS cumulative_sales 
FROM sales;


21. Most Profitable Products (by Gross Income):

SELECT product_name, 
       SUM(gross_income) AS total_gross_income 
FROM sales 
GROUP BY product_name 
ORDER BY total_gross_income DESC;


22.Customer Segmentation by Spending:

SELECT 
    CASE 
        WHEN SUM(sales) < 1000 THEN 'Low Spender'
        WHEN SUM(sales) BETWEEN 1000 AND 5000 THEN 'Medium Spender'
        ELSE 'High Spender' 
    END AS spending_category,
    COUNT(DISTINCT invoice_id) AS customer_count 
FROM sales 
GROUP BY spending_category;



23. Sales growth comparision by Month:

SELECT 
    MONTH(time) AS month,
    SUM(sales) AS total_sales,
    LAG(SUM(sales)) OVER (ORDER BY MONTH(time)) AS previous_month_sales,
    (SUM(sales) - LAG(SUM(sales)) OVER (ORDER BY MONTH(time))) / 
    NULLIF(LAG(SUM(sales)) OVER (ORDER BY MONTH(time)), 0) * 100 AS growth_rate
FROM supermarket_sales
WHERE time IS NOT NULL  
GROUP BY MONTH(time)
ORDER BY month;


24. Top 5 customers based on total Spending:

SELECT 
    invoice_id,
    customer_type,
    SUM(sales) AS total_spent,
    RANK() OVER (ORDER BY SUM(sales) DESC) AS spending_rank
FROM supermarket_sales
GROUP BY invoice_id, customer_type
ORDER BY total_spent DESC
LIMIT 5;


25. Average Sales Per Transaction:

SELECT AVG(sales) AS average_sales_per_transaction FROM sales;