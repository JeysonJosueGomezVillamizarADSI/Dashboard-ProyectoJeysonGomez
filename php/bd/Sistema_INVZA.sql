-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 14-12-2022 a las 22:26:07
-- Versión del servidor: 10.4.25-MariaDB
-- Versión de PHP: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `sistema_invza`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `Cantidad_Material_con_Productos` ()   BEGIN 
SET @cantidadMaterial = (SELECT COUNT(tb_material.Id_Material) FROM tb_material INNER JOIN tb_producto WHERE tb_material.Id_Material =tb_producto.Id_Material_fk);
SET @cantidadTotal = (SELECT COUNT(*) FROM tb_material);
SET @porcentaje = @cantidadMaterial/@cantidadTotal * 100;  
SELECT @cantidadTotal as "Total","Productos Con Material Asignado" as "Productos",@porcentaje AS "Porcentaje",@cantidadMaterial as "Subtotal";
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Cantidad_Material_Entregado` ()   BEGIN 
SET @cantidadMaterial = (SELECT COUNT(tb_material_entregado.Id_Mat_Entregado) FROM tb_material_entregado INNER JOIN tb_material WHERE tb_material.Id_Material =tb_material_entregado.Id_Material_fk);
SET @cantidadTotal = (SELECT COUNT(*) FROM tb_material);
SET @porcentaje = @cantidadMaterial/@cantidadTotal * 100;  
SELECT @cantidadTotal as "Total","Material Entregado" as "Material Entregado",@porcentaje AS "Porcentaje",@cantidadMaterial as "total";
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Cantidad_Material_Faltante` ()   BEGIN 
SET @cantidadMaterial = (SELECT COUNT(tb_material_faltante.Id_Material_Faltante) FROM tb_material_faltante WHERE  tb_material_faltante.Cant_Faltante>=10);
SET @cantidadTotal = (SELECT COUNT(*) FROM tb_material_faltante);
SET @porcentaje = @cantidadMaterial/@cantidadTotal * 100;  
SELECT @cantidadTotal as "Total","Material Faltante" as "Material Faltante",@porcentaje AS "Porcentaje",@cantidadMaterial as "total";
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarTelefono` (IN `id` INT(11))   BEGIN
DELETE FROM tb_telef_empleado WHERE tb_telef_empleado.Id_Telef= id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Empleados_Activos` ()   BEGIN
set @activos = (SELECT COUNT(Ced_Empleado) as 'Empleados' FROM tb_empleado WHERE Estado_Empleado= 'Activo');
set @empleados = (SELECT COUNT(*) FROM `tb_empleado` WHERE Ced_Empleado);
set @porcentaje = (@activos/@empleados)*100;
SELECT @empleados as "Total","Empleados Activos" AS "Empleados Activos", @porcentaje AS 'Porcentaje', @activos AS 'Total empleados activos';
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarMaterialDevuelto` ()   BEGIN 
SELECT Id_Material_Devuelto, Cant_Material_Devuelto,Observaciones, CONCAT (tb_material_devoluciones.Id_Material_fk," ",tb_material.Nom_Material) AS "Material_fk" FROM tb_material_devoluciones INNER JOIN tb_material ON tb_material_devoluciones.Id_Material_fk=tb_material.Id_Material;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarMaterialEntregado` ()   BEGIN
	SELECT Id_Mat_Entregado as "Id", `Cant_Material_Entregado`AS "Cantidad ",Fech_Entrega_Material AS "Fecha",Hora_Entrega AS "Hora", CONCAT (tb_material_entregado.Id_Material_fk," ",tb_material.Nom_Material)AS "Material_fk" FROM tb_material_entregado INNER JOIN tb_material ON tb_material_entregado.Id_Material_fk=tb_material.Id_Material;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarMaterialFaltante` ()   BEGIN
SELECT Id_Material_Faltante, Cant_Faltante,Observaciones, CONCAT (tb_material_faltante.Id_Material_fk," ",tb_material.Nom_Material) AS "Material_fk" FROM tb_material_faltante INNER JOIN tb_material ON tb_material_faltante.Id_Material_fk=tb_material.Id_Material;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarRoles` ()   BEGIN
SELECT `Id_Rol`AS "Id Rol", `Nomb_Rol`AS "Rol",CONCAT(tb_rol_emple.Ced_Empleado_fk," ",tb_empleado.Nom_Empleado) AS "Cedula fk" FROM tb_empleado INNER JOIN tb_rol_emple ON tb_empleado.Ced_Empleado = tb_rol_emple.Ced_Empleado_fk;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListarTareaproducto` ()   BEGIN
SELECT Id_Tarea_Produc AS 'idTarea',CONCAT(Id_Producto,' ',Nom_Producto)AS 'produto_fk',CONCAT(Ced_Empleado,' ', Nom_Empleado) AS 'empleado_fk', CONCAT(Id_Tarea,' ',Nom_Tarea)AS 'tarea_fk', Fecha_Inicio_Tarea AS 'fecha_inicio',Fecha_Fin_Tarea AS 'fecha_fin', Cant AS 'cantidad' FROM tb_tarea_productos INNER JOIN tb_empleado ON tb_empleado.Ced_Empleado=tb_tarea_productos.Ced_Empleado_fk INNER JOIN tb_producto ON tb_producto.Id_Producto=tb_tarea_productos.Id_Producto_fk INNER JOIN tb_tareas ON tb_tareas.Id_Tarea = tb_tarea_productos.Id_Tarea_fk;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `login` (IN `user` VARCHAR(40), IN `cont` VARCHAR(40))   BEGIN
	SELECT `id` as 'numero', `admin` as 'usuario', `contrasena` as 'id' FROM `tb_login` WHERE `admin`= user AND `contrasena`= cont;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Material_Devuelto` ()   BEGIN 
