-- Highest and lowest revenue generating product 
SELECT product_name, ROUND(SUM(CASE WHEN Returned = 'No' THEN transaction_amount ELSE 0 END)::numeric, 2) AS total_amount
FROM sales_data
GROUP BY product_name
ORDER BY total_amount DESC;

-- Top and least selling Product
SELECT product_name, SUM(CASE WHEN Returned = 'No' THEN quantity ELSE 0 END) AS total_quantity
FROM sales_data
GROUP BY product_name
ORDER BY total_quantity DESC;

-- Most returned product by qty
SELECT product_name, SUM(CASE WHEN Returned = 'Yes' THEN quantity ELSE 0 END) AS total_quantity_returned
FROM sales_data
GROUP BY product_name
ORDER BY total_quantity_returned DESC

--most returned products by transaction frequency
SELECT product_name, COUNT(CASE WHEN Returned = 'Yes' THEN 1 END) AS total_returns
FROM sales_data
GROUP BY product_name
ORDER BY total_returns DESC;

-- Product with the highest loyalty points
SELECT 
    product_name,
    SUM(CASE WHEN loyalty_points > 0 THEN loyalty_points ELSE 0 END) AS total_loyalty_points_earned,
    COUNT(CASE WHEN loyalty_points > 0 THEN 1 END) AS total_transactions_with_loyalty
FROM sales_data
GROUP BY product_name
ORDER BY total_loyalty_points_earned DESC;

--Product th