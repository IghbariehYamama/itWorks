--create employees' table
create table employees(ID int primary key identity, employee_ID varchar(10), first_name varchar(10),
last_name varchar(10))

drop table employees

select * from employees