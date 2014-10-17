CREATE DATABASE  IF NOT EXISTS `plitto2014` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `plitto2014`;
-- MySQL dump 10.13  Distrib 5.6.17, for Win32 (x86)
--
-- Host: 127.0.0.1    Database: plitto2014
-- ------------------------------------------------------
-- Server version	5.6.16

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping events for database 'plitto2014'
--

--
-- Dumping routines for database 'plitto2014'
--
/*!50003 DROP FUNCTION IF EXISTS `duser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `duser`() RETURNS int(11)
BEGIN

RETURN 2;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `dusers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `dusers`() RETURNS char(255) CHARSET latin1
BEGIN

RETURN '18,25,14,156,64,132,13,69,724,723,161,168,719';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fThingId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fThingId`(newthingName TEXT) RETURNS int(11)
BEGIN

SET @newthingName = newthingName;

SET @thingId = (select id from tthing where `name` = @newthingName limit 1);


-- call log('new thing',CONCAT('thingID: ',@thingId, ' thingName: ',@newthingName));

if(@thingId > 1) then 
		-- call log('thing id was greater than 1. ',CONCAT('thingID: ',@thingId, ' thingName: ',@newthingName));

	SET @thingId =  @thingId;
else
	-- call log('thing fail. ThingID was 0 or 1',@thingId);
	insert into tthing (`name`) VALUES (@newthingName);

	set @thingId =  LAST_INSERT_ID();
end if;

return @thingId;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `adminDeleteUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `adminDeleteUser`()
BEGIN


delete from tlist where uid in (
select ID 
from tuser
where name like '%ben%'
and id not in (1,168)
) and id > 0;

delete from tuser
where name like '%ben%'
and id not in (1,168);

select ID from tuser
where name like '%ben%'
and id not in (1,168);


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `adminImportDittos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `adminImportDittos`()
BEGIN


SET @loopCount = 1000;
SET @updated = 0;
SET @matched = 0;


WHILE @loopCount >1 DO

	SET @rowid = null;
	SET @uid = null;
	SET @lid = null;
	SET @tid = null;


	SELECT id, uid, lid, tid INTO @rowid, @uid, @lid, @tid from tlist where dittokey = 0 limit 1;

	if @rowid is null then 
		SET @loopCount = 0 ;
	end if;

	-- Find a matching ditto.
	SET @dittoKey = 0;
	SET @dittoKey = (select id from tditto where userID = @uid and thingid = @tid and listid = @lid limit 1);

	-- SELECT @dittoKey as dittokey, @rowid as tlistid, @uid as uid, @tid as tid;

	if @dittoKey is null  then
		update tlist set dittokey = -1 where id = @rowid limit 1;

	else 
		update tlist set dittokey = @dittoKey where id = @rowid limit 1;
		SET @updated = @updated + 1;
	end if;
	SET @matched = @matched + 1;

	SET @loopCount = @loopCount -1; 

END WHILE;

SET @remaining = (select count(*) as thecount from tlist where dittokey = 0);


SELECT @matched as matched, @updated as updated, @loopCount as loopCount, @remaining as remaining;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `adminStressTest` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `adminStressTest`()
BEGIN

SET @i = 0;

WHILE @i < 1000 do 
	
	call `showSome`(
		'general'
		, duser()
		, dusers()	
		, null

	);

	SET @i = @i + 1;

end while;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `log` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `log`(title VARCHAR(255), log TEXT)
BEGIN

insert into log(`title`,`log`) VALUES (title,log);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `migrate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `migrate`()
BEGIN

-- prepare 
delete from tlist where id > 0; -- Has Constraints, so first.

delete from tthing where id > 0;
delete from tuser where id > 0;


-- Things
replace into tthing (`name`,`id`)
select distinct ThingName, ThingId from plitto.things;

-- Users
replace into tuser (`id`,`name`,`fbuid`)
select UserID, UserName, password 
from plitto.user_logins 
where LoginType = 2 and UserName is not null; 

-- Lists - No Ditto
replace into tlist (`tid`,`lid`,`uid`,`added`,`modified`,`state`)
select a.Child, a.ParentListNameID, a.UserId, a.Added, a.Modified, a.State
from plitto.listlinks a 
inner join tthing on tthing.id = a.Child
inner join tthing b on a.parentlistnameid = b.id
inner join tuser c on a.userid = c.id
where a.userSource is null
;

-- Lists - Ditto
replace into tlist (`tid`,`lid`,`uid`,`added`,`modified`,`state`)
select a.Child, a.ParentListNameID, a.UserId, a.Added, a.Modified, a.State
from plitto.listlinks a 
inner join tthing on tthing.id = a.Child
inner join tthing b on a.parentlistnameid = b.id
inner join tuser c on a.userid = c.id
inner join tuser d on d.id = a.userSource
where a.userSource is not null
;

replace into tditto (`userid`,`sourceuserid`,`thingid`,`listid`,`added`,`read`,`hidden`)
select userdittoing, userReceiving, thingNameId, listNameId, dateAdded,0,0
from plitto.log_dittos;


update tlist set uid = 1 where uid = 9;
update tuser set id = 1 where id = 9;
update tditto set userid = 1 where userid = 9;



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spAddToList` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spAddToList`(thingName TEXT, listnameid INT, userid INT )
BEGIN
-- addToList("'.$_POST['thingName'].'","'.$_POST['listnameid'].'","'.$_POST['userid'].'","'.$_POST['userfb'].'");'accessible

call `spSqlLog`(userid, CONCAT('call spAddToList("',thingName,'","',listnameid,'","',userid,'")'), 0, 'spAddToList');


-- Vars
set @thingName = thingName;
set @listnameid = listnameid;
set @userid = userid;
SET @userid_listnameid = CONCAT(@userid,'_',@listnameid);
-- Get the thing id
set @thingId = fThingId(@thingName);

-- Find out if it already exists.
set @thekey = (select id from tlist where lid = @listnameid and uid = @userid and tid = @thingId limit 1);

if @thekey > 1 then
	-- Nothing to do.
	SET @a = 1;
else
	insert into tlist (`lid`,`tid`,`uid`,`added`,`modified`,`state`)
	values (@listnameid, @thingId, @userid, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);

	SET @thekey =  LAST_INSERT_ID();

end if;

SELECT @thekey as thekey, tlist.tid as thingid, 
	@userid_listnameid as listkey, 
	@thingName as thingname, 
	tthing.name as listname,
	@listnameid as lid
from tlist
inner join tthing on tthing.id = @listnameid 
where tlist.tid = @thingId and tlist.uid = @userid
limit 1

;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spDitto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spDitto`(userid INT, sourceuserid INT, thingid INT, 
	listid INT, theaction VARCHAR(20) , myFriends TEXT)
BEGIN

-- Sample: call spDitto("1","2","7779","7772","ditto","2,14,13")
call `spSqlLog`(userid, CONCAT('call spDitto("',userid,'","',sourceuserid,'","',thingid,'","',listid,'","',theaction,'","',myFriends,'")'), 0, 'spDitto');

-- Process the variables
SET @userid = userid;
SET @sourceuserid = sourceuserid;
SET @thingid = thingid;
SET @listid = listid;
SET @theaction = theaction;
SET @myFriends = myFriends; -- to get the count of friends who have that thing in that list.

if @theaction LIKE 'ditto' then 
	-- INSERT INTO TLIST
	INSERT INTO tlist (tid, lid, uid, state, added, modified)
		VALUES (@thingid, @listid, @userid, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
	on duplicate key update state = 1;
	
	SET @thekey = (select id from tlist where tid = @thingid and lid = @listid and uid = @userid limit 1);
	


	-- log the ditto - Working. 
		-- TODO2 - Handle what happens if a ditto is just returning something to its origional state.
	insert into tditto (userid, sourceuserid, thingid, listid, `added`, `read`)
	values (@userid, @sourceuserid, @thingid, @listid, CURRENT_TIMESTAMP, 0);

	-- Get the ditto key - FAILING
	SET @dittokey = 15;

	SET @dkq = CONCAT('
	SET @dittokey = (
		select id 
		from tditto 
		where 
			userid = ',@userid,' and 
			sourceuserid = ',@sourceuserid,' and 
			thingid = ',@thingid,' and 
			listid = ',@listid,' 
		order by id desc
		limit 1
	);');

	-- DEBUG call log('dittokey hunt',@dkq);

	prepare stmt from @dkq;
	execute stmt;
	deallocate prepare stmt;

	-- call log('dittokey result',@dittokey);

	-- Add it to the list table. - This is working.
	update tlist set dittokey = @dittokey where id = @thekey limit 1;

	-- Return the thingid and thingname and listname for the benefit of the Javascript coder.`
	-- SELECT @thekey as thekey;
	
	SET @theQ = CONCAT('
	select 
		l.id as thekey, l.tid, t.name as thingname, l.lid, 
		ln.name as listname, count(*) as friendsWith
	from tlist l
	inner join tthing t on t.id = l.tid
	inner join tthing ln on ln.id = l.lid
	where l.tid = ',@thingid,' and l.lid = ',@listid,' and l.uid in (',@myFriends,',',@userid,')
	group by l.tid, l.lid');

	prepare stmt from @theQ;
	execute stmt;
	deallocate prepare stmt;

elseif @theaction LIKE 'remove' then 
	-- Set the state to 0.
	UPDATE tlist SET state = 0 where tid = @thingid and lid = @listid and uid = @userid limit 1;


	-- Remove the notification and hide the ditto log.
	update tditto set hidden = 1, `read` = 1
	where userid = @userid and sourceuserid = @sourceuserid and thingid = @thingid and listid = @listid
	limit 1;

	SELECT true as success;
	
end if;




END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spDittosUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spDittosUser`(userId int, aboutUserIds TEXT)
BEGIN

call `spSqlLog`(userid, CONCAT('call spDittosUser("',userId,'","',aboutUserIds,'"'), 0, 'spDittosUser');

-- Dittos given
SET @dittosGiven = CONCAT('
select d.listid as lid, l.name as listname, d.thingid as tid, t.name as thingname, d.added 
	, u.id as userid, u.name as username, u.fbuid 
from tditto d
inner join tthing t on t.id = d.thingid
inner join tthing l on l.id = d.listid
inner join tuser u on u.id = d.sourceuserid
where userid = ', userId ,' and sourceuserid in (', aboutUserIds,')
order by d.id desc
limit 500');

-- Dittos received
SET @dittosReceived = CONCAT('
select d.listid as lid, l.name as listname, d.thingid as tid, t.name as thingname, d.added 
, u.id as userid, u.name as username, u.fbuid 
from tditto d
inner join tthing t on t.id = d.thingid
inner join tthing l on l.id = d.listid
inner join tuser u on u.id = d.userid

where userid in (', aboutUserIds,') and sourceuserid = ', userId ,'
order by d.id desc
limit 500');

-- Execute the queries
prepare stmt from @dittosGiven;
execute stmt;
	deallocate prepare stmt;

prepare stmt from @dittosReceived;
execute stmt;
	deallocate prepare stmt;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spFbLogin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spFbLogin`(
	fbuid BIGINT, fbname VARCHAR(255), fbemail VARCHAR(255) )
BEGIN

call `spSqlLog`(0, CONCAT('call spFbLogin("',fbuid,'","',fbname,'","',fbemail,'")'), 0, 'spFbLogin');

SET @fbuid = fbuid;
SET @fbname = fbname;
SET @fbemail = fbemail;

-- Clear the UserIds
SET @puid = null;
SET @active = null;
SET @username = null;
SET @email = null;

-- Step 1 -- see if this account already exists
-- SELECT @puid:=id , @active:=active, @thename:=name, @email:=email from tuser where fbuid = fbuid limit 1;


SELECT tuser.id, tuser.active, tuser.name, tuser.email 
	into @puid, @active, @username, @email 
from tuser where tuser.fbuid = @fbuid 
limit 1;

SET @result = CONCAT('fbuid: ' 
	, CAST(@fbuid AS CHAR CHARACTER SET utf8)
	,' initial puid: '
	, CAST(@puid AS CHAR CHARACTER SET utf8)
);

-- This test is failing: 
if @puid is null then
	set @result = CONCAT(@result,' puid was null. Create account.');

	-- Create the new user.
	insert into tuser (`name`,`fbuid`,`active`,`email`,`added`) 
	VALUES(@fbname, @fbuid, 1, @fbemail,CURRENT_TIMESTAMP);
	
	-- The first time around, this is making the user as if they were ID 1.
	SELECT 
		id, active, `name`, email 
		into @puid, @active, @username, @email 
	from tuser 
	where id = last_insert_id()
	limit 1;



-- Step 2 -- See if there are updates to make
elseif @active != 1 or @username != fbname or @email != fbemail then
	update tuser set `name` = @fbname, email = @fbemail where id = @puid limit 1;
	SET @result = CONCAT(@result,' | Update account information');
end if;

select @puid as puid, @username as username, @fbuid as fbuid; 

/*
*/

