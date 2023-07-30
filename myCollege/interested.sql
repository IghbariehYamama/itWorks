--create intereseted's table
create table interested(ID int primary key identity,
userID int foreign key references users(ID),
courseID int foreign key references courses(ID))

drop table interested

select * from interested