SELECT 
    a.first_name + ' ' + a.last_name AS [Applicant Name],
    a.state AS [State],
    c1.course_name AS [First Preference],
    c1.institution_name AS [Institution],
    p1.offer_status AS [First Pref Offer],
    c2.course_name AS [Accepted Course], -- Joined directly instead of a subquery
    a.atar_score AS [ATAR]
FROM applications a
-- 1. Get the 1st Preference details
LEFT JOIN preferences p1 
    ON a.applicant_id = p1.applicant_id AND p1.preference_order = 1
LEFT JOIN courses c1 
    ON p1.course_code = c1.course_code

-- 2. Get the Accepted Preference details (if any)
LEFT JOIN preferences p_acc 
    ON a.applicant_id = p_acc.applicant_id AND p_acc.response = 'Accepted'
LEFT JOIN courses c2 
    ON p_acc.course_code = c2.course_code

ORDER BY [Applicant Name];
