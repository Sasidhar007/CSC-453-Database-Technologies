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


INSERT INTO Users VALUES(101, 'Rohit', 'Reddy', 1, DATE '2016-10-12');
INSERT INTO Users VALUES(102, 'Rakesh', 'Redd', 1, date '2015-12-31');
INSERT INTO Users VALUES(103, 'Nag', 'Bave', 1, date '2016-04-28');
INSERT INTO Users VALUES(104, 'Sarah', 'Palin', 1, date '2016-05-11');
INSERT INTO Users VALUES(105, 'Connor', 'Arnold', 1, date '2016-08-26');
INSERT INTO Users VALUES(106, 'James', 'Bond', 1, date '2016-09-17');
INSERT INTO Users VALUES(107, 'Dr.', 'Dre', 1, date'2016-10-22');
INSERT INTO Users VALUES(108, 'Drake', 'Jr', 0, date'2016-08-19');

INSERT INTO UserPayments VALUES(201, 103, date '2016-08-26', 60);
INSERT INTO UserPayments VALUES(202, 106, date '2016-09-29', 60);
INSERT INTO UserPayments VALUES(203, 102, date '2016-01-15', 60);
INSERT INTO UserPayments VALUES(204, 101,DATE '2016-10-12', 60);
INSERT INTO UserPayments VALUES(205, 104, date '2016-07-11', 60);
INSERT INTO UserPayments VALUES(206, 105, date '2016-10-20', 60);
INSERT INTO UserPayments VALUES(207, 107, date '2016-10-22', 60);
INSERT INTO UserPayments VALUES(208, 108, date '2016-08-19', 60);

/*The Question which was given in the assignment*/
BEGIN
  UPDATE USERS SET isactive = 0
  WHERE userid IN(select userid from userpayments where (Extract(Month from(CURRENT_TIMESTAMP)) - Extract(MONTH FROM(paymentdate))) > 2);
  
  INSERT INTO DeactivatedUsers (userid, deactivationdate)
  SELECT userid, current_timestamp from users where isactive = 0 AND USERID = 105;
  
  COMMIT;
END; 