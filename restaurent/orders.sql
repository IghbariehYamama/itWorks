--create orders' table
create table orders(ID int primary key identity,
customerID int foreign key references customers(ID), address varchar(30), pay_confirm varchar(12),
order_time datetime, kitchen_time datetime, delivery_time datetime)

drop table orders

select * from orders