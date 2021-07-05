/*7-Report that returns the students information according to Department No parameter.*/
create proc Getst_by_dept_noparam 
as
	select St_Id , St_name ,St_gender,St_city ,Dept_name
	from Student s,Department d
	where s.Dept_Id =d.Dept_Id

execute Getst_by_dept_noparam 