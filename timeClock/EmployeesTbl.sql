--יצירת טבלת עובדים
create table employees(ID int primary key identity, emp_ID varchar(10), first_name varchar(10), last_name varchar(10),
phone_number varchar(12), email varchar(20))

--drop table employees

select * from employees

--הכנסת עובד חדש בטבלה
if not exists(select * from employees where emp_ID = '2020394')
begin 
insert into employees values('2020394','ha', 'lo', '012', 'halo@mail.com')
end

--הצהרת משתנים
declare @emp_ID varchar(10) = '2094', @first_name varchar(10) = 'yam', @last_name varchar(10) = 'am',
@phone_number varchar(12) = '0011', @email varchar(20) = 'yamam@lkl.co', @answer varchar(100)

if not exists(select * from employees where emp_ID = @emp_ID)
begin 
	insert into employees values(@emp_ID, @first_name, @last_name, @phone_number, @email)
	select @answer = ''+@first_name+' entered successfully'
end
else
begin
	select @answer = ''+@first_name+' already exist'
end
select @answer

select emp_ID AS 'ID number', first_name +' '+last_name AS 'Full Name' from employees order by last_name



