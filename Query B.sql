SELECT 
    c.institution_name,
    COUNT(p.applicant_id) AS [Total Applications],
    SUM(CASE WHEN p.preference_order = 1 THEN 1 ELSE 0 END) AS [First Preference Apps],
    SUM(CASE WHEN p.offer_status = 'Offered' THEN 1 ELSE 0 END) AS [Offers Made],
    SUM(CASE WHEN p.response = 'Accepted' THEN 1 ELSE 0 END) AS [Offers Accepted],
    
    -- Offer Rate %
    CAST(SUM(CASE WHEN p.offer_status = 'Offered' THEN 1.0 ELSE 0 END) 
         / NULLIF(COUNT(p.applicant_id), 0) * 100 AS DECIMAL(10,2)) AS [Offer Rate %],
    
    -- Acceptance Rate %
    CAST(SUM(CASE WHEN p.response = 'Accepted' THEN 1.0 ELSE 0 END) 
         / NULLIF(SUM(CASE WHEN p.offer_status = 'Offered' THEN 1 ELSE 0 END), 0) * 100 AS DECIMAL(10,2)) AS [Acceptance Rate %]

FROM courses c
LEFT JOIN preferences p ON c.course_code = p.course_code
GROUP BY c.institution_name
ORDER BY [Total Applications] DESC;
