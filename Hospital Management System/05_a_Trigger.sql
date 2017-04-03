DROP TRIGGER HMSTRIGGER;
CREATE TRIGGER HMSTRIGGER
BEFORE INSERT ON APPOINTMENTS
FOR EACH ROW
DECLARE
  counter NUMBER := 0 ;
  t_patient_id patient.patient_id%type;
  CURSOR u_users is
      SELECT patient_id FROM patient;
BEGIN
   OPEN u_users;
    LOOP
      FETCH u_users into t_patient_id;
      SELECT COUNT(*) INTO COUNTER FROM PATIENT WHERE patient_id = t_patient_id;
      IF COUNTER = 0 THEN
        dbms_output.put_line ('The patient does not exist. create a new patient record.');
      END IF;
    END LOOP;
END;
/
