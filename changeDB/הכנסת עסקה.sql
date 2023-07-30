
--הכנסת עסקה
--משתנים עבור המטבעות והכמות שלהם
declare @coin_get_code varchar(3)='ILS', 
@coin_give_code varchar(3)='USD',
@coin_giveID int, @coin_getID int,
@coin_get_quantity decimal = 100000,
@coin_give_quantity decimal = 3200, @cashID int = 1,
@amount decimal, @answer varchar(100),
@customerID int, @receipt_num int = 120202,
@id_number varchar(10) = '1234'

--בדיקה על מספר זהות
select @customerID = (select ID from customers where customerID = @id_number)
if @customerID is not null
begin

--מציאת קוד מטבע לקבל וקוד מטבע לתת
select @coin_getID = (select ID from coins where @coin_get_code = currency_code)
select @coin_giveID = (select ID from coins where @coin_give_quantity = currency_code)
--בדיקה האם יש מספיק דולרים בקופה
select @amount = (select SUM(quantity) from enter_coins_in_register where
cash_registerID = @cashID and coinID = @coin_giveID)
if @amount<@coin_give_quantity
	select @answer = 'Not Enough Money in the cash register'
else
begin
	declare @identity_give int, @identity_get int
	--הכנסת מטבעות לקופה
	insert into enter_coins_in_register values(@cashID, @coin_getID, @coin_get_quantity, GETDATE())
	--הוצאת הקוד של המטבעות שנכנסו עכשיו
	select @coin_getID = @@IDENTITY

	--הוצאת מטבעות מהקופה
	insert into enter_coins_in_register values(@cashID, @coin_giveID, (@coin_give_quantity)*-1, GETDATE())
	--הוצאת הקוד של המטבעות שיצאו עכשיו לקופה
	select @coin_giveID = @@IDENTITY

	--הכנסה לטבלת עסקה
	insert into deal values(@customerID, @coin_giveID, @coin_getID, @receipt_num)
	select @answer = 'The deal has been made successfully'
end
end

select @answer

--הצגת פרטי עסקה
--שם לקוח, מספר זהות, שם קופאי, שם מטבע לקבלה, כמות מטבע לקבלה
--שם מטבע להוצאה, כמות מטבע להוצאה, מספר קבלה, תאריך, שעה

select customers.first_name + ' ' + customers.last_name as 'Customer Name',
customers.customerID as 'ID Number', 
cashier.first_name + ' ' + cashier.last_name as 'Cashier Name',
cash_register.ID as 'Cash Register Number',
--מטבע לקבלה
(select coins.name from coins where ID = 
(select coinID from enter_coins_in_register where ID = deal.get_coins)) as 'Receive Coins',
--כמות
(select enter_coins_in_register.quantity from enter_coins_in_register where 
ID = deal.get_coins) as 'Receive Quantity',
--מטבע להוצאה 
(select coins.name from coins where ID = 
(select coinID from enter_coins_in_register where ID = deal.give_coins)) as 'Give Coins'
--כמות
(select enter_coins_in_register.quantity from enter_coins_in_register where 
ID = deal.give_coins) as 'Give Quantity',
deal.receipt_num as 'Receipt Number',
--תאריך ושעת עסקה
(CONVERT(varchar(10), enter_coins_in_register.enter_time, 103) + ' ' + 
CONVERT(varchar(10), enter_coins_in_register.enter_time, 108)) as 'Time of Deal'
--מציאת הקשר בין העסקה ללקוח
from deal inner join customers on customers.ID = customerID
--מציאת הקשר בין העסקה לקופה בשני שלבים
--שלב ראשון: חיבור להכנסת נתונים
inner join enter_coins_in_register on enter_coins_in_register.ID = deal.get_coins
--שלב שני: חיבור לקופה
inner join cash_register on enter_coins_in_register.cash_registerID = cash_register.ID
--חיבור בין הקופה לעובד
inner join cashiers on cashiers.ID = cash_register.cashierID

select * from customers
select * from deal
select * from enter_coins_in_register
select * from cash_register
select * from cashiers



insert into customers values ('21200', 'Aseel', 'Nemer', '456456', 'aseel@gmail.com')

--בדיקה כמה כסף יש בקופה


