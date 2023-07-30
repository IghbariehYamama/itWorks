
--קופאי
create table cashiers(ID int primary key identity, cashierID varchar(10),
first_name varchar(20), last_name varchar(20), phone_num varchar(20), 
email varchar(30), password varchar(30))


--כניסת ויציאת קופאי
create table cashier_entryTime(ID int primary key identity, 
cashierID int foreign key references cashiers(ID),
enterTime datetime, exitTime datetime)


--פתיחת קופה
create table cash_register(ID int primary key identity,
cashierID int foreign key references cashiers(ID),
open_time datetime, close_time datetime)


--לקוח
create table customers(ID int primary key identity, 
customerID varchar(10), first_name varchar(10),
last_name varchar(10), phone_num varchar(12), email varchar(20))

select * from customers
insert into customers values('212121', 'Gigi', 'Hadid', '05505', 'Gigi@gmail.com')

--עסקאות
create table deal(ID int primary key identity, 
customerID int foreign key references customers(ID), dealDate datetime, 
give_coins int foreign key references enter_coins_in_register(ID), 
get_coins int foreign key references enter_coins_in_register(ID), 
receipt_num int)

select * from coins

--מטבעות
create table coins(ID int primary key identity,
currency_code varchar(20), name varchar(20), country varchar(50))
insert into coins values('USD', 'Dollar', 'USA')
insert into coins values('EUR', 'Euro', 'Europe')
insert into coins values('ILS', 'Shekel', 'Israel')

--הכנסת מטבעות לקופה
create table enter_coins_in_register(ID int primary key identity,
cash_registerID int foreign key references cash_register(ID),
coinID int foreign key references coins(ID), 
quantity decimal, enter_time datetime)
