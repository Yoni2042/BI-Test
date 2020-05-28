/********************************************
Query Exercise 
Please use the Hospital database 
**************************************************/
--Q1-Write a query in SQL to obtain the name of the physicians who are the head of each department.
select P.[Name] as Physician_Name,
DT.[Name] as Department_Name from [dbo].[Physician] as P
inner join [dbo].[Department] as DT
on P.EmployeeID=DT.Head
--Q2-Write a query in SQL to find the floor and block where the room number 212 belongs to.
select RM.Floor_NO,RM.Code from [dbo].[Room] as RM
--inner join [dbo].[tblBlock] as BK
--on RM.Floor_NO=BK.Floor_NO
where RM.Number=212
--Q3-Write a query in SQL to count the number available rooms.
select count([Number])  from [dbo].[Room]
--Q4-Write a query in SQL to obtain the name of the physician and the departments they are affiliated with
select P.[Name] as Physician,DT.[Name] as Department_Name from dbo.Physician AS P
inner join dbo.Affiliated_With AS AW
on P.EmployeeID=AW.Physician
inner join dbo.Department AS DT
on AW.Department=DT.DepartmentID
--Q5-Write a query in SQL to obtain the name of the physicians who are trained for a special treatement
select P.[Name] AS Physicians,TB.[Name] as Special_treatement  from dbo.Physician as P
inner join dbo.Trained_In as TR
on P.EmployeeID=TR.Physician
inner Join dbo.tblProcedure AS TB
on TB.Code=TR.Treatment

--Q6-Write a query in SQL to obtain the name of the physicians who are not a specialized physician.
select Name from [dbo].[Physician]
except
select P.[Name] AS Physicians from dbo.Physician as P
inner join dbo.Trained_In as TR
on P.EmployeeID=TR.Physician
inner Join dbo.tblProcedure AS TB
on TB.Code=TR.Treatment
--Q7-Write a query in SQL to obtain the name of the patients with their physicians by whom they got their preliminary treatement.
select PT.[Name] from dbo.Patient as PT
inner join dbo.Physician as P
on PT.PCP=P.EmployeeID
--Q8-Write a query in SQL to find the name of the patients and the number of the room where they have to go for their treatment.
select PT.[Name] AS PATIENT_NAME,RM.Number as ROOM_NUMBER from dbo.Stay as ST
inner Join dbo.Patient AS PT
on ST.Patient=PT.SSN
inner Join dbo.Room as RM
on ST.Room=RM.Number
--Q9-Write a query in SQL to find the name of the nurses and the room scheduled, where they will assist the physicians.
select NS.[Name] as Assisting_Nurse,RM.Number as Room_Number from dbo.Undergoes as UG
Inner Join dbo.Room as RM
on UG.tblProcedure=RM.Code
inner Join dbo.Nurse as NS
ON NS.EmployeeID=UG.AssistingNurse

--Q10-Write a query in SQL to find the name of the patients who taken the appointment on the 25th of April at 10 am, and also display their physician,
select PT.Name as Patient,PN.Name as Physician from [dbo].[Appointment] as AP
inner join dbo.Patient AS PT
on AP.Patient=PT.SSN
Inner Join dbo.Physician as PN
ON AP.Physician=PN.EmployeeID
where AP.Start_TIME = '2008-04-25 10:00'

--Q11-Write a query in SQL to find the name of patients and their physicians who does not require any assistance of a nurse.
select PT.Name as Patient,PN.Name as Physician from dbo.Undergoes as UG
inner join dbo.Patient as PT
on UG.Patient=PT.SSN
inner join dbo.Physician as PN
on UG.Physician=PN.EmployeeID
where UG.AssistingNurse is null
--Q12-Write a query in SQL to find the name of the patients, their treating physicians and medication.
Select PT.Name as Patient_name,PN.Name as Physician,MD.Name as Medication from dbo.Prescribes as PR
inner Join dbo.Patient as PT
on PR.Patient=PT.SSN
inner join dbo.Physician as PN
on PR.Physician=PN.EmployeeID
inner join dbo.Medication As MD
on PR.Medication=MD.Code
--Q13-Write a query in SQL to find the name of the patients who taken an advanced appointment, and also display their physicians and medication.
select PT.Name from [dbo].Prescribes AS PR
inner join dbo.Appointment as AP
on PR.Appointment=AP.AppointmentID
inner join dbo.Patient AS PT
on PT.SSN=PR.Patient
inner join dbo.Physician as PN
on PR.Physician=PN.EmployeeID

