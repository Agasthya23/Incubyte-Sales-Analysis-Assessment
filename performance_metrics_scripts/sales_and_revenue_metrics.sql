--Total Transactions made by the Supplier company for the year 2022
SELECT COUNT(*) AS total_transactions FROM sales_data


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




