--create payment's table
create table payment(ID int primary key identity,
userID int foreign key references users(ID),
date datetime, sum decimal(5,2), receipt_num int)

drop table payment

select * from payment