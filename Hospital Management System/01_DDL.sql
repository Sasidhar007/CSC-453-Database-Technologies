DROP TABLE bills;
DROP TABLE assigned_to_room;
DROP TABLE diagnosis;
DROP TABLE appointments;
DROP TABLE patient;
DROP TABLE doctor;

CREATE TABLE patient
(
  patient_id INT NOT NULL,
  pname VARCHAR(25) NOT NULL,
  date_of_birth DATE NOT NULL,
  address VARCHAR(40) NOT NULL,
  sex VARCHAR(10) NOT NULL,
  PRIMARY KEY (patient_id)
);

CREATE TABLE doctor
(
  empid INT NOT NULL,
  ename VARCHAR(25) NOT NULL,
  specialisation VARCHAR(25) NOT NULL,
  charge_per_hour INT NOT NULL,
  PRIMARY KEY (empid)
);


CREATE TABLE bills
(
  bill_id INT NOT NULL,
  cost_of_diagnosis INT NOT NULL,
  doctor_charges INT NOT NULL,
  room_charges int default NULL,
  patient_id INT NOT NULL,
  PRIMARY KEY (bill_id),
  FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
);


CREATE TABLE assigned_to_room
(
  room_id INT NOT NULL,
  class VARCHAR(10) NOT NULL,
  patient_id INT NOT NULL,
  PRIMARY KEY (room_id),
  FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
);

CREATE TABLE diagnosis
(
  diagnosis_id INT NOT NULL,
  cost_of_diagnosis INT NOT NULL,
  empid INT NOT NULL,
  patient_id INT NOT NULL,
  PRIMARY KEY (diagnosis_id, empid, patient_id),
  FOREIGN KEY (empid) REFERENCES doctor(empid),
  FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
);

CREATE TABLE appointments
(
  appointment_dates DATE NOT NULL,
  timeslot INT NOT NULL,
  empid INT NOT NULL,
  patient_id INT NOT NULL,
  PRIMARY KEY (empid, patient_id),
  FOREIGN KEY (empid) REFERENCES doctor(empid),
  FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
);