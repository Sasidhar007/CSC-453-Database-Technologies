DROP TABLE DeactivatedUsers;
DROP TABLE UserPayments;
DROP TABLE Users;


CREATE TABLE Users(
  UserId NUMBER PRIMARY KEY,
  FirstName VARCHAR2(100) NOT NULL,
  LastName VARCHAR2(100) NOT NULL,
  IsActive CHAR(1) DEFAULT 1 NOT NUll,
  LastLoginDate DATE
);

CREATE TABLE UserPayments(
  PaymentId NUMBER PRIMARY KEY,
  UserId NUMBER NOT NULL REFERENCES Users(UserId),
  PaymentDate DATE DEFAULT SYSDATE NOT NULL,
  PaymentAmount DECIMAL(7, 2) NOT NULL
);

CREATE TABLE DeactivatedUsers(
  UserId NUMBER PRIMARY KEY,
  DeactivationDate DATE,
  FOREIGN KEY (UserId) REFERENCES Users(UserId)
);
select * from users

BEGIN

  Update Users
  SET IsActive = 0
  WHERE UserID NOT IN (
    SELECT UserID
    FROM UserPayment
    WHERE (Current_Date - PaymentDate) <= 60 
  );
  
  INSERT INTO DeactivatedUsers
  SELECT u.UserID, Current_Date
  FROM Users u
  LEFT OUTER JOIN DeactivatedUsers d ON d.UserID = u.UserID
  WHERE IsActive = 0 AND d.UserID IS NULL;

END;


/*Trigger*/


Insert into users values(112,'RamBO','ryderS',1,date '2016-10-01');
Insert into users values(113,'StarkSON','IronMAN',1,date '2015-10-01');
  
SELECT u.UserID FROM UserPayents up
LEFT JOIN Users u on up.UserID=u.UserID
WHERE (CURRENT_DATE - up.PaymentDate) <= 60 
