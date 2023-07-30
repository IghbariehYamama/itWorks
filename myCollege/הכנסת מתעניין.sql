--הכנסת מתעניין
declare @userID varchar(10) = '488994', @ID int,
@first_name varchar(12) = 'Gigi',
@last_name varchar(12) = 'Hadid',
@password varchar(12) = 'ss1234',
@phone_num varchar(10) = '054054',
@email varchar(20) = 'gigi@mail.com',
@answer varchar(100), @course_id int,
@course_name varchar(20) = 'Full Stack'

--1. בדיקה האם המתעניין החדש נמצא בטבלה של היוזרים
select @ID = (select ID from users where userID = @userID)
-- אם לא נמצא הקוד
if @ID is null
begin --הכנסת יוזר חדש
	insert into users values(@userID, @first_name, @last_name, @phone_num, @email, @password)
	--הוצאת הקוד של הקורס לפי המספר שקיבל במסד נתונים
	select @ID = @@IDENTITY
end
--1.1. אם נמצא, עדכון פרטים
else
begin
	update users 
	set userID = @userID, first_name = @first_name, last_name = @last_name, phone_num = @phone_num, email = @email, password = @password
	where ID = @ID
end
--2. בדיקה על הקורס
select @course_id = (select ID from courses where courseName = @course_name)
if @course_id is null
begin 
	select @answer = 'This course is not available in our system'
end
else
begin
	if not exists (select ID from interested where userID = @ID and courseID = @course_id)
		begin
		insert into interested values(@ID, @course_id)
		end
	select @answer = 'We are thankful that you are interested in this course'
end
select @answer

select users.first_name+ ' ' + users.last_name as 'Full Name', courses.courseName as 'Course Name',
users.phone_num as 'Phone Number' from users inner join interested on users.ID = interested.userID 
inner join courses on courses.ID = interested.courseID


select * from interested
select * from courses
select * from users