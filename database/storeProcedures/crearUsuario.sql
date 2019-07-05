DROP PROCEDURE crearUsuario;
DELIMITER ;;
CREATE  PROCEDURE crearUsuario(
IN _nombres varchar(45), IN _status varchar(45),IN _apellidos varchar(45),
IN _correo varchar(45),IN _password varchar(45),IN _id_tipo_documento INT,
IN _numero_documento varchar(45),IN _id_sexo INT,IN _id_estado_civil INT,
IN _fecha_nacimiento varchar(45),IN _profesion varchar(45),IN _conyugue varchar(45),
IN _tel_casa varchar(45),IN _celular varchar(45),IN _lugar_trabajo varchar(45), 
IN _direccion varchar(250), IN _id_ciudad INT)

BEGIN
	-- Insertar direccion
	INSERT INTO `mydb`.`hc_direccion`
	(`info_direccion`,`id_ciudad`)
	VALUES(_direccion,_id_ciudad);

	SET @ID_DIRECCION = LAST_INSERT_ID();

	-- Insetar usuario
	INSERT INTO `mydb`.`hc_usuarios`
	(`nombres`,`status`,`apellidos`,`correo`,`password`,`id_tipo_documento`,`numero_documento`,`id_sexo`,
	`id_estado_civil`,`fecha_nacimiento`,`profesion`,`conyugue`,`tel_casa`,`celular`,`lugar_trabajo`,`id_direccion`)
	VALUES
	(_nombres,_status,_apellidos,_correo,_password,_id_tipo_documento,_numero_documento,id_sexo,
    id_estado_civil,_fecha_nacimiento,_profesion,_conyugue,_tel_casa,_celular,_lugar_trabajo,@ID_DIRECCION);
	SELECT LAST_INSERT_ID();
END ;;
DELIMITER ;
-- Ejemplo
-- call crearUsuario("Luis", "status", "Prado", "luismash@hotmail.com", "123456", 1,"1234",1,1,"22041992","Ingeniero", "NA","24102570","88081725","GBM","150 m asdasd",1);