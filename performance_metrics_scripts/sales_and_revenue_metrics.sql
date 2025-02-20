--Total Transactions made by the Supplier company for the year 2022
SELECT COUNT(*) AS total_transactions FROM sales_data

-- Total Quantity Sold
SELECT SUM(CASE WHEN Returned = 'No' THEN quantity ELSE 0 END) AS total_quantity_sold FROM sales_data;

-- Total Transactions made on each month
SELECT 
    DATE_TRUNC('month', transaction_date) AS month, 
    COUNT(*) AS total_transactions
FROM sales_data
GROUP BY month
ORDER BY month;

--Month that made the highest transaction
SELECT 
    DATE_TRUNC('month', transaction_date) AS month, 
    COUNT(*) AS total_transactions
FROM sales_data
GROUP BY month
ORDER BY total_transactions DESC;

--Net Revenue of 2022
SELECT ROUND(SUM(CASE WHEN Returned = 'No' THEN transaction_amount ELSE 0 END)::numeric, 2) AS NetRevenue
FROM sales_data;

--Highest Net Revenue Month of 2022
SELECT 
    DATE_TRUNC('month', transaction_date) AS month,
    ROUND(SUM(CASE WHEN Returned = 'No' THEN transaction_amount ELSE 0 END)::numeric, 2) AS net_revenue
FROM sales_data
GROUP BY month
ORDER BY net_revenue DESC
LIMIT 1;

-- Top method of payment in terms of Transaction Amount
SELECT payment_method, ROUND(SUM(CASE WHEN Returned = 'No' THEN transaction_amount ELSE 0 END)::numeric, 2) AS total_amount
FROM sales_data
GROUP BY payment_method
ORDER BY total_amount DESC;

-- Revenue by City and Region
SELECT city, region, ROUND(SUM(CASE WHEN Returned = 'No' THEN transaction_amount ELSE 0 END)::numeric, 2) AS total_revenue
FROM sales_data
GROUP BY city, region
ORDER BY total_revenue DESC;

-- Online vs in-store
SELECT store_type, ROUND(SUM(CASE WHEN Returned = 'No' THEN transaction_amount ELSE 0 END)::numeric, 2) AS total_revenue
FROM sales_data
GROUP BY store_type
ORDER BY store_type DESC;
