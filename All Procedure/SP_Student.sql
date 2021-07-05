----------------------------------------------Student-----------------------------------------------------------
--select 
alter proc selectst
as
	select St_name ,St_gender , St_city ,Dept_description
	from Student s, Department d
	where s.Dept_Id=d.Dept_Id
execute selectst

--insert
alter proc insertst  @name nvarchar(50) ,@gender nvarchar(2) , @city nvarchar(20) ,@did int
as
	begin try
		insert into Student ( St_name ,St_gender , St_city,Dept_Id)
		values( @name ,@gender ,@city ,@did)
	end try
	begin catch
		select 'error'
	end catch
execute insertst 'salma','F','alex',3

--update
alter proc updatest @id int , @ststring nvarchar(50) ,@value nvarchar(30)
as 
	begin try
		if (@ststring='name')
			update Student set St_name =@value where St_Id=@id
		else if (@ststring ='gender')
			update Student set St_gender =@value where St_Id=@id
		else if(@ststring ='city')
			update Student set St_city =@value where St_Id=@id
		else if(@ststring ='dept' or @ststring='department')
				update Student set Dept_Id =CONVERT(int , @value) where St_Id=@id 
		else if(@ststring = 'email' or @ststring='mail')
			update Student set St_mail =@value where St_Id=@id
		else if(@ststring ='pass' or @ststring='password')
			update Student set St_password =@value where St_Id=@id
		else
			select 'Invalid Info'
	end try
	begin catch
		select 'error'
	end catch

execute updatest 14,'email','salma8598@gmail.com'
execute updatest 14,'pass','127854'

--delete
alter proc deletest @sid int
as 
	if exists(select st_id from Student where st_id=@sid)
	begin
		delete from Student where St_Id=@sid
		select 'Deleted Successfully'
	end
	else
		select 'Not Found!'	
execute deletest 14


