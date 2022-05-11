--UC-1-Create-Payroll-Service-Database--
create database Payroll_Service;
use Payroll_Service;

--UC-2-Employee-Payroll-Table--
Create Table employee_payroll(
	Id int identity (1,1) primary key,
	Name varchar(200),
	Salary float,
	StartDate date);

--UC-3-Create-Employee-Payroll-Data-As-Part-Of-CURD-Operation--
insert into employee_payroll (Name, Salary, StartDate) values
('Akshay', 70000.00, '2005-12-01'),
('Poorva', 50000.00, '2008-03-02'),
('Anuj', 60000.00, '2007-04-07'),
('Manali', 40000.00, '2016-01-03'),
('Rahul', 50000.00, '2018-06-10');

--UC-4-Retrieve-Employee-Payroll-Data--
select * from employee_payroll;

--UC-5-Retrieve-Salary-Of-Particular-Employee-And-Particular-Date-Range--
select salary from employee_payroll where Name = 'Akshay';
select * from employee_payroll where StartDate between cast ('2018-01-01' as date) and GETDATE();

--UC-6-Add-Gender-To-Employee-Payroll-Table-And-Update-The-Rows-To-Reflect-The-Correct-Employee-Gender
ALTER TABLE employee_payroll ADD Gender char(1);
update employee_payroll set Gender = 'M' where Id in (1,3,5);
update employee_payroll set Gender = 'F' where Id in (2,4);

--UC-7-Find-Sum, Average, Min, Max And Number Of Male And Female Employees--
select sum(Salary) as sumsalary,Gender from employee_payroll group by Gender;
select avg(Salary) as avgsalary,Gender from employee_payroll group by Gender; 
select max(Salary) as maxsalary,Gender from employee_payroll group by Gender; 
select min(Salary) as minsalary,Gender from employee_payroll group by Gender; 
select count(Name) as EmployeeCount,Gender from employee_payroll group by Gender;

--UC-8-Add Employee Phone, Department(not null), Address (using default values)--
select * from employee_payroll;
alter table employee_payroll add Phone bigint;
ALTER TABLE employee_payroll add Department varchar(200) not null default 'IT';
ALTER TABLE employee_payroll add Address varchar(200) default 'Mumbai';

--UC-9-Extend Table To Have Basic Pay, Deductions, Taxable Pay, Income Tax, Net Pay--
exec sp_rename 'employee_payroll.salary','Basic_pay','column';
alter table employee_payroll add 
								 Deductions float not null default 0.00,
								 Taxable_Pay float not null default 0.00, 
								 Income_Tax float not null default 0.00,
								 Net_Pay float not null default 0.00;

--UC10-Adding-Department-of-Terisa-As-Sales-&-Marketing-Both--
INSERT INTO employee_payroll
(NAME, Department, Gender, Basic_pay, Deductions, Taxable_Pay, Income_Tax, Net_Pay, StartDate) VALUES
('Akshay', 'SD', 'M', 3000000.00, 1000000.00, 2000000.00, 500000.00, 1500000.00, '2018-01-03' );
update employee_payroll set Net_Pay = (Basic_Pay-Deductions-Taxable_Pay-Income_Tax);
select * from employee_payroll;

--ER diagram--
create table Department
(
Dept_Id int identity (1,1) primary key,
Emp_Id int foreign key references employee_payroll(Id),
Department varchar(100)
);

--drop table Department;
insert into employee_payroll (Name, Basic_pay, StartDate, Gender, Phone, Address, Department, Deductions, Taxable_Pay, Income_Tax,Net_pay)
					  values ('Akshay', 60000.00, '2011-05-05', 'M', 7999837990, 'Bangalore', 'SD',1000.00, 59000.00, 2000.00,0);
update employee_payroll set Net_Pay = (Basic_Pay-Deductions-Taxable_Pay-Income_Tax);

--Stored procedure--
create procedure spAddEmployees
@Name varchar(100),
@Startdate Date,
@Gender char(1),
@Phone bigint,
@Department varchar(100),
@Address varchar(100),
@Basic_Pay float,
@Deductions float,
@Taxable_pay float,
@Income_tax float,
@Net_pay float
as
insert into employee_payroll (Name, Startdate, Gender, Phone, Address, Department, Basic_Pay, Deductions, Taxable_pay, Income_tax, Net_pay)
	values(@Name, @Startdate, @Gender, @Phone, @Address, @Department, @Basic_Pay, @Deductions, @Taxable_pay, @Income_tax, @Net_pay);

--Update procedure--
create procedure spUpdateEmployee
@Name varchar(100),
@Id int,
@Basic_Pay float
as
update employee_payroll set Basic_pay = @Basic_Pay where Id=@Id and Name= @Name;