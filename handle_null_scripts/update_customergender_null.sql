--Handle Nulls values in Customer_Gender column by setting it to "not_mentioned"

UPDATE sales_data
SET customer_gender = 'not_mentioned'
WHERE customer_gender IS NULL;
