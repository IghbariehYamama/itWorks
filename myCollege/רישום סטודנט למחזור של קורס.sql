--הוספת מחזור לקורס
declare @userID varchar(10) = '488994', @ID int,
@first_name varchar(12) = 'Gigi',
@last_name varchar(12) = 'Hadid',
@password varchar(12) = 'ss1234',
@phone_num varchar(10) = '054054',
@email varchar(20) = 'gigi@mail.com',
@answer varchar(100), @course_id int,
@course_name varchar(20) = 'Full Stack',
@course_num varchar(10) = '3684599',
@faculty varchar(10) = 'Computer Science', 
@rating decimal(5,2) = 2.6, @cycleID int,
@cycle_name varchar(10) = 'Summer 2020',
@start_date date = GETDATE(), 
@end_date date = GETDATE()+30, 
@price decimal = 2050, @stu_ID int

--1. בדיקה האם הקורס קיים במערכת והוצאת הקוד שלו
select @course_id = (select ID from courses where courseName = @course_name)
-- אם לא נמצא הקוד
if @course_id is null
begin --מכניס את הקורס לטבלת הקורסים
	insert into courses values(@course_num, @course_name, @faculty, null)
	--הוצאת הקוד של הקורס לפי המספר שקיבל במסד נתונים
	select @course_id = @@IDENTITY
end
--בדיקה האם המחזור לקורס קיים במערכת והוצאת הקוד שלו
select @cycleID = (select ID from coursesCycle where courseID = @course_id and name = @cycle_name)
-- אם לא נמצא הקוד
if @cycleID is null
begin --מכניס את הקורס לטבלת הקורסים
	insert into coursesCycle values(@course_id, @cycle_name, @start_date, @end_date, @price)
	--הוצאת הקוד של המחזור לפי המספר שקיבל במסד נתונים
	select @cycleID = @@IDENTITY
end

--רישום סטודנט למחזור של קורס
--1. לבדוק ולהכניס לטבלת היוזרס
select @ID = (select ID from users where userID = @userID)
-- אם לא נמצא הקוד
if @ID is null
begin --הכנסת יוזר חדש
	insert into users values(@userID, @first_name, @last_name, @phone_num, @email, @password)
	--הוצאת הקוד של הקורס לפי המספר שקיבל במסד נתונים
	select @ID = @@IDENTITY
end
else
begin
	update users 
	set userID = @userID, first_name = @first_name, last_name = @last_name, phone_num = @phone_num, email = @email, password = @password
	where ID = @ID
end
--2. להכניס לטבלת הסטודנטים ולבחור מחזור
insert into payment values(@ID, GETDATE(), @price, 1023)

insert into students values(@ID, @cycleID)
--3. למחוק מטבלת המתעניינים רק הקורס הנוכחי
delete from interested where userID = @ID