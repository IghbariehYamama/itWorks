--���� ������
create table customers(ID int primary key identity,
id_number varchar(12), first_name varchar(20),
last_name varchar(20),phone_number varchar(20),
email varchar(30))

--���� ������
create table employees(ID int primary key identity,
id_number varchar(12), first_name varchar(20),
last_name varchar(20),phone_number varchar(20),
email varchar(30))

--�����
create table cash_register(ID int primary key identity,
employeeID int foreign key references employees(ID),
open_time datetime, close_time datetime )


--������
create table coins(ID int primary key identity,
name varchar(20),currency_code varchar(3) ,country varchar(20))


--����� ������ �����
create table enter_coins_in_cash(ID int primary key identity,
cashID int foreign key references cash_register(ID),
coinID int foreign key references coins(ID),
quantity decimal , time datetime)

--����� �����
create table deal(ID int primary key identity,
give_coins int foreign key references enter_coins_in_cash(ID),
get_coins int foreign key references enter_coins_in_cash(ID),
customerID int foreign key references customers(ID),
recipt_number int)

select * from cash_register
select * from coins
select * from enter_coins_in_cash
select * from employees
--����� ���� ���
insert into employees values('1234','Amir','Abu Hani','050-7777','amir@gmail.com')

--����� ���� ����

declare @id_number_employee varchar(12)='1234', @employeeID int
select @employeeID=(select ID from employees where id_number=@id_number_employee)
if @employeeID is not null 
begin
	insert into cash_register values(@employeeID, getdate(), null)
	select @@IDENTITY
end
insert into coins values('Shekel','ILS','Israel')
--����� ������
insert into enter_coins_in_cash values(1,2,-500)


--����� ��� ��� �� ����� 
select cash_register.open_time , coins.name,SUM(enter_coins_in_cash.quantity)
from cash_register inner join enter_coins_in_cash
on cash_register.ID=enter_coins_in_cash.cashID
inner join coins
on enter_coins_in_cash.coinID=coins.ID
group by open_time ,name


select * from deal
select * from enter_coins_in_cash



--����� �����
--������ ���� ������� ������ ����
declare @coin_get_code varchar(3)='ILS',@coin_getID int,@coin_get_quantity decimal=10000,
		@coin_give_code varchar(3)='USD',@coin_giveID int,@coin_give_quantity decimal=3200,
@cashID int=1, @amount decimal ,@answer varchar(100),
@customerID int,@id_number varchar(12)='5678', @recipt_number int=789
--����� ��� ���� ���� ���� ���� ���
select @coin_getID=(select ID from coins where currency_code= @coin_get_code) 
select @coin_giveID=(select ID from coins where currency_code= @coin_give_code) 

--����� �� ���� ����
select @customerID=(select ID from customers where id_number=@id_number)

if @customerID is not null
begin
--����� ��� �� ����� ������ �����

select @amount=(select sum(quantity) from enter_coins_in_cash where 
cashID=@cashID and coinID=@coin_giveID)
if @amount<@coin_give_quantity
	select @answer='��� ����� ��� �����'
else
	begin
		--2. ����� ������ �� ��� ����� ��� ��� ���� ��� ���� �����
		declare @identity_give int,@identity_get int
		--����� ������ �����
		insert into enter_coins_in_cash values(@cashID,@coin_getID,@coin_get_quantity,getdate())
		--����� ���� �� ������� ������ ����� �����
		select @coin_getID=@@IDENTITY

		--����� ������ ������
		insert into enter_coins_in_cash values(@cashID,@coin_giveID,(@coin_give_quantity*-1),getdate())
		--����� ���� �� ������� ����� ����� �����
		select @coin_giveID=@@IDENTITY

		--����� ����� �����
		insert into deal values(@coin_giveID,@coin_getID,@customerID,@recipt_number)

		select @answer='������ ����� ������'
	end
	end
select @answer

select * from deal

--���� ���� �����
--�� ����, ���� ����, �� �����,���� ����, �� ���� �����, ���� ���� �����,
-- �� ���� ������, ���� ���� ������, ���� ����, �����, ���

select customers.first_name+' '+customers.last_name as '�� ����',
customers.id_number as '���� ����',
employees.first_name+' '+employees.last_name as '�� �����',
cash_register.ID as '���� ����' ,
--���� ����� 
(select coins.name from coins where ID=(
		select coinID from enter_coins_in_cash where ID=deal.get_coins)) as '���� ����',
--����
(select enter_coins_in_cash.quantity from enter_coins_in_cash where ID =deal.get_coins)
		as '����',
--���� ������ 
(select coins.name from  coins where ID=(
		select coinID from enter_coins_in_cash where ID=deal.give_coins))as '����� ����',
--����
(select quantity from enter_coins_in_cash where ID = deal.give_coins) as '����' ,

deal.recipt_number as '���� ����',
--����� ���� �� ������
(CONVERT(varchar(10),enter_coins_in_cash.time,103))+' '+
	CONVERT(varchar(10),enter_coins_in_cash.time,108) as '��� �����' 
----����� ���� ��� ������ �����
from deal inner join customers on customers.ID=deal.customerID
--����� ���� ��� ������ ����� ���� �����
--��� ����� ����� ������ ������
inner join enter_coins_in_cash on deal.get_coins=enter_coins_in_cash.ID
--��� ��� ����� �����
inner join cash_register on enter_coins_in_cash.cashID=cash_register.ID
--����� ��� ����� �����
inner join employees on cash_register.employeeID=employees.ID


select * from customers
select * from deal
select * from enter_coins_in_cash
select * from cash_register
select * from employees








select * from customers
insert into customers values('5678','Aseel','Nemer','456456','aseel@gmail.com')
select * from enter_coins_in_cash