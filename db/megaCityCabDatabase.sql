CREATE DATABASE  IF NOT EXISTS `megacitycab` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `megacitycab`;
-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: megacitycab
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings` (
  `booking_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `cab_type` varchar(50) DEFAULT NULL,
  `pickup_location` varchar(255) DEFAULT NULL,
  `dropoff_location` varchar(255) DEFAULT NULL,
  `pickup_time` varchar(50) DEFAULT NULL,
  `status` enum('Pending','Confirmed','Completed','Cancelled') DEFAULT 'Pending',
  `cab_id` int DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `distance` decimal(10,1) DEFAULT NULL,
  PRIMARY KEY (`booking_id`),
  KEY `user_id` (`user_id`),
  KEY `cab_id` (`cab_id`),
  CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`userid`),
  CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`cab_id`) REFERENCES `cabs` (`cab_id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings`
--

LOCK TABLES `bookings` WRITE;
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
INSERT INTO `bookings` VALUES (1,7,'SUV','Col','Col6','2025-03-06T01:33','Confirmed',4,56.80,NULL),(2,7,'SUV','Town','16 Hampden','2025-03-06T05:00','Cancelled',NULL,38.95,NULL),(3,7,'Mini','Colombo 3 (Kollupitiya)','Pettah','2025-03-07T14:20','Confirmed',8,19.96,NULL),(4,7,'SUV','Colombo Fort','Colombo International Airport','2025-03-07T14:56','Cancelled',NULL,571.63,NULL),(5,8,'SUV','Moratuwa','Kirulapone','2025-03-07T15:08','Completed',1,521.03,NULL),(6,7,'Mini','Town','16 Hampden','2025-03-07T03:13','Completed',1,78.40,NULL),(7,7,'SUV','Town','16 Hampden','2025-03-08T03:19','Cancelled',NULL,84.00,NULL),(8,7,'SUV','Town','Col6','2025-03-08T05:23','Cancelled',NULL,58.40,29.0),(9,7,'Sedan','Colombo 06','Colombo 05','2025-03-19T15:00','Completed',3,30.00,10.0),(10,7,'SUV','Borella','Moratuwa','2025-03-08T13:51','Cancelled',NULL,507.68,NULL),(11,7,'Mini','Colombo Fort','Moratuwa','2025-03-06T13:57','Completed',5,498.05,NULL),(12,7,'Mini','Mount Lavinia','Nugegoda','2025-03-14T14:00','Cancelled',NULL,208.00,6.4),(13,7,'SUV','Colombo Fort','Dehiwala','2025-03-07T03:06','Cancelled',NULL,393.19,13.2),(14,7,'SUV','Dehiwala','Borella','2025-03-07T02:11','Cancelled',NULL,217.35,3.4),(15,9,'Mini','Dehiwala','Malabe','2025-03-10T13:20','Cancelled',NULL,188.29,5.4),(16,7,'Sedan','Colombo Fort','Moratuwa','2025-03-07T16:56','Completed',1,514.05,27.1),(17,7,'Mini','Kelaniya','Colombo International Airport','2025-03-12T15:47','Cancelled',NULL,458.17,24.6),(18,7,'Mini','Nugegoda','Colombo International Airport','2025-03-28T19:35','Cancelled',NULL,541.00,29.8),(19,7,'Mini','Nugegoda','Kelaniya','2025-03-19T10:04','Cancelled',NULL,192.33,5.6),(20,7,'Mini','Colombo 7','Pettah','2025-03-07T20:19','Cancelled',NULL,205.17,6.3),(21,7,'Sedan','Kelaniya','Rajagiriya','2025-04-05T18:22','Cancelled',NULL,211.90,5.6),(22,7,'Mini','Mount Lavinia Beach','Wattala','2025-03-27T21:15','Completed',5,324.15,13.1),(23,7,'SUV','Wattala','Mount Lavinia','2025-03-27T21:21','Cancelled',NULL,389.14,13.0),(24,7,'Mini','Borella','Wattala','2025-03-29T22:48','Cancelled',NULL,210.98,6.5),(25,7,'SUV','Colombo International Airport','Kelaniya','2025-03-22T21:41','Confirmed',9,514.17,24.6),(26,7,'SUV','Colombo Fort','Nugegoda','2025-03-14T03:38','Cancelled',NULL,376.98,12.3),(27,7,'Sedan','Dehiwala','Moratuwa','2025-03-27T22:53','Cancelled',NULL,414.00,20.9),(28,7,'Sedan','Colombo 7','Moratuwa','2025-03-21T22:55','Confirmed',2,470.60,24.4),(29,7,'SUV','Colombo International Airport','Borella','2025-03-29T23:02','Confirmed',4,596.67,29.8),(30,7,'SUV','Kirulapone','Colombo 7','2025-03-21T23:28','Cancelled',NULL,191.17,2.1),(31,7,'Sedan','Dehiwala','Moratuwa','2025-03-22T23:36','Cancelled',NULL,414.00,20.9),(32,13,'Sedan','Colombo 7','Moratuwa','2025-03-29T00:13','Pending',NULL,470.60,24.4),(33,7,'SUV','Wattala','Pettah','2025-03-20T02:21','Pending',NULL,184.68,1.7),(34,7,'SUV','Malabe','Colombo 3 (Kollupitiya)','2025-03-29T02:23','Cancelled',NULL,215.69,3.3),(35,16,'SUV','Colombo Fort','Colombo 7','2025-03-15T10:00','Completed',17,344.93,10.7);
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cabs`
--

DROP TABLE IF EXISTS `cabs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cabs` (
  `cab_id` int NOT NULL AUTO_INCREMENT,
  `cab_number` varchar(20) NOT NULL,
  `model` varchar(50) NOT NULL,
  `cab_type` enum('Sedan','SUV','Mini') NOT NULL,
  `capacity` int NOT NULL,
  `status` enum('available','busy') DEFAULT 'available',
  `driver_id` int DEFAULT NULL,
  PRIMARY KEY (`cab_id`),
  UNIQUE KEY `cab_number_UNIQUE` (`cab_number`),
  KEY `fk_cab_cab` (`driver_id`),
  CONSTRAINT `fk_cab_cab` FOREIGN KEY (`driver_id`) REFERENCES `driver` (`driver_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cabs`
--

LOCK TABLES `cabs` WRITE;
/*!40000 ALTER TABLE `cabs` DISABLE KEYS */;
INSERT INTO `cabs` VALUES (1,'CQ8009','Toyota Prius','Sedan',5,'busy',4),(2,'CA3456','Toyota Premio','Sedan',5,'busy',10),(3,'AB1234','Toyota Camry','Sedan',4,'busy',1),(4,'CD5678','Honda CR-V','SUV',6,'busy',3),(5,'EF9012','Hyundai i10','Mini',4,'busy',2),(6,'GH3456','Ford Explorer','SUV',7,'available',NULL),(7,'IJ7890','Maruti Swift','Mini',4,'busy',NULL),(8,'KL2345','Honda Accord','Sedan',4,'busy',NULL),(9,'MN6789','Toyota Highlander','SUV',7,'busy',5),(10,'OP1234','Tata Tiago','Mini',4,'available',NULL),(11,'BH2345','Suzuki Alto','Sedan',5,'available',NULL),(13,'CA5678','BMW','SUV',6,'available',NULL),(14,'BA2045','Honda Fit','Mini',5,'available',NULL),(17,'CD1122','Kia Sorento','SUV',6,'available',12);
/*!40000 ALTER TABLE `cabs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `driver`
--

DROP TABLE IF EXISTS `driver`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `driver` (
  `driver_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `license_number` varchar(45) NOT NULL,
  `phone_number` varchar(45) NOT NULL,
  `address` varchar(60) DEFAULT NULL,
  `status` enum('available','busy') DEFAULT NULL,
  `cab_id` int DEFAULT NULL,
  `is_authorized` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`driver_id`),
  UNIQUE KEY `license_number_UNIQUE` (`license_number`),
  KEY `fk_driver_cab` (`cab_id`),
  CONSTRAINT `fk_driver_cab` FOREIGN KEY (`cab_id`) REFERENCES `cabs` (`cab_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `driver`
--

LOCK TABLES `driver` WRITE;
/*!40000 ALTER TABLE `driver` DISABLE KEYS */;
INSERT INTO `driver` VALUES (1,'Driver 1','D8765432','0776543244','No.66,Pirivena Road,Colombo08','busy',3,1),(2,'Driver 2','D8765437','0776543744','No.7,Hospital Lane,Colombo06','busy',5,1),(3,'Priyantha Rathnayake','D8765490','0716416783','No.7,Park Street,Colombo 06','busy',4,0),(4,'Mahinda Gunasekara','I8790490','0716416543','No.7,Manning Place,Colombo 06','busy',1,1),(5,'shanej','D8765439','0716416589','Kollupitiya','busy',9,0),(6,'Menaka Rajapaksha','M8907439','0716413763','No.6,Krester Place,Colombo04','available',NULL,0),(7,'Sheron','B6745345','0715465765','Bandarawela','available',NULL,0),(10,'Driver 3','W2343434','0776666666','Haputale','busy',2,0),(11,'newDriver','R5674567','0786655432','Diyatalawa','available',NULL,0),(12,'Test driver','B1234567','0773456789','No.05, Dehiwala, Colombo','busy',17,1);
/*!40000 ALTER TABLE `driver` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `locations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `latitude` double NOT NULL,
  `longitude` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locations`
--

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
INSERT INTO `locations` VALUES (1,'Colombo Fort',6.9271,79.8612),(2,'Colombo 7',6.929,79.9577),(3,'Colombo 3 (Kollupitiya)',6.9278,79.9742),(4,'Borella',6.9279,79.9747),(5,'Pettah',6.9814,79.9784),(6,'Mount Lavinia',6.8696,79.9756),(7,'Dehiwala',6.8977,79.977),(8,'Kirulapone',6.9354,79.9752),(9,'Rajagiriya',6.9273,79.9754),(10,'Nugegoda',6.9271,79.973),(11,'Kottawa',6.889,79.9939),(12,'Battaramulla',6.9292,79.9811),(13,'Malabe',6.94,80.0013),(14,'Wattala',6.9857,79.9633),(15,'Kelaniya',6.9776,79.9741),(16,'Mount Lavinia Beach',6.869,79.9767),(17,'Colombo International Airport',7.18,79.8833),(18,'Sri Jayawardenepura Kotte',6.9279,79.9972),(19,'Moratuwa',6.71,79.9733);
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `userid` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `username` varchar(15) NOT NULL,
  `password` varchar(225) NOT NULL,
  `email` varchar(30) NOT NULL,
  `phonenumber` varchar(15) DEFAULT NULL,
  `address` varchar(40) DEFAULT NULL,
  `NIC` varchar(12) NOT NULL,
  `role` enum('admin','customer','driver') DEFAULT 'customer',
  PRIMARY KEY (`userid`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `NIC_UNIQUE` (`NIC`),
  UNIQUE KEY `phonenumber_UNIQUE` (`phonenumber`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin','admin','240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9','admin@gmail.com','0711268077','No.8,Model Town,Colombo06','200279103178','admin'),(2,'Chamodi Hansika','chamodi','8684cfd1d96b660a3e036c0c640907deb5144fb367891c1ab1cb5d0639334d05','chamodi@gmail.com','0716416492','No.7,Hospital Lane,Colombo06','97654323457V','customer'),(3,'Vishmi Perera','vishmi','3a3424b7ae2d3e66c6e1da54cf6181e829b4e6187e7241035c79b98d3cb24b3b','vishmi@gmail.com','0776589744','No.7,Hospital Lane,Colombo06','200278654367','customer'),(4,'Luna John','luna','ec67242fa63a32f2808625436cf5422a20583d9feb371fff69d8a1a19bd9e9e9','luna@gmail.com','0776543211','No.66,Pirivena Road,Colombo06','200678654763','customer'),(5,'Chamashi Nethsarani','chamashi','2e41f534e3071687887c8e4795325cb7d0a7e21ab87e3ffaa890c15d9b16f0f6','chamashi@gmail.com','0716785433','No.48,Pipeline Road,Colombo04','200278654388','customer'),(7,'shanej','shanemj','b25d6a431968b4285031761a3f0887c7bf1820aef0d5b9546328baeea4825074','shanemj@gmail.com','0789898999','Kollupitiya','20028978678','customer'),(8,'Malcolm','malcolm','bae5025bc62a8cb51163f9069b76041f16347e8ae79d080858084953e80e748a','malcolm@gmail.com','0786787654','Bandarawela','229989098765','customer'),(9,'Fathima Afra','Afra','a47c599adad9fa20ed06a7c66ca023810567ef46695de9bba227c1dedef36f48','afra@gmail.com','0768554323','No.80,Fuzzles Lane, Colombo6','200345786589','customer'),(10,'Driver 1','driver1','c8ffa9fcf473102b5526af2a62f39db33d006b49c8ee5324698bf1394556bd87','driver1@gmail.com','0776543244','No.66,Pirivena Road,Colombo08','200767855456','driver'),(11,'Driver 2','driver2','da4b3ff1c6297947d1cc6041fdb4b1a44a76c80d7f4b637e5a76f3c3c12dacb5','driver2@gmail.com','0776543744','No.7,Hospital Lane,Colombo06','244567355678','driver'),(12,'Mahinda Gunasekara','mahinda','177ff978c3dc8c655adcca816170832177467ff3232853f2325bc76a15156d4f','mahinda@gmail.com','0716416543','No.7,Manning Place,Colombo 06','200878699678','driver'),(13,'Mashi','mashi','deb4ba6ea7cad31da50807e2146efb9da41d1301bb42f8990a83490c14b0f375','mashi@gmail.com','0701268977','No.6 Pinnalanda Gardens, Badulla','200278896785','customer'),(16,'testuser','testuser','ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f','testuser1@gmail.com','0771234567','123 Test Street ','123456789V ','customer'),(17,'Test driver','testdriver','47dccb3f924eb7b6d86f868331c8dd80b89af795fcf75b610e83721f94a75f99','testdriver@gmail.com','0773456789','No.05, Dehiwala, Colombo','112233445v','driver'),(18,'Invalid User','invaliduser','a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3','invaliduser@gmail.com','0771122333 ','123 Main Street','3344556V ','customer');
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

-- Dump completed on 2025-03-14 22:34:12
