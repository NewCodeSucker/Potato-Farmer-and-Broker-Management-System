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
-- Table structure for table `crop_cycle`
--

DROP TABLE IF EXISTS `crop_cycle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `crop_cycle` (
  `cyleId` int(11) NOT NULL AUTO_INCREMENT,
  `cycleName` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `endHarvestDate` date DEFAULT NULL,
  `endRegDate` date NOT NULL,
  `harvestDate` date NOT NULL,
  `maxpeople` int(11) NOT NULL,
  `openRegDate` date NOT NULL,
  `plantDate` date NOT NULL,
  `potatoType` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `purchasePrice` decimal(10,2) NOT NULL,
  `status` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`cyleId`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crop_cycle`
--

LOCK TABLES `crop_cycle` WRITE;
/*!40000 ALTER TABLE `crop_cycle` DISABLE KEYS */;
INSERT INTO `crop_cycle` VALUES (1,'รอบที่ 01',NULL,'2026-06-30','2026-10-23',150,'2026-06-15','2026-07-15','แอตแลนติก',23.79,'CANCEL'),(2,'รอบที่ 02',NULL,'2026-07-16','2026-10-24',50,'2026-07-01','2026-07-16','แอตแลนติก',20.00,'PROGRESS'),(3,'รอบที่ 02',NULL,'2026-07-16','2026-10-24',50,'2026-07-01','2026-07-16','แอตแลนติก',23.00,'CANCEL'),(4,'รอบที่ 03',NULL,'2026-07-16','2026-10-25',50,'2026-07-01','2026-07-17','สปันต้า',20.00,'PROGRESS'),(5,'1/2569',NULL,'2026-07-16','2026-10-28',50,'2026-07-01','2026-07-20','แอตแลนติก',25.00,'PROGRESS'),(6,'รอบประวัติเดโม 2569','2026-05-25','2026-01-20','2026-05-15',30,'2026-01-05','2026-02-01','แอตแลนติก',25.00,'CLOSE'),(7,'รอบประวัติเดโม 2569','2026-05-25','2026-01-20','2026-05-15',30,'2026-01-05','2026-02-01','แอตแลนติก',25.00,'CLOSE'),(8,'รอบประวัติเดโม Farmer 9','2026-05-25','2026-01-20','2026-05-15',30,'2026-01-05','2026-02-01','แอตแลนติก',25.00,'CLOSE'),(9,'รอบเดโม่ประวัติผลผลิต','2026-05-25','2026-01-15','2026-05-15',50,'2026-01-01','2026-02-01','แอตแลนติก',25.00,'CLOSE'),(10,'รอบ01/2568',NULL,'2026-01-15','2026-05-15',50,'2026-01-01','2026-02-01','แอตแลนติก',25.00,'CLOSE');
/*!40000 ALTER TABLE `crop_cycle` ENABLE KEYS */;
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
