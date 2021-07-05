/*6-Report that takes exam number and the student ID then returns the Questions in this exam with the student answers*/
alter proc getst_ans_exam @examcode nvarchar(25),@stid int 
as	
	select  se.St_Id , exam_q_id ,Q_content, St_ans 
	from Student_take_Exam se,Question q 
	where se.Exam_code = @examcode and St_Id = @stid and se.exam_q_id = q.Q_Id 



getst_ans_exam '0ff6',3
getst_ans_exam '52CF',3