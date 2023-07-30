--create subjInCour' table
create table subjInCour(ID int primary key identity,
courseID int foreign key references courses(ID),
subjectID int foreign key references subjects(ID))

drop table subjInCour

select * from subjInCour