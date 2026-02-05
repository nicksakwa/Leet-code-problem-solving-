WITH GroupedDays AS (
    SELECT
        id,
        visit_date,
        people,
        id -ROW_NUMBER() OVER ( ORDER BY id) AS island_id
    FROM stadium
    WHERE people >= 100 
)
SELECT 
    id,
    visit_date,
    people
FROM GroupedDays
WHERE island_id IN(
    SELECT island_id 
    FROM GroupedDays
    GROUP BY island_id
    HAVING COUNT(*) >=3 
)
ORDER BY visit_date;