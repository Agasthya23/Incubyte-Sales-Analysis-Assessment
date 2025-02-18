-- Replacing NULL customer_id values with -1 because:
-- 1. The original data does not provide a reliable way to determine missing customer IDs.
-- 2. Checked patterns in customer_age, region, and store_type, but no clear mapping was found.
-- 3. Using -1 differentiates missing values without introducing incorrect data.

UPDATE sales_data
SET customer_id = -1
WHERE customer_id IS NULL;