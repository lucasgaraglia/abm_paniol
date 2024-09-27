-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 28, 2024 at 01:19 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `panol`
--

-- --------------------------------------------------------

--
-- Table structure for table `baja_herramientas`
--

CREATE TABLE `baja_herramientas` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `imagen` varchar(255) NOT NULL,
  `observaciones` varchar(500) DEFAULT NULL,
  `tipo_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categorias`
--

CREATE TABLE `categorias` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categorias`
--

INSERT INTO `categorias` (`id`, `nombre`) VALUES
(1, 'Manual');

-- --------------------------------------------------------

--
-- Table structure for table `consumibles`
--

CREATE TABLE `consumibles` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `unidad` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `imagen` varchar(255) DEFAULT NULL,
  `subcategoria_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `consumibles`
--

INSERT INTO `consumibles` (`id`, `nombre`, `unidad`, `cantidad`, `imagen`, `subcategoria_id`) VALUES
(1, 'Clavos de cabeza plana de 20mm', 0, 80, 'imagen1.png', 1);

-- --------------------------------------------------------

--
-- Table structure for table `devoluciones`
--

CREATE TABLE `devoluciones` (
  `id` int(11) NOT NULL,
  `pedido_id_fk` int(11) DEFAULT NULL,
  `herramienta_id_fk` int(11) DEFAULT NULL,
  `usuario_fk` int(11) DEFAULT NULL,
  `fecha_devolucion` date DEFAULT NULL,
  `horario_devolucion` time DEFAULT NULL,
  `estado_fk` int(11) DEFAULT NULL,
  `observaciones` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `estado`
--

CREATE TABLE `estado` (
  `id` int(11) NOT NULL,
  `estado` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `herramientas`
--

CREATE TABLE `herramientas` (
  `id` int(11) NOT NULL,
  `imagen` varchar(255) DEFAULT NULL,
  `observaciones` varchar(500) DEFAULT NULL,
  `tipo_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `herramientas`
--

INSERT INTO `herramientas` (`id`, `imagen`, `observaciones`, `tipo_id`) VALUES
(1, 'imagen2.png', 'asd', 2);

-- --------------------------------------------------------

--
-- Table structure for table `historica`
--

CREATE TABLE `historica` (
  `id` int(11) NOT NULL,
  `pedido_id_fk` int(11) DEFAULT NULL,
  `usuario_fk` int(11) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `horario` time DEFAULT NULL,
  `estado_fk` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `historica_consumibles`
--

CREATE TABLE `historica_consumibles` (
  `id` int(11) NOT NULL,
  `pedido_id_fk` int(11) DEFAULT NULL,
  `consumible_id_fk` int(11) DEFAULT NULL,
  `usuario_fk` int(11) DEFAULT NULL,
  `fecha_entrega` date DEFAULT NULL,
  `horario_entrega` time DEFAULT NULL,
  `cantidad` int(11) NOT NULL,
  `estado_fk` int(11) DEFAULT NULL,
  `observaciones` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `historica_herramientas`
--

CREATE TABLE `historica_herramientas` (
  `id` int(11) NOT NULL,
  `pedido_id_fk` int(11) DEFAULT NULL,
  `herramienta_id_fk` int(11) DEFAULT NULL,
  `usuario_fk` int(11) DEFAULT NULL,
  `fecha_entrega` date DEFAULT NULL,
  `fecha_devolucion` date DEFAULT NULL,
  `horario_entrega` time DEFAULT NULL,
  `horario_devolucion` time DEFAULT NULL,
  `cantidad` int(11) NOT NULL,
  `estado_fk` int(11) DEFAULT NULL,
  `observaciones` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pedidos`
--

CREATE TABLE `pedidos` (
  `id` int(11) NOT NULL,
  `usuario_fk` int(11) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `horario` time DEFAULT NULL,
  `estado_fk` int(11) DEFAULT NULL,
  `tipo_pedido` enum('herramienta','consumible') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pedido_consumibles`
--

CREATE TABLE `pedido_consumibles` (
  `id` int(11) NOT NULL,
  `pedido_id_fk` int(11) DEFAULT NULL,
  `consumible_id_fk` int(11) DEFAULT NULL,
  `cantidad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pedido_herramientas`
--

CREATE TABLE `pedido_herramientas` (
  `id` int(11) NOT NULL,
  `pedido_id_fk` int(11) DEFAULT NULL,
  `herramienta_id_fk` int(11) DEFAULT NULL,
  `cantidad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subcategorias`
--

CREATE TABLE `subcategorias` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `categoria_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subcategorias`
--

INSERT INTO `subcategorias` (`id`, `nombre`, `categoria_id`) VALUES
(1, 'Clavos', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tipos_herramienta`
--

CREATE TABLE `tipos_herramienta` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `disponibles` int(11) DEFAULT NULL,
  `subcategoria_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tipos_herramienta`
--

INSERT INTO `tipos_herramienta` (`id`, `nombre`, `cantidad`, `disponibles`, `subcategoria_id`) VALUES
(2, 'Destornillador plano', 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `baja_herramientas`
--
ALTER TABLE `baja_herramientas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tipo_id` (`tipo_id`);

--
-- Indexes for table `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `consumibles`
--
ALTER TABLE `consumibles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `subcategoria_id` (`subcategoria_id`);

--
-- Indexes for table `devoluciones`
--
ALTER TABLE `devoluciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pedido_id_fk` (`pedido_id_fk`),
  ADD KEY `herramienta_id_fk` (`herramienta_id_fk`),
  ADD KEY `usuario_fk` (`usuario_fk`),
  ADD KEY `estado_fk` (`estado_fk`);

--
-- Indexes for table `estado`
--
ALTER TABLE `estado`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `herramientas`
--
ALTER TABLE `herramientas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tipo_id` (`tipo_id`);

--
-- Indexes for table `historica`
--
ALTER TABLE `historica`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pedido_id_fk` (`pedido_id_fk`),
  ADD KEY `usuario_fk` (`usuario_fk`),
  ADD KEY `estado_fk` (`estado_fk`);

--
-- Indexes for table `historica_consumibles`
--
ALTER TABLE `historica_consumibles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pedido_id_fk` (`pedido_id_fk`),
  ADD KEY `consumible_id_fk` (`consumible_id_fk`),
  ADD KEY `usuario_fk` (`usuario_fk`),
  ADD KEY `estado_fk` (`estado_fk`);

--
-- Indexes for table `historica_herramientas`
--
ALTER TABLE `historica_herramientas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pedido_id_fk` (`pedido_id_fk`),
  ADD KEY `herramienta_id_fk` (`herramienta_id_fk`),
  ADD KEY `usuario_fk` (`usuario_fk`),
  ADD KEY `estado_fk` (`estado_fk`);

--
-- Indexes for table `pedidos`
--
ALTER TABLE `pedidos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_fk` (`usuario_fk`),
  ADD KEY `estado_fk` (`estado_fk`);

--
-- Indexes for table `pedido_consumibles`
--
ALTER TABLE `pedido_consumibles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pedido_id_fk` (`pedido_id_fk`),
  ADD KEY `consumible_id_fk` (`consumible_id_fk`);

--
-- Indexes for table `pedido_herramientas`
--
ALTER TABLE `pedido_herramientas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pedido_id_fk` (`pedido_id_fk`),
  ADD KEY `herramienta_id_fk` (`herramienta_id_fk`);

--
-- Indexes for table `subcategorias`
--
ALTER TABLE `subcategorias`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categoria_id` (`categoria_id`);

--
-- Indexes for table `tipos_herramienta`
--
ALTER TABLE `tipos_herramienta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `subcategoria_id` (`subcategoria_id`);

--
-- Indexes for table `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `consumibles`
--
ALTER TABLE `consumibles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `devoluciones`
--
ALTER TABLE `devoluciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `estado`
--
ALTER TABLE `estado`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `herramientas`
--
ALTER TABLE `herramientas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `historica`
--
ALTER TABLE `historica`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `historica_consumibles`
--
ALTER TABLE `historica_consumibles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `historica_herramientas`
--
ALTER TABLE `historica_herramientas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pedidos`
--
ALTER TABLE `pedidos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pedido_consumibles`
--
ALTER TABLE `pedido_consumibles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pedido_herramientas`
--
ALTER TABLE `pedido_herramientas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subcategorias`
--
ALTER TABLE `subcategorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tipos_herramienta`
--
ALTER TABLE `tipos_herramienta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `baja_herramientas`
--
ALTER TABLE `baja_herramientas`
  ADD CONSTRAINT `baja_herramientas_ibfk_1` FOREIGN KEY (`tipo_id`) REFERENCES `tipos_herramienta` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `consumibles`
--
ALTER TABLE `consumibles`
  ADD CONSTRAINT `consumibles_ibfk_1` FOREIGN KEY (`subcategoria_id`) REFERENCES `subcategorias` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `devoluciones`
--
ALTER TABLE `devoluciones`
  ADD CONSTRAINT `devoluciones_ibfk_1` FOREIGN KEY (`pedido_id_fk`) REFERENCES `pedidos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `devoluciones_ibfk_2` FOREIGN KEY (`herramienta_id_fk`) REFERENCES `herramientas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `devoluciones_ibfk_3` FOREIGN KEY (`usuario_fk`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `devoluciones_ibfk_4` FOREIGN KEY (`estado_fk`) REFERENCES `estado` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `herramientas`
--
ALTER TABLE `herramientas`
  ADD CONSTRAINT `herramientas_ibfk_1` FOREIGN KEY (`tipo_id`) REFERENCES `tipos_herramienta` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `historica`
--
ALTER TABLE `historica`
  ADD CONSTRAINT `historica_ibfk_1` FOREIGN KEY (`pedido_id_fk`) REFERENCES `pedidos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `historica_ibfk_2` FOREIGN KEY (`usuario_fk`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `historica_ibfk_3` FOREIGN KEY (`estado_fk`) REFERENCES `estado` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `historica_consumibles`
--
ALTER TABLE `historica_consumibles`
  ADD CONSTRAINT `historica_consumibles_ibfk_1` FOREIGN KEY (`pedido_id_fk`) REFERENCES `pedidos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `historica_consumibles_ibfk_2` FOREIGN KEY (`consumible_id_fk`) REFERENCES `consumibles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `historica_consumibles_ibfk_3` FOREIGN KEY (`usuario_fk`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `historica_consumibles_ibfk_4` FOREIGN KEY (`estado_fk`) REFERENCES `estado` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `historica_herramientas`
--
ALTER TABLE `historica_herramientas`
  ADD CONSTRAINT `historica_herramientas_ibfk_1` FOREIGN KEY (`pedido_id_fk`) REFERENCES `pedidos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `historica_herramientas_ibfk_2` FOREIGN KEY (`herramienta_id_fk`) REFERENCES `herramientas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `historica_herramientas_ibfk_3` FOREIGN KEY (`usuario_fk`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `historica_herramientas_ibfk_4` FOREIGN KEY (`estado_fk`) REFERENCES `estado` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `pedidos`
--
ALTER TABLE `pedidos`
  ADD CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`usuario_fk`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `pedidos_ibfk_2` FOREIGN KEY (`estado_fk`) REFERENCES `estado` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `pedido_consumibles`
--
ALTER TABLE `pedido_consumibles`
  ADD CONSTRAINT `pedido_consumibles_ibfk_1` FOREIGN KEY (`pedido_id_fk`) REFERENCES `pedidos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `pedido_consumibles_ibfk_2` FOREIGN KEY (`consumible_id_fk`) REFERENCES `consumibles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `pedido_herramientas`
--
ALTER TABLE `pedido_herramientas`
  ADD CONSTRAINT `pedido_herramientas_ibfk_1` FOREIGN KEY (`pedido_id_fk`) REFERENCES `pedidos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `pedido_herramientas_ibfk_2` FOREIGN KEY (`herramienta_id_fk`) REFERENCES `herramientas` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `subcategorias`
--
ALTER TABLE `subcategorias`
  ADD CONSTRAINT `subcategorias_ibfk_1` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `tipos_herramienta`
--
ALTER TABLE `tipos_herramienta`
  ADD CONSTRAINT `tipos_herramienta_ibfk_1` FOREIGN KEY (`subcategoria_id`) REFERENCES `subcategorias` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
