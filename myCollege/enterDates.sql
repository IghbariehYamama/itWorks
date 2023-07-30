--הכנסת 50 מפגשי קורס רק בימי שני
declare @i int=0, @datestart date=getdate(), @sum int = 50 ,
@day int =2 
while @i<@sum
begin
	if(DATEPART(DW,@datestart)=@day)
		begin
			insert into times values(@datestart)
			select @i=@i+1
		end
		select @datestart=DATEADD(day,1, @datestart)
end
--הכנסת 50 מפגשי קורס רק בימי שני וחמישי
declare @i int=0, @datestart date=getdate(), @sum int = 50 ,
@day varchar(7) ='2,5' 

while @i<@sum
begin
	declare @week_day int=DATEPART(DW,@datestart)
	if(@day like '%'+convert(varchar, @week_day)+'%')
		begin
			insert into times values(@datestart)
			select @i=@i+1
		end
		select @datestart=DATEADD(day,1, @datestart)
			
end

