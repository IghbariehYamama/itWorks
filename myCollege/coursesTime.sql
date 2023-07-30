--create coursesCycle's table
create table coursesCycle(ID int primary key identity,
courseID int foreign key references courses(ID),
name varchar(20),start_date date, end_date date, price decimal)

drop table coursesCycle

--ALTER TABLE coursesCycle
--ADD name varchar(20);
--DROP COLUMN price;

select * from coursesCycle