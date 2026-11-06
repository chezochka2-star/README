USE crownfield_eye_hospital;
-- Run as an administrator. Demonstration roles require a host supporting MySQL roles.
CREATE ROLE IF NOT EXISTS 'hospital_admin';
CREATE ROLE IF NOT EXISTS 'doctor';
CREATE ROLE IF NOT EXISTS 'receptionist';
CREATE ROLE IF NOT EXISTS 'patient_portal';
GRANT ALL PRIVILEGES ON crownfield_eye_hospital.* TO 'hospital_admin';
GRANT SELECT,INSERT,UPDATE ON crownfield_eye_hospital.appointment TO 'doctor';
GRANT SELECT,INSERT,UPDATE ON crownfield_eye_hospital.diagnosis TO 'doctor';
GRANT SELECT ON crownfield_eye_hospital.patient TO 'doctor';
GRANT SELECT,INSERT,UPDATE ON crownfield_eye_hospital.appointment TO 'receptionist';
GRANT SELECT ON crownfield_eye_hospital.patient TO 'receptionist';
GRANT SELECT ON crownfield_eye_hospital.clinician TO 'receptionist';
GRANT SELECT ON crownfield_eye_hospital.clinic TO 'receptionist';
GRANT SELECT ON crownfield_eye_hospital.appointment TO 'patient_portal';
-- Production note: patient row-level isolation needs a safe application/API layer or per-patient views/accounts.
-- Least privilege and parameterized queries should be enforced by the application connection.
-- Transaction example: destructive test is explicitly rolled back.
START TRANSACTION;
UPDATE appointment SET status='Cancelled' WHERE appointment_id=3;
DELETE FROM follow_up_plan WHERE appointment_id=3;
ROLLBACK;
-- Data protection discussion: use salted password hashing in an application identity provider.
-- Avoid reversible storage of passwords. Encrypt backups and restrict access to identifying/clinical data.
