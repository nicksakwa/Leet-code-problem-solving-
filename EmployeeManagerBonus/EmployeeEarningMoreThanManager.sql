SELECT 
    E.name AS Employee
FROM 
    Employee E
JOIN
    Employee M ON E.ManagerId = M.id
WHERE
    E.salary > M.salary;