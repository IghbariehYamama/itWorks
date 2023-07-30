--create prices' table
create table prices(ID int primary key identity, mealID int foreign key references meals(ID),
price decimal(5,2), start_date datetime, end_date datetime)

drop table prices

select * from prices

--delete prices where ID is null