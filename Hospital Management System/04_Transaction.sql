BEGIN
  /*Here we are updating the address of the patient with patient_id 8*/
  UPDATE patient  
  SET address = 'West Illinois Drive, Apt3'
  WHERE patient_id = 8;
    
  /*We will be inserting a new patient record*/
  INSERT INTO Patient(PATIENT_ID,PNAME,date_of_birth,address,sex)
  VALUES(155,'Deepak',date '1990-05-28', 'West Greenwood Avenue, Cincinnati', 'MALE');
  
  /*We will be creating a new appointment for the patient named Sarah*/
  INSERT INTO Appointments(APPOINTMENT_DATES,TIMESLOT,EMPID,patient_id)
  SELECT CURRENT_TIMESTAMP, 1500, 666, patient_id from patient where patient.PNAME='Sarah';
    
  /*We will be deleting an appointment which was between Empid 555 and Patient_id 5*/
  DELETE FROM Appointments
  WHERE EMPID=555 AND PATIENT_ID=5;
  
  COMMIT;
END;