CREATE DATABASE  IF NOT EXISTS `unicorn` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `unicorn`;
-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: unicorn
-- ------------------------------------------------------
-- Server version	5.7.19-log

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
-- Table structure for table `att_categories`
--

DROP TABLE IF EXISTS `att_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `att_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `key_words` varchar(45) DEFAULT NULL,
  `description` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `att_categories`
--

LOCK TABLES `att_categories` WRITE;
/*!40000 ALTER TABLE `att_categories` DISABLE KEYS */;
INSERT INTO `att_categories` VALUES (1,'Extreme sport',NULL,NULL),(2,'Excursions',NULL,NULL),(3,'Concert',NULL,NULL),(5,'Quests',NULL,NULL),(7,'Festivals',NULL,NULL),(8,'Shopping',NULL,NULL);
/*!40000 ALTER TABLE `att_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `att_ord`
--

DROP TABLE IF EXISTS `att_ord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `att_ord` (
  `id` int(11) NOT NULL,
  `id_attr` int(11) NOT NULL,
  `id_order` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_ao_attr_idx` (`id_attr`),
  KEY `fk_ao_order_idx` (`id_order`),
  CONSTRAINT `fk_ao_attr` FOREIGN KEY (`id_attr`) REFERENCES `attractions` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ao_order` FOREIGN KEY (`id_order`) REFERENCES `orders` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `att_ord`
--

LOCK TABLES `att_ord` WRITE;
/*!40000 ALTER TABLE `att_ord` DISABLE KEYS */;
/*!40000 ALTER TABLE `att_ord` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attractions`
--

DROP TABLE IF EXISTS `attractions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attractions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_city` int(11) NOT NULL,
  `id_cat` int(11) NOT NULL,
  `duration` time NOT NULL,
  `time` time DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `name` varchar(100) NOT NULL,
  `image` varchar(200) DEFAULT '/images/attraction/',
  PRIMARY KEY (`id`),
  KEY `fk_a_city_idx` (`id_city`),
  KEY `fk_a_cat_idx` (`id_cat`),
  CONSTRAINT `fk_a_cat` FOREIGN KEY (`id_cat`) REFERENCES `att_categories` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_a_city` FOREIGN KEY (`id_city`) REFERENCES `cities` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attractions`
--

LOCK TABLES `attractions` WRITE;
/*!40000 ALTER TABLE `attractions` DISABLE KEYS */;
INSERT INTO `attractions` VALUES (1,2,2,'05:30:00','08:20:00',58.00,'Holiday of chocolate','/images/attraction/Holiday of chocolate.jpg'),(2,2,3,'03:00:00','20:20:00',157.00,'ACDC','/images/attraction/ACDC.jpg'),(3,1,1,'04:00:00','08:15:00',15.00,'Bungee jumping','/images/attraction/BungeeJumping.jpg'),(4,7,1,'03:00:00','10:00:00',27.00,'Wakeboarding','/images/attraction/Wakeboarding.jpg'),(5,2,1,'02:00:00',NULL,56.00,'Paintball in city','/images/attraction/Paintball-Photos.jpg'),(8,4,1,'06:00:00',NULL,159.00,'Strittlation','/images/attraction/Strittlation.jpg'),(9,13,1,'06:00:00',NULL,154.00,'surfing','/images/attraction/surfing.jpg'),(10,7,1,'06:00:00',NULL,49.99,'Cyclocross','/images/attraction/Cyclocross.jpg'),(11,7,1,'02:00:00',NULL,46.00,'Rock climbing','/images/attraction/Rock climbing.jpg'),(12,13,1,'04:00:00',NULL,200.00,'diving','/images/attraction/_Neu_Banner_EAN_Mobile.jpg'),(13,12,7,'06:00:00',NULL,0.00,'Carnival','/images/attraction/Carnival.jpg'),(15,9,7,'02:00:00',NULL,9.00,'Flower Festival','/images/attraction/Flower Festival.jpg'),(16,13,7,'05:00:00',NULL,12.00,'Film Festival','/images/attraction/Film Festival.jpg'),(17,1,7,'02:00:00',NULL,15.00,'Food Festival','/images/attraction/Food Festival.jpg'),(18,5,7,'02:00:00',NULL,20.00,'Whiskey Festival','/images/attraction/Whiskey Festival.jpg'),(19,2,7,'06:00:00',NULL,9.00,'Shopping Festival','/images/attraction/Shopping Festival.jpg'),(20,3,7,'02:00:00',NULL,13.00,'Festival of balloons','/images/attraction/Festival of balloons.jpg'),(21,4,7,'04:00:00',NULL,8.00,'International Cannabis Festival','/images/attraction/International Cannabis Festival.jpg'),(22,6,7,'05:30:00',NULL,14.00,'Festival of Olives','/images/attraction/Festival of Olives.PNG'),(23,7,7,'06:00:00',NULL,6.00,'Festival of sacred music','/images/attraction/Festival of sacred music.jpg'),(24,8,7,'02:00:00',NULL,12.00,'Festival of Jazz','/images/attraction/Festival of Jazz.jpg'),(25,10,7,'04:00:00',NULL,20.00,'Festival of Lights','/images/attraction/Festival of Lights.jpg'),(26,11,7,'06:00:00',NULL,21.00,'Carrot Festival','/images/attraction/Carrot Festival.jpg'),(27,1,3,'01:15:00',NULL,12.00,'O\'torvald','/images/attraction/O\'torvald.jpg'),(28,2,3,'00:55:00',NULL,8.00,'Monatik','/images/attraction/Monatik.jpg'),(29,13,3,'01:20:00',NULL,11.00,'Hollywood Undead','/images/attraction/Hollywood Undead.jpg'),(30,1,3,'03:00:00',NULL,17.00,'Open Kids','/images/attraction/Open Kids.jpg'),(31,1,3,'02:25:00',NULL,50.00,'Scorpions','/images/attraction/Scorpions.jpg'),(32,2,3,'01:07:00',NULL,7.00,'Onuka','/images/attraction/Onuka.jpg'),(33,4,3,'02:00:00',NULL,20.00,'Adam Gontier','/images/attraction/Adam Gontier.jpg'),(34,2,3,'01:33:00',NULL,22.00,'BrainStorm','/images/attraction/BrainStorm.jpg'),(35,9,3,'03:00:00',NULL,7.00,'Metallica','/images/attraction/Metallica.jpg'),(39,1,5,'01:00:00',NULL,7.00,'Aliens Reunion','/images/attraction/Aliens Reunion.JPG'),(40,4,5,'01:00:00',NULL,7.00,'Victorian Detective','/images/attraction/Victorian Detective.jpg'),(41,2,5,'01:00:00',NULL,7.00,'Guardians of Memory','/images/attraction/Guardians of Memory.jpg'),(42,5,5,'01:00:00',NULL,7.00,'1001 night','/images/attraction/1001 night.jpg'),(43,6,5,'01:00:00',NULL,7.00,'Way of the Samurai','/images/attraction/Way of the Samurai.jpg'),(44,7,5,'01:00:00',NULL,7.00,'Conspirator\'s apartment','/images/attraction/Conspirator\'s apartment.jpg'),(45,8,5,'01:00:00',NULL,7.00,'Warlock','/images/attraction/Warlock.jpg'),(46,9,5,'01:00:00',NULL,7.00,'Cold to shudder','/images/attraction/Cold to shudder.jpg'),(47,10,5,'01:00:00',NULL,7.00,'Boardwalk Empire','/images/attraction/Boardwalk Empire.jpg'),(48,3,5,'01:00:00',NULL,7.00,'Artist\'s Dream','/images/attraction/Artist\'s Dream.jpg'),(49,11,5,'01:00:00',NULL,7.00,'Dungeons of the Inquisition','/images/attraction/Dungeons of the Inquisition.jpg'),(50,12,5,'01:00:00',NULL,7.00,'Laboratory','/images/attraction/Laboratory.jpg'),(51,13,5,'01:00:00',NULL,7.00,'Designer\'s cabinet','/images/attraction/Designer\'s cabinet.jpg'),(52,5,8,'02:00:00',NULL,0.00,'Victoria Secret','/images/attraction/Victoria Secret.jpg'),(53,1,8,'01:00:00',NULL,0.00,'Antonioli','/images/attraction/Antonioli.jpg'),(54,2,8,'01:00:00',NULL,0.00,'Dior','/images/attraction/Dior.jpg'),(55,3,8,'01:00:00',NULL,0.00,'Gallo','/images/attraction/Gallo.jpg'),(56,4,8,'01:00:00',NULL,0.00,'Castellani','/images/attraction/Castellani.jpg'),(57,7,8,'01:00:00',NULL,0.00,'Colette','/images/attraction/Colette.jpg'),(58,6,8,'01:00:00',NULL,0.00,'Boucheron','/images/attraction/Boucheron.jpg'),(59,9,8,'01:00:00',NULL,0.00,'Caron','/images/attraction/Caron.jpg'),(60,8,8,'01:00:00',NULL,0.00,'Moncler','/images/attraction/Moncler.jpg'),(61,13,8,'01:00:00',NULL,0.00,'Hermes','/images/attraction/Hermes.jpg'),(62,11,8,'01:00:00',NULL,0.00,'Chanel','/images/attraction/Chanel.jpg'),(63,10,8,'01:00:00',NULL,0.00,'Gucci','/images/attraction/Gucci.jpg'),(64,12,8,'01:00:00',NULL,0.00,'Mango','/images/attraction/Mango.jpg');
/*!40000 ALTER TABLE `attractions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cities`
--

DROP TABLE IF EXISTS `cities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `id_country` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_cit_cou_idx` (`id_country`),
  CONSTRAINT `fk_cit_cou` FOREIGN KEY (`id_country`) REFERENCES `countries` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cities`
--

LOCK TABLES `cities` WRITE;
/*!40000 ALTER TABLE `cities` DISABLE KEYS */;
INSERT INTO `cities` VALUES (1,'Kyiv',1),(2,'Lviv',1),(3,'Paris',2),(4,'Chicago',4),(5,'London',3),(6,'Monaco',2),(7,'Dnipro',1),(8,'Warszawa',5),(9,'Krakow',5),(10,'Praha',7),(11,'Brno',7),(12,'Wien',6),(13,'LA',4);
/*!40000 ALTER TABLE `cities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `countries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countries`
--

LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
INSERT INTO `countries` VALUES (1,'Ukraine'),(2,'France'),(3,'England'),(4,'USA'),(5,'Poland'),(6,'Austria'),(7,'Czech');
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hotels`
--

DROP TABLE IF EXISTS `hotels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hotels` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_city` int(11) NOT NULL,
  `marks` double NOT NULL,
  `name` varchar(45) NOT NULL,
  `address` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_h_city_idx` (`id_city`),
  CONSTRAINT `fk_h_city` FOREIGN KEY (`id_city`) REFERENCES `cities` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotels`
--

LOCK TABLES `hotels` WRITE;
/*!40000 ALTER TABLE `hotels` DISABLE KEYS */;
INSERT INTO `hotels` VALUES (1,2,5,'Splash Hostel','Zaliznychna St., 7 ZH, Floor 1');
/*!40000 ALTER TABLE `hotels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_from` int(11) NOT NULL,
  `id_to` int(11) NOT NULL,
  `id_room` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `FIO` longtext NOT NULL,
  `email` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_o_f_idx` (`id_from`),
  KEY `fk_o_t_idx` (`id_to`),
  KEY `fk_o_r_idx` (`id_room`),
  CONSTRAINT `fk_o_f` FOREIGN KEY (`id_from`) REFERENCES `tickets` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_o_r` FOREIGN KEY (`id_room`) REFERENCES `rooms` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_o_t` FOREIGN KEY (`id_to`) REFERENCES `tickets` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room_types`
--

DROP TABLE IF EXISTS `room_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `room_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room_types`
--

LOCK TABLES `room_types` WRITE;
/*!40000 ALTER TABLE `room_types` DISABLE KEYS */;
INSERT INTO `room_types` VALUES (1,'Econom'),(2,'Standard'),(3,'Lux');
/*!40000 ALTER TABLE `room_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rooms`
--

DROP TABLE IF EXISTS `rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rooms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_hostel` int(11) NOT NULL,
  `id_type` int(11) NOT NULL,
  `price` decimal(9,2) NOT NULL,
  `count` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_r_h_idx` (`id_hostel`),
  KEY `fk_r_t_idx` (`id_type`),
  CONSTRAINT `fk_r_h` FOREIGN KEY (`id_hostel`) REFERENCES `hotels` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_r_t` FOREIGN KEY (`id_type`) REFERENCES `room_types` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rooms`
--

LOCK TABLES `rooms` WRITE;
/*!40000 ALTER TABLE `rooms` DISABLE KEYS */;
INSERT INTO `rooms` VALUES (4,1,1,10.00,20),(5,1,2,20.00,8),(6,1,3,150.00,5);
/*!40000 ALTER TABLE `rooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket_types`
--

DROP TABLE IF EXISTS `ticket_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ticket_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_types`
--

LOCK TABLES `ticket_types` WRITE;
/*!40000 ALTER TABLE `ticket_types` DISABLE KEYS */;
INSERT INTO `ticket_types` VALUES (1,'Flights'),(2,'Train'),(3,'Bus');
/*!40000 ALTER TABLE `ticket_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tickets`
--

DROP TABLE IF EXISTS `tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tickets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_from` int(11) NOT NULL,
  `id_to` int(11) NOT NULL,
  `id_type` int(11) DEFAULT '0',
  `datetime` datetime DEFAULT NULL,
  `duration` time DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_c_from_idx` (`id_from`),
  KEY `fk_c_to_idx` (`id_to`),
  KEY `fk_t_t_idx` (`id_type`),
  CONSTRAINT `fk_c_from` FOREIGN KEY (`id_from`) REFERENCES `cities` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_c_to` FOREIGN KEY (`id_to`) REFERENCES `cities` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_t_t` FOREIGN KEY (`id_type`) REFERENCES `ticket_types` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets`
--

LOCK TABLES `tickets` WRITE;
/*!40000 ALTER TABLE `tickets` DISABLE KEYS */;
INSERT INTO `tickets` VALUES (1,1,2,1,'2017-10-11 10:00:00','01:15:00',20.00,'/images/plane/plane1.png'),(2,3,5,1,'2017-10-11 13:45:00','02:30:00',35.00,'/images/plane/plane6.png'),(3,6,3,3,'2017-10-11 08:10:00','03:40:00',27.85,'/images/plane/plane2.png'),(4,1,2,2,'2017-10-11 21:35:00','07:53:00',15.00,'/images/plane/plane3.png'),(5,2,1,1,'2017-10-12 10:10:00','04:15:00',20.00,'/images/plane/plane5.png');
/*!40000 ALTER TABLE `tickets` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-10-08 11:47:18
