CREATE DEFINER=`root`@`%` FUNCTION `INSTITUTO_PROYECTO`.`obtener_edad_alumno`(id_alumno INT) RETURNS int
BEGIN
    DECLARE fecha date;
    DECLARE edad INT;

    SELECT a.Fecha_Nacimiento INTO fecha
    FROM ALUMNADO a
    WHERE a.Num_Expediente = id_alumno;

    SET edad = TIMESTAMPDIFF(YEAR, fecha, CURDATE());

    RETURN edad;
END;

CREATE DEFINER=`root`@`%` FUNCTION `INSTITUTO_PROYECTO`.`total_profesorado_departamento`(departamento VARCHAR(45)) RETURNS int
BEGIN
    DECLARE num_profesorado INT;
   
	SELECT COUNT(*) INTO num_profesorado
    FROM PROFESORADO p
    INNER JOIN DEPARTAMENTO d ON p.Codigo_Departamento = d.Codigo
    WHERE d.Nombre = departamento;

    RETURN num_profesorado;
END;
