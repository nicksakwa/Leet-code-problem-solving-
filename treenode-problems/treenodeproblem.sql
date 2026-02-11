SELECT 
    id,
    CASE
        WHEN p_id is NULL then 'Root'
        WHEN id IN (SELECT p_id FROM Tree WHERE p_id is NOT NULL ) THEN 'Inner'
        ELSE 'Leaf'
END AS type FROM tree;