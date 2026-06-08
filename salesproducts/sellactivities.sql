SELECT 
    Activities.sell_date,
    COUNT(DISTINCT Activities.product) AS num_sold,
    GROUP_CONCAT(
        DISTINCT Activities.product
        ORDER BY Activities.product ASC
        SEPARATOR ','
    ) AS products
FROM Activities
GROUP BY Activities.sell_date
ORDER BY Activities.sell_date ASC;