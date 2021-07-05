--------------------------------Question-------------------------------------------------------------
--select 
create proc getquestion
as
	select * from Question

execute getquestion

create proc getqustion_for_crs 
as
	select Crs_Name , Q_Id ,Q_content ,Q_type 
	from Course c, Question q
	where c.Crs_Id=q.Crs_Id

execute getqustion_for_crs




--insert 
alter proc insertquestion @qcont nvarchar(250) ,@qtype nvarchar(25),@correctans nvarchar(2),@crsid int
as
	if not exists(select Q_content from Question where Q_content = @qcont and Crs_Id=@crsid) 
		insert into Question(Q_content,Q_type,correct_ans,Crs_Id) values (@qcont,@qtype,@correctans,@crsid)
	else
		select 'error'
	
execute insertquestion 'what is the full form ','mcq','a',1

--update
create proc updatequestion @qid int ,@string nvarchar(50),@value nvarchar(250)
as
	begin try 
		if(@string='content' or @string='question content')
			update Question set Q_content=@value where Q_Id =@qid 

		else if(@string='mark' or @string='question mark')
			update Question set Q_mark=CONVERT( int ,@value) where Q_Id =@qid 

		else if(@string='correct answer' or @string='correct')
			update Question set correct_ans = @value where Q_Id = @qid 
		
		else
			select 'Invalid Info'
	end try
	begin catch
		select 'error'
	end catch

execute updatequestion 161,'mark',2

--Delete
create proc deletequestion @qid int
as
	if exists(select Q_Id from Question where Q_Id =@qid )
		begin
			delete from Question where Q_Id = @qid
			select 'Deleted Successfully'
		end
	else
		select 'Not Found!'
execute deletequestion 161

-------------------------------------Question have answer----------------------------------------------
alter proc getqusetion_with_ansoption 
as
	select q.Q_Id ,Q_content ,a.ans_id ,ans_option ,ans_content
	from Question q, Answer a, answer_option ap , Question_have_answer qa
	where q.Q_Id=qa.Q_Id and a.ans_id=qa.ans_Id
	and a.ans_id=ap.ans_id

execute getqusetion_with_ansoption 



-----------------------------------------answer/answer option-------------------------------------------------------------
--select 
create proc selectans_with_option
as
	select a.ans_id,ans_option ,ans_content 
	from Answer a, answer_option ap
	where a.ans_id= ap.ans_id


execute selectans_with_option

--insert
alter proc insertans @ansid int
as
	begin try 
	insert into Answer (ans_id) values (@ansid)
	end try
	begin catch
		select 'error'
	end catch

execute insertans 85

create proc insertans_option @ansid int ,@ansoption nvarchar(1) , @anscontent nvarchar(250)
as
	begin try 
	insert into answer_option (ans_id,ans_option,ans_content) values (@ansid ,@ansoption ,@anscontent)
	end try
	begin catch
		select 'error'
	end catch
execute insertans_option 85,'a','sjlsfns'

select ans_content from answer_option where ans_id =85 and ans_option='a'

--update 
alter proc update_ans_option @ansid int ,@ansoption nvarchar(2) ,@anscontent nvarchar(250)
as
	if exists(select ans_content from answer_option where ans_id = @ansid and ans_option =@ansoption )
		update answer_option set ans_content = @anscontent where ans_id = @ansid and ans_option =@ansoption
	else
		select 'error'

execute update_ans_option 85,'a','Date ()'

--Delete
alter proc deleteans @ansid int
as 
	if exists(select ans_id from Answer where ans_id =@ansid )
		delete from Answer where ans_id =@ansid
	else
		select 'error'

execute deleteans 82

alter proc delete_ans_option @ansid int ,@ansopt nvarchar(2)
as 
	if exists(select ans_option from answer_option where ans_id =@ansid and ans_option=@ansopt )
		delete from answer_option where ans_id =@ansid and ans_option =@ansopt
	else
		select 'error'

execute delete_ans_option 85,'b'