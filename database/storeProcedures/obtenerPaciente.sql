DROP PROCEDURE IF EXISTS obtenerPaciente;
DELIMITER $$
CREATE  PROCEDURE obtenerPaciente(
IN _id_paciente INT)
BEGIN
SELECT * FROM hc_pacientes
	INNER JOIN hc_contacto ON hc_pacientes.id_contacto = hc_contacto.id_contacto
WHERE hc_pacientes.id_paciente = _id_paciente;
END$$
DELIMITER ;

call obtenerPaciente(2);
