-- MySQL dump 10.13  Distrib 5.6.16, for Win32 (x86)
--
-- Host: localhost    Database: plitto2014
-- ------------------------------------------------------
-- Server version	5.6.16

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tlist`
--

DROP TABLE IF EXISTS `tlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tlist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tid` int(11) NOT NULL,
  `lid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `added` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `state` tinyint(1) DEFAULT '1',
  `dittokey` int(11) DEFAULT NULL,
  `uuid` varchar(45) DEFAULT NULL,
  `dittoCount` int(11) DEFAULT '0',
  `commentCount` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`tid`,`lid`,`uid`),
  UNIQUE KEY `uuid_UNIQUE` (`uuid`),
  KEY `tuid_idx` (`uid`),
  KEY `lid_idx` (`lid`),
  KEY `dittokey_idx` (`dittokey`),
  CONSTRAINT `dittokey` FOREIGN KEY (`dittokey`) REFERENCES `tditto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `lid` FOREIGN KEY (`lid`) REFERENCES `tthing` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `tid` FOREIGN KEY (`tid`) REFERENCES `tthing` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `tuid` FOREIGN KEY (`uid`) REFERENCES `tuser` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=166957 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-01-30  0:05:43
