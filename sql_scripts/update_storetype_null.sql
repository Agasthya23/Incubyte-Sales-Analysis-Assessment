-- Handle null values in store type
-- Fill null values Based on Customer's Past Transactions (excluding invalid customer_ids)

WITH CustomerPreferredStore AS (
    SELECT 
        customer_id, 
        store_type, 
        COUNT(*) AS usage_count,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY COUNT(*) DESC) AS rn
    FROM sales_data
    WHERE store_type IS NOT NULL 
    AND customer_id != -1  
    GROUP BY customer_id, store_type
)
UPDATE sales_data s
SET store_type = cps.store_type
FROM CustomerPreferredStore cps
WHERE s.customer_id = cps.customer_id
AND s.store_type IS NULL
AND cps.rn = 1;

-- Fill null values using City-Level Most Used store_type (excluding invalid customer_ids)
WITH CityPreferredStore AS (
    SELECT 
        city, 
        store_type, 
        COUNT(*) AS usage_count,
        ROW_NUMBER() OVER (PARTITION BY city ORDER BY COUNT(*) DESC) AS rn
    FROM sales_data
    WHERE store_type IS NOT NULL
    AND customer_id != -1 
    GROUP BY city, store_type
)
UPDATE sales_data s
SET store_type = cps.store_type
FROM CityPreferredStore cps
WHERE s.city = cps.city
AND s.store_type IS NULL
AND s.customer_id != -1 
AND cps.rn = 1;

-- Fill null values using City-Level for invalid customer_ids

WITH CityPreferredStore AS (
    SELECT 
        city, 
        store_type, 
        COUNT(*) AS usage_count,
        ROW_NUMBER() OVER (PARTITION BY city ORDER BY COUNT(*) DESC) AS rn
    FROM sales_data
    WHERE store_type IS NOT NULL
    GROUP BY city, store_type
)
UPDATE sales_data s
SET store_type = cps.store_type
FROM CityPreferredStore cps
WHERE s.city = cps.city
AND s.store_type IS NULL
AND s.customer_id = -1  
AND cps.rn = 1;


