/*
SQLyog Trial v12.02 (64 bit)
MySQL - 5.6.16 : Database - plitto2014
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`plitto2014` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `plitto2014`;

/*Table structure for table `dblog` */

DROP TABLE IF EXISTS `dblog`;

CREATE TABLE `dblog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL,
  `query` text,
  `time` decimal(12,5) DEFAULT NULL,
  `sp` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5983 DEFAULT CHARSET=latin1 COMMENT='Log of Database calls.';

/*Table structure for table `log` */

DROP TABLE IF EXISTS `log`;

CREATE TABLE `log` (
  `idlog` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(45) DEFAULT NULL,
  `log` text,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlog`)
) ENGINE=MyISAM AUTO_INCREMENT=11852 DEFAULT CHARSET=latin1 COMMENT='For development';

/*Table structure for table `presentlist` */

DROP TABLE IF EXISTS `presentlist`;

CREATE TABLE `presentlist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL,
  `fromuid` int(11) DEFAULT NULL,
  `lid` int(11) DEFAULT NULL,
  `lastdate` datetime DEFAULT NULL,
  `presentcount` int(11) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UniquePL` (`uid`,`fromuid`,`lid`),
  KEY `pluid_idx` (`uid`),
  KEY `pllid_idx` (`lid`),
  CONSTRAINT `plfromuid` FOREIGN KEY (`uid`) REFERENCES `tuser` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `pllid` FOREIGN KEY (`lid`) REFERENCES `tthing` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `pluid` FOREIGN KEY (`uid`) REFERENCES `tuser` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7635 DEFAULT CHARSET=latin1;

/*Table structure for table `presentthing` */

DROP TABLE IF EXISTS `presentthing`;

CREATE TABLE `presentthing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL,
  `count` int(11) DEFAULT NULL,
  `lastdate` datetime DEFAULT NULL,
  `tlistkey` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tlistkey_UNIQUE` (`tlistkey`),
  KEY `ptuif_idx` (`uid`),
  KEY `pttlkey_idx` (`tlistkey`),
  CONSTRAINT `pttlkey` FOREIGN KEY (`tlistkey`) REFERENCES `tlist` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ptuif` FOREIGN KEY (`uid`) REFERENCES `tuser` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=23166 DEFAULT CHARSET=latin1;

/*Table structure for table `qlog` */

DROP TABLE IF EXISTS `qlog`;

CREATE TABLE `qlog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `call` text,
  `executeTime` decimal(12,5) DEFAULT NULL,
  `executed` datetime DEFAULT NULL,
  `userid` int(11) DEFAULT NULL,
  `proc` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `showsometemp` */

DROP TABLE IF EXISTS `showsometemp`;

