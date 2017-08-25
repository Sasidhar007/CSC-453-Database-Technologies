CREATE TRIGGER TRIGGER3
BEFORE UPDATE ON USERS
FOR EACH ROW
DECLARE
  u_userid Users.UserID%TYPE;
  CURSOR u_users is
   SELECT u.userid FROM UserPAYMENTS u WHERE (current_date - u.paymentdate) >= 60 ;
   
BEGIN
  OPEN u_users;
  LOOP
    FETCH u_users into u_userid; EXIT when u_users%NOTFOUND;
    dbms_output.put_line  (u_userid); 
    INSERT INTO DeactivatedUsers VALUES(u_userid, current_timestamp);
  END LOOP;
  CLOSE u_users;
END;
/


CREATE TRIGGER TRIGGER4
BEFORE UPDATE or INSERT ON deactivatedUSERS
FOR EACH ROW
DECLARE
  u_userid Users.UserID%TYPE;
  CURSOR u_users is
   SELECT userid FROM DEACTIVATEDUSERS;
   
BEGIN
  OPEN u_users;
  LOOP
    FETCH u_users into u_userid; EXIT when u_users%NOTFOUND;
    dbms_output.put_line  (u_userid); 
    UPDATE USERS SET isactive = 0
    WHERE userid = u_userid;
  END LOOP;
  CLOSE u_users;
END;
/
