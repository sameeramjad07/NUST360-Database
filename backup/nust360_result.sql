-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: nust360
-- ------------------------------------------------------
-- Server version	8.0.34

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
-- Table structure for table `result`
--

DROP TABLE IF EXISTS `result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `result` (
  `cms` int NOT NULL,
  `cid` int NOT NULL,
  `exam_type` int NOT NULL,
  `total_marks` int NOT NULL,
  `marks_obtained` decimal(4,2) NOT NULL,
  `class_avg` decimal(4,2) DEFAULT NULL,
  `dateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `resultCms` (`cms`),
  KEY `resultCid` (`cid`),
  KEY `resultExam_type` (`exam_type`),
  CONSTRAINT `resultCid` FOREIGN KEY (`cid`) REFERENCES `course` (`cid`),
  CONSTRAINT `resultCms` FOREIGN KEY (`cms`) REFERENCES `student` (`cms`),
  CONSTRAINT `resultExam_type` FOREIGN KEY (`exam_type`) REFERENCES `examtype` (`exam_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `result`
--

LOCK TABLES `result` WRITE;
/*!40000 ALTER TABLE `result` DISABLE KEYS */;
INSERT INTO `result` VALUES (408160,1,1,10,5.00,NULL,'2023-12-31 03:00:00'),(408160,1,2,10,7.00,NULL,'2023-12-31 04:30:00'),(408160,1,3,50,23.00,NULL,'2023-12-31 06:00:00'),(408160,1,4,100,55.00,NULL,'2023-12-31 08:30:00'),(408160,2,1,10,3.00,NULL,'2023-12-31 03:00:00'),(408160,2,2,10,5.00,NULL,'2023-12-31 04:30:00'),(408160,2,3,50,33.00,NULL,'2023-12-31 06:00:00'),(408160,2,4,100,35.00,NULL,'2023-12-31 08:30:00'),(408160,3,1,10,7.00,NULL,'2023-12-31 03:00:00'),(408160,3,2,10,8.00,NULL,'2023-12-31 04:30:00'),(408160,3,3,50,20.00,NULL,'2023-12-31 06:00:00'),(408160,3,4,100,85.00,NULL,'2023-12-31 08:30:00'),(408160,4,1,10,4.00,NULL,'2023-12-31 03:00:00'),(408160,4,2,10,9.00,NULL,'2023-12-31 04:30:00'),(408160,4,3,50,40.00,NULL,'2023-12-31 06:00:00'),(408160,4,4,100,85.00,NULL,'2023-12-31 08:30:00'),(408160,5,1,10,9.00,NULL,'2023-12-31 03:00:00'),(408160,5,2,10,9.00,NULL,'2023-12-31 04:30:00'),(408160,5,3,50,44.00,NULL,'2023-12-31 06:00:00'),(408160,5,4,100,34.00,NULL,'2023-12-31 08:30:00'),(422791,1,1,10,3.00,NULL,'2023-12-31 03:00:00'),(422791,1,2,10,8.00,NULL,'2023-12-31 04:30:00'),(422791,1,3,50,43.00,NULL,'2023-12-31 06:00:00'),(422791,1,4,100,85.00,NULL,'2023-12-31 08:30:00'),(422791,2,1,10,1.00,NULL,'2023-12-31 03:00:00'),(422791,2,2,10,3.00,NULL,'2023-12-31 04:30:00'),(422791,2,3,50,34.00,NULL,'2023-12-31 06:00:00'),(422791,2,4,100,67.00,NULL,'2023-12-31 08:30:00'),(422791,3,1,10,4.00,NULL,'2023-12-31 03:00:00'),(422791,3,2,10,5.00,NULL,'2023-12-31 04:30:00'),(422791,3,3,50,34.00,NULL,'2023-12-31 06:00:00'),(422791,3,4,100,34.00,NULL,'2023-12-31 08:30:00'),(422791,4,1,10,7.00,NULL,'2023-12-31 03:00:00'),(422791,4,2,10,3.00,NULL,'2023-12-31 04:30:00'),(422791,4,3,50,34.00,NULL,'2023-12-31 06:00:00'),(422791,4,4,100,99.00,NULL,'2023-12-31 08:30:00'),(422791,5,1,10,3.00,NULL,'2023-12-31 03:00:00'),(422791,5,2,10,3.00,NULL,'2023-12-31 04:30:00'),(422791,5,3,50,24.00,NULL,'2023-12-31 06:00:00'),(422791,5,4,100,94.00,NULL,'2023-12-31 08:30:00');
/*!40000 ALTER TABLE `result` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-01-01  7:45:40
