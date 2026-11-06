USE crownfield_eye_hospital;
-- Q1 aggregate and HAVING: clinicians with at least two scheduled/completed visits.
SELECT c.clinician_id, CONCAT(c.given_name,' ',c.family_name) clinician, COUNT(*) appointments
FROM clinician c JOIN appointment a USING(clinician_id)
WHERE a.status IN ('Scheduled','Completed') GROUP BY c.clinician_id,clinician HAVING COUNT(*) >= 2;
-- Q2 three-table INNER JOIN: appointment, patient and clinician.
SELECT a.appointment_id, CONCAT(p.given_name,' ',p.family_name) patient, CONCAT(c.given_name,' ',c.family_name) clinician, a.appointment_date
FROM appointment a JOIN patient p USING(patient_id) JOIN clinician c USING(clinician_id);
-- Q3 LEFT JOIN: find appointments without a recorded diagnosis.
SELECT a.appointment_id,a.patient_id,a.appointment_date FROM appointment a LEFT JOIN diagnosis d USING(appointment_id) WHERE d.diagnosis_id IS NULL;
-- Q4 subquery: patients with more appointments than the overall per-patient average.
SELECT patient_id,COUNT(*) visits FROM appointment GROUP BY patient_id HAVING COUNT(*) > (SELECT AVG(n) FROM (SELECT COUNT(*) n FROM appointment GROUP BY patient_id) x);
-- Q5 procedure call (created in 03).
CALL GetPatientAppointments('OP001');
-- Q6 trigger demonstration: update status in transaction, inspect audit row, then roll back.
START TRANSACTION; UPDATE appointment SET status='Cancelled' WHERE appointment_id=3; SELECT * FROM appointment_audit WHERE appointment_id=3; ROLLBACK;
