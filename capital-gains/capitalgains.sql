SELECT
    Stocks.stock_name,
    SUM(
        CASE
            WHEN Stocks.operation ='Buy' Then -Stocks.price
            ELSE Stocks.price
        END
    ) AS capital_gain_loss
FROM Stocks
GROUP BY Stocks.stock_name;