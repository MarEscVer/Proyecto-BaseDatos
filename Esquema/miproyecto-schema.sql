CREATE DATABASE `instituto` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

CREATE TABLE `alumnado` (
  `Num_Expediente` int NOT NULL,
  `Nombre` varchar(45) NOT NULL,
  `Apellido1` varchar(45) DEFAULT NULL,
  `Apellido2` varchar(45) DEFAULT NULL,
  `Fecha_Nacimiento` date DEFAULT NULL,
  `Direccion` varchar(45) NOT NULL,
  `Codigo_Grupo` int DEFAULT NULL,
  `Alumnado_Ayudante` int DEFAULT NULL,
  `Tutor2` int DEFAULT NULL,
  `Tutor1` int NOT NULL,
  PRIMARY KEY (`Num_Expediente`),
  KEY `fk_ALUMNADO_GRUPO1_idx` (`Codigo_Grupo`),
  KEY `fk_ALUMNADO_ALUMNADO1_idx` (`Alumnado_Ayudante`),
  KEY `ALUMNADO_FK_1` (`Tutor2`),
  KEY `ALUMNADO_FK` (`Tutor1`),
  CONSTRAINT `ALUMNADO_FK` FOREIGN KEY (`Tutor1`) REFERENCES `tutor_legal` (`Codigo`),
  CONSTRAINT `ALUMNADO_FK_1` FOREIGN KEY (`Tutor2`) REFERENCES `tutor_legal` (`Codigo`),
  CONSTRAINT `ALUMNADO_FK_2` FOREIGN KEY (`Codigo_Grupo`) REFERENCES `grupo` (`Codigo`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `fk_ALUMNADO_ALUMNADO1` FOREIGN KEY (`Alumnado_Ayudante`) REFERENCES `alumnado` (`Num_Expediente`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `asignatura` (
  `Codigo` int NOT NULL,
  `Nombre` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `GRUPO_Codigo` int NOT NULL,
  PRIMARY KEY (`Codigo`),
  KEY `fk_ASIGNATURA_GRUPO1_idx` (`GRUPO_Codigo`),
  CONSTRAINT `ASIGNATURA_FK` FOREIGN KEY (`GRUPO_Codigo`) REFERENCES `grupo` (`Codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `departamento` (
  `Codigo` int NOT NULL,
  `Nombre` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Codigo_Jefe` int NOT NULL,
  `Codigo_Despacho` int NOT NULL,
  PRIMARY KEY (`Codigo`),
  KEY `fk_DEPARTAMENTO_TRABAJADORES1_idx` (`Codigo_Jefe`),
  KEY `fk_DEPARTAMENTO_ZONAS1_idx` (`Codigo_Despacho`),
  CONSTRAINT `DEPARTAMENTO_FK` FOREIGN KEY (`Codigo_Jefe`) REFERENCES `profesorado` (`DNI`),
  CONSTRAINT `fk_DEPARTAMENTO_ZONAS1` FOREIGN KEY (`Codigo_Despacho`) REFERENCES `zonas` (`Codigo`) ON DELETE SET DEFAULT ON UPDATE SET DEFAULT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `grupo` (
  `Codigo` int NOT NULL,
  `Nombre` varchar(5) NOT NULL,
  `Tutor` int DEFAULT NULL,
  PRIMARY KEY (`Codigo`),
  KEY `GRUPO_FK` (`Tutor`),
  CONSTRAINT `GRUPO_FK` FOREIGN KEY (`Tutor`) REFERENCES `profesorado` (`DNI`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `horario` (
  `DNI_Profesorado` int NOT NULL,
  `ASIGNATURA_Codigo` int NOT NULL,
  `ZONAS_Codigo` int NOT NULL,
  `Dia` varchar(45) NOT NULL,
  `Hora_Inicio` time NOT NULL,
  `Hora_Final` time NOT NULL,
  PRIMARY KEY (`DNI_Profesorado`,`ASIGNATURA_Codigo`,`ZONAS_Codigo`,`Dia`),
  KEY `fk_TRABAJADORES_has_ASIGNATURA_ASIGNATURA1_idx` (`ASIGNATURA_Codigo`),
  KEY `fk_TRABAJADORES_has_ASIGNATURA_TRABAJADORES1_idx` (`DNI_Profesorado`),
  KEY `fk_HORARIO_ZONAS1_idx` (`ZONAS_Codigo`),
  CONSTRAINT `fk_HORARIO_ZONAS1` FOREIGN KEY (`ZONAS_Codigo`) REFERENCES `zonas` (`Codigo`) ON DELETE SET DEFAULT ON UPDATE SET DEFAULT,
  CONSTRAINT `fk_TRABAJADORES_has_ASIGNATURA_ASIGNATURA1` FOREIGN KEY (`ASIGNATURA_Codigo`) REFERENCES `asignatura` (`Codigo`) ON DELETE SET DEFAULT ON UPDATE SET DEFAULT,
  CONSTRAINT `fk_TRABAJADORES_has_ASIGNATURA_TRABAJADORES1` FOREIGN KEY (`DNI_Profesorado`) REFERENCES `profesorado` (`DNI`) ON DELETE SET DEFAULT ON UPDATE SET DEFAULT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `matricula` (
  `ALUMNADO_Num_Expediente` int NOT NULL,
  `ASIGNATURA_Codigo` int NOT NULL,
  `Nota_alumnado` int DEFAULT NULL,
  `Incidencias` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`ALUMNADO_Num_Expediente`,`ASIGNATURA_Codigo`),
  KEY `fk_ALUMNADO_has_ASIGNATURA_ASIGNATURA1_idx` (`ASIGNATURA_Codigo`),
  KEY `fk_ALUMNADO_has_ASIGNATURA_ALUMNADO1_idx` (`ALUMNADO_Num_Expediente`),
  CONSTRAINT `fk_ALUMNADO_has_ASIGNATURA_ALUMNADO1` FOREIGN KEY (`ALUMNADO_Num_Expediente`) REFERENCES `alumnado` (`Num_Expediente`) ON DELETE SET DEFAULT ON UPDATE SET DEFAULT,
  CONSTRAINT `fk_ALUMNADO_has_ASIGNATURA_ASIGNATURA1` FOREIGN KEY (`ASIGNATURA_Codigo`) REFERENCES `asignatura` (`Codigo`) ON DELETE SET DEFAULT ON UPDATE SET DEFAULT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `profesorado` (
  `DNI` int NOT NULL,
  `Nombre` varchar(45) DEFAULT NULL,
  `Apellido1` varchar(45) DEFAULT NULL,
  `Apellido2` varchar(45) DEFAULT NULL,
  `Telefono` int DEFAULT NULL,
  `Codigo_Departamento` int NOT NULL,
  PRIMARY KEY (`DNI`),
  KEY `TRABAJADORES_FK` (`Codigo_Departamento`),
  CONSTRAINT `TRABAJADORES_FK` FOREIGN KEY (`Codigo_Departamento`) REFERENCES `departamento` (`Codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `tutor_legal` (
  `Codigo` int NOT NULL AUTO_INCREMENT,
  `DNI` varchar(12) NOT NULL,
  `Nombre` varchar(40) DEFAULT NULL,
  `telefono` int NOT NULL,
  PRIMARY KEY (`Codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `zonas` (
  `Codigo` int NOT NULL,
  `Piso` int DEFAULT NULL,
  `Num_pupitres` int DEFAULT NULL,
  `Tipo` int NOT NULL,
  PRIMARY KEY (`Codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
