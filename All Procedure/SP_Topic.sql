------------------------------------Topic----------------------------------------------------------------------
--select 
create proc selectalltopic
as
	select * from Topic

selectalltopic

--insert
alter proc inserttopic @topid int, @topname nvarchar(50) 
as
	if not exists(select Top_Name from Topic where Top_Name=@topname)
		insert into Topic (Top_Id ,Top_name)values(@topid, @topname)

	else
		select 'error'
	

inserttopic 6,'genal'
--update
alter proc updatetopic @topid int , @topname nvarchar(50) 
as 
	if  exists(select Top_name from Topic where Top_name=@topname)
			update Topic set Top_name =@topname where Top_Id=@topid
	else
		select 'error'
	

updatetopic 5,'gej'

--delete
create proc deletetopic @topid int
as 
	if exists(select Top_Id from Topic where Top_Id=@topid)
	begin
		delete from Topic where Top_Id=@topid
		select 'Deleted Successfully'
	end
	else
		select 'Not Found!'

deletetopic 6
