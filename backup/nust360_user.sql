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
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `uuid` int NOT NULL AUTO_INCREMENT,
  `role` varchar(10) NOT NULL,
  `fname` varchar(30) NOT NULL,
  `mname` varchar(30) DEFAULT NULL,
  `lname` varchar(30) NOT NULL,
  `DOB` date NOT NULL,
  `Username` varchar(20) DEFAULT NULL,
  `password` varbinary(255) NOT NULL,
  `profile_pic` varchar(255) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `email` varchar(50) NOT NULL,
  `emergency_contact` varchar(15) DEFAULT NULL,
  `gender` varchar(10) NOT NULL,
  `cnic` varchar(15) NOT NULL,
  `nationality` varchar(20) NOT NULL,
  `religion` varchar(20) NOT NULL,
  `marital_status` varchar(10) NOT NULL,
  `age` int NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'student','Abdur',NULL,'Rehman','2003-11-23','abdurRehman_0',_binary '\Í]ê¨‘¸\Ûxr´8\ÅÎ±E','profile_pic1.jpg','1234567890','abdurRehman@student.com',NULL,'Male','02345-6789123-4','Pakistani','Islam','Single',20),(2,'student','Muhammad',NULL,'Saad','2002-05-22','muhammadSaad_0',_binary 'J‚wŸõÙ›O}0f­Ñ¡','profile_pic2.jpg','9876543210','SaadDX@student.com',NULL,'Male','56789-1234567-0','Pakistani','Islam','Single',22),(3,'faculty','Dr.Shams',NULL,'Qazi','1978-08-10','dr.shamsQazi_0',_binary '<\Û\Ç\ï.1”ž\ëFT—PŸ(','profile_pic3.jpg','5556667777','shamsQazi@seecs.com',NULL,'Male','98765-4321098-7','Pakistani','Islam','Married',44),(4,'admin','Admin',NULL,'User','1985-03-20','adminUser_0',_binary '7©µ.i¾šÔ¨\Çø[¸ú','profile_pic4.jpg','1112223333','admin@example.com',NULL,'Male','11111-2222333-4','American','Islam','Married',37);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
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
