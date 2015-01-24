-- MySQL dump 10.13  Distrib 5.6.16, for Win32 (x86)
--
-- Host: localhost    Database: plitto2014
-- ------------------------------------------------------
-- Server version	5.6.16
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping routines for database 'plitto2014'
--
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE FUNCTION `duser`() RETURNS int(11)
BEGIN

RETURN 2;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE FUNCTION `dusers`() RETURNS char(255) CHARSET latin1
BEGIN

RETURN '18,25,14,156,64,132,13,69,724,723,161,168,719';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
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


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `adminAddItemKeyToTDitto`()
BEGIN

/*
ALTER TABLE `plitto2014`.`tlist` 
ADD COLUMN `uuid` VARCHAR(45) NULL AFTER `dittokey`;
*/

SET @changeCount = (select count(*) from tditto where itemDittoed is null);

SET @loopCount = 0;

goodTimes:BEGIN

while @loopCount < @changeCount DO
	
    SET @tdKey = null, @tdThingId = null, @tdListId = null, @tdUserId = null, @tdSourceUserId = null, @tListKey = null;
    
    SELECT id, thingid, listid, userid, sourceuserid 
		into @tdKey, @tdThingId, @tdListId, @tdUserId, @tdSourceUserId 
	from tditto
    where itemDittoed is null
    limit 1;

	if @tdKey is null then
		LEAVE goodTimes;
	end if;

	SELECT 
		`id` into @tListKey 
    from `tlist` 
    where 
		`tlist`.`tid` = @tdThingId and 
		`tlist`.`lid` = @tdListId and 
        `tlist`.`uid` = @tdSourceUserId
    limit 1;

	UPDATE tditto 
	set `itemDittoed` = @tListKey
	where `tditto`.`id` = @tdKey
    limit 1;
	
	SET @loopCount = @loopCount + 1;

END WHILE;

END; -- END goodTimes

if @tdKey != null then
	SELECT @changeCount as `toChange`, @loopCount as `changed`, false as `errorOut`;
else
	SELECT @changeCount as `toChange`, @loopCount as `changed`, true as `errorOut`, @tdKey, @tdThingId, @tdListId, @tdUserId, @tdSourceUserid, @tListKey;
end if;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `adminAddUuidToTlist`()
BEGIN

/*
ALTER TABLE `plitto2014`.`tlist` 
ADD COLUMN `uuid` VARCHAR(45) NULL AFTER `dittokey`;
*/

SET @changeCount = (select count(*) from tlist where uuid is null);

SET @loopCount = 0;

while @loopCount < @changeCount DO

		UPDATE tlist set uuid = UUID() where uuid is null limit 1;
        
        SET @loopCount = @loopCount + 1;

END WHILE;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE PROCEDURE `adminDeleteUser`()
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
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `adminImportDittos`()
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
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `adminLog`( searchString VARCHAR(255))
BEGIN

    

    IF CHAR_LENGTH(searchString) > 0 THEN

    

			SELECT * FROM dblog 

				WHERE `query` LIKE CONCAT('%',searchString,'%')

			ORDER BY id DESC LIMIT 100;

		ELSE

			SELECT * FROM dblog 

				WHERE `query` LIKE CONCAT('%',searchString,'%')

			ORDER BY id DESC LIMIT 100;

		END IF;



    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `adminStressTest`()
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
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `log`(title VARCHAR(255), log TEXT)
BEGIN

insert into log(`title`,`log`) VALUES (title,log);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE PROCEDURE `migrate`()
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
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `spSqlLog`(
	userId INT, 
    thequery TEXT, 
    sp VARCHAR(45),
    OUT logKey INT(11) )
BEGIN

insert into dblog(`userId`,`query`,`time`,`sp`,`added`)
-- dreamhost mysql5.0 can't handle this. VALUES (userId, thequery, ROUND(UNIX_TIMESTAMP(CURTIME(4)) * 1000) , sp, CURRENT_TIMESTAMP);
VALUES (userId, thequery, UNIX_TIMESTAMP() , sp, CURRENT_TIMESTAMP);

SET logKey = LAST_INSERT_ID();

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `spSqlLog_Timing`(logKey INT(11) )
BEGIN


update dblog set `dblog`.`time` = (UNIX_TIMESTAMP - `dblog`.`time`) 
where `dblog`.`id` = logKey 
limit 1;


-- select 'spSqlLog_Timing( logkey: ' as pt1, logKey as pt2;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `v2.0_addComment`( 
	token VARCHAR(59), 
    targetuid INT(12), 
    lid INT(13), 
    theTid INT(15), 
    theItemUuid VARCHAR(45),
    newComment VARCHAR(255), 
    newStatus  TINYINT(1) 
	)
BEGIN
SET @thetoken = token;
SET @targetuid = targetuid;
SET @lid = lid;
SET @tid = theTid;
SET @itemUuid = theItemUuid;
SET @newComment = newComment;
SET @newStatus = newStatus;

-- Do the token.

goodTimes:BEGIN
	/* Begin Token Check Block */
	SET @uid = '';
	SET @tokenSuccess = false;
    SET @friendArray = '';
	SET @errorMessage = '';
    
    SET @logKey = null;
	call `v2.0_checkToken`( 
		'v2.0_addComment',
		@thetoken, 
        CONCAT(
			'call `v2.0_addComment`("',
            @thetoken,'","',
            @targetuid,'","',
            @lid,'","',
            @tid,'", "' , 
            @itemKey , '", "',
			CONVERT(@newComment using utf8),
			'","',
			CONVERT(@newStatus using utf8),
			'")' )  ,
        @tokenSuccess, 
        @uid, 
        @friendArray, 
        @errorMessage,
        @logKey
        
        );
    
    if @tokenSuccess = false then
		LEAVE goodTimes;
	end if;
    /* End Token Check Block */

-- Clear existing variables.

SET @thisuid = null;
SET @friendsarray = null;
select `uid`, `friendsarray` into @thisuid , @friendsarray from token where token = @thetoken limit 1;

-- select @thisuid  as thisuid, @targetuid as targetuid , @thetoken as token;

if @thisuid != ceil(@thisuid) or @thisuid is null then
	select 
		'Invalid token' as errortxt, 
        true as error,
        @thetoken as thetoken, 
        @thisuid as theuid, 
        ceil(@thisuid) as ceiluid, 
        @friendsarray as friendsarray
	;
	LEAVE goodTimes;
end if;

-- If the comment is 0 characters, leave.
if CHAR_LENGTH(@newComment) = 0 then
	select true as error, "Comments cannot be null." as errorTxt;
	LEAVE goodTimes;
end if;


-- Get the item that is being commented on.
SET @itemKey = 0;

SELECT id into @itemKey from tlist where uuid = @itemUuid limit 1; 
-- select CONCAT("SELECT id into @itemKey from tlist where uid = ",@targetuid," and lid = ",@lid," and tid = ",@tid," limit 1; ") as test;
-- SELECT id  , @targetuid as targetuid, @lid as lid , @thisuid as uid, @tid as tid from tlist where uid = @targetuid and lid = @lid and tid = @tid limit 1; 
-- select CONCAT(" TEST! ", " SELECT id into @itemKey  from tlist where uid = ", @targetuid ," and lid = ", @lid ," and tid = ", @tid ,"  limit 1") as test; 

-- If the comment is 0 characters, leave.
if @itemKey = 0  then
	select true as error, "Invalid thing to comment on" as errorTxt;
	LEAVE goodTimes;
end if;

-- See if there is an existing comment

if @newStatus = "1" and @newComment != "0" then
	-- Insert the comment
	INSERT into tcomments 
		(`itemid`,`byuserid`,`comment`,`read`,`added`, `active`)
	VALUES 
		( @itemKey, @thisuid, @newComment, 0, CURRENT_TIMESTAMP,1) 
	on duplicate key update `comment` = CONVERT(@newComment using utf8), `active` = 1;
    
    /* DEBUG
    select 
		CONCAT("INSERT into tcomments (`itemid`,`byuserid`,`comment`,`read`,`added`, `active`)
		VALUES ( ",@itemKey,", ",@thisuid,", '",@newComment,"', 0, CURRENT_TIMESTAMP,1) on duplicate key update `comment` = CONVERT('",@newComment,"' using utf8), `active` = 1 ; 1, ? ") 
        as debug;
	*/
    SET @newStatus = "YES! Create Comment Not Null.";
    
elseif @newStatus = "1" then -- @newComment must be "0" 
    	-- Insert the comment
	INSERT into tcomments 
		(`itemid`,`byuserid`,`comment`,`read`,`added`, `active`)
	VALUES 
		( @itemKey, @thisuid, "", 0, CURRENT_TIMESTAMP,1) 
        on duplicate key update `active` = 1;
    /* DEBUG 
    select CONCAT("INSERT into tcomments (`itemid`,`byuserid`,`comment`,`read`,`added`, `active`)
	VALUES ( ",@itemKey,", ",@thisuid,", '",@newComment,"', 0, CURRENT_TIMESTAMP,1) on duplicate key update `comment` = '', `active` = 1; 1,0 ") as debug;
    */ 
    SET @newStatus = "YES!";
    
elseif @newStatus = "0" then
	update tcomments set `active` = 0 
    where byuserid = @thisuid and itemid = @itemKey limit 1;
    SET @newStatus = "NO!";
end if;
    
select true as success, @itemKey as itemKey, @targetuid as targetuid, @thisuid as theuid, @lid as lid, @tid as tid, @newStatus as newStatus;


END;
call `spSqlLog_Timing` (@logKey );

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `v2.0_addtolist`( thetoken VARCHAR(36), thingName TEXT, listnameid INT )
BEGIN

SET @thetoken = thetoken;

goodTimes:BEGIN
	/* Begin Token Check Block */
	SET @uid = '';
	SET @tokenSuccess = false;
    SET @friendArray = '';
	SET @errorMessage = '';
    SET @logKey = null;
	call `v2.0_checkToken`( 
		'v2.0_addtolist',
		@thetoken, 
        CONCAT('call v2.0_addtolist("',@thetoken,'","',thingName,'","',listnameid,'")'),
        @tokenSuccess, 
        @uid, 
        @friendArray, 
        @errorMessage,
        @logKey
        
        );
    
    if @tokenSuccess = false then
		LEAVE goodTimes;
	end if;
    /* End Token Check Block */

select uid, friendsarray into @uid, @friendArray from token where token = @thetoken limit 1;


if @uid != ceil(@uid) or @uid is null then
	select 'Invalid token' as errortxt, true as error
		,@thetoken as thetoken, @uid as theuid, ceil(@uid) as ceiluid, @friendArray as friendsarray
	;
	LEAVE goodTimes;
end if;


-- Vars
set @thingName = thingName;
set @listnameid = listnameid;
SET @userid_listnameid = CONCAT(@uid,'_',@listnameid);
-- Get the thing id
set @thingId = fThingId(@thingName);

-- Find out if it already exists.
set @thekey = (select id from tlist where lid = @listnameid and uid = @uid and tid = @thingId limit 1);

if @thekey > 1 then
	-- Nothing to do.
	SET @a = 1;
else
	insert into tlist (`lid`,`tid`,`uid`,`added`,`modified`,`state`,`uuid`)
	values (@listnameid, @thingId, @uid, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1, UUID() );

	SET @thekey =  LAST_INSERT_ID();

end if;

SELECT @thekey as thekey, tlist.tid as thingid, 
	@userid_listnameid as listkey, 
	@thingName as thingname, 
	tthing.name as listname,
	@listnameid as lid,
    `tlist`.`uuid`
from tlist
inner join tthing on tthing.id = @listnameid 
where tlist.tid = @thingId and tlist.uid = @uid
limit 1

;
End; -- Ends the proclabel.
call `spSqlLog_Timing` (@logKey );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`theuser`@`%` PROCEDURE `v2.0_chatAbout`(vToken VARCHAR(55), vUserFilter VARCHAR(255) )
BEGIN

SET @thetoken = vToken;
SET @userFilter = vUserFilter;


-- TODO1 - It should be ordered by newest ditto and or comment.

goodTimes:BEGIN
	/* Begin Token Check Block */
	SET @uid = '';
	SET @tokenSuccess = false;
    SET @friendArray = '';
	SET @errorMessage = '';
    SET @logKey = null;
	call `v2.0_checkToken`( 
		'v2.0_chatAbout',
		@thetoken, 
        CONCAT('call v2.0_chatAbout("',@thetoken,'","',@userFilter,'")'),
        @tokenSuccess, 
        @uid, 
        @friendArray, 
        @errorMessage,
        @logKey
        
        );
    
    if @tokenSuccess = false then
		LEAVE goodTimes;
	end if;
    /* End Token Check Block */

if @userFilter = '-1' or @userFilter = '0' or @userFilter = -1 or @userFilter = 0 then
	-- SET @userFilter = 0;
    SET @userFilter = @friendArray;
end if;

-- select @userFilter as `test37userfilter`;
-- Condititional where user statement
-- SET @userFilterView = CONCAT(" and d.userid = @uid or d.sourceuserid = @uid ");
-- Don't show my dittos out, by default.

SET @chatKeys =  "";
SET @tempKeys = "";
SET @groupLimit = 10;
SET @userFilterWhere = '';

