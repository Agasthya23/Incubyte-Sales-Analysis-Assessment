-- Handle null values in Product_Name
UPDATE sales_data
SET product_name = 'unknown_product'
WHERE product_name IS NULL