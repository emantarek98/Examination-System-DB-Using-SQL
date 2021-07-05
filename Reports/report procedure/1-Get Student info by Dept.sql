/*1-Report that returns the students information according to Department .*/
alter proc Getst_by_dept @did int
as
	select St_Id , St_name ,St_gender,St_city ,Dept_name
	from Student s,Department d
	where d.Dept_Id = @did and s.Dept_Id =d.Dept_Id


execute getst_by_dept 1

