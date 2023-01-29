
Use Insurance 
Go

--step 1

/*--Query 1
Select claimantid,reopeneddate
from claimant

--Query 2
Select pk,max(entrydate) as ExaminerAssignedDate
from claimlog
where fieldname='Examinercode'
group by pk

--Query 3
Select claimnumber,max(enteredon) As Lastpublished
from reservingtool
where ispublished=1
group by claimnumber*/

/*--step 4

--declare @dateasof date
--set @dateasof = '1/1/2019'

--declare @reservingtoolpbl table 
--(
--claimnumber varchar (30),
--lastpublisheddate datetime
--)

--declare @assigneddatelog table
--(
--pk int,
--examinerassigneddate datetime
--)

----step 5

--insert into @reservingtoolpbl
--Select claimnumber,max(enteredon) As Lastpublished
--from reservingtool
--where ispublished=1
--group by claimnumber

--insert into @assigneddatelog
--Select pk,max(entrydate) as ExaminerAssignedDate
--from claimlog
--where fieldname='Examinercode'
--group by pk

----select * from @reservingtoolpbl
----select * from @assigneddatelog

----step 3

--select 
-- claimnumber
-- ,managercode
-- ,managertitle
-- ,managername
-- ,supervisorcode
-- ,supervisortitle
-- ,supervisorname
-- ,examinercode
-- ,examinertitle
-- ,examinername
-- ,office
-- ,claimstatusdesc
-- ,Claimantname
-- ,claimanttypedesc
-- ,examinerassigneddate
-- ,ReopenedDate
-- ,adjustedassigneddate
-- ,lastpublisheddate
-- ,dayssincelastadjustedassigneddate
-- ,daysincesincelastpublisheddate
-- ,case 
--  when dayssincelastadjustedassigneddate > 14 and (daysincesincelastpublisheddate > 90  or daysincesincelastpublisheddate is null) then 0
--  when 91-daysincesincelastpublisheddate >= 15-dayssincelastadjustedassigneddate and daysincesincelastpublisheddate is not null
--  then 91-daysincesincelastpublisheddate
--  else 15-dayssincelastadjustedassigneddate 
--  end as daystocomplete
--  ,case
--  when dayssincelastadjustedassigneddate <=14 or (daysincesincelastpublisheddate <=90 and daysincesincelastpublisheddate is not null) then 0
--  when daysincesincelastpublisheddate -90 <= dayssincelastadjustedassigneddate-14 and  daysincesincelastpublisheddate is not null
--  then daysincesincelastpublisheddate -90
--  else daysincesincelastpublisheddate -90
--  end as daysoverdue

--from 
--(

----step 2

--select 
--     c.claimnumber,
--	 r.reserveamount,
--	 o.officedesc as office,
--	 o.state,
--	 u.username as examinercode,
--	 u2.username as supervisorcode,
--	 u3.username as managercode,
--	 u.title as examinertitle,
--	 u2.title as supervisortitle,
--	 u3.title as managertitle,
--	 u.lastfirstname as examinername,
--	 u2.lastfirstname as supervisorname,
--	 u3.lastfirstname as managername,
--	 cs.claimstatusdesc,
--	 trim(p.firstname + ' ' + p.middlename + ' ' + p.lastname) as Claimantname,
--	 cl.reopeneddate,
--	 ct.claimanttypedesc,
--	 u.reservelimit,
--	 (case
--	 when rt.parentid in (1,2,3,4,5) then parentid
--	 else rt.reservetypeid
--	 end) as reservebucketid,
--	 case
--      when cs.claimstatusdesc='reopen' and cl.ReopenedDate > adl.examinerassigneddate then cl.reopeneddate
--      else adl.examinerassigneddate
--      end as adjustedassigneddate,
--	  adl.examinerassigneddate,
--	  rtp.lastpublisheddate,
--	  case
--      when cs.claimstatusdesc='reopen' and cl.ReopenedDate > adl.examinerassigneddate then datediff(day,reopenedDate,@dateasof)
--	  else datediff(day,examinerassigneddate,@dateasof)
--	  end as dayssincelastadjustedassigneddate,
--	  datediff(day,lastpublishedDate,@dateasof) as daysincesincelastpublisheddate


--	from Claimant cl
--	inner join claim c on c.claimid=cl.claimid
--	inner join users u on u.username=c.examinercode
--	inner join users u2 on u.supervisor=u2.username
--	inner join users u3 on u2.supervisor=u3.username
--	inner join office o on u.officeid=o.officeid
--	inner join claimanttype ct on ct.claimanttypeid=cl.claimanttypeid
--	inner join reserve r on r.claimantid=cl.claimantid
--	inner join claimstatus cs on cs.claimstatusid=cl.claimstatusid
--	inner join reservetype rt on rt.reservetypeid=r.reservetypeid
--	inner join patient p on p.patientid=cl.patientid
--	left join @assigneddatelog adl on c.claimid=adl.pk
--	left join @reservingtoolpbl rtp on c.ClaimNumber=rtp.claimnumber
--	where o.officedesc in ('Sacramento','San Diego','SAn Francisco')
--	and (rt.parentid in (1,2,3,4,5) or rt.reservetypeid in (1,2,3,4,5))
--	and (cs.claimstatusid = 1 or (cs.claimstatusid =2 and cl.reopenedreasonid <> 3))
--	 --step 2 ends
--	) basedata
--	pivot
--	( sum(reserveamount)
--	for reservebucketid in ([1],[2],[3],[4],[5])
--	) pivottable
-- where pivottable.claimanttypedesc in ('firstaid','medicalonly')
-- or ( pivottable.office='san diego'
-- and (isnull([1],0) + isnull([2],0) + isnull([3],0) + isnull([4],0) + isnull([5],0) >= pivottable.reservelimit)
-- )
-- or
-- (pivottable.office in ('sacremento','san francisco')
-- and  ( isnull([1],0) > 800 or isnull([5],0) >100 or (isnull([2],0)>0 or isnull([3],0)>0 or isnull([4],0)>0))
-- )*/



