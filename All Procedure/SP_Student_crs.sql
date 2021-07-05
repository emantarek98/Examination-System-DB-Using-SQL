-------------------------------------Student enroll course------------------------------------------------
create proc selectst_enroll_courses 
as 
	select s.St_Id,St_name ,Crs_Name,Crs_grade_of_st  
	from Student_enroll_course sc,Student s,Course c
	where s.St_Id=sc.St_Id and c.Crs_Id=sc.Crs_Id

execute selectst_enroll_courses


alter proc insertst_enroll_courses @sid int ,@crsid int ,@st_crs_garde int = 0
as
	begin try
		insert into Student_enroll_course (St_Id,Crs_Id,Crs_grade_of_st) values (@sid,@crsid,@st_crs_garde)
	end try
	begin catch
		select 'error'
	end catch

execute insertst_enroll_courses 3,7

--update cousre
alter proc updatest_enroll_courses @sid int ,@oldcrsid int ,@newcrsid int ,@st_crs_garde int = 0
as
	begin try
		update Student_enroll_course set Crs_Id = @newcrsid , Crs_grade_of_st = @st_crs_garde 
		where St_Id = @sid and Crs_Id=@oldcrsid
	end try
	begin catch
		select 'error'
	end catch

execute updatest_enroll_courses 1,9,7

--update crs grade

alter proc update_st_crs_grade @stid int ,@examcode nvarchar(25) ,@crsid int
as
	if exists(select se.Exam_code ,e.Crs_Id from Exam e,Student_take_Exam se where se.Exam_code =e.Exam_code and se.Exam_code =@examcode and e.Crs_Id=@crsid and se.St_Id = @stid )
		begin
			update Student_enroll_course set Crs_grade_of_st +=(select sum(St_grade) 
														from Student_take_Exam 
														where Exam_code = @examcode
														and St_Id =@stid)
			where St_Id =@stid and Crs_Id = @crsid
		end
	else 
		select 'Exam Not Found'

execute update_st_crs_grade 3,'52CF',7

--delete
alter proc deletest_enroll_crs @sid int,@crsid int
as
	if exists(select st_id ,Crs_Id from Student_enroll_course where st_id=@sid and Crs_Id=@crsid)
		begin
			delete from Student_enroll_course where St_Id=@sid and Crs_Id=@crsid
			select 'Deleted Successfully'
		end
	else
		select 'Not Found!'
	
execute deletest_enroll_crs 8,8
----------------------------------Student Take Exam -----------------------------------------------------------
--select
alter proc selectst_take_exam
as
	select sa.St_name , sa.Exam_code ,eq.Q_Id, St_ans , Crs_Name  
	from Course c 
	right join(
		select St_name , se.Exam_code , St_ans ,Crs_Id ,exam_q_id
		from Student s, Student_take_Exam se ,Exam e  
		where s.St_Id = se.St_Id and e.Exam_code= se.Exam_code)as sa 
		on c.Crs_Id =sa.Crs_Id
		inner join Exam_have_questions eq on eq.Exam_code = sa.Exam_code and eq.Q_Id =sa.exam_q_id
	
execute selectst_take_exam

create proc getall_st_take_exam_noinfo 
as
	select * from Student_take_Exam

execute getall_st_take_exam_noinfo
--insert
create proc insertst_take_exam @exam_code nvarchar(20),@sid int ,@qid int =null,@st_ans nvarchar(2)
as
	begin try
		insert into Student_take_Exam (Exam_code,St_Id,exam_q_id,St_ans)
		values (@exam_code,@sid,@qid,@st_ans)
	end try
	begin catch
		select 'error'
	end catch

execute insertst_take_exam '2',1,2,'a'

--update 
alter proc updatest_take_exam @string nvarchar(25),@examcode nvarchar(20),@sid int ,@qid int,@value nvarchar(3)
as
	begin try
	if(@string ='answer')
		update Student_take_Exam set  St_ans=@value where St_Id=@sid and Exam_code=@examcode and exam_q_id =@qid
	else if(@string ='grade')
		update Student_take_Exam set  St_grade= convert(int , @value) where St_Id=@sid and Exam_code=@examcode and exam_q_id =@qid  
	end try
	begin catch
		select 'error'
	end catch

execute updatest_take_exam 'answer','1',1,2,'d'


--delete 
create proc deletest_take_exam @sid int ,@examcode nvarchar(20),@qid int ,@st_ans nvarchar(3)
as
	if exists(select St_ans=@st_ans from Student_take_Exam where Exam_code=@examcode and St_Id=@sid and exam_q_id=@qid )
		begin
			delete from Student_take_Exam where St_ans=@st_ans and Exam_code=@examcode and St_Id=@sid and exam_q_id=@qid
			select 'Deleted Successfully'
		end
	else
		select 'Not Found!'

execute deletest_take_exam 2,'2',2,'a'