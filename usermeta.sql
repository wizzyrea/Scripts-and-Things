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
-- Table structure for table `wp_usermeta`
--

DROP TABLE IF EXISTS `wp_usermeta`;
CREATE TABLE `wp_usermeta` (
  `umeta_id` bigint(20) NOT NULL auto_increment,
  `user_id` bigint(20) NOT NULL default '0',
  `meta_key` varchar(255) default NULL,
  `meta_value` longtext,
  PRIMARY KEY  (`umeta_id`),
  KEY `user_id` (`user_id`),
  KEY `meta_key` (`meta_key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `wp_usermeta`
--


/*!40000 ALTER TABLE `wp_usermeta` DISABLE KEYS */;
LOCK TABLES `wp_usermeta` WRITE;
INSERT INTO `wp_usermeta` VALUES (1,1,'nickname','admin'),(2,1,'rich_editing','true'),(3,1,'admin_color','fresh'),(4,1,'wp_capabilities','a:1:{s:13:\"administrator\";b:1;}'),(12,1,'s2_format','text'),(13,1,'s2_excerpt','excerpt'),(14,1,'s2_autosub','yes'),(15,1,'s2_subscribed','-1,3,4'),(34,3,'admin_color','fresh'),(20,1,'s2_cat3','3'),(35,3,'nickname','Librarian'),(22,1,'s2_cat4','4'),(33,3,'rich_editing','true'),(32,3,'wp_capabilities','a:1:{s:13:\"administrator\";b:1;}');
UNLOCK TABLES;
/*!40000 ALTER TABLE `wp_usermeta` ENABLE KEYS */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

