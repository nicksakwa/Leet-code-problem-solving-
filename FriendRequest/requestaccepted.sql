# Write your MySQL query statement below
SELECT 
    id,
    COUNT(*) AS num
FROM (
    SELECT requester_id AS id FROM RequestAccepted
    UNION ALL
    SELECT accepter_id FROM RequestAccepted
) AS combined
GROUP BY id
HAVING num =(
    SELECT COUNT(*)
    FROM (
        SELECT requester_id AS id FROM RequestAccepted
        UNION ALL
        SELECT accepter_id FROM RequestAccepted
    ) AS combined
    GROUP BY id
    ORDER BY COUNT(*) DESC
    LIMIT 1
);