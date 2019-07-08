DROP PROCEDURE IF EXISTS obtenerPacientes;
DELIMITER $$
CREATE  PROCEDURE obtenerPacientes()
BEGIN
SELECT * FROM hc_pacientes
	INNER JOIN hc_contacto ON hc_pacientes.id_contacto = hc_contacto.id_contacto;
END$$
DELIMITER ;

call obtenerPacientes();
