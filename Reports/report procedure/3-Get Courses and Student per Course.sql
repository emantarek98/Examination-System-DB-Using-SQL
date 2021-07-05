/*3-Report that takes the instructor ID and returns the name of the courses 
that he teaches and the number of student per course*/
alter proc Getcrs_st_by_ins @insid int
as
	select T_name , Crs_Name ,COUNT(s.St_Id) "Number of student"
	from Teacher t,Teacher_tech_course tc ,Course c,Student_enroll_course sc, Student s
	where t.T_Id = tc.T_Id and c.Crs_Id= tc.Crs_Id
	and s.St_Id=sc.St_Id and c.Crs_Id=sc.Crs_Id
	and t.T_Id=@insid
	group by T_name ,Crs_Name

Getcrs_st_by_ins 1
