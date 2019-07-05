DROP PROCEDURE IF EXISTS obtenerUsuarios;
DELIMITER ;;

CREATE  PROCEDURE obtenerUsuarios()
BEGIN
SELECT * FROM hc_usuarios 
	INNER JOIN hc_direccion ON hc_usuarios.id_direccion = hc_direccion.id_direccion
    INNER JOIN hc_tipo_documento ON hc_usuarios.id_tipo_documento = hc_tipo_documento.id_tipo_documento
    INNER JOIN hc_sexo ON hc_usuarios.id_sexo = hc_sexo.id_sexo
    INNER JOIN hc_estado_civil ON hc_estado_civil.id_estado_civil = hc_usuarios.id_estado_civil;
END;;
DELIMITER ;

-- example

call obtenerUsuarios();

    
	