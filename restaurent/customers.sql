--create customers' table
create table customers(ID int primary key identity, customerID varchar(10), 
name varchar(10),phone_num varchar(12), email varchar(20), password varchar(12))

drop table customers

select * from customers