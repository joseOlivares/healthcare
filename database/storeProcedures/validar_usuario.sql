CREATE PROCEDURE `validarUsuario`(
	IN `email` VARCHAR(45),
	IN `pass` VARCHAR(45)
)
LANGUAGE SQL
NOT DETERMINISTIC
READS SQL DATA
SQL SECURITY DEFINER
COMMENT 'Procedimiento que valida la existencia de un usuario '
SELECT id_usuarios, nombres, apellidos, correo
    FROM hc_usuarios
    WHERE correo= email and password=pass