--Q14-Write a query in SQL to count the number of available rooms in each floor.
select COUNT(Number),Floor_NO from dbo.Room
group by Floor_NO
--Q15-Write a query in SQL to find out the floor where the maximum no of rooms are available.
select Floor_NO,count(Number) from dbo.Room
 where Unavailable=0
group by Floor_NO
 
--Q16-Write a query in SQL to obtain the name of the patients, their block, floor, and room number where they are admitted.
select distinct PT.Name,TB.Floor_NO,RM.Number from dbo.Room as RM
inner join dbo.tblBlock AS TB
on RM.Floor_NO=TB.Floor_NO
inner join dbo.Stay as ST
on ST.Room=RM.Number
inner join dbo.Patient AS PT
on PT.SSN=ST.Patient
--Q17-Write a query in SQL to obtain the nurses and the block where they are booked for attending the patients on call. 
select NS.Name,CL.Code from dbo.Nurse AS NS
inner join dbo.On_Call as CL
on NS.EmployeeID=CL.Nurse
--Q18-Write a SQL query to obtain the names of all the physicians performed a medical procedure but they are not ceritifed to perform. 
select distinct PN.Name from dbo.Trained_In as TR
inner join dbo.Physician AS PN
on TR.Physician=PN.EmployeeID
except
select distinct PN.Name from dbo.Physician as PN
inner join dbo.Undergoes as UG
on UG.Physician=PN.EmployeeID
--Q19-Write a query in SQL to obtain the names of all the physicians, their procedure, date when the procedure was carried out and name of 
--the patient on which procedure have been carried out but those physicians are not cetified for that procedure
select *from dbo.Undergoes as UG
inner join dbo.Physician as PN
on UG.Physician=PN.EmployeeID
inner join dbo.tblProcedure as TB
on TB.Code=UG.tblProcedure
inner join dbo.Patient as PT
on PT.SSN=UG.Patient
inner join dbo.Trained_In as TR
on TR.Physician=UG.Physician
where PN.EmployeeID not in (TR.Physician)




--Q20- Write a query in SQL to obtain the name and position of all physicians who completed a medical procedure with certification after the date of expiration of their certificate.
select PN.Name,PN.Position from dbo.Trained_In as TR
inner join dbo.Physician as PN
on TR.Physician=PN.EmployeeID
inner join dbo.Undergoes as UG
on TR.Physician=UG.Physician
where TR.CertificationExpires<UG.Date


--Q21-Write a query in SQL to obtain the name of all those physicians who completed a medical procedure with certification after.
--the date of expiration of their certificate, their position, procedure they have done, date of procedure, name of the patient on which the procedure had been applied and the date when the certification expired.
select PN.Name,PN.Position,TR.CertificationExpires,TB.Name,UG.Date,PT.Name from dbo.Trained_In as TR
inner join dbo.Physician as PN
on TR.Physician=PN.EmployeeID
inner join dbo.Undergoes as UG
on TR.Physician=UG.Physician
inner join dbo.tblProcedure as TB
on UG.tblProcedure=TB.Code
inner join dbo.Patient PT
on PT.SSN=UG.Patient
where TR.CertificationExpires<UG.Date

--Q22-Write a query in SQL to obtain the names of all the nurses who have ever been on call for room 122. 
select NS.Name from dbo.On_Call as CL
inner join dbo.Nurse as NS
on CL.Nurse=NS.EmployeeID
inner join dbo.Room RM
on RM.Code=CL.Code
where RM.Number=122
--Q23-Write a query in SQL to obtain the names of all patients who has been undergone a procedure costing more than $5,000 and the name of that physician who has carried out primary care.
select PT.Name,TB.Cost from dbo.Undergoes as UG
inner join dbo.Patient as PT
on UG.Patient=PT.SSN
inner join dbo.tblProcedure as TB
on TB.Code=UG.tblProcedure
where TB.Cost>5000

/*--Q24-Write a query in SQL to Obtain the names of all patients whose primary care is taken by 
a physician who is not the head of any department and name of that physician along with their primary care physician.*/
select PT.Name,PN.Name,PT.PCP,PN.EmployeeID from dbo.Patient as PT
inner join dbo.Physician as PN
on PT.PCP=PN.EmployeeID
where PT.PCP not in (select Head from dbo.Department)




