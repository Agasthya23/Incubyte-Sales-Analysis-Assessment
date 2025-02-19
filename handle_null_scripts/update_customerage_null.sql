--Handle null values in customer_age by filling with the median age of the respective city

WITH CityMedianAge AS (
    SELECT 
        city, 
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY customer_age) AS median_age
    FROM sales_data
    WHERE customer_age IS NOT NULL 
    GROUP BY city
)
UPDATE sales_data s
SET customer_age = m.median_age
FROM CityMedianAge m
WHERE s.city = m.city
AND s.customer_age IS NULL; 
