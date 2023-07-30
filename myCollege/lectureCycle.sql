--create lectureCycle' table
create table lectureCycle(ID int primary key identity,
cycleID int foreign key references coursesCycle(ID),
lecturerID int foreign key references lecturers(ID))

drop table lectureCycle

select * from lectureCycle