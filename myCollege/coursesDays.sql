--create coursesDays' table
create table coursesDays(ID int primary key identity,
lectureCycleID int foreign key references lectureCycle(ID),
start_time time, end_time time, days int)

drop table coursesDays

--ALTER TABLE courses
--ADD description varchar(100);

--DROP COLUMN price;

select * from coursesDays