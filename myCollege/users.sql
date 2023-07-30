--create users's table
create table users(ID int primary key identity, userID varchar(10), first_name varchar(10),
last_name varchar(10), phone_num varchar(12), email varchar(20), password varchar(12))

drop table users

insert into users values(11111,'yaya','agh','052','ya@hi','.21321')