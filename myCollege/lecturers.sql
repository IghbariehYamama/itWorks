--create lecturers' table
create table lecturers(ID int primary key identity,
userID int foreign key references users(ID),
subjectID int foreign key references subjects(ID))

drop table lecturers

select * from lecturers
