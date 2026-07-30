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
-- Table structure for table `farmer_notification`
--

DROP TABLE IF EXISTS `farmer_notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `farmer_notification` (
  `notificationId` int(11) NOT NULL AUTO_INCREMENT,
  `createdAt` datetime(6) NOT NULL,
  `message` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `notificationType` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `readStatus` bit(1) NOT NULL,
  `targetUrl` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `title` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `farmer_id` int(11) NOT NULL,
  PRIMARY KEY (`notificationId`),
  KEY `FK7i7npx7x8arfv3akn19o04qq7` (`farmer_id`),
  CONSTRAINT `FK7i7npx7x8arfv3akn19o04qq7` FOREIGN KEY (`farmer_id`) REFERENCES `farmer` (`farmerId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `farmer_notification`
--

LOCK TABLES `farmer_notification` WRITE;
/*!40000 ALTER TABLE `farmer_notification` DISABLE KEYS */;
INSERT INTO `farmer_notification` VALUES (1,'2026-07-22 10:56:54.801034','การลงทะเบียนรอบ 1/2569 ได้รับอนุมัติแล้ว ระบบได้กำหนดวันปลูก วันเก็บเกี่ยว และจัดสรรหัวพันธุ์กับปุ๋ยให้เรียบร้อยแล้ว','REGISTRATION_APPROVED',_binary '\0','/farmer/registered-cycle/detail/5','อนุมัติการลงทะเบียนแล้ว',10),(2,'2026-07-22 11:45:39.566102','ใบเบิก REQ3 ของรอบ รอบที่ 03 ได้รับการอนุมัติแล้ว','REQUISITION_APPROVED',_binary '\0','/farmer/requisition/3','ใบเบิกได้รับการอนุมัติ',7),(3,'2026-07-22 12:54:35.832552','การลงทะเบียนรอบ รอบที่ 02 ได้รับอนุมัติแล้ว ระบบได้กำหนดวันปลูก วันเก็บเกี่ยว และจัดสรรหัวพันธุ์กับปุ๋ยให้เรียบร้อยแล้ว','REGISTRATION_APPROVED',_binary '\0','/farmer/registered-cycle/detail/2','อนุมัติการลงทะเบียนแล้ว',11),(4,'2026-07-22 13:03:15.638563','ใบเบิก REQ6 ของรอบ รอบที่ 02 ไม่ได้รับการอนุมัติ','REQUISITION_REJECTED',_binary '\0','/farmer/requisition/6','ใบเบิกไม่ได้รับการอนุมัติ',11);
/*!40000 ALTER TABLE `farmer_notification` ENABLE KEYS */;
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
