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
-- Table structure for table `farmland`
--

DROP TABLE IF EXISTS `farmland`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `farmland` (
  `landId` int(11) NOT NULL AUTO_INCREMENT,
  `location` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ngan` decimal(4,2) NOT NULL,
  `rai` decimal(6,2) NOT NULL,
  `squreWah` decimal(6,2) NOT NULL,
  `titleDeedImagePath` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `titleDeedNo` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `farmer_id` int(11) NOT NULL,
  `titleDeedBackImagePath` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`landId`),
  KEY `FKktvjt18h0n9iwpk8peknl5lfy` (`farmer_id`),
  CONSTRAINT `FKktvjt18h0n9iwpk8peknl5lfy` FOREIGN KEY (`farmer_id`) REFERENCES `farmer` (`farmerId`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `farmland`
--

LOCK TABLES `farmland` WRITE;
/*!40000 ALTER TABLE `farmland` DISABLE KEYS */;
INSERT INTO `farmland` VALUES (1,'1',1.00,1.00,1.00,'1781527965128_farm_image.avif','1',1,NULL),(2,'1',1.00,1.00,1.00,'1781527965189_farm_image.avif','1',1,NULL),(3,'1',1.00,1.00,1.00,'1781712807153_1781527965128_farm_image.avif','1',2,NULL),(4,'1',1.00,1.00,1.00,'1781712807258_1781527965128_farm_image.avif','1',2,NULL),(5,'1',1.00,1.00,1.00,'1781805597047_farm_image.avif','1',3,NULL),(6,'1',1.00,1.00,1.00,'1781805597117_ChatGPT Image 30 มี.ค. 2569 23_23_55.png','1',3,NULL),(7,'1',1.00,1.00,1.00,'1782327946485_farm_image.avif','1',4,NULL),(8,'dd',2.00,2.00,2.00,'1782880055335_coffee2.webp','002',5,NULL),(9,'1',1.00,1.00,1.00,'1782880511024_coffee1.JPG','1',6,NULL),(10,'1',1.00,1.00,1.00,'1782880511052_coffee2.webp','1',6,NULL),(11,'01',2.00,4.00,2.00,'1782886900530_black_tea.webp','002',7,NULL),(12,'jj',5.00,4.00,2.00,'1782886900611_greem_tea.webp','001',7,NULL),(13,'1',1.00,1.00,1.00,'1783450218328_front_ChatGPT Image 30 มี.ค. 2569 23_23_55.png','1',8,'1783450218339_back_ChatGPT Image 30 มี.ค. 2569 23_23_55.png'),(14,'1',1.00,1.00,1.00,'1783450218412_front_ดีไซน์ที่ยังไม่ได้ตั้งชื่อ (3).png','1',8,'1783450218422_back_asldjf.png'),(15,'chaingmai',4.00,1.00,2.00,'1783493686707_front_Gemini_Generated_Image_u9yliju9yliju9yl.png','001',9,'1783493686728_back_ChatGPT Image 30 มี.ค. 2569 23_23_55.png'),(16,'thialand',2.00,2.00,4.00,'1783493686818_front_ดีไซน์ที่ยังไม่ได้ตั้งชื่อ (3).png','002',9,'1783493686828_back_8bc7ec46-6edb-4381-a28d-a50fbad0ffe5.jpeg'),(17,'ddd',2.00,1.00,3.00,'1784665252819_front_ChatGPT Image 15 ก.ค. 2569 02_23_17.png','ddd',9,'1784665252852_back_farm-4.jpg'),(18,'dd',1.00,1.00,1.00,'1784665252909_front_ChatGPT Image 15 ก.ค. 2569 02_23_17.png','fff',9,'1784665252919_back_ChatGPT Image 30 มี.ค. 2569 23_23_55.png'),(19,'11',1.00,1.00,1.00,'1784666028199_front_Gemini_Generated_Image_u9yliju9yliju9yl.png','11',9,'1784666028212_back_farm-4.jpg'),(20,'1',1.00,1.00,1.00,'1784692521322_front_farm-3.jpg','1',10,'1784692521339_back_Gemini_Generated_Image_u9yliju9yliju9yl.png'),(21,'gg',1.00,1.00,1.00,'1784699476811_front_farm-3.jpg','gg',11,'1784699476835_back_farm-3.jpg');
/*!40000 ALTER TABLE `farmland` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-31  0:58:35
