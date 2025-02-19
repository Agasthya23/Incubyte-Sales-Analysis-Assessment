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

-- Most returned product
SELECT product_name, SUM(CASE WHEN Returned = 'Yes' THEN quantity ELSE 0 END) AS total_quantity_returned
FROM sales_data
GROUP BY product_name
ORDER BY total_quantity_returned DESC

