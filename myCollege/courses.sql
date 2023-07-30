--create courses' table
create table courses(ID int primary key identity, courseNum varchar(10),
courseName varchar(10), faculty varchar(12), rating decimal(5,2))

drop table courses

--ALTER TABLE courses
--ADD description varchar(100);

--DROP COLUMN price;

select * from courses