CREATE TABLE `showsometemp` (
  `sstid` int(11) NOT NULL AUTO_INCREMENT,
  `id` int(11) DEFAULT NULL,
  `tid` int(11) DEFAULT NULL,
  `lid` int(11) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  `added` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `dittokey` int(11) DEFAULT NULL,
  `groupid` int(11) DEFAULT NULL,
  `dittoable` int(11) DEFAULT NULL,
  `lastshowncount` int(11) DEFAULT NULL,
  `lastshown` datetime DEFAULT NULL,
  `mykey` int(11) DEFAULT NULL,
  PRIMARY KEY (`sstid`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=latin1;

/*Table structure for table `tditto` */

DROP TABLE IF EXISTS `tditto`;

CREATE TABLE `tditto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) DEFAULT NULL,
  `sourceuserid` int(11) DEFAULT NULL,
  `thingid` int(11) DEFAULT NULL,
  `listid` int(11) DEFAULT NULL,
  `added` datetime DEFAULT NULL,
  `read` tinyint(4) DEFAULT NULL,
  `hidden` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fromuserid_idx` (`sourceuserid`),
  KEY `byuserid_idx` (`userid`),
  CONSTRAINT `byuserid` FOREIGN KEY (`userid`) REFERENCES `tuser` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fromuserid` FOREIGN KEY (`sourceuserid`) REFERENCES `tuser` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1852 DEFAULT CHARSET=latin1;

/*Table structure for table `temp_search` */

DROP TABLE IF EXISTS `temp_search`;

CREATE TABLE `temp_search` (
  `id` int(3) NOT NULL AUTO_INCREMENT,
  `type` varchar(10) DEFAULT NULL,
  `group` int(1) DEFAULT NULL,
  `groupName` varchar(20) DEFAULT NULL,
  `nameid` int(11) DEFAULT NULL,
  `name` text,
  `count` int(7) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

/*Table structure for table `temp_splists` */

DROP TABLE IF EXISTS `temp_splists`;

CREATE TABLE `temp_splists` (
  `id` int(11) DEFAULT NULL,
  `tid` int(11) DEFAULT NULL,
  `lid` int(11) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  `a` datetime DEFAULT NULL,
  `m` datetime DEFAULT NULL,
  `state` tinyint(1) DEFAULT NULL,
  `myKey` int(11) DEFAULT NULL,
  `listid` varchar(20) DEFAULT NULL,
  `show` tinyint(1) DEFAULT NULL,
  `grouporder` tinyint(1) DEFAULT NULL,
  `dittokey` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `tlist` */

DROP TABLE IF EXISTS `tlist`;

CREATE TABLE `tlist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tid` int(11) NOT NULL,
  `lid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `added` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `state` tinyint(1) DEFAULT '1',
  `dittokey` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`tid`,`lid`,`uid`),
  KEY `tuid_idx` (`uid`),
  KEY `lid_idx` (`lid`),
  KEY `dittokey_idx` (`dittokey`),
  CONSTRAINT `dittokey` FOREIGN KEY (`dittokey`) REFERENCES `tditto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `lid` FOREIGN KEY (`lid`) REFERENCES `tthing` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `tid` FOREIGN KEY (`tid`) REFERENCES `tthing` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `tuid` FOREIGN KEY (`uid`) REFERENCES `tuser` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=166328 DEFAULT CHARSET=latin1;

/*Table structure for table `token` */

DROP TABLE IF EXISTS `token`;

CREATE TABLE `token` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` varchar(100) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  `start` datetime DEFAULT NULL,
  `end` datetime DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `usecount` int(10) DEFAULT NULL,
  `friendsarray` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token_UNIQUE` (`token`),
  KEY `uidtoken_idx` (`uid`),
  CONSTRAINT `uidtoken` FOREIGN KEY (`uid`) REFERENCES `tuser` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=578 DEFAULT CHARSET=latin1;

/*Table structure for table `tthing` */

DROP TABLE IF EXISTS `tthing`;

CREATE TABLE `tthing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `added` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=8989 DEFAULT CHARSET=latin1;

/*Table structure for table `tuser` */

DROP TABLE IF EXISTS `tuser`;

CREATE TABLE `tuser` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `added` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `fbuid` bigint(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=725 DEFAULT CHARSET=latin1;

/* Function  structure for function  `duser` */

/*!50003 DROP FUNCTION IF EXISTS `duser` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `duser`() RETURNS int(11)
BEGIN

RETURN 2;
END */$$
DELIMITER ;

/* Function  structure for function  `dusers` */

/*!50003 DROP FUNCTION IF EXISTS `dusers` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `dusers`() RETURNS char(255) CHARSET latin1
BEGIN

RETURN '18,25,14,156,64,132,13,69,724,723,161,168,719';
END */$$
DELIMITER ;

/* Function  structure for function  `fThingId` */

/*!50003 DROP FUNCTION IF EXISTS `fThingId` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `fThingId`(newthingName TEXT) RETURNS int(11)
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


END */$$
DELIMITER ;

/* Procedure structure for procedure `adminDeleteUser` */

/*!50003 DROP PROCEDURE IF EXISTS  `adminDeleteUser` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `adminDeleteUser`()
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


END */$$
DELIMITER ;

/* Procedure structure for procedure `adminImportDittos` */

/*!50003 DROP PROCEDURE IF EXISTS  `adminImportDittos` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `adminImportDittos`()
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


END */$$
DELIMITER ;

/* Procedure structure for procedure `adminLog` */

/*!50003 DROP PROCEDURE IF EXISTS  `adminLog` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `adminLog`( searchString VARCHAR(255))
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

    END */$$
DELIMITER ;

/* Procedure structure for procedure `adminStressTest` */

/*!50003 DROP PROCEDURE IF EXISTS  `adminStressTest` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `adminStressTest`()
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

END */$$
DELIMITER ;

/* Procedure structure for procedure `log` */

/*!50003 DROP PROCEDURE IF EXISTS  `log` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `log`(title VARCHAR(255), log TEXT)
BEGIN

insert into log(`title`,`log`) VALUES (title,log);

END */$$
DELIMITER ;

/* Procedure structure for procedure `migrate` */

/*!50003 DROP PROCEDURE IF EXISTS  `migrate` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `migrate`()
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



END */$$
DELIMITER ;

/* Procedure structure for procedure `spAddToList` */

/*!50003 DROP PROCEDURE IF EXISTS  `spAddToList` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spAddToList`(thingName TEXT, listnameid INT, userid INT )
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

END */$$
DELIMITER ;

/* Procedure structure for procedure `spDitto` */

/*!50003 DROP PROCEDURE IF EXISTS  `spDitto` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spDitto`(userid INT, sourceuserid INT, thingid INT, 
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




END */$$
DELIMITER ;

/* Procedure structure for procedure `spDittosUser` */

/*!50003 DROP PROCEDURE IF EXISTS  `spDittosUser` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spDittosUser`(userId int, aboutUserIds TEXT)
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

END */$$
DELIMITER ;

/* Procedure structure for procedure `spFriendsFB` */

/*!50003 DROP PROCEDURE IF EXISTS  `spFriendsFB` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spFriendsFB`(
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

END */$$
DELIMITER ;

/* Procedure structure for procedure `spGetActivity` */

/*!50003 DROP PROCEDURE IF EXISTS  `spGetActivity` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spGetActivity`(userid INT, users TEXT, lastDate DATETIME)
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



END */$$
DELIMITER ;

/* Procedure structure for procedure `spLists` */

/*!50003 DROP PROCEDURE IF EXISTS  `spLists` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spLists`(
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

END */$$
DELIMITER ;

/* Procedure structure for procedure `spListsB` */

/*!50003 DROP PROCEDURE IF EXISTS  `spListsB` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spListsB`(
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

END */$$
DELIMITER ;

/* Procedure structure for procedure `spPlittoFriendsFromFb` */

/*!50003 DROP PROCEDURE IF EXISTS  `spPlittoFriendsFromFb` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spPlittoFriendsFromFb`(friendString TEXT)
BEGIN

call `spSqlLog`(0, CONCAT('call spPlittoFriendsFromFb("',friendString,'")'), 0, 'spPlittoFriendsFromFb');

SET @q = CONCAT('
select group_concat(id SEPARATOR ",") as puids from tuser where fbuid in (',friendString,')');

prepare stmt from @q;
execute stmt;
deallocate prepare stmt;

END */$$
DELIMITER ;

/* Procedure structure for procedure `spSqlLog` */

/*!50003 DROP PROCEDURE IF EXISTS  `spSqlLog` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spSqlLog`(userId INT, thequery TEXT, logtime DECIMAL(12,5), sp VARCHAR(45))
BEGIN

insert into dblog(`userId`,`query`,`time`,`sp`)
VALUES (userId, thequery, logtime, sp);

END */$$
DELIMITER ;

/* Procedure structure for procedure `spThingId` */

/*!50003 DROP PROCEDURE IF EXISTS  `spThingId` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spThingId`(thingname TEXT)
BEGIN


call `spSqlLog`(0, CONCAT('call spThingId("',thingname,'")'), 0, 'spThingId');

SET @thingname = thingname;

SET @thingid = fThingId(@thingname);

select @thingid as thingid;

END */$$
DELIMITER ;

/* Procedure structure for procedure `v2.0_addtolist` */

/*!50003 DROP PROCEDURE IF EXISTS  `v2.0_addtolist` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `v2.0_addtolist`( thetoken VARCHAR(36), thingName TEXT, listnameid INT )
BEGIN


SET @thetoken = thetoken;

call `spSqlLog`(0, CONCAT('call v2.0_addtolist("',@thetoken,'","',thingName,'","',listnameid,'")'), 0, 'v2.0_addtolist');


proc_label:BEGIN

SET @uid = null;
SET @friendsarray = null;

select uid, friendsarray into @uid, @friendsarray from token where token = @thetoken limit 1;


if @uid != ceil(@uid) or @uid is null then
	select 'Invalid token' as errortxt, true as error
		,@thetoken as thetoken, @uid as theuid, ceil(@uid) as ceiluid, @friendsarray as friendsarray
	;
	LEAVE proc_label;
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
	insert into tlist (`lid`,`tid`,`uid`,`added`,`modified`,`state`)
	values (@listnameid, @thingId, @uid, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 1);

	SET @thekey =  LAST_INSERT_ID();

end if;

SELECT @thekey as thekey, tlist.tid as thingid, 
	@userid_listnameid as listkey, 
	@thingName as thingname, 
	tthing.name as listname,
	@listnameid as lid
from tlist
inner join tthing on tthing.id = @listnameid 
where tlist.tid = @thingId and tlist.uid = @uid
limit 1

;
End; -- Ends the proclabel.
END */$$
DELIMITER ;

/* Procedure structure for procedure `v2.0_ditto` */

/*!50003 DROP PROCEDURE IF EXISTS  `v2.0_ditto` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `v2.0_ditto`(
	thetoken VARCHAR(36), 
	sourceuserid INT, 
	thingid INT, 
	listid INT, 
	theaction VARCHAR(20) 
)
BEGIN

-- Sample: call spDitto("1","2","7779","7772","ditto","2,14,13")
call `spSqlLog`(0, CONCAT('call v2.0_ditto("',thetoken,'","',sourceuserid,'","',thingid,'","',listid,'","',theaction,'")'), 0, 'v2.0_ditto');


SET @thetoken = thetoken;

-- Process the variablesSET @sourceuserid = sourceuserid;
SET @thingid = thingid;
SET @listid = listid;
SET @theaction = theaction;
SET @sourceuserid = sourceuserid;


proc_label:BEGIN

-- Clear existing variables.
SET @uid = null;
SET @friendsarray = null;


-- Get the user from the token.
select uid, friendsarray into @uid, @friendsarray from token where token = @thetoken limit 1;


if @uid != ceil(@uid) or @uid is null then
	select 'Invalid token' as errortxt, true as error
		,@thetoken as thetoken, @uid as theuid, ceil(@uid) as ceiluid, @friendsarray as friendsarray
	;
	LEAVE proc_label;
end if;



if @theaction LIKE 'ditto' then 
	-- INSERT INTO TLIST
	INSERT INTO tlist (tid, lid, uid, state, added, modified)
		VALUES (@thingid, @listid, @uid, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
	on duplicate key update state = 1;
	
	SET @thekey = (select id from tlist where tid = @thingid and lid = @listid and uid = @uid limit 1);
	


	-- log the ditto - Working. 
		-- TODO2 - Handle what happens if a ditto is just returning something to its origional state.
	insert into tditto (userid, sourceuserid, thingid, listid, `added`, `read`)
	values (@uid, @sourceuserid, @thingid, @listid, CURRENT_TIMESTAMP, 0);

	-- Get the ditto key - FAILING
	SET @dittokey = 15;

	SET @dkq = CONCAT('
	SET @dittokey = (
		select id 
		from tditto 
		where 
			userid = ',CAST(@uid as CHAR(10)),' and 
			sourceuserid = ',CAST(@sourceuserid as CHAR(10)),' and 
			thingid = ',CAST(@thingid as CHAR(10)),' and 
			listid = ',CAST(@listid as CHAR(10)),' 
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
	-- SELECT @thekey as thekey;
	
	SET @theQ = CONCAT('
	select 
		l.id as thekey, l.tid, t.name as thingname, l.lid, 
		ln.name as listname, count(*) as friendsWith
	from tlist l
	inner join tthing t on t.id = l.tid
	inner join tthing ln on ln.id = l.lid
	where l.tid = ',@thingid,' and l.lid = ',@listid,' and l.uid in (',@friendsarray,')
	group by l.tid, l.lid');

	prepare stmt from @theQ;
	execute stmt;
	deallocate prepare stmt;

elseif @theaction LIKE 'remove' then 
	-- Set the state to 0.
	UPDATE tlist SET state = 0 where tid = @thingid and lid = @listid and uid = @uid limit 1;


	-- Remove the notification and hide the ditto log.
	update tditto set hidden = 1, `read` = 1
	where userid = @uid and sourceuserid = @sourceuserid and thingid = @thingid and listid = @listid
	limit 1;

	SELECT true as success;
	
end if;


END;


END */$$
DELIMITER ;

/* Procedure structure for procedure `v2.0_fbLogin` */

/*!50003 DROP PROCEDURE IF EXISTS  `v2.0_fbLogin` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `v2.0_fbLogin`(
	fbuid BIGINT, fbname VARCHAR(255), fbemail VARCHAR(255) , fbfriendsarray TEXT)
BEGIN
/*
	Returns a token for this user's session.
		Token masks: user id, start time, usage count, and list of friends.
		All session handling moves into the token arena. All other stored procs should use the token as a way to handle this.
*/
call `spSqlLog`(0, CONCAT('call `v2.0_fbLogin`("',fbuid,'","',fbname,'","',fbemail,'","',fbfriendsarray,'")'), 0, 'v2.0_fbLogin');
SET @fbuid = fbuid;
SET @fbname = fbname;
SET @fbemail = fbemail;
SET @fbfriendsarray = fbfriendsarray;
-- Clear the UserIds
SET @puid = null;
SET @active = null;
SET @username = null;
SET @email = null;
-- Step 1 -- see if this account already exists. If so create some variables to hold their information.
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
-- Step 2 -- See if there are updates to make
elseif @active != 1 or @username != fbname or @email != fbemail then
	update tuser set `name` = @fbname, email = @fbemail where id = @puid limit 1;
	SET @result = CONCAT(@result,' | Update account information');
end if;
-- STEP -- We should have a valid user at this point. Get the plitto IDs from their friends based on the facebook IDs passed in as fbfriendsarray.
SET @friendquery = CONCAT('select GROUP_CONCAT(id) INTO @friendids from tuser where fbuid in (',@fbfriendsarray,')');
 prepare stmt from @friendquery;
	execute stmt;
	deallocate prepare stmt;
-- STEP - Create the token for this user.
if ceil(@puid) = @puid then
	-- update token set `end` = CURRENT_TIMESTAMP, active = 0 where uid = @puid and active = 1 limit 1;
	SET @token = '';
	-- See if this user has a valid token already.
	SELECt token into @token from token where uid = @uid and active = 1 limit 1;
	
	if CHAR_LENGTH(@token) = 0 then
		
	
		-- Create a token
		SET @token = MD5(CONCAT('!%!connect!%!',UUID()));
		insert into token (`token`,`uid`,`start`,`active`,`usecount`,`friendsarray`) VALUES (@token,@puid,CURRENT_TIMESTAMP,1,1, @friendids  );
	END IF;
	
end if;
select @puid as puid, @username as username, @fbuid as fbuid, @token as token, @friendids as friendids; 
/*
*/
-- 
END */$$
DELIMITER ;

/* Procedure structure for procedure `v2.0_feed` */

/*!50003 DROP PROCEDURE IF EXISTS  `v2.0_feed` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`theuser`@`%` PROCEDURE `v2.0_feed`(thetoken VARCHAR(36),  thetype VARCHAR(10), userfilter VARCHAR(10), listfilter VARCHAR(10), mystate VARCHAR(10), oldestKey INT)
BEGIN
SET @thetoken = thetoken;
SET @thetype = thetype;
SET @userfilter = userfilter;
SET @listfilter = listfilter;
SET @mystate = mystate; -- This is the 
SET @oldestKey = oldestKey;
proc_label:BEGIN
	select uid, friendsarray into @uid, @friendsarray from token where token = @thetoken limit 1;
	if @uid != ceil(@uid) or @uid is null then
		select 'Invalid token' as errortxt, true as error
			,@thetoken as thetoken, @uid as theuid, ceil(@uid) as ceiluid, @friendsarray as friendsarray
		;
		LEAVE proc_label;
	end if;
	select uid, friendsarray into @uid, @friendsarray from token where token = @thetoken and active = 1 limit 1;
	if @uid != ceil(@uid) or @uid is null then
		select 'Invalid token' as errortxt, true as error
			,@thetoken as thetoken, @uid as theuid, ceil(@uid) as ceiluid, @friendsarray as friendsarray
		;
		LEAVE proc_label;
	end if;
	update token set usecount = usecount + 1 where token = @thetoken and id > 0 limit 1;
	
	if @thetype = 'list' then
		-- select 'list' as showthis;
		SET @qfilter = CONCAT(' and l.lid = ', @listfilter);
	elseif @thetype = 'profile' then 
		if CHAR_LENGTH(@userfilter) = 0 THEN
			select true as error, 'Profile cannot be null for the user filter' as errortxt;
			
			LEAVE proc_label;
		end if;
		SET @qfilter = CONCAT(' and l.uid = ', @userfilter);
	else 
		SEt @thisnote = 'Unknown filter';
		SET @qfilter = '';
	end if;
	IF CHAR_LENGTH(@oldestKey) > 0 then
		SET @oldestFilter = CONCAT(' and l.id > ',@oldestKey);
	else 
		SET @oldestFilter = '';
	end if;
SET @q = CONCAT(
'select 
	l.id,
	l.uid, un.name as username, un.fbuid as fbuid,
	l.lid, ln.name as listname, 
	l.tid, tn.name as thingname,
	l.added, l.state, l.dittokey, dk.uid as dittouser, du.name as dittousername, du.fbuid as dittofbuid,
	ml.id as mykey
	
from tlist l
inner join tthing ln on ln.id = l.lid 
inner join tthing tn on tn.id = l.tid 
inner join tuser un on un.id = l.uid
left outer join tlist dk on dk.id = l.dittokey 
left outer join tuser du on du.id = dk.uid
left outer join tlist ml on ml.uid = ',@uid,' and ml.lid = l.lid and ml.tid = l.tid and ml.state = 1
where 
l.state = 1
and l.uid in (',@uid,',',@friendsarray,') ',
@qfilter, @oldestFilter,
' order by l.id desc
limit 50');
prepare stmt from @q; execute stmt; deallocate prepare stmt;
-- 
-- select @q;
END;
END */$$
DELIMITER ;

/* Procedure structure for procedure `v2.0_friends` */

/*!50003 DROP PROCEDURE IF EXISTS  `v2.0_friends` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `v2.0_friends`(
	thetoken VARCHAR(36)
)
BEGIN

SET @thetoken = thetoken;

-- select @thetoken as thetokentest;

proc_label:BEGIN


select uid, friendsarray into @uid, @friendsarray from token where token = @thetoken limit 1;


if @uid != ceil(@uid) or @uid is null then
	select 'Invalid token' as errortxt, true as error
		,@thetoken as thetoken, @uid as theuid, ceil(@uid) as ceiluid, @friendsarray as friendsarray
	;
	LEAVE proc_label;
end if;

-- Get the list of this user's friends, based on their token.

SELECT uid, friendsarray into @uid, @friendsarray from token where token = @token and active =1;
UPDATE token set usecount = usecount + 1 where token = @token limit 1;
-- select @uid, @friendsarray;


call `spSqlLog`('0', CONCAT('call v2.0_friends("',@token,'")'), 0, 'v2.0_friends');

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
	u.id in (',@friendsarray,')
	
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


END */$$
DELIMITER ;

/* Procedure structure for procedure `v2.0_GetMore` */

/*!50003 DROP PROCEDURE IF EXISTS  `v2.0_GetMore` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `v2.0_GetMore`(
	thetoken VARCHAR(36),
	
	forUserIDs TEXT ,

	thetype VARCHAR(20),
	theId varchar(20), 
	thenot TEXT
)
BEGIN

call `spSqlLog`(0, CONCAT('call `v2.0_GetMore`("',thetoken,'","',forUserIDs,'","',thetype,'","',theId,'","',thenot,'")'), 0, 'v2.0_GetMore');

SET @thetoken = thetoken;

-- Create variables for this session.
SET @thetype = thetype;

SET @forUserIds = forUserIDs;

SET @theId = theId; -- The user or list id.


proc_label:BEGIN

-- Clear existing variables.
SET @uid = null;
SET @friendsarray = null;



-- Get the user from the token.
select uid, friendsarray into @uid, @friendsarray from token where token = @thetoken limit 1;


if @uid != ceil(@uid) or @uid is null then
	select 'Invalid token' as errortxt, true as error
		,@thetoken as thetoken, @uid as theuid, ceil(@uid) as ceiluid, @friendsarray as friendsarray
	;
	LEAVE proc_label;
end if;

-- Default to their friends if it is null 
if char_length(@forUserIDs) > 0 then
	SET @forUserIDs = forUserIDs; -- For the specific friend.
else
	-- Default to them, and their friends if it looks like that's a good idea.
	SET @forUserIDs = CONCAT(@uid,',',@friendsarray);
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
set @thefields = ' a.id, a.tid, a.lid, a.added, a.modified, a.state, a.dittokey ';
-- set @insertTable = 'insert into temp_splists (`id`,`tid`,`lid`,`uid`,`a`,`m`,`duid`,`state`,`myKey`)';
set @insertTable = 'insert into temp_splists (`id`,`tid`,`lid`,`a`,`m`,`state`,`dittokey`,`uid`,`myKey`,`show`,`listid`,`grouporder`)';

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
		' select ', @thefields,', a.uid , a.id, 1 , CONCAT(a.uid,"_",a.lid) as listid, 1 as grouporder
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
		left outer join tlist b on b.lid = a.lid and b.tid = a.tid and b.state = 1 and b.uid = ',@uid,' 
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
		inner join tlist b on b.lid = a.lid and b.tid = a.tid and b.state = 1 and b.uid = ',@uid,'
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
		left outer join tlist b on b.lid = a.lid and b.tid = a.tid and b.uid = ',@uid,' and b.state =1 and b.id is null
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
	where uid != @uid


	UNION
	select t.id, t.tid, t.lid, t.uid, t.a, t.m, t.state, t.myKey , t.dittokey
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

	;


END;

END */$$
DELIMITER ;

/* Procedure structure for procedure `v2.0_getSome` */

/*!50003 DROP PROCEDURE IF EXISTS  `v2.0_getSome` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `v2.0_getSome`(
	thetype VARCHAR(10)	-- List or User or Null
	, thetoken VARCHAR(36)	
	, theuserfilter TEXT
	, thelistfilter TEXT
	, theSharedFilter VARCHAR(10)
)
BEGIN
SET @thetype = thetype;
SET @thetoken = thetoken;
SET @userfilter = theuserfilter;
SET @thelistfilter = thelistfilter;
SET @uid = NULL;
SET @friendsarray = NULL;
SET @defaultLimit = 1;
SET @showStrangers = TRUE; -- This is for the strangers part. Only don't show from others if the user filter is set.
SET @sharedFilter = theSharedFilter; -- Will be 'ditto' or 'shared' or 'all'
-- Log this query.
CALL `spSqlLog`(0, CONCAT('call `v2.0_getSome`("',@thetype,'","',@thetoken,'","',@userfilter,'","',@thelistfilter,'", "',@sharedFilter,'")'), 0, 'v2.0_getSome');
-- Create a procedure that we can bail out of.
proc_label:BEGIN
	SELECT uid, friendsarray INTO @uid, @friendsarray FROM token WHERE token = @thetoken AND active = 1 LIMIT 1;
	IF @uid != CEIL(@uid) OR @uid IS NULL THEN
		SELECT 'Invalid token' AS errortxt, TRUE AS error
			,@thetoken AS thetoken, @uid AS theuid, CEIL(@uid) AS ceiluid, @friendsarray AS friendsarray
		;
		LEAVE proc_label;
	END IF;
	
-- Log that the token was used.
UPDATE token SET usecount = usecount + 1 WHERE token = @thetoken AND id > 0 LIMIT 1;
	-- If this user has more than three friends, do something different.
	SET @friendCount = CHAR_LENGTH(@friendsarray) - CHAR_LENGTH(REPLACE(@friendsarray,',',''));
	
-- For someone with at least 10 friends, filter out ther things.
IF CHAR_LENGTH(@userfilter) = 0 AND @friendCount > 10 THEN
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
			
ELSEIF CHAR_LENGTH(@userfilter) > 0 THEN
			SET @friendOverload = CONCAT(' and l.uid = ',@userfilter);
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
-- Get some content from the user's friends frist, then optionally, from strangers.
/* BEGIN POPULATING VARIABLES TO USE TO SELECT FROM MY FRIENDS */
	-- Batch A - A list from a friend that I also have, with at least 3 dittoable things in it, that I don't have. 
		-- ',@mylists,' -- This would only show lists that I already have. That seems limiting.
	SET @batchA = CONCAT('select 
	l.uid, l.lid, COUNT(l.id) - COUNT(m.id) AS dittoable, COUNT(l.id) AS thecount, COUNT(m.id) as shared INTO @Auid, @Alid, @Adittoable, @Acount, @Ashared
	from tlist l
	left outer join tlist m on m.lid = l.lid and m.tid=l.tid and m.uid = ',@uid,' 
	left outer join presentlist pl on pl.uid = ',@uid,' and pl.fromuid = l.uid and pl.lid = l.lid
where 
		l.uid in (',@friendsarray,') 
		and l.state = 1
		
		',@friendOverload,' ',@listOverload ,' ',@myKeyFilter,'
	group by l.lid,l.uid
	',@havingShared,'
	order by pl.lastdate asc
	limit 1')
	;
	SET @batchA = CAST(@batchA AS CHAR CHARACTER SET UTF8);
	-- 	SELECT 'batcha' AS context;
-- 
	-- select @batchA as batchA, @uid as uid, @friendsarray as friendsarray, @mylists as mylists, @friendOverload as friendoverload;
-- 	
	PREPARE stmt FROM @batchA;	EXECUTE stmt;	DEALLOCATE PREPARE stmt;
	
	-- if we don't have a valid user, then bail.
	IF CHAR_LENGTH(@Auid) = 0 OR CHAR_LENGTH(@Alid) = 0 THEN
		SELECT TRUE AS error, 'no users meet your criteria' AS errortxt;
		LEAVE proc_label;
	END IF;
	
	-- Batch B - A list from us, that is not the same as the first list.
		-- ',@notmylists,' -- This would show only lists that I do not have. Maybe for specific users.
	IF CHAR_LENGTH(@userfilter) = 0 THEN
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
			l.uid in (',@friendsarray,')  
			
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
			l.uid in (',@friendsarray,')  
			
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
		l.uid not in (',@uid,',',@friendsarray,')  ',@myKeyFilter,'
		
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
		l.uid not in (',@uid,',',@friendsarray,')  
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
		mykey )
	SELECT l.id, l.tid, l.lid, l.uid, l.added, l.modified, l.state, l.dittokey, 1, ',@Adittoable,'
		, pt.count, pt.lastdate
		, m.id
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
		mykey )
	SELECT l.id, l.tid, l.lid, l.uid, l.added, l.modified, l.state, l.dittokey, 2, ',@Bdittoable,'
		, pt.count, pt.lastdate
		, m.id
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
		mykey )
	select l.id, l.tid, l.lid, 0, l.added, l.modified, l.state, l.dittokey, 3, ',@Cdittoable,', pt.count, pt.lastdate, m.id
	from tlist l
	left outer join tlist m on m.uid = ',@uid,'
	 and m.lid = l.lid and m.tid = l.tid and m.state = 1
	left outer join presentthing pt on pt.tlistkey = l.id and pt.uid = ',@uid,' 
	where l.uid not in (',@uid,',',@friendsarray,') and l.lid = ',@Clid,' and l.state = 1 ',@myKeyFilter ,'
	order by pt.lastdate asc
	limit 10');
	-- 
	PREPARE stmt FROM @insertC;	EXECUTE stmt;	DEALLOCATE PREPARE stmt;
