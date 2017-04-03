CREATE OR REPLACE PROCEDURE selectappointments(
     a_patient IN appointments.patient_id%TYPE,
	   a_dat OUT appointments.appointment_dates%TYPE,
	   a_timeslot OUT appointments.timeslot%TYPE,
	   a_empid OUT appointments.empid%TYPE
	   )
IS
BEGIN
 
  select APPOINTMENT_DATES, TIMESLOT, EMPID into a_dat, a_timeslot, a_empid from appointments  where PATIENT_ID = a_patient;
  COMMIT;

END;
/

drop procedure selectappointments;