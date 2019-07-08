DROP PROCEDURE IF EXISTS crearPaciente;
DELIMITER ;;

CREATE  PROCEDURE crearPaciente(
IN _id_usuario INT, IN _num_expediente varchar(45),IN _nombre_contacto varchar(45),
IN _apellido_contacto varchar(45),IN _telefono_1 varchar(45), IN _telefono_2 varchar(45),
IN _id_parentezco INT)

BEGIN
	-- Insertar contacto
	INSERT INTO hc_contacto
	(nombre_contacto,apellido_contacto, telefono_1, telefono_2, id_parentezco)
	VALUES(_nombre_contacto,_apellido_contacto, _telefono_1, _telefono_2, _id_parentezco);

	SET @ID_CONTACTO = LAST_INSERT_ID();
	INSERT INTO hc_pacientes
	(id_usuario, num_expediente, id_contacto)
	VALUES
	(_id_usuario, _num_expediente, @ID_CONTACTO);
	SELECT LAST_INSERT_ID();
END ;;
DELIMITER ;
-- Ejemplo
call crearPaciente(1,"1", "ContactoNombre","Apellido Contacto", "88888888","88888888",1);