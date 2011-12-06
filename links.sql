-- MySQL dump 10.9
--
-- Host: localhost    Database: demo
-- ------------------------------------------------------
-- Server version	4.1.20

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `wp_links`
--

DROP TABLE IF EXISTS `wp_links`;
CREATE TABLE `wp_links` (
  `link_id` bigint(20) NOT NULL auto_increment,
  `link_url` varchar(255) NOT NULL default '',
  `link_name` varchar(255) NOT NULL default '',
  `link_image` varchar(255) NOT NULL default '',
  `link_target` varchar(25) NOT NULL default '',
  `link_category` bigint(20) NOT NULL default '0',
  `link_description` varchar(255) NOT NULL default '',
  `link_visible` varchar(20) NOT NULL default 'Y',
  `link_owner` int(11) NOT NULL default '1',
  `link_rating` int(11) NOT NULL default '0',
  `link_updated` datetime NOT NULL default '0000-00-00 00:00:00',
  `link_rel` varchar(255) NOT NULL default '',
  `link_notes` mediumtext NOT NULL,
  `link_rss` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`link_id`),
  KEY `link_category` (`link_category`),
  KEY `link_visible` (`link_visible`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `wp_links`
--


/*!40000 ALTER TABLE `wp_links` DISABLE KEYS */;
LOCK TABLES `wp_links` WRITE;
INSERT INTO `wp_links` VALUES (12,'http://www.hotmail.com','Hotmail','','',0,'','Y',3,0,'0000-00-00 00:00:00','','',''),(13,'http://mail.yahoo.com','Yahoo! Mail','','',0,'','Y',3,0,'0000-00-00 00:00:00','','',''),(11,'http://www.gmail.com','Google Mail','','',0,'','Y',3,0,'0000-00-00 00:00:00','','',''),(9,'http://www.nekls.org','NEKLS','','',0,'','Y',3,0,'0000-00-00 00:00:00','','',''),(10,'http://www.kslib.info','Kansas State Library','','',0,'','Y',3,0,'0000-00-00 00:00:00','','',''),(8,'http://www.mykansaslibrary.org','My Kansas Library on the Web','','',0,'','Y',3,0,'0000-00-00 00:00:00','','','');
UNLOCK TABLES;
/*!40000 ALTER TABLE `wp_links` ENABLE KEYS */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

