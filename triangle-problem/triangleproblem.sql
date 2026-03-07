SELECT 
    x,
    y,
    z,
    CASE 
        WHEN x + y + z > 2 * GREATEST(x,y,z)
        THEN 'Yes'
        ELSE 'No'
    END AS Triangle
FROM Triangle;
