-- get the average feedback score
SELECT 
    ROUND(AVG(feedback_score), 2) AS avg_feedback_score
FROM sales_data
WHERE feedback_score IS NOT NULL;

-- feedback by city and region
SELECT 
    city,
	region,
    COUNT(*) AS total_reviews,
    ROUND(AVG(feedback_score), 2) AS avg_feedback_score
FROM sales_data
WHERE feedback_score IS NOT NULL
GROUP BY city, region
ORDER BY avg_feedback_score DESC;


-- Calculate average feedback score for each product, ordered by product name
SELECT 
    ROUND(AVG(feedback_score), 2) AS avg_feedback_score,
	product_name
FROM sales_data
GROUP BY product_name
ORDER BY avg_feedback_score;

-- Delivery time vs feedback
SELECT 
    CASE 
        WHEN delivery_time_days <= 2 THEN 'Fast (0-2 Days)'
        WHEN delivery_time_days BETWEEN 3 AND 5 THEN 'Standard (3-5 Days)'
        ELSE 'Slow (6+ Days)' 
    END AS delivery_speed,
    COUNT(*) AS total_orders,
    ROUND(AVG(feedback_score::NUMERIC), 2) AS avg_feedback_score
FROM sales_data
WHERE feedback_score IS NOT NULL
GROUP BY delivery_speed
ORDER BY avg_feedback_score DESC;

-- since all are giving avg 3 score
-- Count the number of negative and positive feedback entries
SELECT 
    SUM(CASE WHEN feedback_score IN (1, 2) THEN 1 ELSE 0 END) AS negative_feedback_count,
    SUM(CASE WHEN feedback_score IN (4, 5) THEN 1 ELSE 0 END) AS positive_feedback_count
FROM sales_data;


--Return rate percentage by product
SELECT 
    product_name, 
    feedback_score,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN returned = 'Yes' THEN 1 ELSE 0 END) AS total_returns,
    ROUND((SUM(CASE WHEN returned = 'Yes' THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 2) AS return_rate_percentage
FROM sales_data
WHERE feedback_score IS NOT NULL
GROUP BY product_name, feedback_score
ORDER BY product_name, feedback_score;




