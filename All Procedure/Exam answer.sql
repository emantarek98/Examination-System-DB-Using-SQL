--------------------------------------------------Exam Answers -----------------------------------------

alter proc examanswers @examcode nvarchar(25),@stid int ,@qno int , @qans nvarchar(2)
as
	begin 
		if not exists(select se.Exam_code,St_Id,exam_q_id from Student_take_Exam se, Exam_have_questions eq where se.Exam_code=@examcode and St_Id =@stid and se.exam_q_id=@qno and eq.Exam_code=se.Exam_code )
			begin
			 if exists(select st_id from Student where St_Id = @stid)
				begin
				if exists (select Exam_code from Exam_have_questions where Exam_code =@examcode)
					begin
						if exists(select Q_Id from Exam_have_questions eq where Q_Id=@qno and Exam_code=@examcode )
							begin
								execute getexam_question @examcode
								insert into Student_take_Exam (Exam_code , St_Id ,exam_q_id,St_ans)
								values(@examcode ,@stid,@qno,@qans)
							end		
						else
							select 'Invalid Question Number'
					end
				else
					select 'Invalid Exam'	
			    end
				else 
					select 'Invalid Student'
		    end	
		else
			select ' Answers Already Submitted '
	end


execute getexam_question '63D6'	
execute examanswers '63D6',5,24,'b'
execute examanswers '63D6'	,5,25,'a'
execute examanswers '63D6'	,5,26,'d'
execute examanswers '63D6'	,5,27,'c'
execute examanswers '63D6'	,5,28,'d'
execute examanswers '63D6'	,5,31,'a'
execute examanswers '63D6'	,5,32,'b'
execute examanswers '63D6'	,5,34,'b'
execute examanswers '63D6'	,5,38,'a'
execute examanswers '63D6'	,5,39,'b'
