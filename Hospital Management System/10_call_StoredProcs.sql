/*To call the stored procedure to insert record into the Patient table*/
BEGIN
  INSERTPATIENT(25,'Ram',date '1992-05-18','S Wabash Avenue.','MALE');
END;

/*To select an appointment from the Appointment table*/

DECLARE
     a_dat APPOINTMENTS.APPOINTMENT_DATES%TYPE;
     a_timeslot APPOINTMENTS.TIMESLOT%TYPE;
	   a_empid APPOINTMENTS.EMPID%TYPE;
begin
  SELECTAPPOINTMENTS(3 ,a_dat ,A_TIMESLOT ,A_EMPID);
  DBMS_OUTPUT.PUT_LINE('DATE OF APPOINTMENT :  ' || a_dat);
  DBMS_OUTPUT.PUT_LINE('TIMESLOT :  ' || a_timeslot);
  DBMS_OUTPUT.PUT_LINE('EMPID :  ' || a_empid);
end;

/*To update a class of the room which is initially 'BASIC' to 'BRONZE'*/

DECLARE
     a_CLASS ASSIGNED_TO_ROOM.CLASS%TYPE := 'BRONZE';
BEGIN
  UPDATEASSIGNED(A_CLASS);
  DBMS_OUTPUT.PUT_LINE('updated CLASS :  ' || a_CLASS);
END;

/*To delete a room from the assigned_tp_room table*/
BEGIN
   deleteroom(1003);
END;
