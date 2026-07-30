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
-- Table structure for table `item_requisition_detail`
--

DROP TABLE IF EXISTS `item_requisition_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item_requisition_detail` (
  `requisitionDetailId` int(11) NOT NULL AUTO_INCREMENT,
  `cause` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `qty` int(11) NOT NULL,
  `unitPrice` decimal(10,2) NOT NULL,
  `item_id` int(11) DEFAULT NULL,
  `requisition_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`requisitionDetailId`),
  KEY `FKu4j0vp6v444jdfs78xgbt8s7` (`item_id`),
  KEY `FKpctv30jougknpch8983385m81` (`requisition_id`),
  CONSTRAINT `FKpctv30jougknpch8983385m81` FOREIGN KEY (`requisition_id`) REFERENCES `item_requisition` (`requisitionId`),
  CONSTRAINT `FKu4j0vp6v444jdfs78xgbt8s7` FOREIGN KEY (`item_id`) REFERENCES `item` (`itemId`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_requisition_detail`
--

LOCK TABLES `item_requisition_detail` WRITE;
/*!40000 ALTER TABLE `item_requisition_detail` DISABLE KEYS */;
INSERT INTO `item_requisition_detail` VALUES (2,'กก',3,650.00,3,2),(3,'กกก',2,650.00,3,3),(4,'จัดสรรหัวพันธุ์ตามพื้นที่ที่ได้รับอนุมัติ',250,18.00,1,4),(5,'จัดสรรปุ๋ยสูตร 15-15-15 ตามพื้นที่',63,850.00,2,4),(6,'จัดสรรปุ๋ยสูตร 13-13-21 ตามพื้นที่',63,19.00,6,4),(7,'จัดสรรปุ๋ยสูตร 46-0-0 ตามพื้นที่',32,21.00,7,4),(8,'จัดสรรหัวพันธุ์ตามพื้นที่ที่ได้รับอนุมัติ',250,18.00,1,5),(9,'จัดสรรปุ๋ยสูตร 15-15-15 ตามพื้นที่',63,850.00,2,5),(10,'จัดสรรปุ๋ยสูตร 13-13-21 ตามพื้นที่',63,19.00,6,5),(11,'จัดสรรปุ๋ยสูตร 46-0-0 ตามพื้นที่',32,21.00,7,5),(12,'ขขขข',2,650.00,3,6);
/*!40000 ALTER TABLE `item_requisition_detail` ENABLE KEYS */;
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
