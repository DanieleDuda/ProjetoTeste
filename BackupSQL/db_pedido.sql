-- MySQL dump 10.13  Distrib 5.1.73, for Win32 (ia32)
--
-- Host: localhost    Database: db_pedido
-- ------------------------------------------------------
-- Server version	5.1.73-community

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tb_cliente`
--

DROP TABLE IF EXISTS `tb_cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_cliente` (
  `codigo` int(11) NOT NULL,
  `nome` varchar(45) DEFAULT NULL,
  `cidade` varchar(45) DEFAULT NULL,
  `uf` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_cliente`
--

LOCK TABLES `tb_cliente` WRITE;
/*!40000 ALTER TABLE `tb_cliente` DISABLE KEYS */;
INSERT INTO `tb_cliente` VALUES (1,'Cliente 1','Araraquara','SP'),(2,'Cliente 2','Araraquara','SP'),(3,'Cliente 3','Araraquara','SP'),(4,'Cliente 4','Araraquara','SP'),(5,'Cliente 5','Araraquara','SP'),(6,'Cliente 6','Araraquara','SP'),(7,'Cliente 7','Araraquara','SP'),(8,'Cliente 8','Araraquara','SP'),(9,'Cliente 9','Araraquara','SP'),(10,'Cliente 10','Araraquara','SP'),(11,'Cliente 11','Araraquara','SP'),(12,'Cliente 12','Araraquara','SP'),(13,'Cliente 13','Araraquara','SP'),(14,'Cliente 14','Araraquara','SP'),(15,'Cliente 15','Araraquara','SP'),(16,'Cliente 16','Araraquara','SP'),(17,'Cliente 17','Araraquara','SP'),(18,'Cliente 18','Araraquara','SP'),(19,'Cliente 19','Araraquara','SP'),(20,'Cliente 20','Araraquara','SP');
/*!40000 ALTER TABLE `tb_cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_pedido`
--

DROP TABLE IF EXISTS `tb_pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_pedido` (
  `id_pedido` int(11) NOT NULL,
  `data_emissao` date DEFAULT NULL,
  `fk_cod_cliente` int(11) DEFAULT NULL,
  `valor_total_pedido` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_pedido`),
  KEY `FK_CODIGO_CLIENTE_idx` (`fk_cod_cliente`),
  CONSTRAINT `FK_CODIGO_CLIENTE` FOREIGN KEY (`fk_cod_cliente`) REFERENCES `tb_cliente` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_pedido`
--

LOCK TABLES `tb_pedido` WRITE;
/*!40000 ALTER TABLE `tb_pedido` DISABLE KEYS */;
INSERT INTO `tb_pedido` VALUES (1,'2021-09-29',1,'1.50'),(2,'2021-09-29',1,'4.60');
/*!40000 ALTER TABLE `tb_pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_produto`
--

DROP TABLE IF EXISTS `tb_produto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_produto` (
  `codigo_produto` int(11) NOT NULL,
  `descricao` varchar(45) DEFAULT NULL,
  `preco_venda` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`codigo_produto`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_produto`
--

LOCK TABLES `tb_produto` WRITE;
/*!40000 ALTER TABLE `tb_produto` DISABLE KEYS */;
INSERT INTO `tb_produto` VALUES (1,'Produto1','1.00'),(2,'Produto 2','2.00'),(3,'Produto 3','3.00'),(4,'Produto 4','4.00'),(5,'Produto 5','5.00'),(6,'Produto 6','6.00'),(7,'Produto 7','7.00'),(8,'Produto 8','8.00'),(9,'Produto 9','9.00'),(10,'Produto 10','10.00'),(11,'Produto 11','11.00'),(12,'Produto 12','12.00'),(13,'Produto 13','13.00'),(14,'Produto 14','14.00'),(15,'Produto 15','15.00'),(16,'Produto 16','16.00'),(17,'Produto 17','17.00'),(18,'Produto 18','18.00'),(19,'Produto 19','19.00'),(20,'Produto 20','20.50');
/*!40000 ALTER TABLE `tb_produto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_produto_pedido`
--

DROP TABLE IF EXISTS `tb_produto_pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_produto_pedido` (
  `id_produto_pedido` int(11) NOT NULL AUTO_INCREMENT,
  `fk_num_pedido` int(11) DEFAULT NULL,
  `fk_cod_produto` int(11) DEFAULT NULL,
  `quantidade` int(11) DEFAULT NULL,
  `valor_unitario` decimal(10,2) DEFAULT NULL,
  `valor_total` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_produto_pedido`),
  KEY `FK_NUM_PEDIDO` (`fk_num_pedido`),
  KEY `FK_COD_PRODUTO` (`fk_cod_produto`),
  CONSTRAINT `FK_COD_PRODUTO` FOREIGN KEY (`fk_cod_produto`) REFERENCES `tb_produto` (`codigo_produto`),
  CONSTRAINT `FK_NUM_PEDIDO` FOREIGN KEY (`fk_num_pedido`) REFERENCES `tb_pedido` (`id_pedido`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_produto_pedido`
--

LOCK TABLES `tb_produto_pedido` WRITE;
/*!40000 ALTER TABLE `tb_produto_pedido` DISABLE KEYS */;
INSERT INTO `tb_produto_pedido` VALUES (19,1,2,1,'1.50','1.50'),(20,2,2,1,'2.00','2.00'),(21,2,6,2,'1.30','2.60');
/*!40000 ALTER TABLE `tb_produto_pedido` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-09-29 22:49:28
