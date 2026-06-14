SELECT
    name,
    SUM(Transactions.amount) AS balance
FROM
    Users
JOIN
    Transactions ON Users.account = Transactions.account
GROUP BY
    Users.account
HAVING
    SUM(Transactions.amount) > 10000;
