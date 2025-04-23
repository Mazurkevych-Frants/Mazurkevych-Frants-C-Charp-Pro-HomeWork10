create database Hospital
go
use Hospital
go

create table Departments
(
	DepartmentsId int identity(1, 1) not null,
	Building int not null,
	Financing decimal(10,2) not null constraint DF_Departments_Financing default (0),
	[Name] nvarchar(100) not null,

	constraint PK_Departments_DepartmentsId primary key (DepartmentsId),
	constraint CK_Departments_Building check (Building between 1 and 5),
	constraint CK_Departments_Financing check (Financing >= 0),
	constraint UQ_Departments_Name unique ([Name]),
	constraint CK_Departments_Name check ([Name] <> '')
)

create table Diseases
(
	DiseasesId int identity(1, 1) not null,
	[Name] nvarchar(100) not null,
	Severity int not null constraint DF_Diseases_Severity default (1),

	constraint CK_Diseases_Severity check (Severity > 0),
	constraint PK_Diseases_DiseasesId primary key (DiseasesId),
	constraint UQ_Diseases_Name unique ([Name]),
	constraint CK_Diseases_Name check ([Name] <> '')
)

create table Doctors
(
	DoctorsId int identity(1, 1) not null,
	[Name] nvarchar(max) not null,
	Phone char(10),
	Salary decimal(10,2) not null,
	Bonus decimal(10,2) constraint DF_Doctors_Bonus default (0),
	Surname nvarchar(max) not null,

	constraint CK_Doctors_Salary check (Salary > 0),
	constraint CK_Doctors_Bonus check (Bonus >= 0),
	constraint PK_Doctors_DoctorsId primary key (DoctorsId),
	constraint CK_Doctors_Name check ([Name] <> ''),
	constraint CK_Doctors_Surname check (Surname <> '')
)

create table Examinations
(
	ExaminationsId int identity(1, 1) not null,
	[DayOfWeek] int not null,
	[Name] nvarchar(100) not null,
	StartTime time not null,
	EndTime time not null,

	constraint UQ_Examinations_Name unique ([Name]),
	constraint CK_Examinations_Name check ([Name] <> ''),
	constraint CK_Examinations_StartTime check (StartTime between '08:00:00' and '18:00:00'),
	constraint CK_Examinations_EndTime check (EndTime > StartTime),
	constraint CK_Examinations_DayOfWeek check ([DayOfWeek] between 1 and 7),
	constraint PK_Examinations_ExaminationsId primary key (ExaminationsId)
)

create table Wards
(
	WardsId int identity(1, 1) not null,
	Building int not null,
	[Floor] int not null,
	[Name] nvarchar(20) not null,

	constraint CK_Wards_Floor check ([Floor] > 0),
	constraint CK_Wards_Building check (Building between 1 and 5),
	constraint PK_Wards_WardsId primary key (WardsId),
	constraint UQ_Wards_Name unique ([Name]),
	constraint CK_Wards_Name check ([Name] <> '')
)

select * from Wards

select [Name], Surname from Doctors

select distinct [Floor] from Wards

select [Name] as [Name of Disease], Severity as [Severity of Disease] from Diseases

select d.Name AS DepartmentName, doc.Name AS DoctorName, e.Name AS ExaminationName
from Departments d, Doctors doc, Examinations e;

select [Name] from Departments
where Building = 5 and Financing < 30000

select [Name] from Departments
where Building = 3 and Financing between 12000 and 15000

select [Name] from Wards
where [Floor] = 1 and (Building = 4 or Building = 5)

select [Name], Building, Financing from Departments
where (Building = 3 or Building = 6) and (Financing < 11000 or Financing > 25000)

--Вывести фамилии врачей, зарплата (сумма ставки и надбавки) которых превышает 1500.
--Что бы решить эту задачу я добавил в таблицу "Докторы" - бонус (надбавку)
select Surname from Doctors
where (Salary + Bonus) > 1500

select Surname from Doctors
where Bonus > 0 and (Salary / 2) > (Bonus * 3)

select distinct [Name] from Examinations
where ([DayOfWeek] between 1 and 3) and StartTime >= '12:00:00' and EndTime <= '15:00:00'

select [Name], Building from Departments
where Building = 1 or Building = 3 or Building = 8 or Building = 10

select [Name] from Diseases
where Severity > 2

select [Name] from Departments
where Building = 2 or Building > 3

select [Name] from Departments
where Building = 1 or Building = 3

select Surname from Doctors
where Surname like 'N%'