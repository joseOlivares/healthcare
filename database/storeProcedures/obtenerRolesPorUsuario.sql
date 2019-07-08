DROP PROCEDURE IF EXISTS obtenerUsuarioRoles; 
DELIMITER $$
CREATE  PROCEDURE obtenerUsuarioRoles(
IN _id_usuario INT)
BEGIN
SELECT * FROM hc_usuarios_roles
	INNER JOIN hc_roles ON hc_usuarios_roles.id_rol = hc_roles.id_rol
WHERE hc_usuarios_roles.id_usuario = _id_usuario;
END$$
DELIMITER ;

-- Example of call
call obtenerUsuarioRoles(1);
