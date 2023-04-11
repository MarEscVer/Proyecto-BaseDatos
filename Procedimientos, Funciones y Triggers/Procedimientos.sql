CREATE DEFINER=`root`@`%` PROCEDURE `INSTITUTO_PROYECTO`.`mostrar_edad_alumno`(IN id_alumno INT)
BEGIN
    DECLARE edad INT;
    
   		SET edad = obtener_edad_alumno(id_alumno);
    	SELECT CONCAT_WS(' ', a.Nombre, a.Apellido1, a.Apellido2) AS nombre_completo, edad AS edad_actual
    	FROM ALUMNADO a
    		WHERE a.Num_Expediente IN(id_alumno);
   
END;

CREATE DEFINER=`root`@`%` PROCEDURE `INSTITUTO_PROYECTO`.`num_asignaturas_por_departamento`(codigo_departamento INT)
BEGIN
	SELECT COUNT(*) AS NumAsignaturas
	FROM ASIGNATURA a
	INNER JOIN HORARIO h ON a.Codigo = h.ASIGNATURA_Codigo
	INNER JOIN PROFESORADO p ON h.DNI_Profesorado = p.DNI
	INNER JOIN DEPARTAMENTO d ON p.Codigo_Departamento = d.Codigo
	WHERE d.Codigo = codigo_departamento;
END;

CREATE DEFINER=`root`@`%` PROCEDURE `INSTITUTO_PROYECTO`.`obtener_cantidad_profesores_por_departamento`(codigo_departamento INT)
BEGIN
    DECLARE codigo INT;
	DECLARE cantidad_profesores INT;
    DECLARE done bool DEFAULT FALSE;
   	DECLARE salida VARCHAR(100);
    
	DECLARE cursor_departamentos CURSOR FOR 
		SELECT d.Codigo
		FROM DEPARTAMENTO d
		WHERE d.Codigo = codigo_departamento;

	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

	SELECT COUNT(*) INTO cantidad_profesores
			FROM PROFESORADO p 
			WHERE p.Codigo_Departamento = codigo_departamento;
			
    OPEN cursor_departamentos;
    
    WHILE NOT done DO
        FETCH cursor_departamentos INTO codigo;
        IF NOT done THEN
			SET salida = concat('El departamento tiene ', cantidad_profesores, ' profesores.');
		END IF;
	END WHILE;
    CLOSE cursor_departamentos;
   
   SELECT salida;
END;
