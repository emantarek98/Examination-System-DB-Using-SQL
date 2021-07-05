--------------------------------Teacher-------------------------------------------------------------
--select
alter proc selectallteacher
as
	select T_name ,Dept_name ,evaluation_description "Evaluation"
	from Teacher t,Department d , Teacher_tech_course tc,Evaluation e
	where t.Dept_Id =d.Dept_Id and tc.T_Id=t.T_Id and tc.evaluation_id= e.evaluation_id

execute selectallteacher

--insert 
alter proc insertinst @teachername nvarchar(50), @did int =null
as
	if not exists (select T_name from Teacher where T_name=@teachername)
	begin
		if(@did is null)
			insert into Teacher (T_name) values(@teachername)
		else 
			insert into Teacher (T_name,Dept_Id) values(@teachername ,@did)
	end
	else
		select 'Error'

execute insertinst 'mahmoud'
 --update
create proc updateinst @teacherid int , @teachername nvarchar(50) , @did int 
as
	begin try 
		update Teacher set T_name = @teachername , Dept_Id=@did where T_Id=@teacherid
	end try 
	begin catch 
		select 'ERROR'
	end catch
execute updateinst 2 ,'mohamed elshafey',2

--delete
alter proc deleteinst @teacherid int 
as 
	if exists(select T_Id from Teacher where T_Id=@teacherid )
		begin 
			delete from teacher where T_Id =@teacherid
			select 'Delete Successfully'
		end 
	else 
		select 'Not Found'

execute deleteinst 45

----------------------------------teacher teach course------------------------------------------------
--select 
create proc selectteacher_teach_course 
as
	select T_name,Crs_Name ,evaluation_description
	from Course c, Teacher_tech_course tc,Teacher t, Evaluation e
	where c.Crs_Id=tc.Crs_Id and t.T_Id =tc.T_Id and tc.evaluation_id =e.evaluation_id

execute selectteacher_teach_course

--insert 
create proc insertteacher_teach_course @crs_id int , @t_id int , @eva int = null
as 
	begin try 
		insert into Teacher_tech_course(Crs_Id,T_Id,evaluation_id) values(@crs_id,@t_id,@eva)
	end try 
	begin catch 
		select 'ERROR'
	end catch
execute insertteacher_teach_course 1,4

--update
create proc updateteacher_teach_course @oldcrs_id int,@oldt_id int,@newcrs_id int,@newt_id int,@eva int = null 
as
	if exists(select Crs_Id,T_Id from Teacher_tech_course where Crs_Id=@oldcrs_id and T_Id=@oldt_id)
		update Teacher_tech_course set Crs_Id = @newcrs_id, T_Id=@newt_id , evaluation_id = @eva where Crs_Id=@oldcrs_id and T_Id=@oldt_id
	else 
		select 'ERROR'

execute updateteacher_teach_course 4,1,2,5

--delete
create proc deleteteacher_teach_course @crs_id int , @t_id int 
as
	if exists(select Crs_Id , T_Id from Teacher_tech_course where Crs_Id=@crs_id and T_Id=@t_id)
		begin
			delete from Teacher_tech_course where Crs_Id=@crs_id and T_Id=@t_id 
			select 'Delete Successfully'
		end
	else 
		select 'Not found'

execute deleteteacher_teach_course 9,9