IF @userFilter != 0 THEN
	SET @userFilterWhereA = CONCAT(' and `tditto`.`sourceuserid` in (',@userFilter,') ');
    SET @userFilterWhereB = CONCAT(' and `tditto`.`userid` in (',@userFilter,') ');
    SET @userFilterWhereC = CONCAT(' and `tlist`.`uid` in (', @userFilter,') ');
    SET @userFilterWhereD = CONCAT(' and `tcomments`.`byuserid` in (', @userFilter,') ');
ELSE
	SET @userFilterWhereA = '';
    SET @userFilterWhereB = '';
    SET @userFilterWhereC = '';
    SET @userFilterWhereD = '';
END IF;

-- Temp Table for this.
DROP TABLE IF EXISTS `temp_chatAbout`;
CREATE TEMPORARY TABLE `temp_chatAbout` (
	`id` int(4) NOT NULL AUTO_INCREMENT,
    `noteType` TINYINT(1),
    `tlid` INT(11),
    `dateOfInterest` DATETIME,
	`read` TINYINT(1),
    PRIMARY KEY (`id`),
    UNIQUE KEY (`tlid`)
    
);


-- TODO1 - If this is not for a specific user filter @userfilter, skip the two that are me to them.

-- Step 1 - Ditto Inputs - Outgoing.
	SET @queryA = CONCAT('
		INSERT INTO `temp_chatAbout` (`noteType`,`tlid`,`dateOfInterest`,`read`)
        
		select 0, `tditto`.`itemDittoed`, `tditto`.`added`, `tditto`.`read` 
		from tditto 
		where tditto.userid = ',@uid,' and tditto.hidden = 0 ',@userFilterWhereA,'
        group by tditto.`itemDittoed` 
		order by id desc
		limit ',@groupLimit,'
        on duplicate key update noteType = 0;    
	');
        
	prepare stmt from @queryA;
	execute stmt;
	deallocate prepare stmt;

-- Step 2 - Ditto Inputs - Incoming.
	if @userFilter != 0 then 
		SET @queryB = CONCAT('
			INSERT INTO `temp_chatAbout` (`noteType`,`tlid`,`dateOfInterest`,`read`)
			
				select 1, `tditto`.`itemDittoed`, `tditto`.`added`, `tditto`.`read` 
				from tditto 
				where tditto.sourceuserid = ',@uid,' and tditto.hidden = 0 ',@userFilterWhereB,'
				group by tditto.`itemDittoed` 
				order by id desc
				limit ',@groupLimit,'
			on duplicate key update noteType = 1;    
			');


		prepare stmt from @queryB;
		execute stmt;
		deallocate prepare stmt;
	End If ;
        
-- Step 3 - Chat Messages - Incoming

	SET @queryC = CONCAT('
		INSERT INTO `temp_chatAbout` (`noteType`,`tlid`,`dateOfInterest`,`read`)
        
			select 2, `tcomments`.`itemid`, `tcomments`.`added`, `tcomments`.`conversed` 
			from tcomments
            inner join tlist on tlist.id = tcomments.itemid
            where tcomments.byuserid = "',@uid, '" ',@userFilterWhereC,' and `tlist`.`state` = 1
            
			
			group by tcomments.`itemid` 
			order by `tcomments`.`id` desc
			limit ',@groupLimit,'
        on duplicate key update noteType = 2;    
		');
    
    prepare stmt from @queryC;
	execute stmt;
	deallocate prepare stmt;
    
    

-- Step 4 - Chat Messages - Outgoing
if @userFilter != 0 then 
	SET @queryD = CONCAT('
		INSERT INTO `temp_chatAbout` (`noteType`,`tlid`,`dateOfInterest`,`read`)
        
			select 3, `tcomments`.`itemid`, `tcomments`.`added`, `tcomments`.`conversed` 
			from tcomments
            inner join tlist on tlist.id = tcomments.itemid
            where `tlist`.`uid`=',@uid,' ',@userFilterWhereD,' and `tlist`.`state` = 1
			
			group by tcomments.`itemid` 
			order by `tcomments`.`id` desc
			limit ',@groupLimit,'
        on duplicate key update noteType = 3;    
		');
    
    prepare stmt from @queryD;
	execute stmt;
	deallocate prepare stmt;
end if;    


	-- select @qe;

	SET @qe = CONCAT('
	select 
		tl.id, 
        tl.uid, 
        un.name as username, 
        un.fbuid, tl.lid, ln.name as listname, tl.tid, 
        tn.name as thingname, 
        tl.added, 
        tl.state, tl.dittokey, 
		tca.noteType as groupid, 
        td.userid as dittouser, 
        tdu.name as dittousername, 
        tdu.fbuid as dittofbuid, 
        ml.id as mykey, 
        tc.comment as commentText, 
        tc.read as commentRead, 
        tc.active as commentActive,
        cu.id as commentuserid, cu.name as commentusername, cu.fbuid as commentfbuid, tl.uuid


		-- tca.notetype, 
		
		-- tca.tlid, tca.dateofinterest, tca.read,
		-- tl.added, tca.tlid, tl.dittokey, tdu.fbuid, tdu.username as dittousername, tn.name as thingname
		-- *
	from `temp_chatAbout` tca ', /* Main table. The Chat */
	' inner join tlist tl on tl.id = tca.tlid ', /*  */
	' left outer join tditto td on tl.dittokey = td.id and tl.dittokey !=0  ',
	' left outer join tuser tdu on td.sourceuserid = tdu.id ', /* User information so I know who they are */
    
	' inner join tthing tn on tn.id = tl.tid ', /* Bring in the thing name */
	' inner join tthing ln on ln.id = tl.lid ', /* Bring in the list name */
	' inner join tuser un on un.id = tl.uid ', /* their user information? */
    ' left outer join tlist ml on ml.uid = ', @uid,' and tl.tid = ml.tid and tl.lid = ml.lid and ml.state = 1', 
	' left outer join tcomments tc 
		on 
			tc.itemid = tl.id and (tc.byuserid = ',@uid,' and tl.uid in (',@userFilter,') ) ',
            ' or (tc.byuserid in (',@userFilter,') and tl.uid = ',@uid,') ',
    ' left outer join tuser cu on cu.id = tc.byuserid  ', /* Comment user information?  */
    ' order by tca.id desc
	');
    
    prepare stmt from @qe;
	execute stmt;
	deallocate prepare stmt;
    


END;

call `spSqlLog_Timing` (@logKey );

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `v2.0_checkToken`( 
	IN sourceProc VARCHAR(45),
	IN varToken VARCHAR(45),
    IN queryToLog TEXT,
    OUT tokenSuccess BOOLEAN,
    OUT userId INT(11),
    OUT friendArray TEXT,
    OUT errorMessage VARCHAR(255),
    OUT logKey INT(11)
)
BEGIN

-- select queryToLog as qtlDEBUG;

SET tokenSuccess = false;
SET userId = 0;
SET friendArray = '0';
SET errorMessage = null;



SET @logKey = null;


goodTimes:BEGIN

SET @theToken = varToken;

SET @uid=0, @friendArray = '';

SELECT `uid`, `friendsarray` INTO @uid, @friendArray FROM token WHERE `token` = @theToken AND `active` = 1 LIMIT 1;

call `spSqlLog`(@uid, queryToLog, sourceProc, logKey );


-- Hande error
IF LENGTH(@uid) = 0  or CEIL(@uid) = 0 THEN
	SET tokenSuccess = false;
    
	SELECT 
		'invalid_token' AS errortxt, 
		TRUE AS error, 
        true as logout,
		@thetoken AS thetoken
        -- @uid AS theuid, 
        -- CEIL(@uid) AS ceiluid, 
        --  @friendArray AS friendsarray
	;
	LEAVE goodTimes;
	
END IF;

SET tokenSuccess = true;


-- Is the token currently valid? If so, populate some variables;
SELECT uid, friendsarray 
INTO userId, friendArray 
FROM token 
WHERE token = @theToken 
AND active = 1 
LIMIT 1;

UPDATE token 
SET usecount = usecount + 1 
WHERE token = @theToken 
AND id > 0 LIMIT 1;





end;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `v2.0_counts`(vToken VARCHAR(50) )
BEGIN

SET @thetoken = vToken;

goodTimes:BEGIN
	/* Begin Token Check Block */
	SET @uid = '';
	SET @tokenSuccess = false;
    SET @friendArray = '';
	SET @errorMessage = '';
	SET @logKey = null;
	call `v2.0_checkToken`( 
		'v2.0_counts',
		@thetoken, 
        CONCAT('call v2.0_counts("',@thetoken,'")'),
        @tokenSuccess, 
        @uid, 
        @friendArray, 
        @errorMessage,
		@logKey
        
        );
    
    if @tokenSuccess = false then
		LEAVE goodTimes;
	end if;
    /* End Token Check Block */

select count(*)  into @unreadDittos from tditto where `read` = 0 and sourceuserid = @uid;

select count(*) into @unreadChats from tcomments tc 
inner join tlist l on l.id = tc.itemid
where tc.`read` = 0 and l.uid = @uid
;

select LENGTH(@friendArray) - LENGTH(REPLACE(@friendArray,",","")) + 1 into @friendCount 
from token where uid = @uid and active = 1 limit 1;

select count(distinct(lid)) 
into @listCount 
from tlist where uid = @uid and tlist.state = 1;

select count(*) 
into @thingCount 
from tlist 
where uid = @uid and tlist.state = 1;

SET @countFeedQ = CONCAT("select COUNT(*) into @feedCount from tlist where uid in ( @friendArray ) and added  > DATE_SUB(NOW(), INTERVAL 24 HOUR)");

prepare stmt from @countFeedQ;
		execute stmt;
		deallocate prepare stmt;

SELECT 
	@unreadDittos as unreadDittos, 
    @unreadChats as unreadChats, 
	@unreadDittos+ @unreadChats as notifications, 
	@friendCount as friendCount, 
	@listCount as listCount, 
    @thingCount as thingCount,
    @feedCount as feedCount,
	0 as friendRequests
    ;


END;

call `spSqlLog_Timing` (@logKey );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `v2.0_ditto`(
	thetoken VARCHAR(36), 
	itemKey VARCHAR(45), 
	theaction VARCHAR(20) 
)
BEGIN

SET @thetoken = thetoken;

goodTimes:BEGIN
	/* Begin Token Check Block */
	SET @uid = '';
	SET @tokenSuccess = false;
    SET @friendArray = '';
	SET @errorMessage = '';
	SET @logKey = null;
	call `v2.0_checkToken`( 
		'v2.0_ditto',
		@thetoken, 
        CONCAT('call v2.0_ditto("',thetoken,'","',itemKey,'" , "',theaction,'")'),
        @tokenSuccess, 
        @uid, 
        @friendArray, 
        @errorMessage,
        @logKey
        );
    
    if @tokenSuccess = false then
		LEAVE goodTimes;
	end if;
    /* End Token Check Block */
    


-- Process the variablesSET @sourceuserid = sourceuserid;
SET @itemKey = itemKey;
SET @theaction = theaction;

-- Get the item, user and list ids for this ditto.
select id, uid, lid, tid 
	into @tlistId, @sourceUserId, @listId, @thingId 
from tlist 
where uuid = @itemKey 
limit 1;

if @theaction LIKE 'ditto' then 

	

	-- INSERT INTO TLIST
	INSERT INTO tlist (`tid`, `lid`, `uid`, `state`, `added`, `modified`,`uuid`)
		VALUES ( @thingid, @listid, @uid, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, UUID() )
	on duplicate key update state = 1;
	
    -- Get the new key and uuid. 
    select id, uuid 
		into @theKey, @theUuid 
	from tlist 
    where tid = @thingId and lid = @listid and uid = @uid limit 1;


	-- log the ditto - Working. 
		-- TODO2 - Handle what happens if a ditto is just returning something to its origional state.
	/* Insert into tditto only if it isn't the person dittoing themself. */
	if @uid != @sourceuserid then 
		insert into tditto (`userid`, `sourceuserid`, `thingid`, `listid`, `added`, `read`, `itemDittoed`)
		values ( @uid, @sourceUserId, @thingId, @listId, CURRENT_TIMESTAMP, 0, @tlistId);
	end if;

	-- Get the ditto key - FAILING
	SET @dittokey = 15;

	SET @dkq = CONCAT('
	SET @dittokey = (
		select id 
		from tditto 
		where 
			userid = ',CAST(@uid as CHAR(10)),' and 
			sourceuserid = ',CAST(@sourceUserId as CHAR(10)),' and 
			thingid = ',CAST(@thingId as CHAR(10)),' and 
			listid = ',CAST(@listId as CHAR(10)),' 
		order by id desc
		limit 1
	);');

	prepare stmt from @dkq;
	execute stmt;
	deallocate prepare stmt;

	
	-- call log('dittokey result',@dittokey);

	-- Add it to the list table. - This is working.
	update tlist set dittokey = @dittokey where id = @thekey limit 1;

	
	-- Return the thingid and thingname and listname for the benefit of the Javascript coder.`
	SET @theQ = CONCAT('
	select 
		l.id as thekey, 
        l.tid, 
        t.name as thingname, 
        l.lid, 
		ln.name as listname, 
        count(*) as friendsWith, 
        `l`.`uuid`
	from tlist l
	inner join tthing t on t.id = l.tid
	inner join tthing ln on ln.id = l.lid
	where l.tid = ', @thingId ,' and l.lid = ' , @listId ,' and l.uid in (',@friendArray,')
	group by l.tid, l.lid');
    -- select @theQ;

	prepare stmt from @theQ;
	execute stmt;
	deallocate prepare stmt;

elseif @theaction LIKE 'remove' then 
	-- Set the state to 0.
	UPDATE tlist SET state = 0 where tid = @thingId and lid = @listId and uid = @uid limit 1;


	-- Remove the notification and hide the ditto log.
	update 
		tditto set hidden = 1, 
        `read` = 1
	where 
		userid = @uid and
		sourceuserid = @sourceUserId and 
        thingid = @thingId and 
        listid = @listid
	limit 1;

	SELECT true as success;
	
end if;


END;

call `spSqlLog_Timing` (@logKey );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `v2.0_extendFbToken`( varPlittoToken VARCHAR(45), varFbLongToken VARCHAR(255) )
BEGIN

SET @plittoToken = varPlittoToken;
SET @fbLongToken = varFbLongToken;

call `spSqlLog`(0, CONCAT('call `v2.0_extendFbToken`("',@plittoToken,'","',@fbLongToken,'" )'), 0, 'v2.0_extendFbToken');


-- Check to see if the token is valid.

select `id` into @plittoTokenid 
from `token`
where 
	`token`.`token` = @plittoToken and
	`token`.`active` = 1
limit 1;

-- Check to see if it is valid 

if LENGTH(@plittoTokenid) > 0 then
	-- The token is valud. Now update with the new long token
    update `token` 
    SET `token`.`fbToken` = @fbLongToken
    WHERE `token`.`id` = @plittoTokenId
    LIMIT 1;
    
    select true as `success`, 'Token updated to long token' as `successMessage`;
    
    
else 

	select true as `error`, 'invalid or expired Plitto token passed' as `errortxt`;
	
end if;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `v2.0_fbLogin`(
	fbuid BIGINT, fbname VARCHAR(255), fbemail VARCHAR(255) , fbfriendsarray TEXT, newFbToken VARCHAR(255) )
BEGIN
/*
	Returns a token for this user's session.
		Token masks: user id, start time, usage count, and list of friends.
		All session handling moves into the token arena. All other stored procs should use the token as a way to handle this.
*/
-- call `spSqlLog`(0, CONCAT('call `v2.0_fbLogin`("',fbuid,'","',fbname,'","',fbemail,'","',fbfriendsarray,'")'), 0, 'v2.0_fbLogin');
SET @logKey = null;
call `spSqlLog`(
	0,
	CONCAT('call `v2.0_fbLogin`("',fbuid,'","',fbname,'","',fbemail,'","',fbfriendsarray,'")'),
    'v2.0_fbLogin', @logKey );

SET @fbuid = fbuid;
SET @fbname = fbname;
SET @fbemail = fbemail;
SET @fbfriendsarray = fbfriendsarray;
-- Clear the UserIds
SET @puid = null;
SET @active = null;
SET @username = null;
SET @email = null;
SET @newFbToken = newFbToken;
SET @newAccount = false;
SET @friendids = '';
-- Step 1 -- see if this account already exists. If so create some variables to hold their information.
-- SELECT @puid:=id , @active:=active, @thename:=name, @email:=email from tuser where fbuid = fbuid limit 1;

	SELECT tuser.id, tuser.active, tuser.name, tuser.email 
		into @puid, @active, @username, @email 
	from tuser 
    where 
		tuser.fbuid = @fbuid 
        
	limit 1;

SET @result = CONCAT('fbuid: ' 
	, CAST(@fbuid AS CHAR CHARACTER SET utf8)
	,' initial puid: '
	, CAST(@puid AS CHAR CHARACTER SET utf8)
);

-- This test is failing: Maybe?
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
    
    SET @newAccount = true;
    
-- Step 2 -- See if there are updates to make
elseif @active != 1 or @username != fbname or @email != fbemail then
	update tuser set `name` = @fbname, email = @fbemail, `active` = 1 where id = @puid limit 1;
	SET @result = CONCAT(@result,' | Update account information');
end if;


-- STEP -- We should have a valid user at this point. Get the plitto IDs from their friends based on the facebook IDs passed in as fbfriendsarray.
SET @friendquery = CONCAT('select GROUP_CONCAT(id) INTO @friendids from tuser where fbuid in (',@fbfriendsarray,')');
 prepare stmt from @friendquery;
	execute stmt;
	deallocate prepare stmt;
    -- At this point, @friendids now holds the FBUIDS 


-- Step Add this user as friends to their friends 1/9/2014
if @newAccount = true then 
	-- Get a list of friend IDS who are this user's friends, and add this user to their graph 
	SET @appendToFriends = CONCAT(
		'update token set friendsarray = CONCAT( CONVERT(friendsarray USING utf8) , ',', CONVERT(',@puid,' using utf8) ) 
		where active = 1 and token.`id` > 0 and token.`uid` in (',@friendids,') ');
        
	-- Add and alert for each of these users to let them know that their friend joined.
    
    -- TODO1 - Add this user to all of them, in their active, or latest token.
    
end if;
	
-- Get the old fbToken: 
SELECT `fbToken`, `id`  into @oldFbToken, @oldTokenId 
from `token`
where `token`.`uid` = @puid and `token`.`active` = 1 
limit 1;


-- Update the token if there is a new facebook token. Check for the existing one.
if @oldFbToken != @newFbToken and LENGTH(@oldFbToken) > 0 then
-- select @oldFbToken as oldFbToken, @fbToken as newFbToken, @puid as puid;
	
    -- Let them login on another device. 1/19/2015
    set @newPlittoToken = @oldTokenId;
    
	/*
		-- Deactivate the old token
		update token set active = 0, `end` = CURRENT_TIMESTAMP where id = @oldTokenId ;
		
		-- Create a new one.
		SET @newPlittoToken = MD5(CONCAT('!%!connect!%!',UUID()));
		insert into token (`token`, `uid`,`start`,`active`,`usecount`,`friendsarray`,`logincount`,`fbToken`, `lastUsed`) 
		VALUES (@newPlittoToken, @puid, CURRENT_TIMESTAMP, 1, 1, @friendids, 1, @newFbToken, CURRENT_TIMESTAMP );
    */
end if;

-- STEP - If the puid exists, then the user is logged in.
if ceil(@puid) = @puid then
	-- SELECT 'matching puids' AS debugMessage, @puid as theuid;
	-- update token set `end` = CURRENT_TIMESTAMP, active = 0 where uid = @puid and active = 1 limit 1;

	-- Initialize the Plitto Token
	SET @plittoToken = '';
	-- See if this user has a valid token already.
	SELECT token, fbtoken into @plittoToken, @oldFbToken from token where uid = @puid and active = 1 limit 1;


	if CHAR_LENGTH(@plittoToken) = 0 then
		

		-- Create a token
		SET @plittoToken = MD5(CONCAT('!%!connect!%!',UUID()));
		insert into token (`token`,`uid`,`start`,`active`,`usecount`,`friendsarray`,`fbToken`, `lastUsed`) 
		VALUES ( @plittoToken, @puid, CURRENT_TIMESTAMP, 1, 1, @friendids, @newFbToken, CURRENT_TIMESTAMP );
	else 
		-- Update their friends.
		update token 
			set `friendsarray` = @friendids, `usecount` = `usecount` + 1, `lastUsed` = CURRENT_TIMESTAMP 
			where `token` = @plittoToken  
			order by id limit 1;

	END IF;
    
    
    
    
	
end if;
select 
	@puid as puid, 
    @username as username, 
    @fbuid as fbuid, 
    @plittoToken as token
    /* , @friendids as friendids */
    ; 
/*
*/
-- 
call `spSqlLog_Timing` (@logKey );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`theuser`@`%` PROCEDURE `v2.0_feed`(
	thetoken VARCHAR(36)
    ,  thetype VARCHAR(10)
    , userfilter VARCHAR(10)
    , listfilter VARCHAR(10)
	, mystate VARCHAR(10)
    , continueKey INT
    , newerOrOlder VARCHAR(10)
)
BEGIN
SET @thetoken = thetoken;
SET @functionCallType = thetype;
SET @userfilter = userfilter;
SET @listfilter = listfilter;
SET @mystate = mystate; -- This could filter the feed someday. TODO3
SET @continueKey = continueKey;
SET @uid = '';
SET @friendArray = '';
SET @whereUser= '';
SET @qfilter = ''; 
SET @extraJoin = '';
SET @theType = thetype; /* This isn't used, for some reason */

goodTimes:BEGIN
	
	
	SET @tokenSuccess = false;
	SET @errorMessage = '';
	SET @logKey = null;
	call `v2.0_checkToken`( 
		'v2.0_feed',
		@thetoken, 
        concat('`call v2.0_feed`("', thetoken,'","',thetype,'","',userfilter,'","',listfilter,'","',mystate,'","',continueKey,'","',newerOrOlder , '")' ) ,
        @tokenSuccess, 
        @uid, 
        @friendArray, 
        @errorMessage,
		@logKey
        
        );
    
    if @tokenSuccess = false then
		LEAVE goodTimes;
	end if;

    
    -- Set the friends filter as part of this. Default to me and my friends.alter
    SET @whereUser = CONCAT(' and l.uid in (',@uid,',',@friendArray,') '); -- Defaults to showing friends.
    SET @userFields = ' l.uid, un.name as username, un.fbuid as fbuid, '; -- Defaults to the private user fields.
    
	IF @functionCallType like 'list' THEN
		-- select 'list' as showthis;
		SET @qfilter = CONCAT(' and l.lid = ', @listfilter); -- Adds a list filter.
        
    ELSEIF @functionCallType like 'profile' THEN 
		IF CHAR_LENGTH(@userfilter) = 0 THEN
			SELECT TRUE AS error, 'Profile cannot be null for the user filter' AS errortxt;
			
			LEAVE goodTimes;
		END IF;
		SET @qfilter = CONCAT(' and l.uid = ', @userfilter);
	
    ELSEIF @functionCallType = 'friends' THEN
		SET @whereUser = CONCAT(' and l.uid in (',@friendArray,') ');
        -- select @friendArray as friendArray;
    
    ELSEIF @functionCallType = 'strangers' THEN
		SET @whereUser = CONCAT(' and l.uid not in (',@uid,',',@friendArray,') ');
		SET @userFields = ' 0 as uid, "Strangers" as username, "" as fbuid, ';
            
	ELSE 
		SET @thisnote = 'Unknown filter';
		SET @qfilter = '';
        select true as `error`, @thisnote as `errortxt`;
        LEAVE goodTimes;
	END IF;
    
    -- This is for the continuation, meaning older.
	IF CHAR_LENGTH(@continueKey) > 0 AND @continueKey != 0 THEN
		SET @oldestFilter = CONCAT(' and l.id < ',@continueKey);
	ELSE 
		SET @oldestFilter = '';
	END IF;
    
-- Execute the query.    
SET @qDo = CONCAT(
'select 
	l.id,
	', @userFields ,'
	l.lid, ln.name as listname, 
	l.tid, tn.name as thingname,
	l.added, l.state, l.dittokey, dk.uid as dittouser, du.name as dittousername, du.fbuid as dittofbuid,
	ml.id as mykey
	, tc.`comment` as commentText, tc.`read` as commentRead, tc.`active` as commentActive , l.uuid
from tlist l
inner join tthing ln on ln.id = l.lid 
inner join tthing tn on tn.id = l.tid 
inner join tuser un on un.id = l.uid
left outer join tlist dk on dk.id = l.dittokey 
left outer join tuser du on du.id = dk.uid
left outer join tlist ml on ml.uid = ',@uid,' and ml.lid = l.lid and ml.tid = l.tid and ml.state = 1
left outer join tcomments tc on tc.itemid = l.id and tc.byuserid = ',@uid,'
where 
l.state = 1 ',
@whereUser, 
@qfilter, @oldestFilter,
' order by l.id desc
limit 50');


prepare stmt from @qDo;
execute stmt;
deallocate prepare stmt;

--  
-- 
-- select @thetoken as thetoken, @thetype as thetype, @userfilter as userfilter, @listfilter as listfilter, @mystate as mystate, @oldestKey as oldestKey;
 -- select @q;
END;
call `spSqlLog_Timing` (@logKey );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `v2.0_friends`(
	thetoken VARCHAR(36)
)
BEGIN

SET @thetoken = thetoken;

goodTimes:BEGIN
	/* Begin Token Check Block */
	SET @uid = '';
	SET @tokenSuccess = false;
    SET @friendArray = '';
	SET @errorMessage = '';
	SET @logKey = null;
	call `v2.0_checkToken`( 
		'v2.0_friends',
		@thetoken, 
        CONCAT('call v2.0_friends("',@thetoken,'")'),
        @tokenSuccess, 
        @uid, 
        @friendArray, 
        @errorMessage,
		@logKey
        
        );
    
    if @tokenSuccess = false then
		LEAVE goodTimes;
	end if;
    /* End Token Check Block */


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
left outer join tlist ot on ot.lid = tt.lid and ot.tid = tt.tid  and ot.state = 1 and ot.uid = ',@uid,'

-- left outer join tditto d on tt.uid = d.sourceuserid
-- left outer join tditto dd on tt.uid = dd.userid

where 
	u.id in (',@friendArray,')
	
group by u.id


union 

select ',@uid,' as id, h.name, h.fbuid, count(g.id) as things
	, count(g.id) as shared
	, 0 as dittoable
	, count( distinct g.lid) as lists
	, count( distinct g.lid) as sharedlists
	, 0 as dittosout
	, 0 as dittosin
from tlist g
inner join tuser h on g.uid = h.id 
where g.uid = ',@uid,'
group by g.uid

');

prepare stmt from @friendquery;
	execute stmt;
	deallocate prepare stmt;

end;

call `spSqlLog_Timing` (@logKey );

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `v2.0_GetMore`(
	thetoken VARCHAR(36),
	
	forUserIDs TEXT ,

	thetype VARCHAR(20),
	theId varchar(20), 
	thenot TEXT
)
BEGIN

SET @thetoken = thetoken;

goodTimes:BEGIN
	/* Begin Token Check Block */
	SET @uid = '';
	SET @tokenSuccess = false;
    SET @friendArray = '';
	SET @errorMessage = '';
	SET @logKey = null;
	call `v2.0_checkToken`( 
		'v2.0_GetMore',
		@thetoken, 
        CONCAT('call `v2.0_GetMore`("',thetoken,'","',forUserIDs,'","',thetype,'","',theId,'","',thenot,'")'),
        @tokenSuccess, 
        @uid, 
        @friendArray, 
        @errorMessage,
		@logKey
	);
    
    if @tokenSuccess = false then
		LEAVE goodTimes;
	end if;
    /* End Token Check Block */
    
    

-- Create variables for this session.
SET @thetype = thetype;

SET @forUserIds = forUserIDs;

SET @theId = theId; -- The user or list id.


-- Default to their friends if it is null 
if char_length(@forUserIDs) > 0 then
	SET @forUserIDs = forUserIDs; -- For the specific friend.
else
	-- Default to them, and their friends if it looks like that's a good idea.
	SET @forUserIDs = CONCAT(@uid,',',@friendArray);
end if;


SET @thetype = thetype;

SET @thenot = thenot;	-- Existing

if LENGTH(@thenot) =  0 then
	SET @theNotWhere = '';
else
	SET @theNotWhere = CONCAT('and (a.uid, a.lid, a.tid) NOT IN (
			',@thenot,'
		)');
end if;


if @thetype like 'list' then
	SET @listadendum = CONCAT(' and a.lid = ',@theId);
else
	SET @listadendum = '';
end if;

--  Removed duid set @thefields = ' a.id, a.tid, a.lid, a.uid, a.added, a.modified, a.duid, a.state ';
set @thefields = ' a.id, a.tid, a.lid, a.added, a.modified, a.state, a.dittokey, a.uuid ';
-- set @insertTable = 'insert into temp_splists (`id`,`tid`,`lid`,`uid`,`a`,`m`,`duid`,`state`,`myKey`)';
set @insertTable = 'insert into temp_splists (`id`,`tid`,`lid`,`a`,`m`,`state`,`dittokey`, `uuid`, `uid`,`myKey`,`show`,`listid`,`grouporder`)';

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
	`dittokey` INT(11),	-- This is where they got their link from
    `uuid` VARCHAR(45)
    
	
);
-- ',@listadendum,' 

-- Insert my items, if it's a list
if @thetype like 'list' then
	SET @myItems = CONCAT(
		@insertTable, 
		' select 
			', @thefields,', 
			a.uid , 
            a.id, 1, 
            CONCAT(a.uid,"_",a.lid) as listid, 
            1 as grouporder
		from tlist a 
		
		where a.uid =',@uid,' and a.state = 1 
			',@listadendum,' 
			',@theNotWhere,'
		order by a.id desc
		limit ',@defaultlimit);

	-- select @myItems;

		prepare stmt from @myItems;
		execute stmt;
		deallocate prepare stmt; 
end if;


	-- Insert Dittoable Content
	SET @dittoable = CONCAT(
		@insertTable, 
		' select ', @thefields,', a.uid , b.id, 1 , CONCAT(a.uid,"_",a.lid) as listid, 1 as grouporder
		from tlist a 
		left outer join 
			tlist b on b.lid = a.lid and b.tid = a.tid and b.state = 1 and b.uid = ',@uid,' 
		where a.uid in (',@forUserIDs,') and a.state = 1 and b.state is null 
			',@listadendum,' 
			',@theNotWhere,'
		order by a.id desc
		limit ',@defaultlimit);


	-- Insert Shared Content
	SET @shared = CONCAT(
		@insertTable, 
		' select ', @thefields,', a.uid , b.id, 1,CONCAT(a.uid,"_",a.lid) as listid, 2 as grouporder
		from tlist a 
		inner join 
			tlist b on b.lid = a.lid and b.tid = a.tid and b.state = 1 and b.uid = ',@uid,'
		where a.uid in (',@forUserIDs,') and a.state = 1 and b.state = 1  
			',@listadendum,' 
			',@theNotWhere,'
		order by a.id desc
		limit ',@defaultlimit);

	-- Insert Dittoable Content from Anonymous Sources.
	SET @anonContent = CONCAT(
		@insertTable, 
		-- Hard code 0 as the anonymous user id.
		' select ', @thefields,', 0 , a.id, 1,CONCAT("0_",a.lid) as listid, 3 as grouporder
		from tlist a 
		left outer join 
			tlist b on b.lid = a.lid and b.tid = a.tid and b.uid = ',@uid,' and b.state =1 and b.id is null
		where a.uid not in (',@uid,',',@forUserIDs,') and a.state = 1
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

	prepare stmt from @anonContent;
		execute stmt;
		deallocate prepare stmt;

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
	, tc.`comment` as commentText, tc.`read` as commentRead, tc.`active` as commentActive 
	-- Integrate the source of a ditto user.
-- , c.id as duid , c.name as dname, c.fbuid as dfbuid
from (
	select * , CONCAT(uid,'_',lid) as listkey 
	from (
	select t.id, t.tid, t.lid, t.uid, t.a, t.m, t.state, t.myKey , t.dittokey, t.uuid
		-- , a.name as thingname, b.name as username, c.name as listname
		-- , b.fbuid
		, `show`, listid , 1 as customOrder
	from temp_splists t
	-- inner join tthing a on t.tid = a.id
	-- inner join tthing c on t.lid = c.id
	-- inner join tuser b on b.id = t.uid
	where uid != @uid


	UNION
	select t.id, t.tid, t.lid, t.uid, t.a, t.m, t.state, t.myKey , t.dittokey, t.uuid
		-- , a.name as thingname, b.name as username, c.name as listname
		-- , b.fbuid
		, `show`, listid , 2 as customOrder
	from temp_splists t
	-- inner join tthing a on t.tid = a.id
	-- inner join tthing c on t.lid = c.id
	-- inner join tuser b on b.id = t.uid
	where uid = @uid)
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
left outer join tcomments tc on tc.itemid = t.id and tc.byuserid = @uid

	;
    
    /*
, tc.`comment` as commentText, tc.`read` as commentRead, tc.`active` as commentActive 

FROM showsometemp s

INNER JOIN tthing tn ON tn.id = s.tid
INNER JOIN tuser un ON un.id = s.uid
INNER JOIN tthing lna ON lna.id = s.lid
LEFT OUTER JOIN tlist dk ON dk.id = s.dittokey 
LEFT OUTER JOIN tuser du ON du.id = dk.uid
left outer join tcomments tc on tc.itemid = s.id and tc.byuserid = @uid
*/


END;
call `spSqlLog_Timing` (@logKey );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `v2.0_getSome`(
	thetype VARCHAR(10)	-- List or User or Null
	, thetoken VARCHAR(36)	
	, theuserfilter TEXT
	, thelistfilter TEXT
	, theSharedFilter VARCHAR(10)
)
BEGIN
SET @thetype = thetype;
SET @thetoken = thetoken;
SET @userFilter = theuserfilter;
SET @thelistfilter = thelistfilter;
SET @defaultLimit = 1;
SET @showStrangers = TRUE; -- This is for the strangers part. Only don't show from others if the user filter is set.
SET @sharedFilter = theSharedFilter; -- Will be 'ditto' or 'shared' or 'all'
-- Log this query.

-- Create a procedure that we can bail out of.

goodTimes:BEGIN
	/* Begin Token Check Block */
	SET @uid = '';
	SET @tokenSuccess = false;
    SET @friendArray = '';
	SET @errorMessage = '';
	SET @logKey = null;
	call `v2.0_checkToken`( 
		'v2.0_getSome',
		@thetoken, 
        CONCAT('call `v2.0_getSome`("',@thetype,'","',@thetoken,'","',@userFilter,'","',@thelistfilter,'", "',@sharedFilter,'")'),
        @tokenSuccess, 
        @uid, 
        @friendArray, 
        @errorMessage,
		@logKey
	);
    
    if @tokenSuccess = false then
		LEAVE goodTimes;
	end if;
    /* End Token Check Block */
    
	
-- For someone with at least 10 friends, filter out ther things.
IF @userFilter = 'strangers' THEN
	-- Only show things from strangers.
    -- TODO2 - There should be a list of pending connections tracked by user, and that would be highlighted. 
    SET @friendOverload = CONCAT(' and l.uid not in (', @friendArray,')');
    
    
ELSEIF @userFilter = 'friends' THEN
	SET @showStrangers = FALSE;
    SET @friendOverload = CONCAT(' and l.uid in (', @friendArray,')');
    
elseIF CHAR_LENGTH(@userFilter) = 0 AND @friendCount > 10 THEN
	-- Exclude the last two users who were shown.
	SET @fq = CAST(CONCAT('SET @freshq = (
	select group_concat(CAST(fromuid AS CHAR CHARACTER SET UTF8) SEPARATOR ",") 
	from 
		(
			select fromuid from presentlist  where uid = ',@uid,' 
			order by lastdate desc limit 2) as t
	);') AS CHAR CHARACTER SET UTF8);
	PREPARE stmt FROM @fq;
	EXECUTE stmt;
	DEALLOCATE PREPARE stmt;
	
	-- Make sure that there were results
	IF CHAR_LENGTH(@freshq) = CHAR_LENGTH(REPLACE(@freshq,",","")) THEN
		-- There wasn't a comma, meaning zero or one friends.
		SET @friendOverload = '';
	ELSE
		SET @friendOverload = CONCAT(' and l.uid not in (',@freshq , ')');
		SET @defaultLimit = 2;
		
	END IF;

-- Filter for a specific user.			
ELSEIF CHAR_LENGTH(@userFilter) > 0 THEN
	-- select @userFilter as userfilter;
	SET @friendOverload = CONCAT(' and l.uid = ',@userFilter);
	SET @defaultLimit = 2;
	SET @showStrangers = FALSE;
ELSE
			SET @friendOverload = '';
END IF;
		
-- Exclude the last two lists that were shown
SET @fl = CAST(CONCAT('SET @freshl = (
	select group_concat(CAST(lid AS CHAR CHARACTER SET UTF8) SEPARATOR ",") 
	from 
		(select lid from presentlist  
			where uid = ',@uid,' 
			order by lastdate desc limit 2) as t
	);') AS CHAR CHARACTER SET UTF8);
	PREPARE stmt FROM @fl;
	EXECUTE stmt;
	DEALLOCATE PREPARE stmt;

-- Add the list filter to the friend overload.
IF CHAR_LENGTH(@freshl) > 0 THEN
	SET @listOverload = CONCAT(' and l.lid not in (', @freshl ,') ');
ELSE
	SET @listOverload = '';
END IF;
	
-- Initiate the variables.
SET 
	@Auid = NULL, @Alid = NULL, @Adittoable = NULL, @Acount = NULL, @Ashared = NULL, 
	@Buid = NULL, @Blid = NULL, @Bdittoable = NULL, @Bcount = NULL, @Bshared = NULL, 
	@Cuid = NULL, @Clid = NULL, @Cdittoable = NULL, @Ccount = NULL, @Cshared = NULL, @Cstrangers = NULL,
	@Duid = NULL, @Dlid = NULL, @Ddittoable = NULL, @Dcount = NULL, @Dshared = NULL, @Dstrangers = NULL,
	@havingShared = NULL, @myKeyFilter = NULL;
	
-- Build a list of my lists by ID. TODO - When this is filtering on a list, get rid of this.
SET @mylists = (SELECT GROUP_CONCAT(DISTINCT CAST(lid AS CHAR CHARACTER SET UTF8) SEPARATOR ',') FROM tlist WHERE uid = @uid AND state = 1 );
IF CHAR_LENGTH(@mylists) > 0 THEN
	SET @notmylists = CONCAT(' and l.lid not in (',@mylists,')');
	SET @mylists = CONCAT(' and l.lid in (',@mylists,')');
	
ELSE 
	SET @mylists = '';
	SET @notmylists = '';
	
END IF;
-- select @mylists;
-- select @showStrangers as 'showStrangers';
-- If a user filter is passed, do this part
-- TODO Handle the Dittoable filter.
-- Handle the dittoable / shared filter
IF @sharedFilter = 'ditto' THEN
	SET @havingShared = ' HAVING dittoable > 2 ';
	SET @myKeyFilter = ' and m.id is null ';
ELSEIF @sharedFilter = 'shared' THEN
	SET @havingShared = ' HAVING shared > 2 ';
	SET @myKeyFilter = ' and m.id > 0 ';
ELSE 
	-- This would be to show without a filter.
	SET @havingShared = ' HAVING thecount > 2 ';
	SET @myKeyFilter = ' ';
END IF;

-- Get some content from the user's friends first, then optionally, from strangers.
/* BEGIN POPULATING VARIABLES TO USE TO SELECT FROM MY FRIENDS */
	-- Batch A - A list from a friend that I also have, with at least 3 dittoable things in it, that I don't have. 
		-- ',@mylists,' -- This would only show lists that I already have. That seems limiting.
if @userFilter != 'strangers' then	
    SET @batchA = CONCAT('select 
	l.uid, l.lid, COUNT(l.id) - COUNT(m.id) AS dittoable, COUNT(l.id) AS thecount, COUNT(m.id) as shared INTO @Auid, @Alid, @Adittoable, @Acount, @Ashared
	from tlist l
	left outer join tlist m on m.lid = l.lid and m.tid=l.tid and m.uid = ',@uid,' 
	left outer join presentlist pl on pl.uid = ',@uid,' and pl.fromuid = l.uid and pl.lid = l.lid
	where 
		l.uid in (',@friendArray,') 
		and l.state = 1
		
		',@friendOverload,' ',@listOverload ,' ',@myKeyFilter,'
	group by l.lid,l.uid
	',@havingShared,'
	order by pl.lastdate asc
	limit 1')
	;
	
	SET @batchA = CAST(@batchA AS CHAR CHARACTER SET UTF8);
	-- 	SELECT 'batcha' AS context;
-- select @batchA as batchA, @uid as uid, @friendArray as friendsarray, @mylists as mylists, @friendOverload as friendoverload;
-- 	
	PREPARE stmt FROM @batchA;	EXECUTE stmt;	DEALLOCATE PREPARE stmt;
	
	-- if we don't have a valid user, then bail.
	IF CHAR_LENGTH(@Auid) = 0 OR CHAR_LENGTH(@Alid) = 0 THEN
		SELECT TRUE AS error, 'no users meet your criteria' AS errortxt;
		LEAVE goodTimes;
	END IF;
	
	-- Batch B - A list from us, that is not the same as the first list.
		-- ',@notmylists,' -- This would show only lists that I do not have. Maybe for specific users.
	IF CHAR_LENGTH(@userFilter) = 0 THEN
		SET @batchB = CONCAT('select
			l.uid, 
			l.lid, 
			COUNT(l.id) - COUNT(m.id) AS dittoable, 
			COUNT(l.id) AS thecount, 
			COUNT(m.id) as shared 
		INTO 
			@Buid, 
			@Blid, 
			@Bdittoable, 
			@Bcount, 
			@Bshared
		from tlist l
		left outer join tlist m on m.lid = l.lid and m.tid=l.tid and m.uid = ',@uid,' 
		left outer join presentlist pl on pl.uid = ',@uid,' and pl.fromuid = l.uid and pl.lid = l.lid
		where 
			l.uid in (',@friendArray,')  
			
			and l.state = 1
			and l.uid != ',@Auid ,' and l.lid !=',@Alid,' ',@listOverload, ' ', @friendOverload ,' ',@myKeyFilter,'
		group by l.lid,l.uid
		',@havingShared,'
		order by pl.lastdate asc
		limit 1')
		;
	ELSE
		-- Doesn't exclude the uid from batch a.
		SET @batchB = CONCAT('select
			l.uid, 
			l.lid, 
			COUNT(l.id) - COUNT(m.id) AS dittoable, 
			COUNT(l.id) AS thecount, 
			COUNT(m.id) as shared 
		INTO 
			@Buid, 
			@Blid, 
			@Bdittoable, 
			@Bcount, 
			@Bshared
		from tlist l
		left outer join tlist m on m.lid = l.lid and m.tid=l.tid and m.uid = ',@uid,' 
		left outer join presentlist pl on pl.uid = ',@uid,' and pl.fromuid = l.uid and pl.lid = l.lid
		where 
			l.uid in (',@friendArray,')  
			
			and l.state = 1
			and l.lid !=',@Alid,' ',@listOverload, ' ', @friendOverload ,' ',@myKeyFilter,'
		group by l.lid,l.uid
		',@havingShared,'
		order by pl.lastdate asc
		limit 1')
		;
	END IF;
--  
	PREPARE stmt FROM @batchB;		EXECUTE stmt;		DEALLOCATE PREPARE stmt;
/* END PICKING FROM FRIENDS */
end if; -- End filtering out if it's strangers only.

-- Don't do this if it's "friends" 

-- showStrangers: We won't be showing from strangers here.
IF @showStrangers = TRUE THEN
	-- Batch C - A list from strangers, I have that list, dittoable > 3, longest time since presented to me 
	
	-- ',@mylists,'
	
	SET @batchC = CONCAT('select
		max(l.lid), count(l.id) - count(m.id) as dittoable, 
		0 as uid, 
		COUNT(l.id) AS thecount, 
		COUNT(m.id) as shared, 
		group_concat(distinct l.uid SEPARATOR ",") as strangersWith
	into @Clid, @Cdittoable, @Cuid, @Ccount, @Cshared, @Cstrangers
	from tlist l
	left outer join tlist m on m.lid = l.lid and m.tid = l.tid and m.uid = ',@uid,' 
	left outer join presentlist pl on pl.uid = ',@uid,' and pl.fromuid = 0 and pl.lid = l.lid
	where 
		l.uid not in (',@uid,',',@friendArray,')  ',@myKeyFilter,'
		
		and l.state = 1
	group by l.lid
	',@havingShared,' and strangersWith > 1 
	order by pl.lastdate asc
	limit 1')
	;
-- -- ',@notmylists,'
PREPARE stmt FROM @batchC;		EXECUTE stmt;		DEALLOCATE PREPARE stmt;
	-- Batch D - A list from strangers, I don't have that list, dittoable > 3, longest time since presented to me 
	SET @batchD = CONCAT('select
	max(l.lid), count(l.id) - count(m.id) as dittoable, 0, COUNT(l.id) AS thecount, COUNT(m.id) as shared, group_concat(distinct l.uid SEPARATOR ",")  as strangersWith
	into @Dlid, @Ddittoable, @Duid, @Dcount, @Dshared, @Dstrangers
	from tlist l
	left outer join tlist m on m.lid = l.lid and m.tid=l.tid and m.uid = ',@uid,' 
	left outer join presentlist pl on pl.uid = ',@uid,' and pl.fromuid = 0 and pl.lid = l.lid
	where 
		l.uid not in (',@uid,',',@friendArray,')  
		and l.lid != ',@Clid,'
		and l.state = 1 ',@myKeyFilter,'
	group by l.lid
	',@havingShared,' and strangersWith > 1 
	order by pl.lastdate asc
	limit 1');
 -- 
 PREPARE stmt FROM @batchD;		EXECUTE stmt;		DEALLOCATE PREPARE stmt;
 
END IF;
-- Debug select @batchA as `a`, @batchB AS `b`, @batchC as `c`, @batchD as `d`;
-- Use a Temporary Table to hold the raw results
DROP TABLE IF EXISTS showsometemp;
CREATE TABLE showsometemp (
	sstid INT NOT NULL AUTO_INCREMENT,
	id INT,
	tid INT,
	lid INT,
	uid INT,
    uuid VARCHAR(45), -- Adds the unique identifier to the table.
	added DATETIME,
	modified DATETIME,
	state INT,
	dittokey INT,
	groupid INT,
	dittoable INT,
	lastshowncount INT,
	lastshown DATETIME,
	mykey INT
	
	, PRIMARY KEY (sstid)
);
-- INSERT RESULTS FROM A if it's valid.
IF @Alid > 0 AND @Auid > 0 THEN
	-- select 'Execute batch a' as messagea, @Alid as `alid`, @Auid as `auid`; 
	SET @insertBatchA = CONCAT('
	INSERT INTO showsometemp(
		id,
		tid,
		lid,
		uid,
		added,
		modified,
		state, 
		dittokey, 
		groupid, 
		dittoable, 
		lastshowncount , 
		lastshown, 
		mykey, 
        uuid )
	SELECT l.id, l.tid, l.lid, l.uid, l.added, l.modified, l.state, l.dittokey, 1, ',@Adittoable,'
		, pt.count, pt.lastdate
		, m.id, l.uuid
	FROM tlist l
	LEFT OUTER JOIN tlist m ON m.uid = ',@uid,' AND m.lid = l.lid AND m.tid = l.tid 
	LEFT OUTER JOIN presentthing pt ON pt.tlistkey = l.id and pt.uid = ',@uid,' 
	WHERE l.uid = ',@Auid,' AND l.lid = ',@Alid,' AND l.state = 1 ',@myKeyFilter ,'
	ORDER BY pt.lastdate ASC
	LIMIT 10');
	PREPARE stmt FROM @insertBatchA;		EXECUTE stmt;		DEALLOCATE PREPARE stmt;
	-- DEBUG
	-- 	select 'DEBUG insert batch a' as themessage, @insertBatchA as insertbatcha, @myKeyFilter as mykeyfilter;
	
	
ELSE
	-- SELECT 'FAILED ON BATCH A' AS messagea, @Alid as 'alid',@Auid as 'auid'; 
	SET @x = FALSE;
END IF;
-- INSERT RESULTS FROM C if it's valid.
IF @Blid > 0 AND @Buid > 0 THEN
	-- SELECT 'Execute batch b' AS messageb, @Blid AS `blid`, @Buid AS `auid`; 
	SET @insertBatchB = CONCAT('
	INSERT INTO showsometemp(
		id,
		tid,
		lid,
		uid,
		added,
		modified,
		state, 
		dittokey, 
		groupid, 
		dittoable, 
		lastshowncount , 
		lastshown, 
		mykey,
        uuid )
	SELECT l.id, l.tid, l.lid, l.uid, l.added, l.modified, l.state, l.dittokey, 2, ',@Bdittoable,'
		, pt.count, pt.lastdate
		, m.id
        , l.uuid 
	FROM tlist l
	LEFT OUTER JOIN tlist m ON m.uid = ',@uid,' AND m.lid = l.lid AND m.tid = l.tid 
	LEFT OUTER JOIN presentthing pt ON pt.tlistkey = l.id and pt.uid = ',@uid,' 
	WHERE l.uid = ',@Buid,' AND l.lid = ',@Blid,' AND l.state = 1 ',@myKeyFilter ,'
	ORDER BY pt.lastdate ASC
	LIMIT 10');
	PREPARE stmt FROM @insertBatchB;		EXECUTE stmt;		DEALLOCATE PREPARE stmt;
END IF;
	
	
-- INSERT RESULTS FROM C if it's valid.
IF CHAR_LENGTH(@Clid) > 0 AND CHAR_LENGTH(@Cuid) > 0 THEN
	SET @insertC = CONCAT('INSERT INTO showsometemp(
		id,
		tid,
		lid,
		uid,
		added,
		modified,
		state, 
		dittokey, 
		groupid, 
		dittoable, 
		lastshowncount , 
		lastshown,
		mykey,
        uuid 
	)
	select 
		l.id, 
		l.tid, 
        l.lid, 
        0, 
        l.added, 
        l.modified, l.state, l.dittokey, 3, ',@Cdittoable,', pt.count, pt.lastdate, 
		m.id,
        l.uuid
	from tlist l
	left outer join tlist m on m.uid = ',@uid,'
	 and m.lid = l.lid and m.tid = l.tid and m.state = 1
	left outer join presentthing pt on pt.tlistkey = l.id and pt.uid = ',@uid,' 
	where l.uid not in (',@uid,',',@friendArray,') and l.lid = ',@Clid,' and l.state = 1 ',@myKeyFilter ,'
	order by pt.lastdate asc
	limit 10');
	-- 
	PREPARE stmt FROM @insertC;	EXECUTE stmt;	DEALLOCATE PREPARE stmt;
END IF;
-- INSERT RESULTS FROM D if it's valid.
IF CHAR_LENGTH(@Dlid) > 0 AND CHAR_LENGTH(@Duid) > 0 THEN
	SET @insertD = CONCAT('
    INSERT INTO showsometemp(
		id,
        tid,
        lid,
        uid,
        added,
        modified,
        state, 
        dittokey, 
        groupid, 
        dittoable, 
        lastshowncount, 
        lastshown, 
        mykey, 
        uuid  
	)
	select 
		l.id, 
        l.tid, 
        l.lid, 
        0, 
        l.added, 
        l.modified, 
        l.state, 
        l.dittokey, 
        4, 
        ',@Ddittoable,', 
        pt.count, 
        pt.lastdate, 
        m.id, 
        l.uuid
	from tlist l
	left outer join 
		tlist m on m.uid = ',@uid,' and m.lid = l.lid and m.tid = l.tid
	left outer join 
		presentthing pt on pt.tlistkey = l.id and pt.uid = ',@uid,' 
	where 
		l.uid not in (',@uid,',',@friendArray,') 
        and l.lid = ', @Dlid ,' 
        and l.state = 1 
        ',@myKeyFilter ,'
	order by pt.lastdate asc
	limit 10');
	-- 
	PREPARE stmt FROM @insertD;  EXECUTE stmt;	DEALLOCATE PREPARE stmt;
END IF;
-- select @insertA, @insertB, @insertC, @insertD;
-- RETURN THE RESULTS - This sends it to the User Interface.
/* RESTORE THIS LATER */
-- SELECT 'return the results' as line337;
SELECT 
	s.id, 
    s.uid, 
    un.name AS username, 
    un.fbuid, 
    s.lid, 
    lna.name AS listname, 
    s.tid, 
	tn.name AS thingname,   
    s.added, 
    s.state, 
    s.dittokey AS dittokey, 
    s.dittoable , 
    s.groupid, 
	dk.uid AS dittouser, 
    du.name AS dittousername, 
    du.fbuid AS dittofbuid, 
    lastshowncount, 
    lastshown, 
    mykey AS mykey, 
    tc.`comment` as commentText, 
    tc.`read` as commentRead, 
    tc.`active` as commentActive,
    s.uuid

FROM showsometemp s

INNER JOIN tthing tn ON tn.id = s.tid
INNER JOIN tuser un ON un.id = s.uid
INNER JOIN tthing lna ON lna.id = s.lid
LEFT OUTER JOIN tlist dk ON dk.id = s.dittokey 
LEFT OUTER JOIN tuser du ON du.id = dk.uid
left outer join tcomments tc on tc.itemid = s.id and tc.byuserid = @uid 

group by s.id


;
-- Update the log to show most recently shown lists.
INSERT INTO presentlist (`uid`,`fromuid`,`lid`,`lastdate`,`presentcount`)
SELECT @uid, uid, lid, CURRENT_TIMESTAMP, 1
FROM showsometemp
GROUP BY lid
ON DUPLICATE KEY UPDATE lastdate = CURRENT_TIMESTAMP, presentcount = presentcount +1;


-- Update the log to show the most recently shown things
INSERT INTO presentthing (`uid`,`count`,`lastdate`,`tlistkey`)
SELECT @uid, 1, CURRENT_TIMESTAMP, id
FROM showsometemp
ON DUPLICATE KEY UPDATE lastdate = CURRENT_TIMESTAMP, `count` = `count` +1;
-- DEBUG
/*
SELECT 
CONCAT('INSERT INTO presentlist (`uid`,`fromuid`,`lid`,`lastdate`,`presentcount`)
SELECT ',@uid,', uid, lid, CURRENT_TIMESTAMP, 1
FROM showsometemp
GROUP BY lid
ON DUPLICATE KEY UPDATE lastdate = CURRENT_TIMESTAMP, presentcount = presentcount +1;
-- Update the log to show the most recently shown things
INSERT INTO presentthing (`uid`,`count`,`lastdate`,`tlistkey`)
SELECT ',@uid,', 1, CURRENT_TIMESTAMP, id
FROM showsometemp
ON DUPLICATE KEY UPDATE lastdate = CURRENT_TIMESTAMP, `count` = `count` +1;') as presentlistlog, 
-- @batchA as BatchA,
-- 
'notes' AS note
,@batchC AS batchC
,@insertBatchC AS insertBatchC
;*/
/*
SELECT * FROM showsometemp;
*/
-- End the proc
END;
call `spSqlLog_Timing` (@logKey );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `v2.0_listOfLists`(thetoken VARCHAR(36), userfilter TEXT, toIgnore TEXT)
BEGIN

SET @thetoken = thetoken;

goodTimes:BEGIN
	/* Begin Token Check Block */
	SET @uid = '';
	SET @tokenSuccess = false;
    SET @friendArray = '';
	SET @errorMessage = '';
	SET @logKey = null;
	call `v2.0_checkToken`( 
		'v2.0_listOfLists',
		@thetoken, 
        CONCAT('call v2.0_listOfLists("',thetoken,'","',userfilter,'","',toIgnore,'")'),
        @tokenSuccess, 
        @uid, 
        @friendArray, 
        @errorMessage,
		@logKey
	);
    
    if @tokenSuccess = false then
		LEAVE goodTimes;
	end if;
    /* End Token Check Block */
    

	SET @userfilter = userfilter;


	/*
		The point of this proc is to show a list of lists. This can either be for a specific user, or across many users. alter

		Regardless, you're always going to see what you have in common with people. 

	*/

	/* Not sure what to do with "toignore" in the future */

	SET @toIgnore = toIgnore;

	-- Append me to the results if my friends are null.

	-- Set the focus for who we are looking for.

	
	if @userfilter != 'all' and length(@userfilter) > 0 then
		
	-- Show all the lists for a specific user. TODO 10/20/2014 - This needs to be reviewed

		SET @q = CONCAT('

		select l.id, ln.name as name, l.lid, count(*) as listmembers
			, count(m.id) as mymembers
			, count(*) - count(m.id) as dittoable
			, count(m.id) as shared

			, max(l.added) as mostrecent
			
			
			, GROUP_CONCAT(distinct u.fbuid) as fbuids
		from tlist l
		inner join tthing as ln on ln.id = l.lid -- Brings in the names of lists.
		inner join tuser as u on u.id = l.uid 
			left outer join tlist m on m.uid = ',@uid,' and m.lid = l.lid and m.tid = l.tid and m.state = 1
		-- Get the fbuids


		where l.uid in (',@userfilter,')
		and l.state = 1
		group by l.lid

		order by shared desc
		limit 20
		;');

	ELSE -- 

	-- Show lists for me and my friends. 	
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
			left outer join tlist as m on m.tid = l.tid and m.lid = l.lid and m.uid = ',@uid,' and m.state = 1 

		-- Get the fbuids

		where l.uid in (',@uid,',',@friendsarray,') -- For lists that me or my friends have. 
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

END;
call `spSqlLog_Timing` (@logKey );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `v2.0_listSearch`(thetoken VARCHAR(36), searchTerm TEXT)
BEGIN

SET @thetoken = thetoken;
SET @searchTerm = searchTerm;


goodTimes:BEGIN
	/* Begin Token Check Block */
	SET @uid = '';
	SET @tokenSuccess = false;
    SET @friendArray = '';
	SET @errorMessage = '';
	SET @logKey = null;
	call `v2.0_checkToken`( 
		'v2.0_listSearch',
		@thetoken, 
        CONCAT('call `v2.0_listSearch`("',thetoken,'","',searchTerm,'")'),
        @tokenSuccess, 
        @uid, 
        @friendArray, 
        @errorMessage,
		@logKey
	);
    
    if @tokenSuccess = false then
		LEAVE goodTimes;
	end if;
    /* End Token Check Block */


select a.lid, b.name as listname, count(*) as thecount 

from tlist a 
inner join tthing b on b.id=  a.lid

where b.name like CONCAT('%',@searchTerm ,'%')
-- and a.userid in (1,2,3,4,5,6,7,8,9,10,13,168,19,18,17,16,15,14,13,12,11)
-- TODO2 - Highlight items that are from user and their friends. Possibly with their profile pictures too.
group by a.lid
order by thecount desc
limit 10;

end;
call `spSqlLog_Timing` (@logKey );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `v2.0_loadList`(
			thetoken VARCHAR(36),
			theType 	VARCHAR(10),
			listId		INT,
			userFilter int, -- Defaults to 0
			oldestKey INT, -- Defaults to 0
			sharedFilter VARCHAR(10)
    )
BEGIN
    
    SET 
		@thetoken = thetoken, 
		@theType = theType, 
		@listId = listId, 
		@userFilter = userFilter, 
		@oldestKey = oldestKey, 
		@sharedFilter = sharedFilter,
		@userCriteria = '', 
		@oldestKeyCriteria =''
	;
    

goodTimes:BEGIN
	/* Begin Token Check Block */
	SET @uid = '';
	SET @tokenSuccess = false;
    SET @friendArray = '';
	SET @errorMessage = '';
	SET @logKey = null;
	call `v2.0_checkToken`( 
		'v2.0_loadList',
		@thetoken, 
        CONCAT('call `v2.0_loadList`("',
			@thetoken,'","',
            @thetype,'","',
            @listId,'","',
            @userFilter,'","',
			@oldestKey,'","',
            @sharedFilter ,
		'")'),
        @tokenSuccess, 
        @uid, 
        @friendArray, 
        @errorMessage,
		@logKey
	);
    
    if @tokenSuccess = false then
		LEAVE goodTimes;
	end if;
    /* End Token Check Block */
    
    SET @goodLimit = 15;
	
	-- Oldest ID Criteria - for loading items older than the oldest id
	IF @oldestKey > 0 THEN
		SET @oldestKeyCriteria = CONCAT(' and l.id < ',@oldestKey);
	ELSE
		SET @oldestKeyCriteria = '';
	END if;
	
-- Make the per-type criterias.	
	if @theType = "ditto" then
		SET @userCriteria = CONCAT(' and l.uid in (' , @friendArray , ')');
	
	elseif @theType = 'shared' then
		SET @userCriteria = CONCAT(' and l.uid in (' , @friendArray,')');
	
	ELSEIF @theType = 'mine' THEN
		SET @userCriteria = CONCAT(' and l.uid = ' , @uid);
	
	ELSEIF @theType = 'feed' THEN
		SET @userCriteria = CONCAT(' and l.uid in (', @friendArray , ',', @uid,') ' );
	
	ELSEIF @theType = 'strangers' THEN
		SET @userCriteria = CONCAT(' and l.uid not in (' , @friendArray , ',', @uid,') ' );
	
	ELSE
		select true as error, 'unknown request' as errortxt;
		LEAVE goodTimes;
	end if ;
-- Create a results table
DROP TABLE IF EXISTS showsometemp;
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
	lastshown DATETIME,
	mykey INT,
    uuid VARCHAR(45)
	
	, PRIMARY KEY (sstid)
);		
		
-- Start with Feed, which has a different query
	
	if @theType = 'feed' then		
		SET @q = CONCAT('
		select 
			l.id, 
			l.uid, 
			un.name AS username, 
			un.fbuid,  
			l.lid, 
            lna.name AS listname, 
            l.tid
			, tn.name AS thingname,   
			l.added, 
            l.state, 
			l.dittokey AS dittokey
			, dk.uid AS dittouser, 
			du.name AS dittousername, 
			du.fbuid AS dittofbuid, 
			m.id as mykey
            , tc.`comment` as commentText, 
            tc.`read` as commentRead, 
            tc.`active` as commentActive,
            l.uuid
		from tlist l
			INNER JOIN tthing tn ON tn.id = l.tid
			INNER JOIN tuser un ON un.id = l.uid
			INNER JOIN tthing lna ON lna.id = l.lid
			LEFT OUTER JOIN tlist dk ON dk.id = l.dittokey 
			LEFT OUTER JOIN tuser du ON du.id = dk.uid
			LEFT OUTER JOIN tlist m on m.uid = ',@uid,' and m.lid = l.lid and m.tid = l.tid and m.state = 1
            left outer join tcomments tc on tc.itemid = l.id and tc.byuserid = ',@uid,'
		where 
			l.state = 1 ',@userCriteria,' ',@oldestKeyCriteria,'
			and l.lid =',@listId,'
		order by l.id desc
		limit ', @goodLimit );
        
        -- select @q as thequery; -- DEBUG ONLY
        prepare stmt from @q; 	execute stmt; 	deallocate prepare stmt;
		
		
	ELSEIF @theType = 'mine' THEN		
		SET @q = CONCAT('
		select 
			l.id, 
            l.uid,
            un.name AS username, 
            un.fbuid,  
			l.lid, 
            lna.name AS listname, 
            l.tid, 
            tn.name AS thingname,   
			l.added, 
            l.state, 
			l.dittokey AS dittokey
			, dk.uid AS dittouser, 
			du.name AS dittousername, 
			du.fbuid AS dittofbuid, 
			m.id as mykey
            , tc.`comment` as commentText, 
            tc.`read` as commentRead, 
            tc.`active` as commentActive,
            l.uuid
		from tlist l
			INNER JOIN tthing tn ON tn.id = l.tid
			INNER JOIN tuser un ON un.id = l.uid
			INNER JOIN tthing lna ON lna.id = l.lid
			LEFT OUTER JOIN tlist dk ON dk.id = l.dittokey 
			LEFT OUTER JOIN tuser du ON du.id = dk.uid
			LEFT OUTER JOIN tlist m on m.uid = ',@uid,' and m.lid = l.lid and m.tid = l.tid and m.state = 1
            left outer join tcomments tc on tc.itemid = l.id and tc.byuserid = @uid
		where 
			l.state = 1 ',@userCriteria,' ',@oldestKeyCriteria,'
			and l.lid =',@listId,'
		order by l.id desc
		limit ', @goodLimit );
		PREPARE stmt FROM @q; 	EXECUTE stmt; 	DEALLOCATE PREPARE stmt;
		-- select @q as thequery;
		
	ELSEIF @theType = 'ditto' THEN
			SET @q = CONCAT('
		INSERT INTO showsometemp (`id`,`tid`,`lid`,`uid`,`added`,`modified`,`dittokey`,`mykey`,`uuid`)
		select l.id, l.tid, l.lid, l.uid, l.added, l.modified, l.dittokey AS dittokey, m.id, l.uuid
		from tlist l
			LEFT OUTER JOIN tlist dk ON dk.id = l.dittokey 
			LEfT OUTER JOIN presentthing pt on pt.tlistkey = l.id 
			left outer join tlist m on m.uid = ',@uid,' and m.lid = l.lid and m.tid = l.tid and m.state = 1
		where 
			l.state = 1 ',@userCriteria,' ',@oldestKeyCriteria,'
			and l.lid =',@listId,'
			and m.id is null
		order by pt.lastdate asc 
		limit ', @goodLimit );
		PREPARE stmt FROM @q; 	EXECUTE stmt; 	DEALLOCATE PREPARE stmt;
		
		-- Join the items and return them.
		select  
			s.id, 
            s.uid, 
            u.name as username, 
            u.fbuid,
			s.lid, 
            lna.name as listname, 
            s.tid, 
            tn.name as thingname,
			s.added, 
            s.state, 
            s.dittokey, 
            dk.uid as dittouser, 
            du.name as dittousername, 
            du.fbuid as dittofbuid, 
            s.mykey, 
            tc.`comment` as commentText, 
            tc.`read` as commentRead, 
            tc.`active` as commentActive, 
            s.uuid
		from showsometemp s
			inner join tuser u on u.id = s.uid 
			inner join tthing lna ON lna.id = s.lid
			inner join tthing tn on tn.id = s.tid
			LEFT OUTER JOIN tlist dk ON dk.id = s.dittokey 
			LEFT OUTER JOIN tuser du ON du.id = dk.uid
            left outer join tcomments tc on tc.itemid = s.id and tc.byuserid = @uid
		order by s.uid asc, s.modified desc
		;
		
		-- Update the log to show most recently shown lists.
		INSERT INTO presentlist (`uid`,`fromuid`,`lid`,`lastdate`,`presentcount`)
		SELECT @uid, uid, lid, CURRENT_TIMESTAMP, 1
		FROM showsometemp
		GROUP BY lid
		ON DUPLICATE KEY UPDATE lastdate = CURRENT_TIMESTAMP, presentcount = presentcount +1;
		
		-- Update the log to show the most recently shown things
		INSERT INTO presentthing (`uid`,`count`,`lastdate`,`tlistkey`)
		SELECT @uid, 1, CURRENT_TIMESTAMP, id
		FROM showsometemp
		ON DUPLICATE KEY UPDATE lastdate = CURRENT_TIMESTAMP, `count` = `count` +1;
        
ELSEIF @theType = 'shared' THEN
			SET @q = CONCAT('
		INSERT INTO showsometemp(`id`,`tid`,`lid`,`uid`,`added`,`modified`,`dittokey`,`mykey`,`uuid`)
		select l.id, l.tid, l.lid, l.uid, l.added, l.modified, l.dittokey AS dittokey, m.id, l.uuid
        
		from tlist l
			LEFT OUTER JOIN tlist dk ON dk.id = l.dittokey 
			LEFT OUTER JOIN tlist m on m.uid = ',@uid,' and m.lid = l.lid and m.tid = l.tid and m.state = 1
			LEFT OUTER JOIN presentthing pt on pt.tlistkey = l.id 
            
		where 
			l.state = 1 ',@userCriteria,' ',@oldestKeyCriteria,'
			and l.lid =',@listId,'
			and m.id is not null
		order by pt.lastdate asc 
		limit ', @goodLimit );
		PREPARE stmt FROM @q; 	EXECUTE stmt; 	DEALLOCATE PREPARE stmt;
		
		-- Join the items and return them.
		SELECT  
		s.id, s.uid, u.name AS username, u.fbuid,
		s.lid, lna.name AS listname, s.tid, tn.name AS thingname,
		s.added, 1, s.dittokey, dk.uid AS dittouser, du.name AS dittousername, du.fbuid AS dittofbuid, s.mykey
        , tc.`comment` as commentText, tc.`read` as commentRead, tc.`active` as commentActive, s.uuid
		FROM showsometemp s
			INNER JOIN tuser u ON u.id = s.uid 
			INNER JOIN tthing lna ON lna.id = s.lid
			INNER JOIN tthing tn ON tn.id = s.tid
			LEFT OUTER JOIN tlist dk ON dk.id = s.dittokey 
			LEFT OUTER JOIN tuser du ON du.id = dk.uid
            left outer join tcomments tc on tc.itemid = s.id and tc.byuserid = @uid
		ORDER BY s.uid ASC, s.modified DESC
		;
		
		-- Update the log to show most recently shown lists.
		INSERT INTO presentlist (`uid`,`fromuid`,`lid`,`lastdate`,`presentcount`)
		SELECT @uid, uid, lid, CURRENT_TIMESTAMP, 1
		FROM showsometemp
		GROUP BY lid
		ON DUPLICATE KEY UPDATE lastdate = CURRENT_TIMESTAMP, presentcount = presentcount +1;
		
		-- Update the log to show the most recently shown things
		INSERT INTO presentthing (`uid`,`count`,`lastdate`,`tlistkey`)
		SELECT @uid, 1, CURRENT_TIMESTAMP, id
		FROM showsometemp
		ON DUPLICATE KEY UPDATE lastdate = CURRENT_TIMESTAMP, `count` = `count` +1;
        
ELSEIF @theType = 'strangers' THEN
			SET @q = CONCAT('
		INSERT INTO showsometemp(`id`,`tid`,`lid`,`uid`,`added`,`modified`,`dittokey`,`mykey`,`uuid`)
		select 
			l.id, 
            l.tid, 
            l.lid, 
            l.uid, 
            l.added, 
            l.modified, 
            l.dittokey AS dittokey, 
            m.id, 
            l.uuid
		from tlist l
			LEFT OUTER JOIN tlist dk ON dk.id = l.dittokey 
			LEFT OUTER JOIN tlist m on m.uid = ',@uid,' and m.lid = l.lid and m.tid = l.tid and m.state = 1
			LEfT OUTER JOIN presentthing pt on pt.tlistkey = l.id 
		where 
			l.state = 1 ',@userCriteria,' ',@oldestKeyCriteria,'
			and l.lid =',@listId,'
			
		order by pt.lastdate asc 
		limit 30');
		PREPARE stmt FROM @q; 	EXECUTE stmt; 	DEALLOCATE PREPARE stmt;
		
		-- Join the items and return them.
		SELECT  
			s.id, 0 as `uid`, 
            'Stranger' AS username, 
            0 as `fbuid`,
			s.lid, lna.name AS listname, 
            s.tid, tn.name AS thingname,
			s.added, 1, s.dittokey, 
            dk.uid AS dittouser, 
            du.name AS dittousername, 
            du.fbuid AS dittofbuid, 
            s.mykey
			, tc.`comment` as commentText, 
            tc.`read` as commentRead, 
            tc.`active` as commentActive,
            s.uuid
            
		FROM showsometemp s
			-- INNER JOIN tuser u ON u.id = s.uid 
			INNER JOIN tthing lna ON lna.id = s.lid
			INNER JOIN tthing tn ON tn.id = s.tid
			LEFT OUTER JOIN tlist dk ON dk.id = s.dittokey 
			LEFT OUTER JOIN tuser du ON du.id = dk.uid
            left outer join tcomments tc on tc.itemid = s.id and tc.byuserid = @uid
		ORDER BY s.uid ASC, s.modified DESC
		;
		
		-- Update the log to show most recently shown lists.
		INSERT INTO presentlist (`uid`,`fromuid`,`lid`,`lastdate`,`presentcount`)
		SELECT @uid, uid, lid, CURRENT_TIMESTAMP, 1
		FROM showsometemp
		GROUP BY lid
		ON DUPLICATE KEY UPDATE lastdate = CURRENT_TIMESTAMP, presentcount = presentcount +1;
		
		-- Update the log to show the most recently shown things
		INSERT INTO presentthing (`uid`,`count`,`lastdate`,`tlistkey`)
		SELECT @uid, 1, CURRENT_TIMESTAMP, id
		FROM showsometemp
		ON DUPLICATE KEY UPDATE lastdate = CURRENT_TIMESTAMP, `count` = `count` +1;
	ELSE
		select 'something' as pending;
	end if;
		
	
end;
call `spSqlLog_Timing` (@logKey );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `v2.0_makeRead`(vTheToken VARCHAR(50), vTheType VARCHAR(50), vKeys TEXT)
BEGIN
-- call `v2.0_makeRead` ('ditto','1831, 1830, 1829, 1675, 1674, 1673, 1672, 1671, 1625, 1591, 1590, 1589, 1588, 1580, 1579, 1576, 1572, 1571, 1567, 1558, 1557, 1556, 1555, 1554, 1551, 1550, 1549, 1534, 1533, 1532');

SET @theType = vTheType;
SET @theKeys = vKeys;

SET @thetoken = vTheToken;

goodTimes:BEGIN
	/* Begin Token Check Block */
	SET @uid = '';
	SET @tokenSuccess = false;
    SET @friendArray = '';
	SET @errorMessage = '';
	SET @logKey = null;
	call `v2.0_checkToken`( 
		'v2.0_makeRead',
		@thetoken, 
        CONCAT('call `v2.0_makeRead`("',@thetoken,'","',@theType,'","',@theKeys,'")'),
        @tokenSuccess, 
        @uid, 
        @friendArray, 
        @errorMessage,
		@logKey
	);
    
    if @tokenSuccess = false then
		LEAVE goodTimes;
	end if;
    /* End Token Check Block */

-- select @theKeys as theKeys;

if @theType = "ditto" then 
	-- 
    set @updateQ = CONCAT('update tditto set `read` = 1 where id in (',@theKeys,')');
    /*
    select @updateQ as x;*/
    
    
    prepare stmt from @updateQ;
	execute stmt;
	deallocate prepare stmt; 
    
        
    
elseif @theType = "chat" then
	-- update tcomments set `read` = 1 where id in (@theKeys);
    set @updateQ = CONCAT('update tcomments set `read` = 1 where id in (',@theKeys,')');
    prepare stmt from @updateQ;
	execute stmt;
	deallocate prepare stmt;
    
else
	select true as `error`, 'unknown request type' as `errorTxt`;
end if;


select 'updated keys' as theResult;

END;
call `spSqlLog_Timing` (@logKey );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `v2.0_notifications`(vToken VARCHAR(55), vUserFilter INT(12) )
BEGIN

SET @thetoken = vToken;
SET @userFilter = vUserFilter;


goodTimes:BEGIN
	/* Begin Token Check Block */
	SET @uid = '';
	SET @tokenSuccess = false;
    SET @friendArray = '';
	SET @errorMessage = '';
	SET @logKey = null;
	call `v2.0_checkToken`( 
		'v2.0_notifications',
		@thetoken, 
        CONCAT('call `v2.0_notifications`("',@thetoken,'","',@userFilter,'")'),
        @tokenSuccess, 
        @uid, 
        @friendArray, 
        @errorMessage,
		@logKey
	);
    
    if @tokenSuccess = false then
		LEAVE goodTimes;
	end if;
    /* End Token Check Block */
    
-- Condititional where user statement
-- SET @userFilterView = CONCAT(" and d.userid = @uid or d.sourceuserid = @uid ");
-- Don't show my dittos out, by default.



if @userFilter > -1 then
	-- This is for a specific user. Note the addition of "me" 
    
	-- SET @userFilterView = CONCAT(" and (d.userid = '" ,@uid , "' and d.sourceuserid = '" ,@userFilter , "' ) or ( d.sourceuserid = '" ,@uid , "' and d.userid = '" ,@userFilter , "' ) ");
    -- SET @userFilterView = CONCAT(" and  d.userid = '" ,@uid , "' and d.sourceuserid = '" ,@userFilter , "' ) or ( d.sourceuserid = '" ,@uid , "' and d.userid = '" ,@userFilter , "' ) ");
    -- SET @userFilterView = CONCAT(" and  ( d.userid = '" ,@uid , "' and d.sourceuserid = '" ,@userFilter , "' ) or ( d.sourceuserid = '" ,@uid , "' and d.userid = '" ,@userFilter , "' ) ");
    SET @userFilterA = CONCAT(" and  ( d.`userid` = '" ,@uid , "' and d.`sourceuserid` = '" ,@userFilter , "' ) "); -- FROM THIS user to SPECIFIC user
    SET @userFilterB = CONCAT(" and  ( d.`userid` = '" ,@userFilter , "' and d.`sourceuserid` = '" ,@uid , "' ) "); -- FROM SPECIFIED user to THIS user
    
    -- SET @theNote = CONCAT("The user filter is ",@userFilter," which evaluated as greater than -1");
    SET @chatFilterA = CONCAT("  (t.`uid` = ", @uid ," and tc.`byuserid` = ", @userFilter ," ) "); -- FROM THIS user to SPECIFIED user
    SET @chatFilterB = CONCAT(" ( tc.`byuserid` = ",@uid, " and t.`uid` = ", @userFilter," )  "); -- FROM SPECIFIED user to THIS user
    
else 
	-- This is for an aggregate of all users.
    
    SET @userFilterA = CONCAT(" and d.`userid` = '", @uid,"' ");	-- From this user (TESTED 12/17)
    SET @userFilterB = CONCAT(" and d.`sourceuserid` = '", @uid,"' "); -- TO this user (NOT WORKING)
    
    -- SET @theNote = CONCAT("The user filter is ",@userFilter," which evaluated as -1");
    SET @chatFilterA = CONCAT("  t.`uid` = ", @uid," "); -- TO THIS USER
    SET @chatFilterB = CONCAT(" tc.`byuserid` = ",@uid, " "); -- FROM THIS USER
    
end if;

SET @groupLimit = 30;

SET @dittoFields = "'ditto' as theType, 
        d.`id` as id, 
        d.`added` as added , 
		d.`userId` as fromUserId, 
        u.`name` as fromUserName, 
        u.`fbuid` as fromFbuid, 
		d.`sourceuserid` as toUserId, 
        su.`name` as toUserName , 
        su.`fbuid` as toFbuid,
		d.`listid`, l.`name` as listName,
		d.`thingid`,  t.`name` as thingName, 
		d.`read`, d.`hidden`,
        '' as note
        from tditto d
		inner join tthing t on t.id = d.thingid
		inner join tthing l on l.id = d.listid
		inner join tuser u on u.id = d.userid
		inner join tuser su on su.id = d.sourceuserid
        where d.`hidden` = 0 
        ";
        
-- Ditto Queries
	-- Dittos FROM THIS USER
	SET @dittoQueryA = CONCAT("select 
		",@dittoFields, " ", @userFilterA ," 
		order by d.id desc
		LIMIT  ", @groupLimit);

	-- Dittos TO THIS USER
	SET @dittoQueryB = CONCAT("select 
		",@dittoFields, " ", @userFilterB ," 
		order by d.id desc
		LIMIT ", @groupLimit);
		-- LIMIT ", @groupLimit);

        
-- Chat Handling
SET @chatFields = "
	'chat' as theType, tc.`id`, tc.`added`,  
	tc.`byuserid` as toUserId, tu.`name` as toUserName, tu.`fbuid` as toFbuid, 
	t.`uid` as fromUserId, fu.`name` as fromUserName, fu.`fbuid` as fromFbuid, 
	t.`lid` as listid, ln.`name` as listName, 
	t.`tid` as thingid, tn.`name` as thingName,
	tc.`read`, 
	CASE WHEN tc.`active` = 0 then 1
		ELSE 0
	END as `hidden`
	, tc.`comment` as note
    from tcomments tc
	inner join tlist t on t.id = tc.itemid
	inner join tuser fu on fu.id = t.uid
	inner join tuser tu on tu.id= tc.byuserid 
	inner join tthing ln on ln.id = t.lid 
	inner join tthing tn on tn.id = t.tid 
	where tc.`active` = 1 and
" ;

-- Chats TO this user.
SET @chatQueryA = CONCAT( "
select ",@chatFields," ", @chatFilterA, "
order by tc.`added` desc 
limit ", @groupLimit );
-- limit ", @groupLimit );

-- CHATS FRom this User
SET @chatQueryB = CONCAT( "

select ", @chatFields, " ", @chatFilterB, "
order by tc.`added` desc 
limit ", @groupLimit );
-- limit ", @groupLimit );

-- select @dittoQueryA as dittoQueryA,  @dittoQueryB as dittoQueryB, @chatQueryA as chatQueryA, @chatQueryB as chatQueryB;

-- Add in the dittos.
SET @theQuery = CONCAT("
select * from 
(
	select * from ( ", @dittoQueryA, ") as ta
	union
	select * from (", @dittoQueryB,") as tb
    union
    select * from (",@chatQueryA,") as tc
	union
    select * from (",@chatQueryB,") as td
) as tz
order by added desc

") 
;

-- select @theQuery as theQuery;

-- SELECT @theNote as theNote;
-- select @chatQuery as ChatQuery;
prepare stmt from @theQuery;execute stmt;deallocate prepare stmt; 

END;
call `spSqlLog_Timing` (@logKey );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `v2.0_search`(thetoken VARCHAR(36), term VARCHAR(255))
BEGIN
SET @thetoken = thetoken;
set @term = term;


goodTimes:BEGIN
	/* Begin Token Check Block */
	SET @uid = '';
	SET @tokenSuccess = false;
    SET @friendArray = '';
	SET @errorMessage = '';
	SET @logKey = null;
	call `v2.0_checkToken`( 
		'v2.0_search',
		@thetoken, 
        CONCAT('call `v2.0_search`("',@thetoken,'","',@term,'")'),
        @tokenSuccess, 
        @uid, 
        @friendArray, 
        @errorMessage,
		@logKey
	);
    
    if @tokenSuccess = false then
		LEAVE goodTimes;
	end if;
    /* End Token Check Block */


drop table if exists `temp_search`;
CREATE TABLE `temp_search` (
	`id` int(3) NOT NULL Auto_Increment, 
	`type` VARCHAR(10),
	`group` INT(1),
	`groupName` VARCHAR(20),
	`nameid` INT(11),
	`name` TEXT,
	`count` INT(7), 
	primary key(`id`)
);
-- Lists that match that from my friends
SET @i = CONCAT(
' INSERT INTO temp_search (`type`,`group`,`groupName`,`nameid`,`name`,`count`)
select "list", 1,"Lists from Us", t.id, t.name, count(*) as contain 
from tthing t
inner join tlist l on l.lid = t.id 
where t.name like "%',@term,'%"
	and l.uid in (',@uid,',',@friendArray,')
group by t.id
order by contain desc
limit 10');
prepare stmt from @i;
execute stmt;
deallocate prepare stmt; 
-- Lists that match that term from everyone, that wasn't in the friend results
SET @j = CONCAT(
' INSERT INTO temp_search (`type`,`group`,`groupName`,`nameid`,`name`,`count`)
select "list", 2, "Lists from Them", t.id, t.name, count(*) as contain 
from tthing t
inner join tlist l on l.lid = t.id 
where t.name like "%',@term,'%"
	and l.uid not in (',@uid,',',@friendArray,')
	-- and t.id not in (select nameid from temp_search)
group by t.id
order by contain desc
limit 10');
prepare stmt from @j;
execute stmt;
deallocate prepare stmt; 
-- Things that match that term from my friends
SET @k  = CONCAT(
' INSERT INTO temp_search (`type`,`group`,`groupName`,`nameid`,`name`,`count`)
select "thing", 3, "Things from Us", t.id, t.name, count(*) as contain 
from tthing t
inner join tlist l on l.tid = t.id 
where t.name like "%',@term,'%"
	and l.uid in (',@uid,',',@friendArray,')
group by t.id
order by contain desc
limit 10');
prepare stmt from @k;
execute stmt;
deallocate prepare stmt; 
-- Things that match that term from everyone.
-- Lists that match that term from everyone, that wasn't in the friend results
SET @l = CONCAT(
' INSERT INTO temp_search (`type`,`group`,`groupName`,`nameid`,`name`,`count`)
select "thing", 4, "Things from Them", t.id, t.name, count(*) as contain 
from tthing t
inner join tlist l on l.tid = t.id 
where t.name like "%',@term,'%"
	and l.uid not in (',@uid,',',@friendArray,')
	and t.id not in (select nameid from temp_search )
group by t.id
order by contain desc
limit 10');
prepare stmt from @l;
execute stmt;
deallocate prepare stmt; 
select * from temp_search;
END;
call `spSqlLog_Timing` (@logKey );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `v2.0_thingDetail`(thetoken VARCHAR(36), thethingid INT)
BEGIN


SET @thetoken = thetoken;

SET @thingid = thethingid; 


goodTimes:BEGIN
	/* Begin Token Check Block */
	SET @uid = '';
	SET @tokenSuccess = false;
    SET @friendArray = '';
	SET @errorMessage = '';
	SET @logKey = null;
	call `v2.0_checkToken`( 
		'v2.0_thingDetail',
		@thetoken, 
        CONCAT('call v2.0_thingDetail("',@thetoken,'","',thethingid,'")'),
        @tokenSuccess, 
        @uid, 
        @friendArray, 
        @errorMessage,
		@logKey
	);
    
    if @tokenSuccess = false then
		LEAVE goodTimes;
	end if;
    /* End Token Check Block */


SET @q = CONCAT('
select 
l.id, l.uid, u.name as username, u.fbuid, l.lid, ln.name as listname, 
l.tid, tn.name as thingname, l.added, l.dittokey
, ml.id as mykey, dk.uid as dittouser, du.fbuid as dittofbuid, du.name as dittousername
, tc.`comment` as commentText, tc.`read` as commentRead, tc.`active` as commentActive , `l`.`uuid` 
from tlist l 
inner join tthing ln on l.lid = ln.id
inner join tthing tn on l.tid = tn.id
inner join tuser u on l.uid = u.id
left outer join tlist ml on ml.uid = ',@uid,' and ml.lid = l.lid and ml.tid = l.tid 
left outer join tlist dk on dk.id = l.dittokey
left outer join tuser du on du.id = dk.uid
left outer join tcomments tc on tc.itemid = l.id and tc.byuserid = ',@uid,'
where 
	l.tid = ',@thingid,' and l.state = 1
	and l.uid in (',@uid,',',@friendArray,')

union

select 
l.id, l.uid, "Anonymous" as username, 0 , l.lid, ln.name as listname, 
l.tid, tn.name as thingname, 0, 0
, ml.id as mykey, 0 as dittouser, 0 as dittofbuid, "Anonymous" as dittousername
, tc.`comment` as commentText, tc.`read` as commentRead, tc.`active` as commentActive , `l`.`uuid` 
from tlist l 
inner join tthing ln on l.lid = ln.id
inner join tthing tn on l.tid = tn.id
inner join tuser u on l.uid = u.id
left outer join tlist ml on ml.uid = ',@uid,' and ml.lid = l.lid and ml.tid = l.tid 
left outer join tlist dk on dk.id = l.dittokey
left outer join tuser du on du.id = dk.uid
left outer join tcomments tc on tc.itemid = l.id and tc.byuserid = ',@uid,'

where 
	l.tid = ',@thingid,' and l.state = 1
	and l.uid not in (',@uid,',',@friendArray,')
group by l.lid

')	
;

	prepare stmt from @q;
	execute stmt;
	deallocate prepare stmt;

-- select @q as q;
End;
call `spSqlLog_Timing` (@logKey );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `v2.0_thingid`(thetoken VARCHAR(36), thingname TEXT)
BEGIN

SET @thetoken = thetoken;



goodTimes:BEGIN
	/* Begin Token Check Block */
	SET @uid = '';
	SET @tokenSuccess = false;
    SET @friendArray = '';
	SET @errorMessage = '';
	SET @logKey = null;
	call `v2.0_checkToken`( 
		'v2.0_thingid',
		@thetoken, 
        CONCAT('call v2.0_thingid("',@thetoken,'","',thingname,'")'),
        @tokenSuccess, 
        @uid, 
        @friendArray, 
        @errorMessage,
		@logKey
	);
    
    if @tokenSuccess = false then
		LEAVE goodTimes;
	end if;
    /* End Token Check Block */


SET @thingname = thingname;

SET @thingid = fThingId(@thingname);

select @thingid as thingid;


END;
call `spSqlLog_Timing` (@logKey );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `v2.0_thingName`( thetoken VARCHAR(46), thingId INT(11))
BEGIN

SET @thingId = thingId;
select `name` as `thingName` from tthing where id = @thingId limit 1;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `v2.0_tokenCheck`( vtoken VARCHAR(36))
BEGIN

SET @token = vtoken;
SET @id = 0;
-- This is the user's token used on login. Check it, and extend it.
-- select id into @id from token where token = @token and active = 1 limit 1;

SET @id = (select id from token where token = @token and active = 1 limit 1);

if @id > 0 then
	update token set logincount = logincount + 1 where token = @token;
    select true as success, fbToken from token where id = @id;
else
	select false as success, true as error, "Invalid or expired token" as errortxt;	
end if;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `v2.0_userInfo`(thetoken VARCHAR(46), thisUserId INT(15) )
BEGIN


SET @thetoken = thetoken;
SET @thisUserId = thisUserId;

goodTimes:BEGIN
	/* Begin Token Check Block */
	SET @uid = '';
	SET @tokenSuccess = false;
    SET @friendArray = '';
	SET @errorMessage = '';
	SET @logKey = null;
	call `v2.0_checkToken`( 
		'v2.0_userInfo',
		@thetoken, 
        CONCAT('call v2.0_userInfo("',thetoken,'" )'),
        @tokenSuccess, 
        @uid, 
        @friendArray, 
        @errorMessage,
        @logKey
        );
    
    if @tokenSuccess = false then
		LEAVE goodTimes;
	end if;
    /* End Token Check Block */
    
    select `id` as `userId`, `name` as `userName`, `fbuid` from tuser where id = @thisUserId limit 1;
    
    
END;    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `ZDELETE_spAddToList`(thingName TEXT, listnameid INT, userid INT )
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
	insert into tlist (`lid`,`tid`,`uid`,`added`,`modified`,`state`,`uuid`)
	values (@listnameid, @thingId, @userid, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1, UUID() );

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
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `ZDELETE_spDitto`(userid INT, sourceuserid INT, thingid INT, 
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
	INSERT INTO tlist (`tid`, `lid`, `uid`, `state`, `added`, `modified`,`uuid`)
		VALUES (@thingid, @listid, @userid, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, UUID())
	on duplicate key update state = 1;
	
	SET @thekey = (select id from tlist where tid = @thingid and lid = @listid and uid = @userid limit 1);
	


	-- log the ditto - Working. 
		-- TODO2 - Handle what happens if a ditto is just returning something to its origional state.
	insert into tditto (`userid`, `sourceuserid`, `thingid`, `listid`, `added`, `read`)
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
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `ZDELETE_spDittosUser`(userId int, aboutUserIds TEXT)
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
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `ZDELETE_spFriendsFB`(
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
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `ZDELETE_spGetActivity`(userid INT, users TEXT, lastDate DATETIME)
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
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `ZDELETE_spLists`(
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
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `ZDELETE_spListsB`(
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
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `ZDELETE_spPlittoFriendsFromFb`(friendString TEXT)
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
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `ZDELETE_spThingId`(thingname TEXT)
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
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-01-23 19:38:42
