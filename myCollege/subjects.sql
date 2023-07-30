--create subjects' table
create table subjects(ID int primary key identity,
subject_name varchar(20), description varchar(100), hours int)

--ALTER TABLE subjects
--ADD hours int
--DROP COLUMN price;

drop table subjects

select * from subjects