--step 6

CREATE PROCEDURE spgetoutstandingrtpublish (
@daystocomplete as int =null
,@daysoverdue as int = null
,@office as varchar(31) = null
,@managercode as varchar(31) =null
,@supervisorcode as varchar(31) = null
,@examinercode as varchar(31)=null
,@team as varchar(250) = null
,@claimswithoutrtpublish as bit = 0
)
as
begin

--step 4

	declare @dateasof date
	set @dateasof = '1/1/2019'

	declare @reservingtoolpbl table 
	(
	claimnumber varchar (30),
	lastpublisheddate datetime
	)

	declare @assigneddatelog table
	(
	pk int,
	examinerassigneddate datetime
	)

	--step 5

	insert into @reservingtoolpbl
	Select claimnumber,max(enteredon) As Lastpublished
	from reservingtool
	where ispublished=1
	group by claimnumber

	insert into @assigneddatelog
	Select pk,max(entrydate) as ExaminerAssignedDate
	from claimlog
	where fieldname='Examinercode'
	group by pk

	--select * from @reservingtoolpbl
	--select * from @assigneddatelog


select *
from
(


	--step 3

	select 
	 claimnumber
	 ,managercode
	 ,managertitle
	 ,managername
	 ,supervisorcode
	 ,supervisortitle
	 ,supervisorname
	 ,examinercode
	 ,examinertitle
	 ,examinername
	 ,office
	 ,claimstatusdesc
	 ,Claimantname
	 ,claimanttypedesc
	 ,examinerassigneddate
	 ,ReopenedDate
	 ,adjustedassigneddate
	 ,lastpublisheddate
	 ,dayssincelastadjustedassigneddate
	 ,daysincesincelastpublisheddate
	 ,case 
	  when dayssincelastadjustedassigneddate > 14 and (daysincesincelastpublisheddate > 90  or daysincesincelastpublisheddate is null) then 0
	  when 91-daysincesincelastpublisheddate >= 15-dayssincelastadjustedassigneddate and daysincesincelastpublisheddate is not null
	  then 91-daysincesincelastpublisheddate
	  else 15-dayssincelastadjustedassigneddate 
	  end as daystocomplete
	  ,case
	  when dayssincelastadjustedassigneddate <=14 or (daysincesincelastpublisheddate <=90 and daysincesincelastpublisheddate is not null) then 0
	  when daysincesincelastpublisheddate -90 <= dayssincelastadjustedassigneddate-14 and  daysincesincelastpublisheddate is not null
	  then daysincesincelastpublisheddate -90
	  else daysincesincelastpublisheddate -90
	  end as daysoverdue

	from 
	(

	--step 2

	select 
		 c.claimnumber,
		 r.reserveamount,
		 o.officedesc as office,
		 o.state,
		 u.username as examinercode,
		 u2.username as supervisorcode,
		 u3.username as managercode,
		 u.title as examinertitle,
		 u2.title as supervisortitle,
		 u3.title as managertitle,
		 u.lastfirstname as examinername,
		 u2.lastfirstname as supervisorname,
		 u3.lastfirstname as managername,
		 cs.claimstatusdesc,
		 trim(p.firstname + ' ' + p.middlename + ' ' + p.lastname) as Claimantname,
		 cl.reopeneddate,
		 ct.claimanttypedesc,
		 u.reservelimit,
		 (case
		 when rt.parentid in (1,2,3,4,5) then parentid
		 else rt.reservetypeid
		 end) as reservebucketid,
		 case
		  when cs.claimstatusdesc='reopen' and cl.ReopenedDate > adl.examinerassigneddate then cl.reopeneddate
		  else adl.examinerassigneddate
		  end as adjustedassigneddate,
		  adl.examinerassigneddate,
		  rtp.lastpublisheddate,
		  case
		  when cs.claimstatusdesc='reopen' and cl.ReopenedDate > adl.examinerassigneddate then datediff(day,reopenedDate,@dateasof)
		  else datediff(day,examinerassigneddate,@dateasof)
		  end as dayssincelastadjustedassigneddate,
		  datediff(day,lastpublishedDate,@dateasof) as daysincesincelastpublisheddate


		from Claimant cl
		inner join claim c on c.claimid=cl.claimid
		inner join users u on u.username=c.examinercode
		inner join users u2 on u.supervisor=u2.username
		inner join users u3 on u2.supervisor=u3.username
		inner join office o on u.officeid=o.officeid
		inner join claimanttype ct on ct.claimanttypeid=cl.claimanttypeid
		inner join reserve r on r.claimantid=cl.claimantid
		inner join claimstatus cs on cs.claimstatusid=cl.claimstatusid
		inner join reservetype rt on rt.reservetypeid=r.reservetypeid
		inner join patient p on p.patientid=cl.patientid
		left join @assigneddatelog adl on c.claimid=adl.pk
		left join @reservingtoolpbl rtp on c.ClaimNumber=rtp.claimnumber
		where o.officedesc in ('Sacramento','San Diego','SAn Francisco')
		and (rt.parentid in (1,2,3,4,5) or rt.reservetypeid in (1,2,3,4,5))
		and (cs.claimstatusid = 1 or (cs.claimstatusid =2 and cl.reopenedreasonid <> 3))
		 --step 2 ends
		) basedata
		pivot
		( sum(reserveamount)
		for reservebucketid in ([1],[2],[3],[4],[5])
		) pivottable
	 where pivottable.claimanttypedesc in ('firstaid','medicalonly')
	 or ( pivottable.office='san diego'
	 and (isnull([1],0) + isnull([2],0) + isnull([3],0) + isnull([4],0) + isnull([5],0) >= pivottable.reservelimit)
	 )
	 or
	 (pivottable.office in ('sacremento','san francisco')
	 and  ( isnull([1],0) > 800 or isnull([5],0) >100 or (isnull([2],0)>0 or isnull([3],0)>0 or isnull([4],0)>0))
	 )

) mainquery
where
(@daystocomplete is null or daystocomplete <=@daystocomplete)
and (@daysoverdue is null or daysoverdue <= @daysoverdue)
and (@office is null or office = @office)
and (@managercode is null or managercode = @managercode)
and (@supervisorcode is null or supervisorcode = @supervisorcode)
and (@examinercode is null or examinercode = @examinercode)
and ( @team is null or examinertitle like '%' + @team + '%'
      or supervisortitle like '%' + @team + '%'
	  or managertitle like '%' + @team + '%'
	  )
and (@claimswithoutrtpublish = 0 or lastpublisheddate is null )

end