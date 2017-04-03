/*1.the patient who had visited  the doctor named fraser*/
select distinct(P.patient_id), p.pname from patient p where p.patient_id IN (select a.PATIENT_ID from APPOINTMENTS a where a.empid = (select EMPID from doctor where ename = 'Fraser'));

/*2. the days when EMPID 333 had appointments  and the timing of the appointments and the employee name USING LEFT JOIN*/
select d.ename, d.empid, a.PATIENT_ID, a.APPOINTMENT_DATES, a.TIMESLOT from doctor d
left join appointments a ON D.EMPID = A.EMPID
WHERE d.empid= 333
ORDER BY a.APPOINTMENT_DATES;


/*3. which doctor did Patient named sarah visit on what the breakdown of the bill*/
select d.ename,d.empid, b.COST_OF_DIAGNOSIS,b.DOCTOR_CHARGES,b.ROOM_CHARGES from bills b, doctor d, appointments a where b.PATIENT_ID=(select patient_id from patient where pname='Sarah') and a.PATIENT_ID=b.PATIENT_ID and a.EMPID=d.EMPID;


/*4. group appointments based on the number of appointments in that month*/
select extract(month from(appointment_dates)) as Monthss, count(appointment_dates)  from appointments group by extract(month from(APPOINTMENT_DATES)) order by monthss;

/*5. The patients who opted for the different classes in rooms using right join*/
select p.patient_id, p.pname, a.class from patient p
right join ASSIGNED_TO_ROOM a
on p.PATIENT_ID=a.PATIENT_ID
order by a.class;

/*6. the patient who paid the most*/
select p.patient_id, p.pname, (b.DOCTOR_CHARGES + b.COST_OF_DIAGNOSIS + b.ROOM_CHARGES) as total from bills b, patient p 
where b.patient_id=p.patient_id 
and
b.PATIENT_ID = (select b.PATIENT_ID from bills b where (b.COST_OF_DIAGNOSIS+b.DOCTOR_CHARGES+b.ROOM_CHARGES) >= (select max(COST_OF_DIAGNOSIS + DOCTOR_CHARGES + ROOM_CHARGES) from bills));

/*7. select the doctor who issued the costliest diagnosis and to which patient*/
select d.empid,d.ename, di.DIAGNOSIS_ID, di.COST_OF_DIAGNOSIS, p.PATIENT_ID,p.pname from doctor d, diagnosis di, patient p where di.COST_OF_DIAGNOSIS=(select max(COST_OF_DIAGNOSIS) from diagnosis) and di.EMPID=d.EMPID and di.PATIENT_ID=p.patient_id;


/*8. patient who did not pay the room charges as they weren't admitted into the hospital or the patients who were out patients*/
select p.patient_id,p.pname from patient p
right join bills b
on b.PATIENT_ID=p.PATIENT_ID
where b.ROOM_CHARGES is null;

/*9. The doctor who charges the most*/
select ename,empid, SPECIALISATION ,CHARGE_PER_HOUR from doctor where CHARGE_PER_HOUR = (select max(CHARGE_PER_HOUR) from doctor);

/*10. The patients who have visited the  after may 31, 2106*/
select * from APPOINTMENTS where extract(month from (APPOINTMENT_DATES)) > 5 order by APPOINTMENT_DATES;

/*11. how much did each patient pay for an appointment in a certain time period*/
select b.patient_id, a.empid, a.appointment_dates,(b.cost_of_diagnosis + b.doctor_charges + b.room_charges) as TOTAL  from APPOINTMENTS a join bills b on b.PATIENT_ID = a.PATIENT_ID where a.APPOINTMENT_DATES BETWEEN date '2016-09-11' and date '2016-10-10';

/*12. Display the patient, doctor he visited and the psecialisation of the doctor and the date and time of the appointment*/
select p.patient_id, d.empid, d.specialisation, a.APPOINTMENT_DATES, a.TIMESLOT from APPOINTMENTS a inner join patient p on a.patient_id = p.PATIENT_ID inner join doctor d on d.EMPID = a.EMPID;

/*13. The most busiest or the most popular doctor in the hospital*/
select a.empid , d.ename ,count(*) from appointments a left join doctor d on a.empid = d.EMPID group by a.EMPID, d.ename having count(*) >= all(select count(*) from appointments group by empid);


/*14. Summarize the bills table usign the aggregate operators*/
select sum(cost_of_diagnosis), sum(doctor_charges), sum(room_charges),avg(cost_of_diagnosis), avg(doctor_charges), avg(room_charges), min(cost_of_diagnosis), min(doctor_charges), min(room_charges), max(cost_of_diagnosis), max(doctor_charges), max(room_charges) from bills;

/*15. the doctors who admitted patients to the hospital as inpatients and also the number of patients they admitted.*/
select d.empid, count(d.empid) from bills b left join DIAGNOSIS d on d.patient_id = b.PATIENT_ID where b.room_charges is not null group by d.empid order by count(d.empid) desc;