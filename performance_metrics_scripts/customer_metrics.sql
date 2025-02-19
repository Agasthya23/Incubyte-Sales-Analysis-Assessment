-- customers that were the highest profitable to the company
SELECT customer_id, ROUND(SUM(CASE WHEN Returned = 'No' THEN transaction_amount ELSE 0 END)::numeric, 2) AS total_amount
FROM sales_data
GROUP BY customer_id
ORDER BY total_amount DESC;

--Customer by age group
SELECT 
    CASE 
        WHEN customer_age BETWEEN 18 AND 30 THEN 'Young (18-30)'
        WHEN customer_age BETWEEN 31 AND 50 THEN 'Middle (31-50)'
        WHEN customer_age >= 51 THEN 'Senior (51+)'
        ELSE 'Unknown'
    END AS age_group, 
    COUNT(DISTINCT customer_id) AS total_customers,  
    COUNT(*) AS total_transactions, 
    ROUND(SUM(transaction_amount)::numeric,2) AS total_revenue
FROM sales_data
WHERE Returned = 'No'
GROUP BY age_group
ORDER BY total_revenue DESC;