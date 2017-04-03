/*This cursor will return the appointments between the date '2016-05-05' and '2016-10-10'*/

DECLARE
  app_rec appointments%rowtype;
  CURSOR app_cur IS
  SELECT * FROM appointments WHERE appointment_dates Between date '2016-05-05' and date '2016-10-10';
BEGIN
  OPEN app_cur;
  FETCH app_cur INTO app_rec;
  DBMS_OUTPUT.PUT_LINE (app_rec.appointment_dates || ' ' || app_rec.timeslot || ' ' || app_rec.empid || ' ' || app_rec.patient_id);
  CLOSE app_cur;
END;
