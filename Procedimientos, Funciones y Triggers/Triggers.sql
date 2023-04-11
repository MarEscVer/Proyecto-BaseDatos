CREATE DEFINER=`root`@`%` TRIGGER `TUTOR_LEGAL_MODIFICADO` AFTER UPDATE ON `TUTOR_LEGAL` FOR EACH ROW BEGIN
INSERT INTO TUTOR_LEGAL_MODIFICADO (Codigo, DNI, Nombre, Telefono)
VALUES (old.Codigo, old.DNI, old.Nombre, old.Telefono);
END;

CREATE DEFINER=`root`@`%` TRIGGER `actualizar_total_alumnos` AFTER INSERT ON `ALUMNADO` FOR EACH ROW BEGIN
    UPDATE TOTAL_ALUMNOS_GRUPO
    SET Total_Alumnos = (
        SELECT COUNT(*) FROM ALUMNADO WHERE Codigo_Grupo = NEW.Codigo_Grupo
    )
    WHERE Codigo_Grupo = NEW.Codigo_Grupo;
END;
