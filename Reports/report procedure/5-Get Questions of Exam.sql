/*5-Report that takes exam number and returns Questions in it*/
alter proc getexam_question_only @examcode nvarchar(25)
as
	select Exam_code ,q.Q_Id,Q_content 
	from Exam_have_questions eq,Question q 
	where eq.Q_Id= q.Q_Id and   Exam_code =@examcode
	
execute getexam_question_only '2056'

ALTER proc getexam_question @examcode nvarchar(25)
as
	select Exam_code ,q.Q_Id,Q_content , ans_option,ans_content
	from Exam_have_questions eq,Question q ,Question_have_answer qa, answer_option ap
	where eq.Q_Id= q.Q_Id and q.Q_Id=qa.Q_Id and qa.ans_Id=ap.ans_id and Exam_code =@examcode

execute getexam_question '2056'

