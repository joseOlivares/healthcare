DROP PROCEDURE IF EXISTS actualizarUsuario;
DELIMITER ;;

CREATE  PROCEDURE actualizarUsuario(
IN _id_usuario INT,
IN _nombres varchar(45), IN _status varchar(45),IN _apellidos varchar(45),
IN _correo varchar(45),IN _password varchar(45),IN _id_tipo_documento INT,
IN _numero_documento varchar(45),IN _id_sexo INT,IN _id_estado_civil INT,
IN _fecha_nacimiento varchar(45),IN _profesion varchar(45),IN _conyugue varchar(45),
IN _tel_casa varchar(45),IN _celular varchar(45),IN _lugar_trabajo varchar(45), 
IN _direccion varchar(250), IN _id_ciudad INT)

BEGIN
	-- Se obtiene el id de la direccion del usuario
	SELECT @ID_DIRECCION :=  id_direccion FROM hc_usuarios 
		WHERE hc_usuarios.id_usuarios = _id_usuario;
    
    -- Se actualiza la direccion del usuario
	UPDATE hc_direccion
	SET
	`info_direccion` = _direccion,
	`id_ciudad` = _id_ciudad
	WHERE `id_direccion` = @ID_DIRECCION;
    
    UPDATE `hc_usuarios`
	SET
	`nombres` =  _nombres,
	`status` = _status,
	`apellidos` = _apellidos,
	`correo` = _correo,
	`password` = _password,
	`id_tipo_documento` = _id_tipo_documento,
	`numero_documento` = _numero_documento,
	`id_sexo` = _id_sexo,
	`id_estado_civil` = _id_estado_civil,
	`fecha_nacimiento` = _fecha_nacimiento,
	`profesion` = _profesion,
	`conyugue` = _conyugue,
	`tel_casa` = _tel_casa,
	`celular` = _celular,
	`lugar_trabajo` = _lugar_trabajo
	WHERE `id_usuarios` = _id_usuario;
END ;;
DELIMITER ;
-- Ejemplo
call actualizarUsuario(1, "Luis", "status", "Prado", "luismash@hotmail.com", "123456", 1,"1234",1,1,"22041992","Ingeniero", "NA","24102570","88081725","GBM","150 m asdasd",1);