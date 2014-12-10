DELIMITER $$

USE `plitto2014`$$

DROP PROCEDURE IF EXISTS `v2.0_fbLogin`$$

CREATE DEFINER=`theuser`@`%` PROCEDURE `v2.0_fbLogin`(
	fbuid BIGINT, fbname VARCHAR(255), fbemail VARCHAR(255) , fbfriendsarray TEXT)
BEGIN
/*
	Returns a token for this user's session.
		Token masks: user id, start time, usage count, and list of friends.
		All session handling moves into the token arena. All other stored procs should use the token as a way to handle this.
*/
CALL `spSqlLog`(0, CONCAT('call `v2.0_fbLogin`("',fbuid,'","',fbname,'","',fbemail,'","',fbfriendsarray,'")'), 0, 'v2.0_fbLogin');
SET @fbuid = fbuid;
SET @fbname = fbname;
SET @fbemail = fbemail;
SET @fbfriendsarray = fbfriendsarray;
-- Clear the UserIds
SET @puid = NULL;
SET @active = NULL;
SET @username = NULL;
SET @email = NULL;
-- Step 1 -- see if this account already exists. If so create some variables to hold their information.
-- SELECT @puid:=id , @active:=active, @thename:=name, @email:=email from tuser where fbuid = fbuid limit 1;
SELECT tuser.id, tuser.active, tuser.name, tuser.email 
	INTO @puid, @active, @username, @email 
FROM tuser WHERE tuser.fbuid = @fbuid 
LIMIT 1;
SET @result = CONCAT('fbuid: ' 
	, CAST(@fbuid AS CHAR CHARACTER SET utf8)
	,' initial puid: '
	, CAST(@puid AS CHAR CHARACTER SET utf8)
);
-- This test is failing: Maybe?
IF @puid IS NULL THEN
	SET @result = CONCAT(@result,' puid was null. Create account.');
	-- Create the new user.
	INSERT INTO tuser (`name`,`fbuid`,`active`,`email`,`added`) 
	VALUES(@fbname, @fbuid, 1, @fbemail,CURRENT_TIMESTAMP);
	
	-- The first time around, this is making the user as if they were ID 1.
	SELECT 
		id, active, `name`, email 
		INTO @puid, @active, @username, @email 
	FROM tuser 
	WHERE id = LAST_INSERT_ID()
	LIMIT 1;
-- Step 2 -- See if there are updates to make
ELSEIF @active != 1 OR @username != fbname OR @email != fbemail THEN
	UPDATE tuser SET `name` = @fbname, email = @fbemail WHERE id = @puid LIMIT 1;
	SET @result = CONCAT(@result,' | Update account information');
END IF;
-- STEP -- We should have a valid user at this point. Get the plitto IDs from their friends based on the facebook IDs passed in as fbfriendsarray.
SET @friendquery = CONCAT('select GROUP_CONCAT(id) INTO @friendids from tuser where fbuid in (',@fbfriendsarray,')');
 PREPARE stmt FROM @friendquery;
	EXECUTE stmt;
	DEALLOCATE PREPARE stmt;
-- STEP - Create the token for this user.
IF CEIL(@puid) = @puid THEN
	-- update token set `end` = CURRENT_TIMESTAMP, active = 0 where uid = @puid and active = 1 limit 1;
	SET @token = '';
	-- See if this user has a valid token already.
	SELECT token INTO @token FROM token WHERE uid = @uid AND active = 1 LIMIT 1;
	
	IF CHAR_LENGTH(@token) = 0 THEN
		
	
		-- Create a token
		SET @token = MD5(CONCAT('!%!connect!%!',UUID()));
		INSERT INTO token (`token`,`uid`,`start`,`active`,`usecount`,`friendsarray`) VALUES (@token,@puid,CURRENT_TIMESTAMP,1,1, @friendids  );
	END IF;
	
END IF;
SELECT @puid AS puid, @username AS username, @fbuid AS fbuid, @token AS token, @friendids AS friendids; 
/*
*/
-- 
END$$

DELIMITER ;