END IF;
-- INSERT RESULTS FROM D if it's valid.
IF CHAR_LENGTH(@Dlid) > 0 AND CHAR_LENGTH(@Duid) > 0 THEN
	SET @insertD = CONCAT('INSERT INTO showsometemp(id,tid,lid,uid,added,modified,state, dittokey, groupid, dittoable, lastshowncount , lastshown, mykey )
	select l.id, l.tid, l.lid, 0, l.added, l.modified, l.state, l.dittokey, 4, ',@Ddittoable,', pt.count, pt.lastdate, m.id
	from tlist l
	left outer join tlist m on m.uid = ',@uid,' and m.lid = l.lid and m.tid = l.tid
	left outer join presentthing pt on pt.tlistkey = l.id and pt.uid = ',@uid,' 
	where l.uid not in (',@uid,',',@friendsarray,') and l.lid = ', @Dlid ,' and l.state = 1 ',@myKeyFilter ,'
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
s.id, s.uid, un.name AS username, un.fbuid,  s.lid, lna.name AS listname, s.tid
, tn.name AS thingname,   s.added, s.state, s.dittokey AS dittokey, s.dittoable , s.groupid
, dk.uid AS dittouser, du.name AS dittousername, du.fbuid AS dittofbuid, lastshowncount, lastshown
, mykey AS mykey
FROM showsometemp s
INNER JOIN tthing tn ON tn.id = s.tid
INNER JOIN tuser un ON un.id = s.uid
INNER JOIN tthing lna ON lna.id = s.lid
LEFT OUTER JOIN tlist dk ON dk.id = s.dittokey 
LEFT OUTER JOIN tuser du ON du.id = dk.uid
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
END */$$
DELIMITER ;

/* Procedure structure for procedure `v2.0_listOfLists` */

/*!50003 DROP PROCEDURE IF EXISTS  `v2.0_listOfLists` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `v2.0_listOfLists`(thetoken VARCHAR(36), userfilter TEXT, toIgnore TEXT)
BEGIN

SET @thetoken = thetoken;

call `spSqlLog`(0, CONCAT('call v2.0_listOfLists("',thetoken,'","',userfilter,'","',toIgnore,'")'), 0, 'v2.0_listOfLists');


proc_label:BEGIN

	SET @uid = null;
	SET @friendsarray = null;

	select uid, friendsarray into @uid, @friendsarray from token where token = @thetoken limit 1;


	if @uid != ceil(@uid) or @uid is null then
		select 'Invalid token' as errortxt, true as error
			,@thetoken as thetoken, @uid as theuid, ceil(@uid) as ceiluid, @friendsarray as friendsarray
		;
		LEAVE proc_label;
	end if;

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
END */$$
DELIMITER ;

/* Procedure structure for procedure `v2.0_listSearch` */

/*!50003 DROP PROCEDURE IF EXISTS  `v2.0_listSearch` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `v2.0_listSearch`(thetoken VARCHAR(36), searchTerm TEXT)
BEGIN

call `spSqlLog`(0, CONCAT('call `v2.0_listSearch`("',thetoken,'","',searchTerm,'")'), 0, 'v2.0_listSearch');

SET @thetoken = thetoken;
SET @searchTerm = searchTerm;

proc_label:BEGIN


select uid, friendsarray into @uid, @friendsarray from token where token = @thetoken limit 1;


if @uid != ceil(@uid) or @uid is null then
	select 'Invalid token' as errortxt, true as error
		,@thetoken as thetoken, @uid as theuid, ceil(@uid) as ceiluid, @friendsarray as friendsarray
	;
	LEAVE proc_label;
end if;





select a.lid, b.name as listname, count(*) as thecount 

from tlist a 
inner join tthing b on b.id=  a.lid

where b.name like CONCAT('%',@searchTerm ,'%')
-- and a.userid in (1,2,3,4,5,6,7,8,9,10,13,168,19,18,17,16,15,14,13,12,11)
group by a.lid
order by thecount desc
limit 10;

end;

END */$$
DELIMITER ;

/* Procedure structure for procedure `v2.0_loadList` */

/*!50003 DROP PROCEDURE IF EXISTS  `v2.0_loadList` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `v2.0_loadList`(
			thetoken VARCHAR(36),
			theType 	VARCHAR(10),
			listId		INT,
			userFilter int,
			oldestKey INT,
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
    
    CALL `spSqlLog`(0, CONCAT('call `v2.0_loadList`("',@thetoken,'","',@thetype,'","',@listId,'")'), 0, 'v2.0_loadList');
-- Create a procedure that we can bail out of.
proc_label:BEGIN
	SELECT uid, friendsarray INTO @uid, @friendsarray FROM token WHERE token = @thetoken AND active = 1 LIMIT 1;
	IF @uid != CEIL(@uid) OR @uid IS NULL THEN
		SELECT 'Invalid token' AS errortxt, TRUE AS error
			,@thetoken AS thetoken, @uid AS theuid, CEIL(@uid) AS ceiluid, @friendsarray AS friendsarray
		;
		LEAVE proc_label;
	END IF;
	
	-- Build the criteria variables
	SELECT uid, friendsarray INTO @uid, @friendsarray FROM token WHERE token = @thetoken AND active = 1 LIMIT 1;
	
	IF @uid != CEIL(@uid) OR @uid IS NULL THEN
		SELECT 'Invalid token' AS errortxt, TRUE AS error
			,@thetoken AS thetoken, @uid AS theuid, CEIL(@uid) AS ceiluid, @friendsarray AS friendsarray
		;
		LEAVE proc_label;
	END IF;
	
	-- Oldest ID Criteria - for loading items older than the oldest id
	IF @oldestKey > 0 THEN
		SET @oldestKeyCriteria = CONCAT(' and l.id < ',@oldestKey);
	ELSE
		SET @oldestKeyCriteria = '';
	END if;
	
-- Make the per-type criterias.	
	if @theType = "ditto" then
		SET @userCriteria = CONCAT(' and l.uid in (' , @friendsarray , ')');
	
	elseif @theType = 'shared' then
		SET @userCriteria = CONCAT(' and l.uid in (' , @friendsarray,')');
	
	ELSEIF @theType = 'mine' THEN
		SET @userCriteria = CONCAT(' and l.uid = ' , @uid);
	
	ELSEIF @theType = 'feed' THEN
		SET @userCriteria = CONCAT(' and l.uid in (', @friendsarray , ',', @uid,') ' );
	
	ELSEIF @theType = 'strangers' THEN
		SET @userCriteria = CONCAT(' and l.uid not in (' , @friendsarray , ',', @uid,') ' );
	
	ELSE
		select true as error, 'unknown request' as errortxt;
		LEAVE proc_label;
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
	mykey INT
	
	, PRIMARY KEY (sstid)
);		
		
-- Start with Feed, which has a different query
	if @theType = 'feed' then		
		SET @q = CONCAT('
		select l.id, l.uid, un.name AS username, un.fbuid,  
		l.lid, lna.name AS listname, l.tid
			, tn.name AS thingname,   
			l.added, l.state, 
			l.dittokey AS dittokey
			, dk.uid AS dittouser, 
			du.name AS dittousername, 
			du.fbuid AS dittofbuid, 
			m.id as mykey
		from tlist l
			INNER JOIN tthing tn ON tn.id = l.tid
			INNER JOIN tuser un ON un.id = l.uid
			INNER JOIN tthing lna ON lna.id = l.lid
			LEFT OUTER JOIN tlist dk ON dk.id = l.dittokey 
			LEFT OUTER JOIN tuser du ON du.id = dk.uid
			LEFT OUTER JOIN tlist m on m.uid = ',@uid,' and m.lid = l.lid and m.tid = l.tid and m.state = 1
		where 
			l.state = 1 ',@userCriteria,' ',@oldestKeyCriteria,'
			and l.lid =',@listId,'
		order by l.id desc
		limit 30');
		prepare stmt from @q; 	execute stmt; 	deallocate prepare stmt;
		-- select @q as thequery;
		
	ELSEIF @theType = 'mine' THEN		
		SET @q = CONCAT('
		select l.id, l.uid, un.name AS username, un.fbuid,  
		l.lid, lna.name AS listname, l.tid
			, tn.name AS thingname,   
			l.added, l.state, 
			l.dittokey AS dittokey
			, dk.uid AS dittouser, 
			du.name AS dittousername, 
			du.fbuid AS dittofbuid, 
			m.id as mykey
		from tlist l
			INNER JOIN tthing tn ON tn.id = l.tid
			INNER JOIN tuser un ON un.id = l.uid
			INNER JOIN tthing lna ON lna.id = l.lid
			LEFT OUTER JOIN tlist dk ON dk.id = l.dittokey 
			LEFT OUTER JOIN tuser du ON du.id = dk.uid
			LEFT OUTER JOIN tlist m on m.uid = ',@uid,' and m.lid = l.lid and m.tid = l.tid and m.state = 1
		where 
			l.state = 1 ',@userCriteria,' ',@oldestKeyCriteria,'
			and l.lid =',@listId,'
		order by l.id desc
		limit 30');
		PREPARE stmt FROM @q; 	EXECUTE stmt; 	DEALLOCATE PREPARE stmt;
		-- select @q as thequery;
		
	ELSEIF @theType = 'ditto' THEN
			SET @q = CONCAT('
		INSERT INTO showsometemp(`id`,`tid`,`lid`,`uid`,`added`,`modified`,`dittokey`,`mykey`)
		select l.id, l.tid, l.lid, l.uid, l.added, l.modified, l.dittokey AS dittokey, m.id
		from tlist l
			LEFT OUTER JOIN tlist dk ON dk.id = l.dittokey 
			LEfT OUTER JOIN presentthing pt on pt.tlistkey = l.id 
			left outer join tlist m on m.uid = ',@uid,' and m.lid = l.lid and m.tid = l.tid and m.state = 1
		where 
			l.state = 1 ',@userCriteria,' ',@oldestKeyCriteria,'
			and l.lid =',@listId,'
			and m.id is null
		order by pt.lastdate asc 
		limit 30');
		PREPARE stmt FROM @q; 	EXECUTE stmt; 	DEALLOCATE PREPARE stmt;
		
		-- Join the items and return them.
		select  
		s.id, s.uid, u.name as username, u.fbuid,
		s.lid, lna.name as listname, s.tid, tn.name as thingname,
		s.added, s.state, s.dittokey, dk.uid as dittouser, du.name as dittousername, du.fbuid as dittofbuid, s.mykey
		from showsometemp s
			inner join tuser u on u.id = s.uid 
			inner join tthing lna ON lna.id = s.lid
			inner join tthing tn on tn.id = s.tid
			LEFT OUTER JOIN tlist dk ON dk.id = s.dittokey 
			LEFT OUTER JOIN tuser du ON du.id = dk.uid
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
		INSERT INTO showsometemp(`id`,`tid`,`lid`,`uid`,`added`,`modified`,`dittokey`,`mykey`)
		select l.id, l.tid, l.lid, l.uid, l.added, l.modified, l.dittokey AS dittokey, m.id
		from tlist l
			LEFT OUTER JOIN tlist dk ON dk.id = l.dittokey 
			LEFT OUTER JOIN tlist m on m.uid = ',@uid,' and m.lid = l.lid and m.tid = l.tid and m.state = 1
			LEfT OUTER JOIN presentthing pt on pt.tlistkey = l.id 
		where 
			l.state = 1 ',@userCriteria,' ',@oldestKeyCriteria,'
			and l.lid =',@listId,'
			and m.id is not null
		order by pt.lastdate asc 
		limit 30');
		PREPARE stmt FROM @q; 	EXECUTE stmt; 	DEALLOCATE PREPARE stmt;
		
		-- Join the items and return them.
		SELECT  
		s.id, s.uid, u.name AS username, u.fbuid,
		s.lid, lna.name AS listname, s.tid, tn.name AS thingname,
		s.added, 1, s.dittokey, dk.uid AS dittouser, du.name AS dittousername, du.fbuid AS dittofbuid, s.mykey
		FROM showsometemp s
			INNER JOIN tuser u ON u.id = s.uid 
			INNER JOIN tthing lna ON lna.id = s.lid
			INNER JOIN tthing tn ON tn.id = s.tid
			LEFT OUTER JOIN tlist dk ON dk.id = s.dittokey 
			LEFT OUTER JOIN tuser du ON du.id = dk.uid
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
		INSERT INTO showsometemp(`id`,`tid`,`lid`,`uid`,`added`,`modified`,`dittokey`,`mykey`)
		select l.id, l.tid, l.lid, l.uid, l.added, l.modified, l.dittokey AS dittokey, m.id
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
		s.id, 0 as `uid`, 'Stranger' AS username, 0 as `fbuid`,
		s.lid, lna.name AS listname, s.tid, tn.name AS thingname,
		s.added, 1, s.dittokey, dk.uid AS dittouser, du.name AS dittousername, du.fbuid AS dittofbuid, s.mykey
		FROM showsometemp s
			-- INNER JOIN tuser u ON u.id = s.uid 
			INNER JOIN tthing lna ON lna.id = s.lid
			INNER JOIN tthing tn ON tn.id = s.tid
			LEFT OUTER JOIN tlist dk ON dk.id = s.dittokey 
			LEFT OUTER JOIN tuser du ON du.id = dk.uid
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
				
			
	/*
	
	SELECT 
s.id, s.uid, un.name AS username, un.fbuid,  s.lid, lna.name AS listname, s.tid
, tn.name AS thingname,   s.added, s.state, s.dittokey AS dittokey, s.dittoable , s.groupid
, dk.uid AS dittouser, du.name AS dittousername, du.fbuid AS dittofbuid, lastshowncount, lastshown
, mykey AS mykey
FROM showsometemp s
INNER JOIN tthing tn ON tn.id = s.tid
INNER JOIN tuser un ON un.id = s.uid
INNER JOIN tthing lna ON lna.id = s.lid
LEFT OUTER JOIN tlist dk ON dk.id = s.dittokey 
LEFT OUTER JOIN tuser du ON du.id = dk.uid
;
*/
	
end;
END */$$
DELIMITER ;

/* Procedure structure for procedure `v2.0_search` */

/*!50003 DROP PROCEDURE IF EXISTS  `v2.0_search` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `v2.0_search`(thetoken VARCHAR(36), term VARCHAR(255))
BEGIN
SET @thetoken = thetoken;
set @term = term;
call `spSqlLog`(0, CONCAT('call `v2.0_search`("',@thetoken,'","',@term,'")'), 0, 'v2.0_search');
proc_label:BEGIN
	select uid, friendsarray into @uid, @friendsarray from token where token = @thetoken and active = 1 limit 1;
	if @uid != ceil(@uid) or @uid is null then
		select 'Invalid token' as errortxt, true as error
			,@thetoken as thetoken, @uid as theuid, ceil(@uid) as ceiluid, @friendsarray as friendsarray
		;
		LEAVE proc_label;
	end if;
	select uid, friendsarray into @uid, @friendsarray from token where token = @thetoken and active = 1 limit 1;
	if @uid != ceil(@uid) or @uid is null then
		select 'Invalid token' as errortxt, true as error
			,@thetoken as thetoken, @uid as theuid, ceil(@uid) as ceiluid, @friendsarray as friendsarray
		;
		LEAVE proc_label;
	end if;
update token set usecount = usecount + 1 where token = @thetoken and id > 0 limit 1;
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
	and l.uid in (',@uid,',',@friendsarray,')
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
	and l.uid not in (',@uid,',',@friendsarray,')
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
	and l.uid in (',@uid,',',@friendsarray,')
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
	and l.uid not in (',@uid,',',@friendsarray,')
	and t.id not in (select nameid from temp_search )
group by t.id
order by contain desc
limit 10');
prepare stmt from @l;
execute stmt;
deallocate prepare stmt; 
select * from temp_search;
END;
END */$$
DELIMITER ;

/* Procedure structure for procedure `v2.0_thingDetail` */

/*!50003 DROP PROCEDURE IF EXISTS  `v2.0_thingDetail` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `v2.0_thingDetail`(thetoken VARCHAR(36), thethingid INT)
BEGIN


SET @thetoken = thetoken;

SET @thingid = thethingid; 

call `spSqlLog`(0, CONCAT('call v2.0_thingDetail("',@thetoken,'","',thethingid,'")'), 0, 'v2.0_thingDetail');


proc_label:BEGIN

SET @uid = null;
SET @friendsarray = null;

select uid, friendsarray into @uid, @friendsarray from token where token = @thetoken limit 1;


if @uid != ceil(@uid) or @uid is null then
	select 'Invalid token' as errortxt, true as error
		,@thetoken as thetoken, @uid as theuid, ceil(@uid) as ceiluid, @friendsarray as friendsarray
	;
	LEAVE proc_label;
end if;


SET @q = CONCAT('
select 
l.id, l.uid, u.name as username, u.fbuid, l.lid, ln.name as listname, 
l.tid, tn.name as thingname, l.added, l.dittokey
, ml.id as mykey, dk.uid as dittouser, du.fbuid as dittofbuid, du.name as dittousername
from tlist l 
inner join tthing ln on l.lid = ln.id
inner join tthing tn on l.tid = tn.id
inner join tuser u on l.uid = u.id
left outer join tlist ml on ml.uid = ',@uid,' and ml.lid = l.lid and ml.tid = l.tid 
left outer join tlist dk on dk.id = l.dittokey
left outer join tuser du on du.id = dk.uid
where 
	l.tid = ',@thingid,' and l.state = 1
	and l.uid in (',@uid,',',@friendsarray,')

union

select 
l.id, l.uid, "Anonymous" as username, 0 , l.lid, ln.name as listname, 
l.tid, tn.name as thingname, 0, 0
, ml.id as mykey, 0 as dittouser, 0 as dittofbuid, "Anonymous" as dittousername
from tlist l 
inner join tthing ln on l.lid = ln.id
inner join tthing tn on l.tid = tn.id
inner join tuser u on l.uid = u.id
left outer join tlist ml on ml.uid = ',@uid,' and ml.lid = l.lid and ml.tid = l.tid 
left outer join tlist dk on dk.id = l.dittokey
left outer join tuser du on du.id = dk.uid

where 
	l.tid = ',@thingid,' and l.state = 1
	and l.uid not in (',@uid,',',@friendsarray,')
group by l.lid

')	
;

	prepare stmt from @q;
	execute stmt;
	deallocate prepare stmt;

select @q as q;
End;
END */$$
DELIMITER ;

/* Procedure structure for procedure `v2.0_thingid` */

/*!50003 DROP PROCEDURE IF EXISTS  `v2.0_thingid` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `v2.0_thingid`(thetoken VARCHAR(36), thingname TEXT)
BEGIN


call `spSqlLog`(0, CONCAT('call v2.0_thingid("',thetoken,'","',thingname,'")'), 0, 'v2.0_thingid');


SET @thetoken = thetoken;


proc_label:BEGIN

SET @uid = null;
SET @friendsarray = null;

select uid, friendsarray into @uid, @friendsarray from token where token = @thetoken limit 1;


if @uid != ceil(@uid) or @uid is null then
	select 'Invalid token' as errortxt, true as error
		,@thetoken as thetoken, @uid as theuid, ceil(@uid) as ceiluid, @friendsarray as friendsarray
	;
	LEAVE proc_label;
end if;


SET @thingname = thingname;

SET @thingid = fThingId(@thingname);

select @thingid as thingid;


END;
END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;