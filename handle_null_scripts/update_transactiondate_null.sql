-- Recursive queries were time consuming and complex for large dataset, so implemented LAG() 

WITH missingdata AS (
    SELECT 
        transaction_id,
        transaction_date,
        LAG(transaction_date) OVER (ORDER BY transaction_id) + INTERVAL '1 minute' AS new_transaction_date
    FROM sales_data
)
UPDATE sales_data a
SET transaction_date = b.new_transaction_date
FROM missingdata b
WHERE a.transaction_id = b.transaction_id
AND a.transaction_date IS NULL;

-- to Check for null values
SELECT SUM(CASE WHEN transaction_date IS NULL THEN 1 ELSE 0 END) AS transaction_date_nulls from sales_data