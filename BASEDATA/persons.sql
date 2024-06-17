-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 18-06-2024 a las 00:29:51
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `attendance`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_o_actualizar` (IN `p_id` INT, IN `p_dni` INT, IN `p_digito` INT, IN `p_lastname` VARCHAR(255), IN `p_name` VARCHAR(255), IN `p_cargo` INT, IN `p_estado` INT(1))   BEGIN
    IF p_id = 0 THEN
        -- Insertar nuevo registro
        INSERT INTO persons (dni, digito, lastname, name, cargo)
        VALUES (p_dni, p_digito, p_lastname, p_name, p_cargo);
    ELSE
        -- Actualizar registro existente
        UPDATE persons
        SET dni = p_dni, digito = p_digito, lastname = p_lastname, name = p_name, cargo = p_cargo, estado = p_estado
        WHERE id = p_id;
    END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asistencia`
--

CREATE TABLE `asistencia` (
  `id` int(20) NOT NULL,
  `persons_id` int(11) NOT NULL,
  `curso_id` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `hora_entrada` time DEFAULT NULL,
  `hora_salida` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cursos`
--

CREATE TABLE `cursos` (
  `id` int(11) NOT NULL,
  `ano` int(2) NOT NULL,
  `División` varchar(10) NOT NULL,
  `Asignatura` varchar(100) NOT NULL,
  `turno` varchar(10) NOT NULL,
  `persons_id` int(11) NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `cursos`
--

INSERT INTO `cursos` (`id`, `ano`, `División`, `Asignatura`, `turno`, `persons_id`, `estado`) VALUES
(1, 1, 'desarrollo', 'Prac I', 'VESPERTINO', 2, 1),
(2, 1, 'desarrollo', 'Arquitectura', 'VESPERTINO', 2, 0),
(3, 1, 'desarrollo', 'Comunicacion', 'VESPERTINO', 1, 1),
(4, 1, 'desarrollo', 'Programacion I', 'VESPERTINO', 3, 1),
(5, 1, 'desarrollo', 'Ingles', 'VESPERTINO', 6, 1),
(6, 2, 'desarrollo', 'Practica II', 'VESPERTINO', 5, 1),
(7, 2, 'desarrollo', 'Programacion II', 'VESPERTINO', 7, 1),
(8, 2, 'desarrollo', 'Bases de Datos', 'VESPERTINO', 2, 1),
(9, 2, 'desarrollo', 'Matematica Aplicada', 'VESPERTINO', 10, 1),
(10, 2, 'desarrollo', 'Modelado de Sistema', 'VESPERTINO', 11, 1),
(11, 3, 'desarrollo', 'Programacion III', 'VESPERTINO', 2, 1),
(12, 3, 'desarrollo', 'Practica III', 'VESPERTINO', 12, 1),
(13, 3, 'desarrollo', 'Valicacion', 'VESPERTINO', 13, 1),
(14, 3, 'desarrollo', 'Etica y Deontologia', 'VESPERTINO', 14, 1),
(15, 3, 'desarrollo', 'Interfaz', 'VESPERTINO', 5, 1),
(16, 3, 'desarrollo', 'Redes', 'VESPERTINO', 12, 1),
(20, 1, 'nes', 'nuevo', 'nuevo', 1, 1),
(21, 1, 'nuevo1', 'nuevo1', 'nuevo1', 0, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `horarios`
--

CREATE TABLE `horarios` (
  `id` int(11) NOT NULL,
  `curso_id` int(11) NOT NULL,
  `dia_semana` varchar(15) NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fin` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `horarios`
--

INSERT INTO `horarios` (`id`, `curso_id`, `dia_semana`, `hora_inicio`, `hora_fin`) VALUES
(1, 1, 'LUNES', '19:30:00', '22:20:00'),
(2, 2, 'LUNES', '22:20:00', '23:40:00'),
(3, 3, 'MARTES', '19:30:00', '21:40:00'),
(4, 4, 'MARTE', '21:40:00', '23:40:00'),
(5, 4, 'JUEVES', '21:40:00', '23:40:00'),
(6, 5, 'MIERCOLES', '21:40:00', '23:40:00'),
(7, 6, 'LUNES', '19:30:00', '20:10:00'),
(8, 6, 'VIERNES', '19:30:00', '22:20:00'),
(9, 7, 'LUNES', '21:00:00', '23:40:00'),
(10, 7, 'MIERCOLES', '21:40:00', '23:00:00'),
(11, 8, 'MARTES', '21:40:00', '23:40:00'),
(12, 9, 'JUEVES', '19:30:00', '21:40:00'),
(13, 10, 'JUEVES', '21:00:00', '23:40:00'),
(14, 11, 'MIERCOLES', '19:30:00', '21:40:00'),
(15, 11, 'VIERNES', '20:10:00', '22:20:00'),
(16, 12, 'LUNES', '21:40:00', '23:40:00'),
(17, 12, 'JUEVES', '19:30:00', '21:40:00'),
(18, 13, 'LUNES', '19:30:00', '21:40:00'),
(19, 14, 'MIERCOLES', '21:40:00', '23:40:00'),
(20, 15, 'JUEVES', '21:40:00', '23:40:00'),
(21, 16, 'MARTES', '21:00:00', '23:40:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persons`
--

CREATE TABLE `persons` (
  `id` int(11) NOT NULL,
  `dni` int(11) NOT NULL,
  `digito` int(11) NOT NULL DEFAULT 1,
  `lastname` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `cargo` int(11) NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `persons`
--

INSERT INTO `persons` (`id`, `dni`, `digito`, `lastname`, `name`, `cargo`, `estado`) VALUES
(0, 111111, 0, 'ninguno', 'ninguno', 0, 0),
(1, 13125548, 1, 'ALVES', 'MARIELA', 18, 1),
(2, 13125548, 1, 'PAEZ', 'SILVANA', 18, 0),
(3, 21234786, 1, 'INFANTE', 'OMAR', 18, 1),
(4, 43232123, 1, 'AQUINO', 'BETSABE', 18, 1),
(5, 34234654, 1, 'BAUTISTA', 'MIGUEL', 18, 1),
(6, 99888777, 2, 'SANTARONE', 'MARIA', 222, 1),
(7, 30666033, 1, 'SOLORZANO', 'ALFREDO', 10, 1),
(8, 11222333, 2, 'ALMARAZ ', 'ARIEL', 222, 1),
(10, 12365498, 1, 'YAVARA', 'MARCELO', 23, 1),
(11, 12365498, 1, 'VILLEGAS', 'HEBER', 23, 1),
(12, 9875465, 1, 'RODRIGUEZ', 'PEDRO', 23, 1),
(13, 31121582, 1, 'PAZ', 'ABEL', 910, 1),
(14, 24568956, 1, 'AGUERO', 'LEONARDO', 910, 1),
(15, 13125548, 0, 'nuevo', 'uno', 18, 1),
(16, 99999333, 1, 'NUEVO', 'NUEVO1', 18, 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `asistencia`
--
ALTER TABLE `asistencia`
  ADD PRIMARY KEY (`id`),
  ADD KEY `persons_id` (`persons_id`),
  ADD KEY `curso_id` (`curso_id`);

--
-- Indices de la tabla `cursos`
--
ALTER TABLE `cursos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `persons_id` (`persons_id`);

--
-- Indices de la tabla `horarios`
--
ALTER TABLE `horarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `curso_id` (`curso_id`);

--
-- Indices de la tabla `persons`
--
ALTER TABLE `persons`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `asistencia`
--
ALTER TABLE `asistencia`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cursos`
--
ALTER TABLE `cursos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `horarios`
--
ALTER TABLE `horarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `persons`
--
ALTER TABLE `persons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `asistencia`
--
ALTER TABLE `asistencia`
  ADD CONSTRAINT `asistencia_ibfk_1` FOREIGN KEY (`persons_id`) REFERENCES `persons` (`id`),
  ADD CONSTRAINT `asistencia_ibfk_2` FOREIGN KEY (`curso_id`) REFERENCES `cursos` (`id`);

--
-- Filtros para la tabla `cursos`
--
ALTER TABLE `cursos`
  ADD CONSTRAINT `cursos_ibfk_1` FOREIGN KEY (`persons_id`) REFERENCES `persons` (`id`);

--
-- Filtros para la tabla `horarios`
--
ALTER TABLE `horarios`
  ADD CONSTRAINT `horarios_ibfk_1` FOREIGN KEY (`curso_id`) REFERENCES `cursos` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
