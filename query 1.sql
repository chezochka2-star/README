SELECT c.clinician_id, CONCAT(c.given_name,' ',c.family_name) clinician, COUNT(*) appointments
FROM clinician c JOIN appointment a USING(clinician_id)
WHERE a.status IN ('Scheduled','Completed') GROUP BY c.clinician_id,clinician HAVING COUNT(*) >= 2;