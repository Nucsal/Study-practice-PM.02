CREATE DATABASE  IF NOT EXISTS `pm02` /*!40100 DEFAULT CHARACTER SET cp1251 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `pm02`;
-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: pm02
-- ------------------------------------------------------
-- Server version	8.0.45

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
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id_u` int NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `password_u` varchar(255) NOT NULL,
  PRIMARY KEY (`id_u`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=cp1251;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'User1@mail.ru','1111'),(2,'User2@mail.ru','2222'),(3,'User3@mail.ru','3333'),(4,'User1@gmail.com','$2b$10$F4A2LoB6Ev4aLyYvcApVze8ciGEo3P3wBkHFBWYmwK9OZ9To3yngq'),(5,'1@mail.ro','$2b$10$sN1I7DghC6zcSiZVKdzUyOy5i7A.6S2Jq/AwveaZCNQY9iuV.r2ge'),(6,'1@mail.ru','$2b$10$YOGhv2zMohUXuAfgj2nt.u67TW.IfTO3R471tfjbRxa.2bu8VhOuO'),(7,'User11@gmail.com','$2b$10$CAlLRoEFgVpyrEbckdIjTOd0K4rh1szBv5SnuaCMb4FAts6M1rHx2'),(8,'User111@gmail.com','$2b$10$Yz8tl2nG9Gsh4DuDnwvsQevmqnY20mF2piLuX48sfNhoRuAH3OssG'),(9,'Use@g.eu','$2b$10$mI1ZJoL1u4mDkS7FwDFfl.2/UmFe302xIy0zT7JAOX5Njzub30B8m'),(10,'User1111@g','$2b$10$fo0Wf7sh790zDymQM.zfv.SfYk.voIWoxrdrM083pffNBH0IMPbTW'),(11,'prorokSunboy@mail.com','$2b$10$RYdCLHzhwqv.aAubZuxRH.CAGAeK8fuKgaielac6EPziF3KjC.K7m');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proposals`
--

DROP TABLE IF EXISTS `proposals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proposals` (
  `id_fb` int NOT NULL AUTO_INCREMENT,
  `id_u_fk` int NOT NULL,
  `note` varchar(500) NOT NULL,
  PRIMARY KEY (`id_fb`),
  KEY `id_u_fk` (`id_u_fk`),
  CONSTRAINT `proposals_ibfk_1` FOREIGN KEY (`id_u_fk`) REFERENCES `users` (`id_u`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=cp1251;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proposals`
--

LOCK TABLES `proposals` WRITE;
/*!40000 ALTER TABLE `proposals` DISABLE KEYS */;
INSERT INTO `proposals` VALUES (1,1,'Один'),(2,2,'Два'),(3,3,'Три'),(6,7,'1'),(7,7,'Я бы хотел улучшить вашу статью, но, боюсь, она уже прекрасна...'),(8,11,'Я бы хотел улучшить вашу статью, но, боюсь, она уже прекрасна...');
/*!40000 ALTER TABLE `proposals` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-22 15:57:16
