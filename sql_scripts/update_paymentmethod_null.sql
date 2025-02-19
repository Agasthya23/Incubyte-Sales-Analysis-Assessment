-- Handle null values in payment method for customers who have only one type of payment method.
-- If a customer has only transacted with one type of payment method, fill in the null values with that method.
WITH SinglePaymentCustomers AS (
    SELECT customer_id, MAX(payment_method) AS payment_method
    FROM sales_data
    WHERE payment_method IS NOT NULL
    AND customer_id != -1 
    GROUP BY customer_id
    HAVING COUNT(DISTINCT payment_method) = 1 
)
UPDATE sales_data s
SET payment_method = spc.payment_method
FROM SinglePaymentCustomers spc
WHERE s.customer_id = spc.customer_id
AND s.payment_method IS NULL;

-- Handle most used payment method by customer_id, prioritizing the most frequently used payment method.
--  If there are multiple payment methods with the same usage count, selecting  the latest transaction date.
WITH MostUsedPayment AS (
    SELECT 
        customer_id, 
        payment_method, 
        COUNT(*) AS usage_count,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY COUNT(*) DESC, MAX(transaction_date) DESC) AS rn
    FROM sales_data
    WHERE payment_method IS NOT NULL
    AND customer_id != -1  
    GROUP BY customer_id, payment_method
)
UPDATE sales_data t1
SET payment_method = m.payment_method
FROM MostUsedPayment m
WHERE t1.customer_id = m.customer_id
AND t1.payment_method IS NULL
AND m.rn = 1
AND t1.customer_id != -1;  

-- For customers without a payment method and Customers having no cust_id, null values are handled by using the most frequent payment method in their city.
WITH MostUsedPayment AS (
    SELECT 
        city, 
        payment_method, 
        COUNT(*) AS usage_count,
        ROW_NUMBER() OVER (PARTITION BY city ORDER BY COUNT(*) DESC, MAX(transaction_date) DESC) AS rn
    FROM sales_data
    WHERE payment_method IS NOT NULL
    GROUP BY city, payment_method
)
UPDATE sales_data s
SET payment_method = m.payment_method
FROM MostUsedPayment m
WHERE s.city = m.city
AND s.payment_method IS NULL
AND m.rn = 1;
