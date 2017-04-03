CREATE PROCEDURE insertpatient(
	   p_patient_id IN patient.patient_id%TYPE,
	   p_pname IN patient.pname%TYPE,
	   p_date_of_birth IN patient.date_of_birth%TYPE,
	   p_address IN patient.address%TYPE,
     p_sex IN patient.sex%TYPE)
IS
BEGIN
 
  INSERT INTO patient (patient_id, pname, date_of_birth, address, sex)
  VALUES ( p_patient_id, p_pname, p_date_of_birth, p_address, p_sex);

  COMMIT;

END;
/
