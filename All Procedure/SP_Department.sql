--------------------------------------------Department---------------------------------------------------
--select 
create proc selectalldept 
as
	select * from Department

selectalldept

--insert
create proc insertdept @did int , @dname nvarchar(50) ,@desc nvarchar(50) =null
as
	if not exists(select Dept_description from Department where Dept_description =@desc)
		insert into Department (Dept_Id , Dept_name ,Dept_description) values(@did, @dname ,@desc)
	else
		select 'error' 

insertdept 5,'jvk','djfnlsdnld'

--update 
create proc updatedept @did int , @olddname nvarchar(50),@newdname nvarchar(50) ,@desc nvarchar(50) =null
as 
	if exists(select Dept_name from Department where Dept_name =@olddname)
			update Department set Dept_name =@newdname ,Dept_description =@desc where Dept_Id=@did 
		else
			select 'Invalid Information'

updatedept 5,'jvk','SW','Software'

--delete
create proc deletedept @did int
as 
	if exists(select Dept_Id from Department where Dept_Id=@did)
	begin
		delete from Department where Dept_Id=@did
		select 'Deleted Successfully'
	end
	else
		select 'Not Found!'

deletedept 5