SET @cantidadMaterial = (SELECT COUNT(tb_material_devoluciones.Id_Material_Devuelto) FROM tb_material_devoluciones WHERE  tb_material_devoluciones.Observaciones="Ninguna");
SET @cantidadTotal = (SELECT COUNT(*) FROM tb_material_devoluciones);
SET @porcentaje = @cantidadMaterial/@cantidadTotal * 100;  
SELECT @cantidadTotal as "Total","Material Devuelto con ninguna observacion" as "Material Devuelto",@porcentaje AS "Porcentaje",@cantidadMaterial as "total";
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Pares_Mayores` ()   BEGIN 
SET @cantidadPares = (SELECT COUNT(tb_producto.Id_Producto) FROM tb_producto WHERE tb_producto.Pares_Producto >=50);
SET @cantidadTotal = (SELECT COUNT(*) FROM tb_producto);
SET @porcentaje = @cantidadPares/@cantidadTotal * 100;  
SELECT @cantidadTotal as "Total","Pares mayoreso o iguales a 50  " as "Pares",@porcentaje AS "Porcentaje",@cantidadPares"Subtotal";
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Puesto_Empleado` ()   BEGIN
SET @cantidadPuestos = (SELECT COUNT(Nom_Puesto) FROM tb_puesto WHERE Nom_Puesto LIKE "Casa Empleado");
SET @cantidadTotal = (SELECT COUNT(*) FROM tb_puesto);
SET @porcentaje = (@cantidadPuestos/@cantidadTotal) * 100;  
SELECT @cantidadTotal as "Total","Empleados que trabajan desde la casa " as "empleado",@porcentaje AS "Porcentaje",@cantidadPuestos as "total";
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Rol_Empleados` ()   BEGIN
SET @cantidadTotal = (SELECT COUNT(*) FROM tb_rol_emple);
SET @cantidadRol = (SELECT COUNT(Nomb_Rol) FROM tb_rol_emple WHERE Nomb_Rol LIKE "Emplantillador(a)");
SET @porcentaje = (@cantidadRol/@cantidadTotal) * 100;  
SELECT @cantidadTotal as "Total","Empleados  con el rol Emplantillador" as "empleado",@porcentaje AS "Porcentaje",@cantidadRol as "total";
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Salario_Menor` ()   BEGIN 
SET @cantidadSalario = (SELECT COUNT(tb_puesto_emple.Id_Puesto_Emple) FROM tb_puesto_emple WHERE tb_puesto_emple.Salar_Empleado <= 1400000);
SET @cantidadTotal = (SELECT COUNT(*) FROM tb_puesto_emple);
SET @porcentaje = @cantidadSalario/@cantidadTotal * 100;  
SELECT @cantidadTotal as "Total","Empleados con salario menor a 1400000" as "Salarios",@porcentaje AS "Porcentaje",@cantidadSalario"Subtotal";
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Tareas_Armar` ()   BEGIN
SET @cantidadArmado = (SELECT COUNT(Id_Tarea) FROM tb_tareas WHERE Nom_Tarea = "Armado");
SET @cantidadTotal = (SELECT COUNT(*) FROM tb_tareas); 
SET @porcentaje = @cantidadArmado/@cantidadTotal * 100;         SELECT @cantidadTotal as 'Total','Tareas Armado' as "Tarea de Armado",@porcentaje AS 'porcentaje',@cantidadArmado as 'Tareas con Armado';
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Tarea_Producto_Fecha` ()   BEGIN 
SET @cantidadTareas = (SELECT COUNT(tb_tarea_productos.Id_Tarea_Produc) FROM tb_tarea_productos WHERE tb_tarea_productos.Fecha_Inicio_Tarea >= '2022-11-01');
SET @cantidadTotal = (SELECT COUNT(*) FROM tb_tarea_productos);
SET @porcentaje = @cantidadTareas/@cantidadTotal * 100;  
SELECT @cantidadTotal as "Total","Tareas iniciadas despues del 1 de noviembre" as "Tareas-Productos",@porcentaje AS "Porcentaje",@cantidadTareas as "Subtotal";
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Telefonos_Empleados` ()   BEGIN 
SET @CantidadTelefono = (SELECT COUNT(Num_Telef) FROM tb_telef_empleado INNER JOIN tb_empleado WHERE Ced_Empleado=tb_telef_empleado.Ced_Empleado_fk);
SET @CantidadTotal = (SELECT COUNT(*) FROM tb_telef_empleado);
SET @Porcentaje = (@cantidadTelefono/@cantidadTotal) * 100; 
SELECT @CantidadTotal as "Total","Empleados con numeros de telefono" as "Telefonos",@porcentaje AS 'Porcentaje',@CantidadTelefono as "Telefonos Empleados" ;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_empleado`
--

