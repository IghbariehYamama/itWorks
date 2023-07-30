--create students' table
create table students(ID int primary key identity,
userID int foreign key references users(ID),
cycleID int foreign key references coursesCycle(ID))

drop table students

select * from students