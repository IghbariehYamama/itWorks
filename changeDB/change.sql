--טבלת לקוחות
create table customers(ID int primary key identity,
id_number varchar(12), first_name varchar(20),
last_name varchar(20),phone_number varchar(20),
email varchar(30))

--טבלת עובדים
create table employees(ID int primary key identity,
id_number varchar(12), first_name varchar(20),
last_name varchar(20),phone_number varchar(20),
email varchar(30))

--קופות
create table cash_register(ID int primary key identity,
employeeID int foreign key references employees(ID),
open_time datetime, close_time datetime )


--מטבעות
create table coins(ID int primary key identity,
name varchar(20),currency_code varchar(3) ,country varchar(20))


--הכנסת מטבעות לקופה
create table enter_coins_in_cash(ID int primary key identity,
cashID int foreign key references cash_register(ID),
coinID int foreign key references coins(ID),
quantity decimal , time datetime)

--יצירת עיסקה
create table deal(ID int primary key identity,
give_coins int foreign key references enter_coins_in_cash(ID),
get_coins int foreign key references enter_coins_in_cash(ID),
customerID int foreign key references customers(ID),
recipt_number int)

select * from cash_register
select * from coins
select * from enter_coins_in_cash
select * from employees
--הכנסת עובד חדש
insert into employees values('1234','Amir','Abu Hani','050-7777','amir@gmail.com')

--פתיחת קופה חדשה

declare @id_number_employee varchar(12)='1234', @employeeID int
select @employeeID=(select ID from employees where id_number=@id_number_employee)
if @employeeID is not null 
begin
	insert into cash_register values(@employeeID, getdate(), null)
	select @@IDENTITY
end
insert into coins values('Shekel','ILS','Israel')
--הכנסת מטבעות
insert into enter_coins_in_cash values(1,2,-500)


--בדיקה כמה כסף יש בקופה 
select cash_register.open_time , coins.name,SUM(enter_coins_in_cash.quantity)
from cash_register inner join enter_coins_in_cash
on cash_register.ID=enter_coins_in_cash.cashID
inner join coins
on enter_coins_in_cash.coinID=coins.ID
group by open_time ,name


select * from deal
select * from enter_coins_in_cash



--הכנסת עיסקה
--משתנים עבור המטבעות והכמות שלהם
declare @coin_get_code varchar(3)='ILS',@coin_getID int,@coin_get_quantity decimal=10000,
		@coin_give_code varchar(3)='USD',@coin_giveID int,@coin_give_quantity decimal=3200,
@cashID int=1, @amount decimal ,@answer varchar(100),
@customerID int,@id_number varchar(12)='5678', @recipt_number int=789
--מציאת קוד מטבע לקבל וקוד מטבע לתת
select @coin_getID=(select ID from coins where currency_code= @coin_get_code) 
select @coin_giveID=(select ID from coins where currency_code= @coin_give_code) 

--בדיקה על מספר זהות
select @customerID=(select ID from customers where id_number=@id_number)

if @customerID is not null
begin
--בדיקה האם יש מספיק דולרים בקופה

select @amount=(select sum(quantity) from enter_coins_in_cash where 
cashID=@cashID and coinID=@coin_giveID)
if @amount<@coin_give_quantity
	select @answer='אין מספיק כסף בקופה'
else
	begin
		--2. הכנסה פעמיים של כסף לקופה פעם אחת פלוס פעם שניה מינוס
		declare @identity_give int,@identity_get int
		--הכנסת מטבעות לקופה
		insert into enter_coins_in_cash values(@cashID,@coin_getID,@coin_get_quantity,getdate())
		--הוצאת הקוד של המטבעות שנכנסו עכשיו לקופה
		select @coin_getID=@@IDENTITY

		--הוצאת מטבעות מהקופה
		insert into enter_coins_in_cash values(@cashID,@coin_giveID,(@coin_give_quantity*-1),getdate())
		--הוצאת הקוד של המטבעות שיצאו עכשיו לקופה
		select @coin_giveID=@@IDENTITY

		--הכנסה לטבלת עיסקה
		insert into deal values(@coin_giveID,@coin_getID,@customerID,@recipt_number)

		select @answer='העיסקה בוצעה בהצלחה'
	end
	end
select @answer

select * from deal

--הצגת פרטי עיסקה
--שם לקוח, מספר זהות, שם קופאי,מספר קופה, שם מטבע לקבלה, כמות מטבע לקבלה,
-- שם מטבע להוצאה, כמות מטבע להוצאה, מספר קבלה, תאריך, שעה

select customers.first_name+' '+customers.last_name as 'שם לקוח',
customers.id_number as 'מספר זהות',
employees.first_name+' '+employees.last_name as 'שם קופאי',
cash_register.ID as 'מספר קופה' ,
--מטבע לקבלה 
(select coins.name from coins where ID=(
		select coinID from enter_coins_in_cash where ID=deal.get_coins)) as 'קבלת מטבע',
--כמות
(select enter_coins_in_cash.quantity from enter_coins_in_cash where ID =deal.get_coins)
		as 'כמות',
--מטבע להוצאה 
(select coins.name from  coins where ID=(
		select coinID from enter_coins_in_cash where ID=deal.give_coins))as 'הוצאת מטבע',
--כמות
(select quantity from enter_coins_in_cash where ID = deal.give_coins) as 'כמות' ,

deal.recipt_number as 'מספר קבלה',
--תאריך ושעה של העיסקה
(CONVERT(varchar(10),enter_coins_in_cash.time,103))+' '+
	CONVERT(varchar(10),enter_coins_in_cash.time,108) as 'זמן עיסקה' 
----מציאת הקשר בין העיסקה ללקוח
from deal inner join customers on customers.ID=deal.customerID
--מציאה הקשר בין העיסקה לקופה בשני שלבים
--שלב ראשון חיבור להכנסת נתונים
inner join enter_coins_in_cash on deal.get_coins=enter_coins_in_cash.ID
--שלב שני חיבור לקופה
inner join cash_register on enter_coins_in_cash.cashID=cash_register.ID
--חיבור בין הקופה לעובד
inner join employees on cash_register.employeeID=employees.ID


select * from customers
select * from deal
select * from enter_coins_in_cash
select * from cash_register
select * from employees








select * from customers
insert into customers values('5678','Aseel','Nemer','456456','aseel@gmail.com')
select * from enter_coins_in_cash