CREATE TABLE `tb_empleado` (
  `Ced_Empleado` varchar(10) NOT NULL,
  `Nom_Empleado` varchar(50) NOT NULL,
  `Apell_Empleado` varchar(50) NOT NULL,
  `Direcc_Empleado` varchar(50) NOT NULL,
  `Estado_Empleado` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_empleado`
--

INSERT INTO `tb_empleado` (`Ced_Empleado`, `Nom_Empleado`, `Apell_Empleado`, `Direcc_Empleado`, `Estado_Empleado`) VALUES
('1002457455', 'Miguel', 'Milagros Ventura', 'Calle 104 # 12-03', 'Activo'),
('1005157790', 'Luis ', 'Sanchez', 'Giron', 'Activo'),
('100547845', 'Angie Valentina', 'Paredes Araque', 'Calle 145 # 12-23', 'Activo'),
('1098802501', 'Josue', 'Gomez Villamizar', 'Calle 105 # 28-45', 'Activo'),
('37713072', 'Orlando', 'Gomez Marino', 'Granjas Julio Rincon Casa 42', 'Activo'),
('40785412', 'Matias ', 'Perez Chaparro', 'Diagonal 23 # 47-85', 'Activo'),
('457841556', 'Enrique', 'Gonzales Perez', 'Carrera 24 # 45-85', 'Activo'),
('7844145', 'Beatriz&nbsp;', 'Gutierrez Lopez', 'Calle 34 # 48-78', 'Activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_login`
--

CREATE TABLE `tb_login` (
  `id` int(11) NOT NULL,
  `admin` varchar(40) NOT NULL,
  `contrasena` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_login`
--

INSERT INTO `tb_login` (`id`, `admin`, `contrasena`) VALUES
(1, 'calzadopaulliny', 'alcirap2845');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_material`
--

CREATE TABLE `tb_material` (
  `Id_Material` int(11) NOT NULL,
  `Nom_Material` varchar(250) NOT NULL,
  `Desc_Material` varchar(250) NOT NULL,
  `Prec_Material` double NOT NULL,
  `Cant_Material` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_material`
--

INSERT INTO `tb_material` (`Id_Material`, `Nom_Material`, `Desc_Material`, `Prec_Material`, `Cant_Material`) VALUES
(1025, 'Cuchilla', 'Cuchilla para el corte de piezas de cuero', 14500, 35),
(7895, 'Hilo&nbsp;', 'Hilo para maquina de cocer pulgada 1/2 color rojo', 14545, 50),
(8562, 'Martillo', 'Martillo cabeza redonda marca delirw', 24589, 58),
(10023, 'Ojalete', 'Ojalete para los cordones de zapatos', 58963, 48),
(45785, 'Tijeras ', 'Tijeras para corte de piezas ', 4504, 23),
(145785, 'Pegante&nbsp;', 'Tarro Pegante Amarillo Para pegar piezas del zapato', 145200, 12),
(478521, 'Aguja', 'Agujas para la maquina plana cocer piezas', 1200, 14);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_material_devoluciones`
--

CREATE TABLE `tb_material_devoluciones` (
  `Id_Material_Devuelto` int(11) NOT NULL,
  `Id_Material_fk` int(11) NOT NULL,
  `Id_Tarea_Produc_fk` int(11) NOT NULL,
  `Cant_Material_Devuelto` int(11) NOT NULL,
  `Observaciones` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_material_devoluciones`
--

INSERT INTO `tb_material_devoluciones` (`Id_Material_Devuelto`, `Id_Material_fk`, `Id_Tarea_Produc_fk`, `Cant_Material_Devuelto`, `Observaciones`) VALUES
(3, 7895, 54856, 2, 'Ninguna'),
(4, 478521, 47123, 5, 'Ninguna'),
(5, 10023, 54856, 10, 'Ninguna'),
(6, 145785, 47123, 17, 'Ninguna');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_material_entregado`
--

CREATE TABLE `tb_material_entregado` (
  `Id_Mat_Entregado` int(11) NOT NULL,
  `Id_Material_fk` int(11) NOT NULL,
  `Id_Tarea_Produc_fk` int(11) NOT NULL,
  `Cant_Material_Entregado` int(11) NOT NULL,
  `Fech_Entrega_Material` date NOT NULL,
  `Hora_Entrega` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_material_entregado`
--

INSERT INTO `tb_material_entregado` (`Id_Mat_Entregado`, `Id_Material_fk`, `Id_Tarea_Produc_fk`, `Cant_Material_Entregado`, `Fech_Entrega_Material`, `Hora_Entrega`) VALUES
(8, 145785, 54856, 4, '2022-11-11', '16:43:57'),
(9, 45785, 47123, 10, '2022-12-20', '10:43:24'),
(10, 1025, 7885, 15, '2022-12-15', '09:45:27'),
(11, 8562, 47123, 4, '2022-12-18', '14:50:22');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_material_faltante`
--

CREATE TABLE `tb_material_faltante` (
  `Id_Material_Faltante` int(11) NOT NULL,
  `Id_Material_Fk` int(11) NOT NULL,
  `Id_Tarea_Produc_fk` int(11) NOT NULL,
  `Cant_Faltante` int(11) NOT NULL,
  `Observaciones` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_material_faltante`
--

INSERT INTO `tb_material_faltante` (`Id_Material_Faltante`, `Id_Material_Fk`, `Id_Tarea_Produc_fk`, `Cant_Faltante`, `Observaciones`) VALUES
(2, 10023, 12004, 8, 'Empleado perdio ojaletes'),
(3, 7895, 7885, 14, 'Nada');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_producto`
--

CREATE TABLE `tb_producto` (
  `Id_Producto` int(11) NOT NULL,
  `Id_Material_fk` int(11) NOT NULL,
  `Nom_Producto` varchar(250) NOT NULL,
  `Pares_Producto` int(11) NOT NULL,
  `Desc_Producto` varchar(250) NOT NULL,
  `Talla` int(11) NOT NULL,
  `Color` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_producto`
--

INSERT INTO `tb_producto` (`Id_Producto`, `Id_Material_fk`, `Nom_Producto`, `Pares_Producto`, `Desc_Producto`, `Talla`, `Color`) VALUES
(5474, 45785, 'Zapato ', 15, 'Zapato Caballero Cuero para terminar', 32, 'Negro'),
(47851, 10023, 'Zapatilla&nbsp;', 74, 'Zapatilla planta alta para mujer ', 34, 'Azul'),
(54784, 7895, 'Sandalia', 100, 'Sandalia Cuero para Mujer  buen detalle', 28, 'Rojo'),
(478512, 8562, 'Baleta', 50, 'Baleta niña', 27, 'Blanco-Rojo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_puesto`
--

CREATE TABLE `tb_puesto` (
  `Id_Puesto` varchar(50) NOT NULL,
  `Nom_Puesto` varchar(50) NOT NULL,
  `Direcc_Puesto` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_puesto`
--

INSERT INTO `tb_puesto` (`Id_Puesto`, `Nom_Puesto`, `Direcc_Puesto`) VALUES
('1001', 'Calzado Paulliny&nbsp;', 'Calle 105 # 14-95'),
('1002', 'Calzado Paulliny Taller', 'Carrera 45# 48-8'),
('1003', 'Calzado Paulliny Taller', 'Calle 123 # 18-14'),
('1004', 'Casa&nbsp;', 'Diagonal 105# 78-24'),
('1005', 'Casa Empleado', 'Trasnversal 43 # 41-12'),
('1006', 'Casa Empleado', 'Calle 12 # 10-85'),
('1007', 'Calzado Paulliny Taller', 'Calle 143# 54-78'),
('1008', 'Calzado Paulliny Taller', 'Transversal 43  # 98-85');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_puesto_emple`
--

CREATE TABLE `tb_puesto_emple` (
  `Id_Puesto_Emple` int(11) NOT NULL,
  `Ced_Empleado_fk` varchar(10) NOT NULL,
  `Id_Puesto_fk` varchar(50) NOT NULL,
  `Horario_Asignado` time NOT NULL,
  `Salar_Empleado` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_puesto_emple`
--

INSERT INTO `tb_puesto_emple` (`Id_Puesto_Emple`, `Ced_Empleado_fk`, `Id_Puesto_fk`, `Horario_Asignado`, `Salar_Empleado`) VALUES
(1, '457841556', '1002', '06:45:00', 1245204),
(2, '1098802501', '1005', '10:40:00', 1253000),
(3, '37713072', '1002', '07:20:00', 1004520),
(4, '1002457455', '1001', '10:30:15', 1500050),
(5, '100547845', '1003', '10:45:00', 1452014),
(6, '7844145', '1004', '08:35:00', 1478500),
(7, '40785412', '1001', '06:25:12', 1356000),
(8, '1005157790', '1008', '07:15:00', 1412000);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_rol_emple`
--

CREATE TABLE `tb_rol_emple` (
  `Id_Rol` int(11) NOT NULL,
  `Nomb_Rol` varchar(50) NOT NULL,
  `Ced_Empleado_fk` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_rol_emple`
--

INSERT INTO `tb_rol_emple` (`Id_Rol`, `Nomb_Rol`, `Ced_Empleado_fk`) VALUES
(18, 'Guarnecedor(a)', '1098802501'),
(19, 'Emplantillador(a)', '7844145'),
(20, 'Guarnecedora(a)', '37713072'),
(22, 'Emplantillador(a)', '1098802501');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_tareas`
--

CREATE TABLE `tb_tareas` (
  `Id_Tarea` int(11) NOT NULL,
  `Nom_Tarea` varchar(50) NOT NULL,
  `Cant_Pares_Tarea` int(11) NOT NULL,
  `Desc_Tarea` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_tareas`
--

INSERT INTO `tb_tareas` (`Id_Tarea`, `Nom_Tarea`, `Cant_Pares_Tarea`, `Desc_Tarea`) VALUES
(2541, 'Emplantillar&nbsp;', 14, 'Alistamiendo del producto&nbsp;'),
(14555, 'Armado y Solador', 10, 'Realizar Ensamble de piezas para el zapato deporti'),
(22254, 'Armado ', 4, 'Ensamble de Piezas Zapato Sport'),
(63200, 'Montura ', 10, 'Montura del zapato ya terminado'),
(478530, 'Cocer', 20, 'Realizar con maquina el cocido de las piezas para ');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_tarea_productos`
--

CREATE TABLE `tb_tarea_productos` (
  `Id_Tarea_Produc` int(11) NOT NULL,
  `Id_Producto_fk` int(11) NOT NULL,
  `Ced_Empleado_fk` varchar(10) NOT NULL,
  `Id_Tarea_fk` int(11) NOT NULL,
  `Fecha_Inicio_Tarea` date NOT NULL,
  `Fecha_Fin_Tarea` date NOT NULL,
  `Cant` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_tarea_productos`
--

INSERT INTO `tb_tarea_productos` (`Id_Tarea_Produc`, `Id_Producto_fk`, `Ced_Empleado_fk`, `Id_Tarea_fk`, `Fecha_Inicio_Tarea`, `Fecha_Fin_Tarea`, `Cant`) VALUES
(7885, 478512, '7844145', 63200, '2022-12-01', '2022-12-02', 13),
(12004, 47851, '1098802501', 22254, '2022-09-01', '2016-09-02', 5),
(47123, 478512, '40785412', 14555, '2022-11-01', '2022-11-07', 3),
(54856, 54784, '1098802501', 14555, '2022-11-20', '2022-10-17', 6);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_telef_empleado`
--

CREATE TABLE `tb_telef_empleado` (
  `Id_Telef` int(11) NOT NULL,
  `Num_Telef` varchar(10) NOT NULL,
  `Ced_Empleado_fk` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_telef_empleado`
--

INSERT INTO `tb_telef_empleado` (`Id_Telef`, `Num_Telef`, `Ced_Empleado_fk`) VALUES
(22, '6485452', '457841556'),
(24, '3006470312', '37713072'),
(30, '3214785952', '1098802501'),
(32, '3147852416', '457841556');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `tb_empleado`
--
ALTER TABLE `tb_empleado`
  ADD PRIMARY KEY (`Ced_Empleado`);

--
-- Indices de la tabla `tb_login`
--
ALTER TABLE `tb_login`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tb_material`
--
ALTER TABLE `tb_material`
  ADD PRIMARY KEY (`Id_Material`);

--
-- Indices de la tabla `tb_material_devoluciones`
--
ALTER TABLE `tb_material_devoluciones`
  ADD PRIMARY KEY (`Id_Material_Devuelto`),
  ADD KEY `Id_Material_fk` (`Id_Material_fk`),
  ADD KEY `Id_Tarea_Produc_fk` (`Id_Tarea_Produc_fk`);

--
-- Indices de la tabla `tb_material_entregado`
--
ALTER TABLE `tb_material_entregado`
  ADD PRIMARY KEY (`Id_Mat_Entregado`),
  ADD KEY `Id_Material_fk` (`Id_Material_fk`),
  ADD KEY `Id_Tarea_Produc_fk` (`Id_Tarea_Produc_fk`);

--
-- Indices de la tabla `tb_material_faltante`
--
ALTER TABLE `tb_material_faltante`
  ADD PRIMARY KEY (`Id_Material_Faltante`),
  ADD KEY `Id_Material_Fk` (`Id_Material_Fk`),
  ADD KEY `Id_Tarea_Produc_fk` (`Id_Tarea_Produc_fk`);

--
-- Indices de la tabla `tb_producto`
--
ALTER TABLE `tb_producto`
  ADD PRIMARY KEY (`Id_Producto`),
  ADD KEY `Cod_Material_fk` (`Id_Material_fk`);

--
-- Indices de la tabla `tb_puesto`
--
ALTER TABLE `tb_puesto`
  ADD PRIMARY KEY (`Id_Puesto`);

--
-- Indices de la tabla `tb_puesto_emple`
--
ALTER TABLE `tb_puesto_emple`
  ADD PRIMARY KEY (`Id_Puesto_Emple`),
  ADD KEY `Ced_Empleado_fk` (`Ced_Empleado_fk`),
  ADD KEY `Id_Puesto_fk` (`Id_Puesto_fk`);

--
-- Indices de la tabla `tb_rol_emple`
--
ALTER TABLE `tb_rol_emple`
  ADD PRIMARY KEY (`Id_Rol`),
  ADD KEY `Id_Empleado_fk` (`Ced_Empleado_fk`);

--
-- Indices de la tabla `tb_tareas`
--
ALTER TABLE `tb_tareas`
  ADD PRIMARY KEY (`Id_Tarea`);

--
-- Indices de la tabla `tb_tarea_productos`
--
ALTER TABLE `tb_tarea_productos`
  ADD PRIMARY KEY (`Id_Tarea_Produc`),
  ADD KEY `Id_Producto_fk` (`Id_Producto_fk`),
  ADD KEY `Id_Empleado_fk` (`Ced_Empleado_fk`),
  ADD KEY `Id_Tarea_fk` (`Id_Tarea_fk`);

--
-- Indices de la tabla `tb_telef_empleado`
--
ALTER TABLE `tb_telef_empleado`
  ADD PRIMARY KEY (`Id_Telef`),
  ADD KEY `Id_Empleado_fk` (`Ced_Empleado_fk`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `tb_material_devoluciones`
--
ALTER TABLE `tb_material_devoluciones`
  MODIFY `Id_Material_Devuelto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `tb_material_entregado`
--
ALTER TABLE `tb_material_entregado`
  MODIFY `Id_Mat_Entregado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `tb_material_faltante`
--
ALTER TABLE `tb_material_faltante`
  MODIFY `Id_Material_Faltante` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `tb_puesto_emple`
--
ALTER TABLE `tb_puesto_emple`
  MODIFY `Id_Puesto_Emple` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `tb_rol_emple`
--
ALTER TABLE `tb_rol_emple`
  MODIFY `Id_Rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `tb_telef_empleado`
--
ALTER TABLE `tb_telef_empleado`
  MODIFY `Id_Telef` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tb_material_devoluciones`
--
ALTER TABLE `tb_material_devoluciones`
  ADD CONSTRAINT `tb_material_devoluciones_ibfk_1` FOREIGN KEY (`Id_Material_fk`) REFERENCES `tb_material` (`Id_Material`),
  ADD CONSTRAINT `tb_material_devoluciones_ibfk_2` FOREIGN KEY (`Id_Tarea_Produc_fk`) REFERENCES `tb_tarea_productos` (`Id_Tarea_Produc`);

--
-- Filtros para la tabla `tb_material_entregado`
--
ALTER TABLE `tb_material_entregado`
  ADD CONSTRAINT `tb_material_entregado_ibfk_1` FOREIGN KEY (`Id_Material_fk`) REFERENCES `tb_material` (`Id_Material`),
  ADD CONSTRAINT `tb_material_entregado_ibfk_2` FOREIGN KEY (`Id_Tarea_Produc_fk`) REFERENCES `tb_tarea_productos` (`Id_Tarea_Produc`);

--
-- Filtros para la tabla `tb_material_faltante`
--
ALTER TABLE `tb_material_faltante`
  ADD CONSTRAINT `tb_material_faltante_ibfk_1` FOREIGN KEY (`Id_Material_Fk`) REFERENCES `tb_material` (`Id_Material`),
  ADD CONSTRAINT `tb_material_faltante_ibfk_2` FOREIGN KEY (`Id_Tarea_Produc_fk`) REFERENCES `tb_tarea_productos` (`Id_Tarea_Produc`);

--
-- Filtros para la tabla `tb_producto`
--
ALTER TABLE `tb_producto`
  ADD CONSTRAINT `tb_producto_ibfk_1` FOREIGN KEY (`Id_Material_fk`) REFERENCES `tb_material` (`Id_Material`);

--
-- Filtros para la tabla `tb_puesto_emple`
--
ALTER TABLE `tb_puesto_emple`
  ADD CONSTRAINT `tb_puesto_emple_ibfk_1` FOREIGN KEY (`Ced_Empleado_fk`) REFERENCES `tb_empleado` (`Ced_Empleado`),
  ADD CONSTRAINT `tb_puesto_emple_ibfk_2` FOREIGN KEY (`Id_Puesto_fk`) REFERENCES `tb_puesto` (`Id_Puesto`);

--
-- Filtros para la tabla `tb_rol_emple`
--
ALTER TABLE `tb_rol_emple`
  ADD CONSTRAINT `tb_rol_emple_ibfk_1` FOREIGN KEY (`Ced_Empleado_fk`) REFERENCES `tb_empleado` (`Ced_Empleado`);

--
-- Filtros para la tabla `tb_tarea_productos`
--
ALTER TABLE `tb_tarea_productos`
  ADD CONSTRAINT `tb_tarea_productos_ibfk_1` FOREIGN KEY (`Ced_Empleado_fk`) REFERENCES `tb_empleado` (`Ced_Empleado`),
  ADD CONSTRAINT `tb_tarea_productos_ibfk_2` FOREIGN KEY (`Id_Tarea_fk`) REFERENCES `tb_tareas` (`Id_Tarea`),
  ADD CONSTRAINT `tb_tarea_productos_ibfk_3` FOREIGN KEY (`Id_Producto_fk`) REFERENCES `tb_producto` (`Id_Producto`);

--
-- Filtros para la tabla `tb_telef_empleado`
--
ALTER TABLE `tb_telef_empleado`
  ADD CONSTRAINT `tb_telef_empleado_ibfk_1` FOREIGN KEY (`Ced_Empleado_fk`) REFERENCES `tb_empleado` (`Ced_Empleado`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
