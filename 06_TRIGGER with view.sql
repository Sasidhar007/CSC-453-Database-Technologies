CREATE VIEW USERS_VW AS SELECT * FROM USERS;
DROP TRIGGER TRIGGER3


CREATE TRIGGER TRIGGER3
INSTEAD OF INSERT OR UPDATE ON USERS_VW
FOR EACH ROW
DECLARE

  u_userid Users.UserID%TYPE;
  CURSOR u_users is
   SELECT u.userid FROM UserPAYMENTS u WHERE (current_date - u.paymentdate) >= 60 ;
   
BEGIN
  OPEN u_users;
  LOOP
    FETCH u_users into u_userid; EXIT when u_users%NOTFOUND; 
    INSERT INTO DeactivatedUsers VALUES(u_userid, current_timestamp);
    UPDATE USERS SET ISACTIVE = 0 WHERE USERID = :new.U_USERID;
  END LOOP;
  CLOSE u_users;
END;
/

drop deactivatedusers;
DROP TRIGGER TRIGGER4;

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
