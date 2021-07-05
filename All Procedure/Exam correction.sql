---------------------------------------------- Exam Correction ---------------------------------------------
alter proc examcorrection @examcode nvarchar(25),@stid int
as
		declare @exam_totalgrade int
		select @exam_totalgrade = (select sum(Q_mark) from Question q, Exam_have_questions eq
		where q.Q_Id = eq.Q_Id and Exam_code=@examcode group by Exam_code)
		update exam set exam_crs_Grade = @exam_totalgrade where Exam_code=@examcode
	
	declare exam_correction cursor 
		for select Exam_code ,St_Id ,exam_q_id ,St_ans , correct_ans ,St_grade
		from Student_take_Exam se, Question q
		where se.exam_q_id = q.Q_Id and Exam_code = @examcode and St_Id = @stid
		for update 
		declare @exam_code nvarchar(25) ,@st_id int,@q_no int ,@st_ans nvarchar(1),@correct_ans nvarchar(1),@grade int
		open exam_correction
		fetch exam_correction into @exam_code,@st_id,@q_no,@st_ans,@correct_ans,@grade
		begin 
			while @@FETCH_STATUS = 0
			begin
				declare @x int
				set @x = DIFFERENCE(@st_ans,@correct_ans)
				if @x =4
					update Student_take_Exam set St_grade =(select Q_mark from Question where Q_Id=@q_no)
					where Exam_code =@exam_code and exam_q_id = @q_no and St_Id =@st_id
				
				else
					update Student_take_Exam set St_grade =0
					where Exam_code =@exam_code and exam_q_id = @q_no and St_Id =@st_id
				fetch exam_correction into @exam_code,@st_id,@q_no,@st_ans,@correct_ans,@grade 
				end
			DECLARE @st_exam_grade float
			SELECT  @st_exam_grade =  ((select sum(St_grade) 
														from Student_take_Exam 
														where Exam_code = @examcode
														and St_Id =@stid)* 1.0/@exam_totalgrade)*100	
		SELECT 'Student grade in percentage' + str(@st_exam_grade) + '%'	
		end
		close exam_correction
		deallocate exam_correction


execute examcorrection '63D6',5

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

execute update_st_crs_grade 5,'63D6',2