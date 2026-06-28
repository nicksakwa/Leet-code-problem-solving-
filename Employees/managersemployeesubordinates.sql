SELECT
    Managers.employee_id,
    Managers.name,
    COUNT(Subordinates.employee_id) AS reports_count,
    ROUND(AVG(Subordinates.age)) AS average_age
FROM
    Employees AS Managers
JOIN
    Employees AS Subordinates
    ON Managers.employee_id = Subordinates.reports_to
GROUP BY
    Managers.employee_id,
    Managers.name
ORDER BY
    Managers.employee_id ASC;