-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: potato_system_db
-- ------------------------------------------------------
-- Server version	5.7.10-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `farmland_cycle_register`
--

DROP TABLE IF EXISTS `farmland_cycle_register`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `farmland_cycle_register` (
  `land_id` int(11) NOT NULL,
  `register_id` int(11) NOT NULL,
  KEY `FKfpe5pod1g8b96lo9qdg2hpkvv` (`register_id`),
  KEY `FKrir17rx4j5u45rajuoja2tx4s` (`land_id`),
  CONSTRAINT `FKfpe5pod1g8b96lo9qdg2hpkvv` FOREIGN KEY (`register_id`) REFERENCES `cycle_register` (`registerId`),
  CONSTRAINT `FKrir17rx4j5u45rajuoja2tx4s` FOREIGN KEY (`land_id`) REFERENCES `farmland` (`landId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `farmland_cycle_register`
--

LOCK TABLES `farmland_cycle_register` WRITE;
/*!40000 ALTER TABLE `farmland_cycle_register` DISABLE KEYS */;
INSERT INTO `farmland_cycle_register` VALUES (1,1),(2,2),(3,3),(4,3),(5,4),(6,4),(7,5),(8,6),(9,7),(10,7),(11,8),(12,8),(13,9),(14,9),(15,10),(16,10),(12,16),(16,17),(17,10),(18,10),(19,10),(20,18),(21,19);
/*!40000 ALTER TABLE `farmland_cycle_register` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-31  0:58:36
