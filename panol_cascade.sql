-- MariaDB dump 10.19  Distrib 10.4.24-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: panol
-- ------------------------------------------------------
-- Server version	10.4.24-MariaDB

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
-- Table structure for table `baja_herramientas`
--

DROP TABLE IF EXISTS `baja_herramientas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `baja_herramientas` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `observaciones` varchar(500) DEFAULT NULL,
  `tipo_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tipo_id` (`tipo_id`),
  CONSTRAINT `baja_herramientas_ibfk_1` FOREIGN KEY (`tipo_id`) REFERENCES `tipos_herramienta` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `baja_herramientas`
--

LOCK TABLES `baja_herramientas` WRITE;
/*!40000 ALTER TABLE `baja_herramientas` DISABLE KEYS */;
/*!40000 ALTER TABLE `baja_herramientas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorias`
--

DROP TABLE IF EXISTS `categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorias`
--

LOCK TABLES `categorias` WRITE;
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
INSERT INTO `categorias` VALUES (1,'Manual');
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consumibles`
--

DROP TABLE IF EXISTS `consumibles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `consumibles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `unidad` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `imagen` varchar(255) DEFAULT NULL,
  `subcategoria_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `subcategoria_id` (`subcategoria_id`),
  CONSTRAINT `consumibles_ibfk_1` FOREIGN KEY (`subcategoria_id`) REFERENCES `subcategorias` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consumibles`
--

