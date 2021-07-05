/*4-Report that takes course ID and returns its topics*/
alter proc Get_crs_by_topic @tid int
as
	select Top_Name , Crs_Name
	from Topic t,Course c
	where t.Top_Id = c.Top_Id and t.Top_Id = @tid

get_crs_by_topic 1

alter proc get_topic_by_crs @cid int
as
	select Crs_Name , Top_Name
	from Topic t,Course c
	where t.Top_Id = c.Top_Id and c.Crs_Id=@cid

get_topic_by_crs 7