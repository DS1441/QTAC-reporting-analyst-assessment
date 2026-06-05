WITH AcceptedApplicants AS (
    -- Identifying anyone who has accepted atleast one offer
    SELECT DISTINCT applicant_id 
    FROM preferences 
    WHERE response = 'Accepted'
)
SELECT 
    a.first_name + ' ' + a.last_name AS [Applicant Name],
    a.state AS [State],
    c.course_name AS [Preference Course],
    p.preference_order AS [Pref rank],
    p.offer_status AS [What Happened],
    p.response AS [Applicant Response]
FROM applications a
JOIN preferences p ON a.applicant_id = p.applicant_id
LEFT JOIN courses c ON p.course_code = c.course_code
WHERE a.applicant_id NOT IN (SELECT applicant_id FROM AcceptedApplicants)
ORDER BY [Applicant Name], p.preference_order;
