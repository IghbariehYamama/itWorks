--הכנסת נושאים לקורס
declare @course_name varchar(20) = 'DBA',
@course_description varchar(30) = 'DBA is the Best!',
@topic varchar(20) = 'Transact SQL',
@hours int = 30, @course_id int, @topic_id int,
@course_num int = 368123,
@faculty varchar(10) = 'Computer Science',
@rating decimal = 3.5,
@topic_description varchar(50) = 'This topic is interesting',
@answer varchar(150)

--1. בדיקה האם הקורס קיים במערכת והוצאת הקוד שלו
select @course_id = (select ID from courses where courseName = @course_name)
-- אם לא נמצא הקוד
if @course_id is null
begin --מכניס את הקורס לטבלת הקורסים
	insert into courses values(@course_num, @course_name, @faculty, @rating)
	--הוצאת הקוד של הקורס לפי המספר שקיבל במסד נתונים
	select @course_id = @@IDENTITY
end
--2. בדיקה האם הנושא קיים במערכת והוצאת הקוד שלו
select @topic_id = (select ID from subjects where subject_name = @topic)
-- אם לא נמצא הקוד
if @topic_id is null
begin --מכניס את הקורס לטבלת הנושאים
	insert into subjects values(@topic, @topic_description, @hours)
	--הוצאת הקוד של הנושא לפי המספר שקיבל במסד נתונים
	select @topic_id = @@IDENTITY
end
--3. בדיקה האם הנושא לא קיים כבר בקורס
if not exists (select * from subjInCour where subjectID = @topic_id and courseID = @course_id)
begin
	--חיבור בין הקורס לנושא
	insert into subjInCour values(@course_id, @topic_id)
	select @answer = 'The course ' + @topic + ' has been added successfully into the course ' + @course_name
end
else
begin
	select @answer = 'The topic ' + @topic + ' is already in the course ' + @course_name
end
select @answer


--מציאת הנושאים הקשורים לפי קורסים
select courses.courseName as 'Course Name', subjects.subject_name as 'Topic Name'
from courses inner join subjInCour on courses.ID = subjInCour.courseID 
inner join subjects on subjects.ID = subjInCour.subjectID

--DELETE FROM subjects WHERE subject_name = 'Full Stack'






--הכנסת מרצה היודע נושא חדש
declare @userID varchar(10) = '123456', @ID int,
@first_name varchar(12) = 'Emily',
@last_name varchar(12) = 'John',
@password varchar(12) = 'secret12',
@phone_num varchar(10) = '052052',
@email varchar(20) = 'mail@mail.com',
@answer varchar(100), 
@topic_name varchar(12) = 'React',
@hours int = 40, @topic_id int,
@topic_description varchar(20) = 'React is interesting'

--1. בדיקה האם המרצה החדש נמצא בטבלה של היוזרים
--1.1. אם נמצא, עדכון פרטים
--1.2. אם לא נמצא, הכנסת יוזר חדש

--1. בדיקה האם המרצה החדש נמצא בטבלה של היוזרים
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

--2. בדיקה האם הנושא קיים בטבלת הנושאים
--2.1. אם נמצא, לוקח את הקוד שלו
--2.2. אם לא נמצא, מכניס את הנושא וגם לוקח את הקוד שלו


select @topic_id = (select ID from subjects where subject_name = @topic_name)
-- אם לא נמצא הקוד
if @topic_id is null
begin
	insert into subjects values(@topic_name, @topic_description, @hours)
	--הוצאת הקוד של הנושא לפי המספר שקיבל במסד נתונים
	select @topic_id = @@IDENTITY
end


--3. בדיקה האם הנושא קיים כבר אצל המרצה
--3.1. אם נמצא, מודיעים שהנושא כבר נמצא אצל המרצה
--3.2. אם לא נמצא, מכניסים את הנושא למרצה

if not exists (select * from lecturers where subjectID = @topic_id and userID = @ID)
begin
	--חיבור בין המרצה לנושא
	insert into lecturers values(@ID, @topic_id)
	select @answer = 'The topic ' + @topic_name + ' has been added successfully to the lecturer ' + @first_name + ' ' + @last_name
end
else
begin
	select @answer = 'The topic ' + @topic_name + ' has already been added to the lecturer ' + @first_name + ' ' + @last_name
end
select @answer

--מציאת הנושאים הקשורים לפי מרצים
select users.first_name+ ' ' + users.last_name as 'lecturer Name', subjects.subject_name as 'Topic Name'
from users inner join lecturers on users.ID = lecturers.userID 
inner join subjects on subjects.ID = lecturers.subjectID

select * from users
select * from subjects

delete lecturers


