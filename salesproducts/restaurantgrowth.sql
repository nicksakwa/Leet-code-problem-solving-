SELECT 
    visited_on, 
    amount, 
    average_amount
FROM (
    SELECT 
        visited_on, 
        SUM(SUM(amount)) OVER (ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS amount, 
        ROUND(SUM(SUM(amount)) OVER (ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) / 7.0, 2) AS average_amount,
        COUNT(*) OVER (ORDER BY visited_on ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS day_count
    FROM Customer
    GROUP BY visited_on
) AS GrowthCalculationTable
WHERE day_count >= 7
ORDER BY visited_on;