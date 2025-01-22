/*!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.8-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: BDD_S2
-- ------------------------------------------------------
-- Server version	10.11.8-MariaDB-0ubuntu0.24.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `CLIENT`
--

DROP TABLE IF EXISTS `CLIENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CLIENT` (
  `idClient` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) DEFAULT NULL,
  `ville` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idClient`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT`
--

LOCK TABLES `CLIENT` WRITE;
/*!40000 ALTER TABLE `CLIENT` DISABLE KEYS */;
INSERT INTO `CLIENT` VALUES
(1,'Mutz','Ruelisheim'),
(2,'Rato','Besancon'),
(3,'Goerig','Walheim'),
(4,'Walter','Bretten'),
(5,'PAUTOT','Belfort'),
(6,'PETIT','Belfort'),
(7,'SAINT DIZIER','Sevenans'),
(8,'SALVI','Offemont'),
(9,'TERRAT','Belfort'),
(10,'TYRODE','Valdoie'),
(11,'ALANKAYA','Bavilliers'),
(12,'DAROSEY','Essert'),
(13,'duguet','Belfort'),
(14,'ESSENBURGER','Belfort'),
(15,'JAOUEN','Sevenans'),
(16,'molin','Belfort'),
(17,'AMGHAR','Belfort'),
(18,'BOUCHAUD','Belfort'),
(19,'COTTARD','Belfort'),
(20,'dirand','Valdoie'),
(21,'LAMOTTE','Belfort'),
(22,'METTEY','Belfort'),
(23,'WOLF','Belfort'),
(24,'BISMUTH','Belfort'),
(25,'chaillet','Belfort'),
(26,'DECOCK','Belfort');
/*!40000 ALTER TABLE `CLIENT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ARTICLE`
--

DROP TABLE IF EXISTS `ARTICLE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ARTICLE` (
  `idArticle` int(11) NOT NULL AUTO_INCREMENT,
  `designation` varchar(255) DEFAULT NULL,
  `prix` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`idArticle`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ARTICLE`
--

LOCK TABLES `ARTICLE` WRITE;
/*!40000 ALTER TABLE `ARTICLE` DISABLE KEYS */;
INSERT INTO `ARTICLE` VALUES
(1,'Gâteaux chocolat ( pâtisserie)',5.25),
(2,'gâteau fraise (pâtisserie) ',5.25),
(3,'Mouchoir ( hygiène)',2.54),
(4,'Coca cola ( boisson )',1.52),
(5,'Salade ( légume ) ',2.00),
(6,'Choux ( légume ) ',2.50),
(7,'Pomme de terre ( légume ) ',1.50),
(8,'Tomate ( légume ) ',1.50),
(9,'Haricot ( légume ) ',6.50),
(10,'Potiron ( légume ) ',3.00),
(11,'Poireau ( légume ) ',1.50),
(12,'Fenouil ( légume ) ',3.00),
(13,'Pissenlit ( légume ) ',5.00),
(14,'Petit pois ( légume ) ',6.00),
(15,'Poivron ( légume ) ',3.00),
(16,'Radis ( légume ) ',2.00),
(17,'Pomme ( fruit ) ',3.00),
(18,'Perrier ( 1L eau ) ',1.50),
(19,'Vittel ( 1L eau ) ',1.80);
/*!40000 ALTER TABLE `ARTICLE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `COMMANDE`
--

DROP TABLE IF EXISTS `COMMANDE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `COMMANDE` (
  `idCommande` int(11) NOT NULL AUTO_INCREMENT,
  `dateCommande` date DEFAULT NULL,
  `idClient` int(11) DEFAULT NULL,
  PRIMARY KEY (`idCommande`),
  KEY `idClient` (`idClient`),
  CONSTRAINT `COMMANDE_ibfk_1` FOREIGN KEY (`idClient`) REFERENCES `CLIENT` (`idClient`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `COMMANDE`
--

LOCK TABLES `COMMANDE` WRITE;
/*!40000 ALTER TABLE `COMMANDE` DISABLE KEYS */;
INSERT INTO `COMMANDE` VALUES
(1,'2023-04-11',3),
(2,'2023-12-11',2),
(3,'2024-01-28',4),
(4,'2023-09-19',1),
(5,'2022-04-11',3),
(6,'2023-12-11',2),
(7,'2023-03-28',4),
(8,'2023-12-09',1),
(9,'2022-04-11',3),
(10,'2023-12-11',2);
/*!40000 ALTER TABLE `COMMANDE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LIGNE`
--

DROP TABLE IF EXISTS `LIGNE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LIGNE` (
  `idCommande` int(11) NOT NULL,
  `idArticle` int(11) NOT NULL,
  `quantite` int(11) DEFAULT NULL,
  PRIMARY KEY (`idCommande`,`idArticle`),
  KEY `idArticle` (`idArticle`),
  CONSTRAINT `LIGNE_ibfk_1` FOREIGN KEY (`idCommande`) REFERENCES `COMMANDE` (`idCommande`),
  CONSTRAINT `LIGNE_ibfk_2` FOREIGN KEY (`idArticle`) REFERENCES `ARTICLE` (`idArticle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LIGNE`
--

LOCK TABLES `LIGNE` WRITE;
/*!40000 ALTER TABLE `LIGNE` DISABLE KEYS */;
INSERT INTO `LIGNE` VALUES
(1,4,12),
(1,9,4),
(1,12,4),
(1,15,4),
(2,3,6),
(2,6,6),
(2,7,6),
(2,14,6),
(3,1,3),
(3,11,3),
(3,12,3),
(3,16,3),
(4,2,27),
(4,8,5),
(4,10,5),
(4,17,5),
(5,12,4),
(6,11,3),
(7,8,5),
(8,14,6);
/*!40000 ALTER TABLE `LIGNE` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-01-15 11:25:17
