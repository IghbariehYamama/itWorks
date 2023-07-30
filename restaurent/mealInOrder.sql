--create mealInOrder' table
create table mealInOrder(ID int primary key identity, priceID int foreign key references prices(ID),
orderID int foreign key references orders(ID), quantity int)

drop table mealInOrder

select * from mealInOrder