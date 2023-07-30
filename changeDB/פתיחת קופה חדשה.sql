--הכנסת עובד חדש


insert into cashier values('212121', 'Emily', 'John', '05050505', 'emily@gmail.com', 'sa1234')

--פתיחת קופה חדשה
declare @cashierIDNumber varchar(10) = '212121', @cashierID int

select @cashierID = (select ID from cashier where @cashierIDNumber = cashierID)
if @cashierID is null
begin 
	insert 
	select @@IDENTITY
end

