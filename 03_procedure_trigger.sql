USE crownfield_eye_hospital;
DELIMITER $$
CREATE PROCEDURE GetPatientAppointments(IN p_patient_id VARCHAR(10))
BEGIN
  SELECT a.appointment_id,a.appointment_date,a.appointment_time,a.status,c.clinic_name
  FROM appointment a JOIN clinic c USING(clinic_id)
  WHERE a.patient_id=p_patient_id ORDER BY a.appointment_date,a.appointment_time;
END$$
CREATE TRIGGER appointment_status_audit AFTER UPDATE ON appointment
FOR EACH ROW
BEGIN
  IF OLD.status <> NEW.status THEN
    INSERT INTO appointment_audit(appointment_id,old_status,new_status,changed_by)
    VALUES(OLD.appointment_id,OLD.status,NEW.status,CURRENT_USER());
  END IF;
END$$
DELIMITER ;
