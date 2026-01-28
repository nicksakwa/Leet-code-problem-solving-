# Write your MySQL query statement below
SELECT 
    d.name AS Department,
    e.Employee,
    e.Salary
FROM (
    SELECT 
        name AS Employee,
        salary AS salary,
        departmentId,
        DENSE_RANK() OVER (PARTITION BY departmentId ORDER BY salary DESC) AS rnk
    FROM Employee
) e
JOIN Department d ON e.departmentId =d.id
WHERE e.rnk <= 3;


