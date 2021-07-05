/*2-Report that takes the student ID and returns the grades of the student in all courses*/
alter proc Getst_grade @sid int
as 
	select St_name,c.Crs_Id,Crs_Name, Crs_grade_of_st "Student Grade"
	from Course c,Student_enroll_course sc, Student s
	where s.St_Id= sc.St_Id and s.St_Id=@sid
	and c.Crs_Id=sc.Crs_Id

Getst_grade 3