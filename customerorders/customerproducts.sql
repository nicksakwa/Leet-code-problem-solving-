SELECT customer_id
FROM Customer
GROUP BY Customer_id
HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(*) FROM product);