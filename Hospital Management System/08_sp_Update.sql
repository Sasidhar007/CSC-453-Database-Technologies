CREATE OR REPLACE PROCEDURE updateassigned(
  a_class IN assigned_to_room.class%type
)
IS
  BEGIN
    UPDATE ASSIGNED_TO_ROOM
    SET CLASS = a_class
    WHERE CLASS = 'BASIC';
    
  COMMIT;
  
END;
  