LOCK TABLES `consumibles` WRITE;
/*!40000 ALTER TABLE `consumibles` DISABLE KEYS */;
INSERT INTO `consumibles` VALUES (1,'Clavos de cabeza plana de 20mm',0,80,'imagen1.png',1);
/*!40000 ALTER TABLE `consumibles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `devoluciones`
--

DROP TABLE IF EXISTS `devoluciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `devoluciones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pedido_id_fk` int(11) DEFAULT NULL,
  `herramienta_id_fk` int(11) DEFAULT NULL,
  `usuario_fk` int(11) DEFAULT NULL,
  `fecha_devolucion` date DEFAULT NULL,
  `horario_devolucion` time DEFAULT NULL,
  `estado_fk` int(11) DEFAULT NULL,
  `observaciones` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pedido_id_fk` (`pedido_id_fk`),
  KEY `herramienta_id_fk` (`herramienta_id_fk`),
  KEY `usuario_fk` (`usuario_fk`),
  KEY `estado_fk` (`estado_fk`),
  CONSTRAINT `devoluciones_ibfk_1` FOREIGN KEY (`pedido_id_fk`) REFERENCES `pedidos` (`id`) ON DELETE CASCADE,
  CONSTRAINT `devoluciones_ibfk_2` FOREIGN KEY (`herramienta_id_fk`) REFERENCES `herramientas` (`id`) ON DELETE CASCADE,
  CONSTRAINT `devoluciones_ibfk_3` FOREIGN KEY (`usuario_fk`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `devoluciones_ibfk_4` FOREIGN KEY (`estado_fk`) REFERENCES `estado` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devoluciones`
--

LOCK TABLES `devoluciones` WRITE;
/*!40000 ALTER TABLE `devoluciones` DISABLE KEYS */;
/*!40000 ALTER TABLE `devoluciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estado`
--

DROP TABLE IF EXISTS `estado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estado` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `estado` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estado`
--

LOCK TABLES `estado` WRITE;
/*!40000 ALTER TABLE `estado` DISABLE KEYS */;
/*!40000 ALTER TABLE `estado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `herramientas`
--

DROP TABLE IF EXISTS `herramientas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `herramientas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `imagen` varchar(255) DEFAULT NULL,
  `observaciones` varchar(500) DEFAULT NULL,
  `tipo_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tipo_id` (`tipo_id`),
  CONSTRAINT `herramientas_ibfk_1` FOREIGN KEY (`tipo_id`) REFERENCES `tipos_herramienta` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `herramientas`
--

LOCK TABLES `herramientas` WRITE;
/*!40000 ALTER TABLE `herramientas` DISABLE KEYS */;
INSERT INTO `herramientas` VALUES (1,'imagen2.png','asd',2);
/*!40000 ALTER TABLE `herramientas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historica`
--

DROP TABLE IF EXISTS `historica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `historica` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pedido_id_fk` int(11) DEFAULT NULL,
  `usuario_fk` int(11) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `horario` time DEFAULT NULL,
  `estado_fk` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pedido_id_fk` (`pedido_id_fk`),
  KEY `usuario_fk` (`usuario_fk`),
  KEY `estado_fk` (`estado_fk`),
  CONSTRAINT `historica_ibfk_1` FOREIGN KEY (`pedido_id_fk`) REFERENCES `pedidos` (`id`) ON DELETE CASCADE,
  CONSTRAINT `historica_ibfk_2` FOREIGN KEY (`usuario_fk`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `historica_ibfk_3` FOREIGN KEY (`estado_fk`) REFERENCES `estado` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historica`
--

LOCK TABLES `historica` WRITE;
/*!40000 ALTER TABLE `historica` DISABLE KEYS */;
/*!40000 ALTER TABLE `historica` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historica_consumibles`
--

DROP TABLE IF EXISTS `historica_consumibles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `historica_consumibles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pedido_id_fk` int(11) DEFAULT NULL,
  `consumible_id_fk` int(11) DEFAULT NULL,
  `usuario_fk` int(11) DEFAULT NULL,
  `fecha_entrega` date DEFAULT NULL,
  `horario_entrega` time DEFAULT NULL,
  `cantidad` int(11) NOT NULL,
  `estado_fk` int(11) DEFAULT NULL,
  `observaciones` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pedido_id_fk` (`pedido_id_fk`),
  KEY `consumible_id_fk` (`consumible_id_fk`),
  KEY `usuario_fk` (`usuario_fk`),
  KEY `estado_fk` (`estado_fk`),
  CONSTRAINT `historica_consumibles_ibfk_1` FOREIGN KEY (`pedido_id_fk`) REFERENCES `pedidos` (`id`) ON DELETE CASCADE,
  CONSTRAINT `historica_consumibles_ibfk_2` FOREIGN KEY (`consumible_id_fk`) REFERENCES `consumibles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `historica_consumibles_ibfk_3` FOREIGN KEY (`usuario_fk`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `historica_consumibles_ibfk_4` FOREIGN KEY (`estado_fk`) REFERENCES `estado` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historica_consumibles`
--

LOCK TABLES `historica_consumibles` WRITE;
/*!40000 ALTER TABLE `historica_consumibles` DISABLE KEYS */;
/*!40000 ALTER TABLE `historica_consumibles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historica_herramientas`
--

DROP TABLE IF EXISTS `historica_herramientas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `historica_herramientas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pedido_id_fk` int(11) DEFAULT NULL,
  `herramienta_id_fk` int(11) DEFAULT NULL,
  `usuario_fk` int(11) DEFAULT NULL,
  `fecha_entrega` date DEFAULT NULL,
  `fecha_devolucion` date DEFAULT NULL,
  `horario_entrega` time DEFAULT NULL,
  `horario_devolucion` time DEFAULT NULL,
  `cantidad` int(11) NOT NULL,
  `estado_fk` int(11) DEFAULT NULL,
  `observaciones` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pedido_id_fk` (`pedido_id_fk`),
  KEY `herramienta_id_fk` (`herramienta_id_fk`),
  KEY `usuario_fk` (`usuario_fk`),
  KEY `estado_fk` (`estado_fk`),
  CONSTRAINT `historica_herramientas_ibfk_1` FOREIGN KEY (`pedido_id_fk`) REFERENCES `pedidos` (`id`) ON DELETE CASCADE,
  CONSTRAINT `historica_herramientas_ibfk_2` FOREIGN KEY (`herramienta_id_fk`) REFERENCES `herramientas` (`id`) ON DELETE CASCADE,
  CONSTRAINT `historica_herramientas_ibfk_3` FOREIGN KEY (`usuario_fk`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `historica_herramientas_ibfk_4` FOREIGN KEY (`estado_fk`) REFERENCES `estado` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historica_herramientas`
--

LOCK TABLES `historica_herramientas` WRITE;
/*!40000 ALTER TABLE `historica_herramientas` DISABLE KEYS */;
/*!40000 ALTER TABLE `historica_herramientas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido_consumibles`
--

DROP TABLE IF EXISTS `pedido_consumibles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pedido_consumibles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pedido_id_fk` int(11) DEFAULT NULL,
  `consumible_id_fk` int(11) DEFAULT NULL,
  `cantidad` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pedido_id_fk` (`pedido_id_fk`),
  KEY `consumible_id_fk` (`consumible_id_fk`),
  CONSTRAINT `pedido_consumibles_ibfk_1` FOREIGN KEY (`pedido_id_fk`) REFERENCES `pedidos` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pedido_consumibles_ibfk_2` FOREIGN KEY (`consumible_id_fk`) REFERENCES `consumibles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido_consumibles`
--

LOCK TABLES `pedido_consumibles` WRITE;
/*!40000 ALTER TABLE `pedido_consumibles` DISABLE KEYS */;
/*!40000 ALTER TABLE `pedido_consumibles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido_herramientas`
--

DROP TABLE IF EXISTS `pedido_herramientas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pedido_herramientas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pedido_id_fk` int(11) DEFAULT NULL,
  `herramienta_id_fk` int(11) DEFAULT NULL,
  `cantidad` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pedido_id_fk` (`pedido_id_fk`),
  KEY `herramienta_id_fk` (`herramienta_id_fk`),
  CONSTRAINT `pedido_herramientas_ibfk_1` FOREIGN KEY (`pedido_id_fk`) REFERENCES `pedidos` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pedido_herramientas_ibfk_2` FOREIGN KEY (`herramienta_id_fk`) REFERENCES `herramientas` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido_herramientas`
--

LOCK TABLES `pedido_herramientas` WRITE;
/*!40000 ALTER TABLE `pedido_herramientas` DISABLE KEYS */;
/*!40000 ALTER TABLE `pedido_herramientas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pedidos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario_fk` int(11) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `horario` time DEFAULT NULL,
  `estado_fk` int(11) DEFAULT NULL,
  `tipo_pedido` enum('herramienta','consumible') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `usuario_fk` (`usuario_fk`),
  KEY `estado_fk` (`estado_fk`),
  CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`usuario_fk`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pedidos_ibfk_2` FOREIGN KEY (`estado_fk`) REFERENCES `estado` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subcategorias`
--

DROP TABLE IF EXISTS `subcategorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subcategorias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `categoria_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `categoria_id` (`categoria_id`),
  CONSTRAINT `subcategorias_ibfk_1` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subcategorias`
--

LOCK TABLES `subcategorias` WRITE;
/*!40000 ALTER TABLE `subcategorias` DISABLE KEYS */;
INSERT INTO `subcategorias` VALUES (1,'Clavos',1);
/*!40000 ALTER TABLE `subcategorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipos_herramienta`
--

DROP TABLE IF EXISTS `tipos_herramienta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipos_herramienta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `disponibles` int(11) DEFAULT NULL,
  `subcategoria_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `subcategoria_id` (`subcategoria_id`),
  CONSTRAINT `tipos_herramienta_ibfk_1` FOREIGN KEY (`subcategoria_id`) REFERENCES `subcategorias` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipos_herramienta`
--

LOCK TABLES `tipos_herramienta` WRITE;
/*!40000 ALTER TABLE `tipos_herramienta` DISABLE KEYS */;
INSERT INTO `tipos_herramienta` VALUES (2,'Destornillador plano',1,1,1);
/*!40000 ALTER TABLE `tipos_herramienta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-09-20 19:30:25