-- 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spFriends` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spFriends`(
	userId INT, 
	forUserIDs TEXT
)
BEGIN

call `spSqlLog`(userId, CONCAT('call spFriends("',userId,'","',forUserIDs,'")'), 0, 'spFriends');


SET @userId = userId;
SET @forUserIDs = forUserIds;

-- Try to build all the results from a single query.
SET @friendquery = CONCAT('

select u.id, u.name, u.fbuid  
	, count(DISTINCT tt.tid, tt.lid) as things
	, count(DISTINCT ot.tid, ot.lid) as shared
	, count(DISTINCT tt.tid, tt.lid) - count(DISTINCT ot.tid, ot.lid) as dittoable

	, count(distinct tt.lid) as lists
	, count(distinct ot.lid) as sharedlists
	-- , count(distinct d.id) as dittosout
	-- , count(distinct dd.id) as dittosin
	,1 as dittosout
	,1 as dittosin

from tuser u 

-- In Common
	-- Their things 0.016
inner join tlist tt on tt.uid = u.id  and tt.state = 1



	-- Things in common 0.0031
left outer join tlist ot on ot.lid = tt.lid and ot.tid = tt.tid  and ot.state = 1 and ot.uid = ',@userId,'

-- left outer join tditto d on tt.uid = d.sourceuserid
-- left outer join tditto dd on tt.uid = dd.userid

where 
	u.id in (',@forUserIds,')
	
group by u.id


union 

select ',@userId,' as id, h.name, h.fbuid, count(g.id) as things
	, count(g.id) as shared
	, 0 as dittoable
	, count( distinct g.lid) as lists
	, count( distinct g.lid) as sharedlists
	, 0 as dittosout
	, 0 as dittosin
from tlist g
inner join tuser h on g.uid = h.id 
where g.uid = ',@userId,'
group by g.uid

');

prepare stmt from @friendquery;
	execute stmt;
	deallocate prepare stmt;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spFriendsFB` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spFriendsFB`(
	userId INT, 
	forUserIDs TEXT
)
BEGIN

call `spSqlLog`(userId, CONCAT('call spFriendsFB("',userId,'","',forUserIDs,'")'), 0, 'spFriendsFB');


SET @userId = userId;
SET @forUserIDs = forUserIds;

-- Try to build all the results from a single query.
SET @friendquery = CONCAT('

select u.id, u.name, u.fbuid  
	, count(DISTINCT tt.tid, tt.lid) as things

	, count(DISTINCT ot.tid, ot.lid) as shared
	, count(DISTINCT tt.tid, tt.lid) - count(DISTINCT ot.tid, ot.lid) as dittoable

	, count(distinct tt.lid) as lists
	, count(distinct ot.lid) as sharedlists
/*
	, count(distinct d.id) as dittosout
	, count(distinct dd.id) as dittosin
*/
	
	

from tuser u 

-- In Common
	-- Their things 0.016
inner join tlist tt on tt.uid = u.id  and tt.state = 1



	-- Things in common 0.0031
left outer join tlist ot on ot.lid = tt.lid and ot.tid = tt.tid  and ot.state = 1 and ot.uid = ',@userId,'

-- left outer join tditto d on tt.uid = d.sourceuserid
-- left outer join tditto dd on tt.uid = dd.userid

where 
	u.fbuid in (',@forUserIds,')
	
group by u.id
order by shared desc



');

prepare stmt from @friendquery;
	execute stmt;
	deallocate prepare stmt;

/*

union 

select ',@userId,' as id, h.name, h.fbuid, count(g.id) as things
	, count(g.id) as shared
	, 0 as dittoable
	, count( distinct g.lid) as lists
	, count( distinct g.lid) as sharedlists
	, 0 as dittosout
	, 0 as dittosin
from tlist g
inner join tuser h on g.uid = h.id 
where g.uid = ',@userId,'
group by g.uid
*/

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spGetActivity` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spGetActivity`(userid INT, users TEXT, lastDate DATETIME)
BEGIN
-- call getActivity(for users ,last activity date)
-- call getActivity('2,13,14,1','')
call `spSqlLog`(userid, CONCAT('call spGetActivity("',userid,'","',users,'","',lastDate,'")'), 0, 'spGetActivity');


SET @users = users;
set @lastDate = lastDate;
SET @muid = userid;


	set @num :=0, @uid := null;
SET @q = CONCAT('

select 
	a.id, 
	a.uid ,  u.name as username, u.fbuid as fbuid, 
	a.lid, ln.name as listname,
	a.tid, tn.name as thingname,
	a.added, a.modified, a.state, a.mykey, 
	a.dittokey, d.sourceuserid as dittouser,du.fbuid as dittofbuid, du.name as dittousername
	
from (
	select * from (
		select i.id, 
				i.uid, 
			i.lid, 
			i.tid, 
			i.added, 
			i.modified,
			i.state,
			i.dittokey,
				j.id as mykey, 
			@num := if(@uid = i.uid, @num + 1,1) as row_number,
			@uid := i.uid as dummy
		from tlist i 
			
			left outer join tlist j 
				on i.lid = j.lid and i.tid = j.tid and j.state = 1 and j.uid = ',@muid,'
		
		where 
			i.uid in (',@users,') 
			and i.state = 1
			and i.added > DATE_SUB(NOW(), INTERVAL 2 MONTH)
			and j.id is null
		group by i.uid, i.lid, i.tid
		having row_number <=20
		order by i.uid desc
			
	) as dittoable

	union

	select * from (
		select i.id, 
				i.uid, 
			i.lid, 
			i.tid, 
			i.added, 
			i.modified,
			i.state,
			i.dittokey,
				j.id as mykey, 
			@num := if(@uid = i.uid, @num + 1,1) as row_number,
			@uid := i.uid as dummy
		from tlist i 
			
			left outer join tlist j 
				on i.lid = j.lid and i.tid = j.tid and j.state = 1 and j.uid = ',@muid,'
		
		where 
			i.uid in (',@users,') 
			and i.state = 1
			and i.added > DATE_SUB(NOW(), INTERVAL 2 MONTH)
			and j.id is not null
		group by i.uid, i.lid, i.tid
		having row_number <=20
		order by i.uid desc
			
	) as incommon
)
as a 
inner join tuser u on u.id = a.uid
inner join tthing ln on ln.id = a.lid
inner join tthing tn on tn.id = a.tid

left outer join tditto d on d.id = a.dittokey
left outer join tuser du on d.sourceuserid = du.id 


order by a.added desc


');

SET @dot = 1;

if @dot = 1 then
	prepare stmt from @q;
	execute stmt;
	deallocate prepare stmt;
else
	select @q;
end if;



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spGetMore` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spGetMore`(
	userId INT(10),
	
	forUserIDs TEXT ,

	thetype VARCHAR(20),
	theval
	 varchar(20), 
	thenot TEXT
)
BEGIN

call `spSqlLog`(userId, CONCAT('call spGetMore("',userId,'","',forUserIDs,'","',thetype,'","',theval,'","',thenot,'")'), 0, 'spGetMore');

-- call spGetMore(719,'','list','2067','');
SET @userId = userId; -- This user's user id.
SET @forUserIDs = forUserIDs; -- The target id.

SET @thetype = thetype;

SET @theval = theval;	-- Unused for now.
SET @thenot = thenot;	-- Existing

if LENGTH(@thenot) =  0 then
	SET @theNotWhere = '';
else
	SET @theNotWhere = CONCAT('and (a.uid, a.lid, a.tid) NOT IN (
			',@thenot,'
		)');
end if;


if @thetype like 'list' then
	SET @listadendum = CONCAT(' and a.lid in (',@theval,')');
else
	SET @listadendum = '';
end if;

--  Removed duid set @thefields = ' a.id, a.tid, a.lid, a.uid, a.added, a.modified, a.duid, a.state ';
set @thefields = ' a.id, a.tid, a.lid, a.uid, a.added, a.modified, a.state, a.dittokey ';
-- set @insertTable = 'insert into temp_splists (`id`,`tid`,`lid`,`uid`,`a`,`m`,`duid`,`state`,`myKey`)';
set @insertTable = 'insert into temp_splists (`id`,`tid`,`lid`,`uid`,`a`,`m`,`state`,`dittokey`,`myKey`,`show`,`listid`,`grouporder`)';

SET @defaultlimit = 25;

drop table if exists `temp_splists`;

CREATE table temp_splists (
	`id` INT(11),
	`tid` int(11),
	`lid` int(11),
	`uid` int(11),
	`a` datetime,
	`m` datetime,
	-- Removed. This will move to notifications and dittos. `duid` int(11),
	`state` tinyint(1),
	`myKey` int(11),
	`listid` VARCHAR(20),
	`show` TINYINT(1),
	`grouporder` tinyint(1),
	`dittokey` INT(11)	-- This is where they got their link from
	
);
-- ',@listadendum,' 

-- Insert my items, if it's a list
if @thetype like 'list' then
	SET @myItems = CONCAT(
		@insertTable, 
		' select ', @thefields,' , a.id, 1 , CONCAT(a.uid,"_",a.lid) as listid, 1 as grouporder
		from tlist a 
		
		where a.uid in (',@userId,') and a.state = 1 
			',@listadendum,' 
			',@theNotWhere,'
		order by a.id desc
		limit ',@defaultlimit);

		prepare stmt from @myItems;
		execute stmt;
		deallocate prepare stmt; 
end if;

-- Handle the exception for when the user has no friends.
if(length(@forUserIDs) > 0) then
	-- Dittoable 
	SET @dittoable = CONCAT(
		@insertTable, 
		' select ', @thefields,' , b.id, 1 , CONCAT(a.uid,"_",a.lid) as listid, 1 as grouporder
		from tlist a 
		left outer join tlist b on b.lid = a.lid and b.tid = a.tid and b.state = 1 and b.uid = ',@userId,' 
		where a.uid in (',@forUserIDs,') and a.state = 1 and b.state is null 
			',@listadendum,' 
			',@theNotWhere,'
		order by a.id desc
		limit ',@defaultlimit);


	-- Shared 
	SET @shared = CONCAT(
		@insertTable, 
		' select ', @thefields,' , b.id, 1,CONCAT(a.uid,"_",a.lid) as listid, 2 as grouporder
		from tlist a 
		inner join tlist b on b.lid = a.lid and b.tid = a.tid and b.state = 1 and b.uid = ',@userId,'
		where a.uid in (',@forUserIDs,') and a.state = 1 and b.state = 1  
			',@listadendum,' 
			',@theNotWhere,'
		order by a.id desc
		limit ',@defaultlimit);


	prepare stmt from @dittoable;
		execute stmt;
		deallocate prepare stmt; 

	prepare stmt from @shared;
		execute stmt;
		deallocate prepare stmt;
end if;

/* Result Set 1: List Contents */
-- SELECT * FROM temp_splists order by uid desc, lid asc, a desc;
select b.id
	-- Owning user.
	, b.uid, u.name as username, u.fbuid as fbuid
	, b.lid, ln.name as listname
	, b.tid, tn.name as thingname 
	, b.a as added, b.m as modified, b.state
	
	-- My key
	, b.mykey
	-- Where did they get this from? (before 0.07 - 0.125 sec)
	, b.dittokey , dt.sourceuserid as dittouser , du.fbuid as dittofbuid, du.name as dittousername

	-- Integrate the source of a ditto user.
-- , c.id as duid , c.name as dname, c.fbuid as dfbuid
from (
	select * , CONCAT(uid,'_',lid) as listkey 
	from (
	select t.id, t.tid, t.lid, t.uid, t.a, t.m, t.state, t.myKey , t.dittokey
		-- , a.name as thingname, b.name as username, c.name as listname
		-- , b.fbuid
		, `show`, listid , 1 as customOrder
	from temp_splists t
	-- inner join tthing a on t.tid = a.id
	-- inner join tthing c on t.lid = c.id
	-- inner join tuser b on b.id = t.uid
	where uid != @userId


	UNION
	select t.id, t.tid, t.lid, t.uid, t.a, t.m, t.state, t.myKey , t.dittokey
		-- , a.name as thingname, b.name as username, c.name as listname
		-- , b.fbuid
		, `show`, listid , 2 as customOrder
	from temp_splists t
	-- inner join tthing a on t.tid = a.id
	-- inner join tthing c on t.lid = c.id
	-- inner join tuser b on b.id = t.uid
	where uid = @userId)
	as x order by customOrder desc, listid desc) b
-- Bring in this user's information? For their facebook id, I guess.
inner join tuser u on b.uid = u.id
-- bring in the thing and list names
inner join tthing tn on tn.id = b.tid
inner join tthing ln on ln.id = b.lid

-- Bring in the dittos
left outer join tditto dt on dt.id = b.dittokey and b.dittokey >0
-- Bring in the user information from the dittos.
left outer join tuser du on du.id = dt.sourceuserid

	;




END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spListOfLists` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spListOfLists`(userId INT, friends TEXT, toIgnore TEXT)
BEGIN



call `spSqlLog`(userid, CONCAT('call spListOfLists("',userId,'","',friends,'","',toIgnore,'")'), 0, 'spListOfLists');

SET @userId = userId;
SET @friends = friends;
SET @toIgnore = toIgnore;

-- Append me to the results if my friends are null.

-- TODO0 - Add my lists to this.

if length(@friends) = 0 then

	SET @q = CONCAT('

	select l.id, ln.name as name, l.lid, count(*) as listmembers, count(*) as mymembers
		, 0 as dittoable, max(l.added) as mostrecent
		-- Count Shared
		, count(*) as shared
		, GROUP_CONCAT(distinct u.fbuid) as fbuids
	from tlist l
	inner join tthing as ln on ln.id = l.lid -- Brings in the names.
	inner join tuser as u on u.id = l.uid

	-- Get the fbuids


	where l.uid in (',@userid,')
	and l.state = 1
	group by l.lid

	order by shared desc
	limit 20
	;');

else

	SET @q = CONCAT('

	select l.id, ln.name as name, l.lid, count(*) as listmembers, count(m.id) as mymembers
		, count(*) - count(m.id) as dittoable, max(l.added) as mostrecent
		-- Count Shared
		, sum( m.id != l.id AND m.uid != l.uid) as shared
		, GROUP_CONCAT(distinct u.fbuid) as fbuids
	from tlist l
	inner join tthing as ln on ln.id = l.lid -- Brings in the names.
	inner join tuser as u on u.id = l.uid
	-- Brings in my key.
		left outer join tlist as m on m.tid = l.tid and m.lid = l.lid and m.uid = ',@userId,' and m.state = 1 

	-- Get the fbuids


	where l.uid in (',@friends,')
	and l.state = 1
	group by l.lid

	order by shared desc
	limit 20
	;');
end if;

prepare stmt from @q;
execute stmt;
deallocate prepare stmt;

SET @q = null;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spLists` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spLists`(
	userId INT, 
	forUserIDs TEXT, 
	forLists TEXT ,
	filters VARCHAR(255) ,
	firstDate INT(11), 
	lastDate INT(11), 
	direction VARCHAR(255)
)
BEGIN

call `spSqlLog`(userId, CONCAT('call spLists("',userId,'","',forUserIDs,'","',forLists,'","',filters,'","',firstDate,'","',lastDate,'","',direction,'")'), 0, 'spLists');

SET @userId = userId;			-- For this UserID.
SET @forUserIDs = forUserIDs;	-- String of IDs to pull
SET @forLists = forLists;		-- String of list name ids to pull
SET @filters = filters;			-- incommon,shared,ditto
SET @firstDate = firstDate;		-- The Oldest date in the current record set.
SET @lastDate = lastDate;			-- The Newest Date in the current record set
SET @direction = direction;		-- Older, Newer, or Both

--  Removed duid set @thefields = ' a.id, a.tid, a.lid, a.uid, a.added, a.modified, a.duid, a.state ';
set @thefields = ' a.id, a.tid, a.lid, a.uid, a.added, a.modified, a.state ';
-- set @insertTable = 'insert into temp_splists (`id`,`tid`,`lid`,`uid`,`a`,`m`,`duid`,`state`,`myKey`)';
set @insertTable = 'insert into temp_splists (`id`,`tid`,`lid`,`uid`,`a`,`m`,`state`,`myKey`)';

SET @defaultlimit = 50;

drop table if exists `temp_splists`;

CREATE table temp_splists (
	`id` INT(11),
	`tid` int(11),
	`lid` int(11),
	`uid` int(11),
	`a` datetime,
	`m` datetime,
	-- Removed. This will move to notifications and dittos. `duid` int(11),
	`state` tinyint(1),
	`myKey` int(11)
);

-- This must have been some kind of debuggind. 
 -- and a.tid not in (8082,7089,7088,7087,7086,7085,7084,7608,7517,7516,7515,7514,7513,7512,7511,7510,7509,7508,7507,7506,7505,7504,7503,7502,7501,7527,7487)

-- My Stuff
SET @myStuff = CONCAT(@insertTable, 
	' select ', @thefields,' , a.id 
	from tlist a 
	
	where a.uid = "',@userId,'" and a.state = 1 
		
	order by a.id desc
	limit ',@defaultlimit);

-- Dittoable 
SET @dittoable = CONCAT(@insertTable, 
	' select ', @thefields,' , b.id
	from tlist a 
	left outer join tlist b on b.lid = a.lid and b.tid = a.tid and b.state = 1 and b.uid = ',@userId,' 
	where a.uid in (',@forUserIDs,') and a.state = 1 and b.state is null 
		
	order by a.id desc
	limit ',@defaultlimit);


-- Shared 
SET @shared = CONCAT(@insertTable, 
	' select ', @thefields,' , b.id
	from tlist a 
	inner join tlist b on b.lid = a.lid and b.tid = a.tid and b.state = 1 and b.uid = ',@userId,'
	where a.uid in (',@forUserIDs,') and a.state = 1 and b.state = 1  
		
	order by a.id desc
	limit ',@defaultlimit);


prepare stmt from @myStuff;
	execute stmt;
	deallocate prepare stmt;

prepare stmt from @dittoable;
	execute stmt;
	deallocate prepare stmt;

prepare stmt from @shared;
	execute stmt;
	deallocate prepare stmt;


/* Result Set 1: List Contents */
SELECT * FROM temp_splists order by uid desc, lid asc, a desc;

/* Result Set 2: Thing Names */

select * from (
	select l.tid as id, a.name
	from temp_splists l
	inner join tthing a on a.id = l.tid


	union 


	select  l.lid as id, a.name
	from temp_splists l
	inner join tthing a on a.id = l.lid
) 
as b
order by id asc;

/*
 // Result Set 2: User Names 
select distinct a.uid , b.name, b.fbuid
from temp_splists a 
inner join tuser b on a.uid = b.id;
*/

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spListsB` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spListsB`(
	userId INT, 
	forUserIDs TEXT, 
	forLists TEXT ,
	filters VARCHAR(255) ,
	firstDate INT(11), 
	lastDate INT(11), 
	direction VARCHAR(255)
)
BEGIN

call `spSqlLog`(userId, CONCAT('call spListsB("',userId,'","',forUserIDs,'","',forLists,'","',filters,'","',firstDate,'","',lastDate,'","',direction,'")'), 0, 'spListsB');

SET @userId = userId;			-- For this UserID.
SET @forUserIDs = forUserIDs;	-- String of IDs to pull
SET @forLists = forLists;		-- String of list name ids to pull
SET @filters = filters;			-- incommon,shared,ditto
SET @firstDate = firstDate;		-- The Oldest date in the current record set.
SET @lastDate = lastDate;			-- The Newest Date in the current record set
SET @direction = direction;		-- Older, Newer, or Both

--  Removed duid set @thefields = ' a.id, a.tid, a.lid, a.uid, a.added, a.modified, a.duid, a.state ';
set @thefields = ' a.id, a.tid, a.lid, a.uid, a.added, a.modified, a.state ';
-- set @insertTable = 'insert into temp_splists (`id`,`tid`,`lid`,`uid`,`a`,`m`,`duid`,`state`,`myKey`)';
set @insertTable = 'insert into temp_splists (`id`,`tid`,`lid`,`uid`,`a`,`m`,`state`,`myKey`,`show`,`listid`,`grouporder`)';

SET @defaultlimit = 200;

drop table if exists `temp_splists`;

CREATE table temp_splists (
	`id` INT(11),
	`tid` int(11),
	`lid` int(11),
	`uid` int(11),
	`a` datetime,
	`m` datetime,
	-- Removed. This will move to notifications and dittos. `duid` int(11),
	`state` tinyint(1),
	`myKey` int(11),
	`listid` VARCHAR(20),
	`show` BINARY,
	`grouporder` tinyint(1)
);

-- This must have been some kind of debuggind. 
 -- and a.tid not in (8082,7089,7088,7087,7086,7085,7084,7608,7517,7516,7515,7514,7513,7512,7511,7510,7509,7508,7507,7506,7505,7504,7503,7502,7501,7527,7487)

-- My Stuff
SET @myStuff = CONCAT(@insertTable, 
	' select ', @thefields,' , a.id, false as `show` ,CONCAT(a.uid,"_",a.lid) as listid, 3 as grouporder
	from tlist a 
	
	where a.uid = "',@userId,'" and a.state = 1 
		
	order by a.id desc
	limit ',@defaultlimit);

-- Dittoable 
SET @dittoable = CONCAT(@insertTable, 
	' select ', @thefields,' , b.id, true as `show`, CONCAT(a.uid,"_",a.lid) as listid, 1 as grouporder
	from tlist a 
	left outer join tlist b on b.lid = a.lid and b.tid = a.tid and b.state = 1 and b.uid = ',@userId,' 
	where a.uid in (',@forUserIDs,') and a.state = 1 and b.state is null 
		
	order by a.id desc
	limit ',@defaultlimit);


-- Shared 
SET @shared = CONCAT(@insertTable, 
	' select ', @thefields,' , b.id, true as `show`,CONCAT(a.uid,"_",a.lid) as listid, 2 as grouporder
	from tlist a 
	inner join tlist b on b.lid = a.lid and b.tid = a.tid and b.state = 1 and b.uid = ',@userId,'
	where a.uid in (',@forUserIDs,') and a.state = 1 and b.state = 1  
		
	order by a.id desc
	limit ',@defaultlimit);

prepare stmt from @dittoable;
	execute stmt;
	deallocate prepare stmt; 

prepare stmt from @shared;
	execute stmt;
	deallocate prepare stmt;

prepare stmt from @myStuff;
	execute stmt;
	deallocate prepare stmt;


/* Result Set 1: List Contents */
-- SELECT * FROM temp_splists order by uid desc, lid asc, a desc;
select *, CONCAT(uid,'_',lid) as listkey from (
select t.id, t.tid, t.lid, t.uid, t.a, t.m, t.state, t.myKey 
	, a.name as thingname, b.name as username, c.name as listname
	, b.fbuid, `show`, listid , 1 as customOrder
from temp_splists t
inner join tthing a on t.tid = a.id
inner join tthing c on t.lid = c.id
inner join tuser b on b.id = t.uid
where uid != @userId


UNION
select t.id, t.tid, t.lid, t.uid, t.a, t.m, t.state, t.myKey 
	, a.name as thingname, b.name as username, c.name as listname
	, b.fbuid, `show`, listid , 2 as customOrder
from temp_splists t
inner join tthing a on t.tid = a.id
inner join tthing c on t.lid = c.id
inner join tuser b on b.id = t.uid
where uid = @userId)
as x order by customOrder desc, listid desc
;

/* Result Set 2: Thing Names 

select * from (
	select l.tid as id, a.name
	from temp_splists l
	inner join tthing a on a.id = l.tid


	union 

DELIMITER $$
CREATE FUNCTION `fThingId`(newthingName TEXT) RETURNS int(11)
BEGIN

SET @newthingName = newthingName;

SET @thingId = (select id from tthing where `name` = @newthingName limit 1);


-- call log('new thing',CONCAT('thingID: ',@thingId, ' thingName: ',@newthingName));

if(@thingId > 1) then 
		-- call log('thing id was greater than 1. ',CONCAT('thingID: ',@thingId, ' thingName: ',@newthingName));

	SET @thingId =  @thingId;
else
	-- call log('thing fail. ThingID was 0 or 1',@thingId);
	insert into tthing (`name`) VALUES (@newthingName);

	set @thingId =  LAST_INSERT_ID();
end if;

return @thingId;


END$$
DELIMITER ;

	select  l.lid as id, a.name
	from temp_splists l
	inner join tthing a on a.id = l.lid
) 
as b
order by id asc;
*/
/*
 // Result Set 2: User Names 
select distinct a.uid , b.name, b.fbuid
from temp_splists a 
inner join tuser b on a.uid = b.id;
*/

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spListSearch` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spListSearch`(userId INT, searchTerm TEXT, graph TEXT)
BEGIN

call `spSqlLog`(userId, CONCAT('call spListSearch("',userId,'","',searchTerm,'","',graph,'")'), 0, 'spListSearch');

SET @searchTerm = searchTerm;

select a.lid, b.name as listname, count(*) as thecount 

from tlist a 
inner join tthing b on b.id=  a.lid

where b.name like CONCAT('%',@searchTerm ,'%')
-- and a.userid in (1,2,3,4,5,6,7,8,9,10,13,168,19,18,17,16,15,14,13,12,11)
group by a.lid
order by thecount desc
limit 10;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spPlittoFriendsFromFb` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spPlittoFriendsFromFb`(friendString TEXT)
BEGIN

call `spSqlLog`(0, CONCAT('call spPlittoFriendsFromFb("',friendString,'")'), 0, 'spPlittoFriendsFromFb');

SET @q = CONCAT('
select group_concat(id SEPARATOR ",") as puids from tuser where fbuid in (',friendString,')');

prepare stmt from @q;
execute stmt;
deallocate prepare stmt;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spSearch` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spSearch`(theuserid INT, theusers TEXT, term VARCHAR(255))
BEGIN

SET @userid = theuserid;
SET @users = theusers;
set @term = term;

drop table if exists `temp_search`;
CREATE TABLE `temp_search` (
	`id` int(3) NOT NULL Auto_Increment, 
	`type` VARCHAR(10),
	`group` INT(1),
	`nameid` INT(11),
	`name` TEXT,
	`count` INT(7), 
	primary key(`id`)
);


-- Lists that match that from my friends
SET @i = CONCAT(
' INSERT INTO temp_search (`type`,`group`,`nameid`,`name`,`count`)
select "list", 1, t.id, t.name, count(*) as contain 
from tthing t
inner join tlist l on l.lid = t.id 
where t.name like "%',@term,'%"
	and l.uid in (',@userid,',',@users,')
group by t.id
order by contain desc
limit 10');


prepare stmt from @i;
execute stmt;
deallocate prepare stmt; 



-- Lists that match that term from everyone, that wasn't in the friend results
SET @j = CONCAT(
' INSERT INTO temp_search (`type`,`group`,`nameid`,`name`,`count`)
select "list", 2, t.id, t.name, count(*) as contain 
from tthing t
inner join tlist l on l.lid = t.id 
where t.name like "%',@term,'%"
	and l.uid not in (',@userid,',',@users,')
	and t.id not in (select nameid from temp_search)
group by t.id
order by contain desc
limit 10');


prepare stmt from @j;
execute stmt;
deallocate prepare stmt; 


-- Things that match that term from my friends
SET @k  = CONCAT(
' INSERT INTO temp_search (`type`,`group`,`nameid`,`name`,`count`)
select "thing", 3, t.id, t.name, count(*) as contain 
from tthing t
inner join tlist l on l.tid = t.id 
where t.name like "%',@term,'%"
	and l.uid in (',@userid,',',@users,')
group by t.id
order by contain desc
limit 10');


prepare stmt from @k;
execute stmt;
deallocate prepare stmt; 

-- Things that match that term from everyone.
-- Lists that match that term from everyone, that wasn't in the friend results
SET @l = CONCAT(
' INSERT INTO temp_search (`type`,`group`,`nameid`,`name`,`count`)
select "thing", 4, t.id, t.name, count(*) as contain 
from tthing t
inner join tlist l on l.tid = t.id 
where t.name like "%',@term,'%"
	and l.uid not in (',@userid,',',@users,')
	and t.id not in (select nameid from temp_search )
group by t.id
order by contain desc
limit 10');


prepare stmt from @l;
execute stmt;
deallocate prepare stmt; 

select * from temp_search;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spShowSome` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spShowSome`(
	thetype VARCHAR(10)
	, userid int(11)
	, theusers TEXT
	, thelist int(11) 
)
BEGIN

SET @thetype = thetype;
SET @theusers = theusers;
SET @theist = thelist;
SET @userid = userid;

-- If this user has more than three friends, do something different.
SET @itemsCount = CHAR_LENGTH(@theusers) - CHAR_LENGTH(REPLACE(@theusers,',',''));
if @itemsCount > 2 then
	
	SET @fq = CONCAT('SET @freshq = (
	select group_concat(fromuid SEPARATOR ",") 
	from (select fromuid from presentlist  where fromuid in (',@theusers,') and uid = ',@userid,' order by lastdate desc limit 2) as t
	);');
		
	prepare stmt from @fq;
	execute stmt;
	deallocate prepare stmt;


	SET @friendOverload = CONCAT(' and l.uid not in (',@freshq , ')');

	-- select @fq as fo;

else
	SET @friendOverload = '';
end if;

-- select @friendOverload, @itemsCount;

SET @Auid = null, @Alid = null, @Adittoable = null, @Buid = null, @Blid = null, @Bdittoable = null, @Cuid = null, @Clid = null
	, @Cdittoable =null, @Duid = null, @Dlid = null, @Ddittoable =null;

-- Make my lists that I have and don't have
SET @mylists = (select group_concat(distinct lid SEPARATOR ',') from tlist where uid = @userid and state = 1 );

/* Batch A - A list from a friend that I also have, with at least 3 dittoable things in it, that I don't have. */
SET @batchA = CONCAT('select 
l.lid, l.uid, count(l.id) - count(m.id) as dittoable into @Alid, @Auid, @Adittoable

from tlist l
left outer join tlist m on m.lid = l.lid and m.tid=l.tid and m.uid = ',@userid,' and m.id is null
left outer join presentlist pl on pl.uid = ',@userid,' and pl.fromuid = l.uid and pl.lid = l.lid

where 
	l.uid in (',@theusers,')  
	and l.lid in (',@mylists,')
	and l.state = 1
	',@friendOverload,'
group by l.lid,l.uid
having dittoable > 3
order by pl.lastdate asc
limit 1')
;

-- select @batchA as x;

prepare stmt from @batchA;
	execute stmt;
	deallocate prepare stmt;


/* Batch B - A list from a friend, that I don't have that list, with at least 3 dittoable things in it, that I have, 
	and is from a different user 
	LOGIC - It the filter is a user, then this must be the same user.
*/

SET @batchB = CONCAT('select
l.lid, l.uid, count(l.id) - count(m.id) as dittoable into @Blid, @Buid, @Bdittoable
from tlist l
left outer join tlist m on m.lid = l.lid and m.tid=l.tid and m.uid = ',@userid,' and m.id is null
left outer join presentlist pl on pl.uid = ',@userid,' and pl.fromuid = l.uid and pl.lid = l.lid
where 
	l.uid in (',@theusers,')  
	and l.lid not in (',@mylists,')
	and l.state = 1
	and l.uid != ',@Auid ,'
group by l.lid,l.uid
having dittoable > 3
order by pl.lastdate asc
limit 1')
;

prepare stmt from @batchB;
	execute stmt;
	deallocate prepare stmt;

/* Batch C - A list from strangers, I have that list, dittoable > 3, longest time since presented to me */
SET @batchC = CONCAT('select
max(l.lid), count(l.id) - count(m.id) as dittoable, group_concat(distinct l.uid SEPARATOR ",")  as strangersWith
into @Clid, @Cdittoable, @Cuid
from tlist l
left outer join tlist m on m.lid = l.lid and m.tid=l.tid and m.uid = ',@userid,' and m.id is null
left outer join presentlist pl on pl.uid = ',@userid,' and pl.fromuid = l.uid and pl.lid = l.lid
where 
	l.uid not in (',@theusers,')  
	and l.lid in (',@mylists,')
	and l.state = 1
group by l.lid
having dittoable > 2 and strangersWith > 1 
order by pl.lastdate asc
limit 1')
;

prepare stmt from @batchC;
	execute stmt;
	deallocate prepare stmt;

/* Batch D - A list from strangers, I don't have that list, dittoable > 3, longest time since presented to me */
SET @batchD = CONCAT('select
max(l.lid), count(l.id) - count(m.id) as dittoable, group_concat(distinct l.uid SEPARATOR ",")  as strangersWith
into @Dlid, @Ddittoable, @Duid
-- into @Alid, @Auid, @Adittoable
-- *, count(l.id) as theirlistitems, count(m.id) as mylistitems, count(l.id) - count(m.id) as dittoable
from tlist l
left outer join tlist m on m.lid = l.lid and m.tid=l.tid and m.uid = ',@userid,' and m.id is null
left outer join presentlist pl on pl.uid = ',@userid,' and pl.fromuid = l.uid and pl.lid = l.lid
where 
	l.uid not in (',@theusers,')  
	and l.lid not in (',@mylists,')
	and l.state = 1
group by l.lid
having dittoable > 2 and strangersWith > 1 
order by pl.lastdate asc
limit 1')
;
prepare stmt from @batchD;
	execute stmt;
	deallocate prepare stmt;

-- Use a Temporary Table to hold the raw results
drop table if exists showsometemp;

CREATE TABLE showsometemp (
	sstid INT NOT NULL AUTO_INCREMENT,
	id INT,
	tid INT,
	lid INT,
	uid INT,
	added DATETIME,
	modified DATETIME,
	state INT,
	dittokey INT,
	groupid INT,
	dittoable INT,
	lastshowncount INT,
	lastshown DATETIME
	
	, PRIMARY KEY (sstid)
);

-- INSERT RESULTS FROM A if it's valid.
if @Alid > 0 and @Auid > 0 then
	INSERT INTO showsometemp(id,tid,lid,uid,added,modified,state, dittokey, groupid, dittoable, lastshowncount , lastshown )
	select l.id, l.tid, l.lid, l.uid, l.added, l.modified, l.state, l.dittokey, 1, @Adittoable, pt.count, pt.lastdate
	from tlist l
	left outer join tlist m on m.uid = @userid and m.lid = l.lid and m.tid = l.tid and m.id is null
	left outer join presentthing pt on pt.tlistkey = l.id
	where l.uid = @Auid and l.lid = @Alid and l.state = 1
	order by pt.lastdate asc
	limit 10;
end if;


-- INSERT RESULTS FROM C if it's valid.
if @Blid > 0 and @Buid > 0 then
	INSERT INTO showsometemp(id,tid,lid,uid,added,modified,state, dittokey, groupid, dittoable, lastshowncount , lastshown )
	select l.id, l.tid, l.lid, l.uid, l.added, l.modified, l.state, l.dittokey, 2, @Bdittoable, pt.count, pt.lastdate
	from tlist l
	left outer join tlist m on m.uid = @userid and m.lid = l.lid and m.tid = l.tid and m.id is null
	left outer join presentthing pt on pt.tlistkey = l.id
	where l.uid = @Buid and l.lid = @Blid and l.state = 1
	order by pt.lastdate asc
	limit 10;
end if;
	
	
-- INSERT RESULTS FROM C if it's valid.
if CHAR_LENGTH(@Clid) > 0 and CHAR_LENGTH(@Cuid) > 0 then
	SET @insertC = CONCAT('INSERT INTO showsometemp(id,tid,lid,uid,added,modified,state, dittokey, groupid, dittoable, lastshowncount , lastshown )
	select l.id, l.tid, l.lid, 0, l.added, l.modified, l.state, l.dittokey, 3, @Cdittoable, pt.count, pt.lastdate
	from tlist l
	left outer join tlist m on m.uid = @userid and m.lid = l.lid and m.tid = l.tid and m.id is null
	left outer join presentthing pt on pt.tlistkey = l.id
	where l.uid IN (',@Cuid,') and l.lid = @Clid and l.state = 1
	order by pt.lastdate asc
	limit 10');
	prepare stmt from @insertC;
	execute stmt;
	deallocate prepare stmt;

end if;

-- INSERT RESULTS FROM D if it's valid.
if CHAR_LENGTH(@Dlid) > 0 and CHAR_LENGTH(@Duid) > 0 then
	SET @insertD = CONCAT('INSERT INTO showsometemp(id,tid,lid,uid,added,modified,state, dittokey, groupid, dittoable, lastshowncount , lastshown )
	select l.id, l.tid, l.lid, 0, l.added, l.modified, l.state, l.dittokey, 4, @Ddittoable, pt.count, pt.lastdate
	from tlist l
	left outer join tlist m on m.uid = @userid and m.lid = l.lid and m.tid = l.tid and m.id is null
	left outer join presentthing pt on pt.tlistkey = l.id
	where l.uid IN (',@Duid,') and l.lid in(', @Dlid ,') and l.state = 1
	order by pt.lastdate asc
	limit 10');
	prepare stmt from @insertD;
	execute stmt;
	deallocate prepare stmt;

end if;

-- RETURN THE RESULTS
select 
s.id, s.uid, un.name as username, un.fbuid,  s.lid, ln.name as listname, s.tid
, tn.name as thingname,   s.added, s.state, s.dittokey as dittokey, s.dittoable , s.groupid
, dk.uid as dittouser, du.name as dittousername, du.fbuid as dittofbuid, lastshowncount, lastshown
, null as mykey
from showsometemp s
inner join tthing tn on tn.id = s.tid
inner join tuser un on un.id = s.uid
inner join tthing ln on ln.id = s.lid
left outer join tlist dk on dk.id = s.dittokey 
left outer join tuser du on du.id = dk.uid

;

-- prepare stmt from @resultsA; 	execute stmt; 	deallocate prepare stmt;


-- SELEct @resultsA, @batchC, @Auid, @Alid, @Adittoable, @Buid, @Blid, @Bdittoable, @Cuid, @Clid, @Cdittoable, @Duid, @Dlid, @Ddittoable,@mylists;

-- Update the log to show most recently shown lists.
insert into presentlist (`uid`,`fromuid`,`lid`,`lastdate`,`presentcount`)
SELECT @userid, uid, lid, CURRENT_TIMESTAMP, 1
from showsometemp
group by lid
ON DUPLICATE KEY UPDATE lastdate = CURRENT_TIMESTAMP, presentcount = presentcount +1;
/*
select 'SELECT @userid, userid, lid, CURRENT_TIMESTAMP, 1
from showsometemp
group by lid' as x;
*/
-- Update the log to show most recently shown lists.
insert into presentthing (`uid`,`count`,`lastdate`,`tlistkey`)
SELECT @userid, 1, CURRENT_TIMESTAMP, id
from showsometemp
ON DUPLICATE KEY UPDATE lastdate = CURRENT_TIMESTAMP, count = count +1;





END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spSqlLog` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spSqlLog`(userId INT, thequery TEXT, logtime DECIMAL(12,5), sp VARCHAR(45))
BEGIN

insert into dblog(`userId`,`query`,`time`,`sp`)
VALUES (userId, thequery, logtime, sp);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spThingDetail` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spThingDetail`(theuserid INT, theuserids TEXT, thethingid INT)
BEGIN

SET @userid = theuserid;
SET @userids = theuserids;
SET @thingid = thethingid; 

SET @q = CONCAT('
select 
l.id, l.uid, u.name as username, u.fbuid, l.lid, ln.name as listname, 
l.tid, tn.name as thingname, l.added, l.dittokey
, ml.id as mykey, dk.uid as dittouser, du.fbuid as dittofbuid, du.name as dittousername
from tlist l 
inner join tthing ln on l.lid = ln.id
inner join tthing tn on l.tid = tn.id
inner join tuser u on l.uid = u.id
left outer join tlist ml on ml.uid = ',@userid,' and ml.lid = l.lid and ml.tid = l.tid 
left outer join tlist dk on dk.id = l.dittokey
left outer join tuser du on du.id = dk.uid
where 
	l.tid = ',@thingid,' and l.state = 1
	and l.uid in (',@userid,',',@userids,')

union

select 
l.id, l.uid, "Anonymous" as username, 0 , l.lid, ln.name as listname, 
l.tid, tn.name as thingname, 0, 0
, ml.id as mykey, 0 as dittouser, 0 as dittofbuid, "Anonymous" as dittousername
from tlist l 
inner join tthing ln on l.lid = ln.id
inner join tthing tn on l.tid = tn.id
inner join tuser u on l.uid = u.id
left outer join tlist ml on ml.uid = ',@userid,' and ml.lid = l.lid and ml.tid = l.tid 
left outer join tlist dk on dk.id = l.dittokey
left outer join tuser du on du.id = dk.uid

where 
	l.tid = ',@thingid,' and l.state = 1
	and l.uid not in (',@userid,',',@userids,')
group by l.lid

')	
;

	prepare stmt from @q;
	execute stmt;
	deallocate prepare stmt;

select @q as q;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spThingId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spThingId`(thingname TEXT)
BEGIN


call `spSqlLog`(0, CONCAT('call spThingId("',thingname,'")'), 0, 'spThingId');

SET @thingname = thingname;

SET @thingid = fThingId(@thingname);

select @thingid as thingid;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-10-17 15:38:35
