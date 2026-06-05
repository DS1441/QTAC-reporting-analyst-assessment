-- Fix the lowercase 'qld' for consistency
UPDATE applications 
SET state = 'QLD' 
WHERE state = 'qld';

-- Rounding off ATARs to 2 places
UPDATE applications 
SET atar_score = ROUND(atar_score, 2);

UPDATE courses 
SET study_mode = 'Full-time' 
WHERE study_mode = 'full-time';


ALTER TABLE preferences 
ALTER COLUMN preference_id INT;

DELETE FROM preferences 
WHERE preference_id = 22.00;

