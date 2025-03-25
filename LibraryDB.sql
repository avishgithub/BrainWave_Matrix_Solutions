-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: librarydb
-- ------------------------------------------------------
-- Server version	8.0.39

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
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books` (
  `BookID` int NOT NULL AUTO_INCREMENT,
  `Title` varchar(255) NOT NULL,
  `Author` varchar(255) DEFAULT NULL,
  `ISBN` varchar(20) NOT NULL,
  `Category` varchar(100) DEFAULT NULL,
  `AvailableCopies` int DEFAULT '1',
  PRIMARY KEY (`BookID`),
  UNIQUE KEY `ISBN` (`ISBN`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` VALUES (1,'The Alchemist','Paulo Coelho','9780061122415','Fiction',5),(2,'Harry Potter','J.K. Rowling','9780747532743','Fantasy',3),(3,'Rich Dad Poor Dad','Robert Kiyosaki','9781612680194','Finance',4),(4,'The Exponential Age','Azeem Azhar','9780747532754','Technology, Business, Society',7);
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `borrowings`
--

DROP TABLE IF EXISTS `borrowings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `borrowings` (
  `BorrowID` int NOT NULL AUTO_INCREMENT,
  `MemberID` int NOT NULL,
  `BookID` int NOT NULL,
  `BorrowDate` date DEFAULT (curdate()),
  `DueDate` date NOT NULL,
  `ReturnDate` date DEFAULT NULL,
  `Status` enum('Borrowed','Returned') DEFAULT 'Borrowed',
  PRIMARY KEY (`BorrowID`),
  KEY `MemberID` (`MemberID`),
  KEY `BookID` (`BookID`),
  CONSTRAINT `borrowings_ibfk_1` FOREIGN KEY (`MemberID`) REFERENCES `members` (`MemberID`) ON DELETE CASCADE,
  CONSTRAINT `borrowings_ibfk_2` FOREIGN KEY (`BookID`) REFERENCES `books` (`BookID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `borrowings`
--

LOCK TABLES `borrowings` WRITE;
/*!40000 ALTER TABLE `borrowings` DISABLE KEYS */;
INSERT INTO `borrowings` VALUES (7,1,1,'2025-03-24','2025-04-07',NULL,'Borrowed'),(8,2,2,'2025-03-24','2025-04-07',NULL,'Borrowed'),(9,3,3,'2025-03-24','2025-03-31',NULL,'Borrowed');
/*!40000 ALTER TABLE `borrowings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fine`
--

DROP TABLE IF EXISTS `fine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fine` (
  `FineID` int NOT NULL AUTO_INCREMENT,
  `MemberID` int NOT NULL,
  `BorrowID` int NOT NULL,
  `FineAmount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `Currency` varchar(10) DEFAULT 'INR',
  `FineStatus` enum('Unpaid','Paid') DEFAULT 'Unpaid',
  `PaymentDate` date DEFAULT NULL,
  PRIMARY KEY (`FineID`),
  KEY `MemberID` (`MemberID`),
  KEY `BorrowID` (`BorrowID`),
  CONSTRAINT `fine_ibfk_1` FOREIGN KEY (`MemberID`) REFERENCES `members` (`MemberID`) ON DELETE CASCADE,
  CONSTRAINT `fine_ibfk_2` FOREIGN KEY (`BorrowID`) REFERENCES `borrowings` (`BorrowID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fine`
--

LOCK TABLES `fine` WRITE;
/*!40000 ALTER TABLE `fine` DISABLE KEYS */;
INSERT INTO `fine` VALUES (7,1,7,250.00,'INR','Unpaid',NULL),(8,3,8,420.75,'INR','Paid',NULL);
/*!40000 ALTER TABLE `fine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `librarians`
--

DROP TABLE IF EXISTS `librarians`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `librarians` (
  `LibrarianID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Phone` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`LibrarianID`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `librarians`
--

LOCK TABLES `librarians` WRITE;
/*!40000 ALTER TABLE `librarians` DISABLE KEYS */;
INSERT INTO `librarians` VALUES (1,'Sunil Kumar','sunil789@gmail.com','9001122334');
/*!40000 ALTER TABLE `librarians` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loans`
--

DROP TABLE IF EXISTS `loans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loans` (
  `LoanID` int NOT NULL AUTO_INCREMENT,
  `BookID` int DEFAULT NULL,
  `MemberID` int DEFAULT NULL,
  `IssueDate` date DEFAULT (curdate()),
  `DueDate` date NOT NULL,
  `ReturnDate` date DEFAULT NULL,
  PRIMARY KEY (`LoanID`),
  KEY `BookID` (`BookID`),
  KEY `MemberID` (`MemberID`),
  CONSTRAINT `loans_ibfk_1` FOREIGN KEY (`BookID`) REFERENCES `books` (`BookID`) ON DELETE CASCADE,
  CONSTRAINT `loans_ibfk_2` FOREIGN KEY (`MemberID`) REFERENCES `members` (`MemberID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loans`
--

LOCK TABLES `loans` WRITE;
/*!40000 ALTER TABLE `loans` DISABLE KEYS */;
/*!40000 ALTER TABLE `loans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `members`
--

DROP TABLE IF EXISTS `members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `members` (
  `MemberID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Phone` varchar(15) DEFAULT NULL,
  `Address` text,
  `MembershipDate` date DEFAULT (curdate()),
  PRIMARY KEY (`MemberID`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members`
--

LOCK TABLES `members` WRITE;
/*!40000 ALTER TABLE `members` DISABLE KEYS */;
INSERT INTO `members` VALUES (1,'Raj Bansal','raj123@gmail.com','9876543210','ABC Mumbai','2025-03-24'),(2,'Sam Patel','sam456@gmail.com','9123456789','XYZ Mumbai','2025-03-24'),(3,'Daksh Patil','daksh789@gmail.com','9023456781','PQR Mumbai','2025-03-24');
/*!40000 ALTER TABLE `members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservations`
--

DROP TABLE IF EXISTS `reservations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservations` (
  `ReservationID` int NOT NULL AUTO_INCREMENT,
  `MemberID` int NOT NULL,
  `BookID` int NOT NULL,
  `ReservationDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Status` enum('Pending','Cancelled','Completed') DEFAULT 'Pending',
  PRIMARY KEY (`ReservationID`),
  KEY `MemberID` (`MemberID`),
  KEY `BookID` (`BookID`),
  CONSTRAINT `reservations_ibfk_1` FOREIGN KEY (`MemberID`) REFERENCES `members` (`MemberID`) ON DELETE CASCADE,
  CONSTRAINT `reservations_ibfk_2` FOREIGN KEY (`BookID`) REFERENCES `books` (`BookID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservations`
--

LOCK TABLES `reservations` WRITE;
/*!40000 ALTER TABLE `reservations` DISABLE KEYS */;
INSERT INTO `reservations` VALUES (1,1,4,'2025-03-24 14:51:15','Pending'),(2,2,1,'2025-03-24 14:51:15','Pending'),(3,3,2,'2025-03-24 14:51:15','Pending');
/*!40000 ALTER TABLE `reservations` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-25 18:48:46
