SELECT 
    loan_id, 
    rate_type, 
    CASE 
        WHEN rate_type = 'fixed' THEN 1 
        ELSE 0 
    END AS fixed,
    CASE 
        WHEN rate_type = 'variable' THEN 1 
        ELSE 0 
    END AS variable
FROM submissions;
