---------------------------------------Exam generation-------------------------------------------------	
alter proc getquestions_for_exam @crsid int , @mcqno int , @t_fno int 
as
	declare @ques table (q_id int)
	insert into @ques 
		select top(@mcqno)Q_Id from Question 
		where Crs_Id=@crsid and Q_type='mcq' 
		ORDER BY NEWID();
	insert into @ques
		select top(@t_fno) Q_Id from Question 
		where Crs_Id=@crsid and Q_type='T/F'
		ORDER BY NEWID()
	select * from @ques



alter proc insertexam @crsid int ,  @mcqno int , @t_fno int ,@exam_code nvarchar(25) output 
as
	
	declare @ex nvarchar(25)
	set @ex=LEFT(REPLACE(NewId(),'-',''),4) 
	insert into Exam (Crs_Id,no_of_mcq,[no_of_t/f],Exam_code)
	values (@crsid,@mcqno,@t_fno,@ex) 
	select @exam_code=Exam_code from Exam where Exam_code =@ex


--------------exam generation----------

alter proc examgeneration @crsname nvarchar(25) , @mcqno int , @t_fno int,@examcode nvarchar(20) output
as
	begin
		if @mcqno+@t_fno =10
			begin
			if exists(select Crs_Id from Course where Crs_Name=@crsname)
				begin
					declare @crsid int
					select @crsid = Crs_Id from Course where Crs_Name=@crsname
					execute insertexam @crsid,@mcqno,@t_fno,@examcode output
					declare @tab table (ques_id int)
					insert into @tab (ques_id)
					 execute getquestions_for_exam @crsid,@mcqno,@t_fno


					insert into Exam_have_questions (Exam_code,Q_Id) 
					select  e.Exam_code ,Q_Id=ques_id  from @tab,Exam e ,Question
					where e.Exam_code =@examcode and Question.Q_Id = ques_id
				end
			else 
				select 'Invalid Course!'
		  end
       else 
			select 'No of questions must be 10'
	end


	

declare @z nvarchar(25)	
execute examgeneration 'sql',3,7,@z output
select @z

execute getexam_question @z

declare @a nvarchar(25)	
execute examgeneration 'sql',5,5,@a output
select @a

execute getexam_question @a


declare @c nvarchar(25)	
execute examgeneration 'c#',5,5,@c output
select @c

execute getexam_question @c

declare @e nvarchar(25)	
execute examgeneration 'Data Mining',7,3,@e output
select @e

execute getexam_question @e

declare @d nvarchar(25)	
execute examgeneration 'Operating System',4,6,@d output
select @d

execute getexam_question @d

declare @f nvarchar(25)	
execute examgeneration 'Python ',7,3,@f output
select @f

execute getexam_question @f

declare @g nvarchar(25)	
execute examgeneration 'Excel',3,7,@g output
select @g

execute getexam_question @g

declare @h nvarchar(25)	
execute examgeneration 'Power BI',5,5,@h output
select @h

execute getexam_question @h

declare @i nvarchar(25)	
execute examgeneration 'Machine Learning',8,2,@i output
select @i

execute getexam_question @i
