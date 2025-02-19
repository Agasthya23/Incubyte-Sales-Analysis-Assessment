--Revenue lost and return rate percentage
SELECT
    ROUND(SUM(CASE WHEN Returned = 'Yes' THEN transaction_amount ELSE 0 END)::numeric, 2) AS revenue_lost,
    ROUND(
        (COUNT(CASE WHEN Returned = 'Yes' THEN 1 END) * 100.0) 
        / COUNT(*), 2
    ) AS return_rate_percentage
FROM sales_data;

--Total Returned Items
SELECT COUNT(*) AS total_returned_items
FROM sales_data
WHERE Returned = 'Yes';

--Online vs instore store type purchase returned
SELECT 
    store_type, 
    SUM(CASE WHEN Returned = 'Yes' THEN 1 ELSE 0 END) AS total_quantity_returned
FROM sales_data
GROUP BY store_type;



SELECT 
    CASE 
        WHEN discount_percent BETWEEN 0 AND 10 THEN '0-10%'
        WHEN discount_percent BETWEEN 11 AND 20 THEN '11-20%'
        WHEN discount_percent BETWEEN 21 AND 30 THEN '21-30%'
        WHEN discount_percent BETWEEN 31 AND 40 THEN '31-40%'
		WHEN discount_percent BETWEEN 41 AND 50 THEN '41-50%'
		WHEN discount_percent > 50 THEN '50%+'
        ELSE 'Unknown'  
    END AS discount_range,
    COUNT(*) AS total_sales,
    COUNT(CASE WHEN Returned = 'Yes' THEN 1 END) AS total_returns
FROM sales_data
GROUP BY discount_range
ORDER BY discount_range;



--Promotional
SELECT 
    is_promotional,
    COUNT(*) AS total_sales,
   ROUND(SUM(CASE WHEN Returned = 'No' THEN transaction_amount ELSE 0 END)::numeric, 2) AS total_revenue,
    ROUND(AVG(transaction_amount)::numeric, 2) AS avg_transaction_value
FROM sales_data
GROUP BY is_promotional
ORDER BY total_revenue DESC;


