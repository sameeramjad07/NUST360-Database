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
-- Table structure for table `enrols`
--

DROP TABLE IF EXISTS `enrols`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enrols` (
  `cms` int NOT NULL,
  `cid` int NOT NULL,
  `term` varchar(10) NOT NULL,
  `year` year NOT NULL,
  `grade` varchar(5) DEFAULT NULL,
  `attendancePercentAge` decimal(8,2) DEFAULT NULL,
  KEY `enrolsCms` (`cms`),
  KEY `enrolsCid` (`cid`),
  CONSTRAINT `enrolsCid` FOREIGN KEY (`cid`) REFERENCES `course` (`cid`),
  CONSTRAINT `enrolsCms` FOREIGN KEY (`cms`) REFERENCES `student` (`cms`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enrols`
--

LOCK TABLES `enrols` WRITE;
/*!40000 ALTER TABLE `enrols` DISABLE KEYS */;
INSERT INTO `enrols` VALUES (408160,1,'Fall',2023,NULL,NULL),(408160,2,'Fall',2023,NULL,NULL),(408160,3,'Fall',2023,NULL,NULL),(408160,4,'Fall',2023,NULL,NULL),(408160,5,'Fall',2023,NULL,NULL),(422791,1,'Fall',2023,NULL,NULL),(422791,2,'Fall',2023,NULL,NULL),(422791,3,'Fall',2023,NULL,NULL),(422791,4,'Fall',2023,NULL,NULL),(422791,5,'Fall',2023,NULL,NULL);
/*!40000 ALTER TABLE `enrols` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-01-01  7:45:39
