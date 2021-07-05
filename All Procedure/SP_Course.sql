---------------------------------------course----------------------------------------------
--select
alter proc selectallcourses
as
	select Crs_Id,Crs_Name ,Top_Name 
	from Course c,Topic t
	where c.Top_Id =t.Top_Id

execute selectallcourses

--insert
alter proc insertcrs @crsname nvarchar(50) ,@top_id int
as 
	if not exists(select Crs_Name from Course where Crs_Name=@crsname)
		insert into Course(Crs_Name,Top_Id) values(@crsname , @top_id)
	else 
		select 'ERROR' as check_value
	
execute insertcrs  'pmmmython',3

--update
alter proc updatecrs @crsid int , @crsname nvarchar(50) , @topic int 
as 
	if exists(select Crs_Id from Course where Crs_Id=@crsid) 
			update Course set Crs_Name = @crsname , Top_Id=@topic where Crs_Id=@crsid
	else 
		select 'ERROR'

execute updatecrs  12 ,'njj' , 1

--delete 
create proc deletecrs @crsid int
as 
	if exists(select crs_id from Course where Crs_Id=@crsid)
		begin 
			delete from course where Crs_Id=@crsid 
			select 'delete successful'
		end 
	else 
		select 'Not found'

execute deletecrs 13