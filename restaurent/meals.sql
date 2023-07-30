--create meals' table
create table meals(ID int primary key identity, category_ID int foreign key references categories(ID),
meal_name varchar(20), discount varchar(10),descreption varchar(50), image text)

drop table meals

select * from meals