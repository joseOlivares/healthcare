DROP PROCEDURE IF EXISTS actualizarPaciente;
DELIMITER $$
CREATE PROCEDURE actualizarPaciente(
IN _id_paciente INT, 
IN _id_usuario INT, IN _num_expediente varchar(45),IN _nombre_contacto varchar(45),
IN _apellido_contacto varchar(45),IN _telefono_1 varchar(45), IN _telefono_2 varchar(45),
IN _id_parentezco INT)
BEGIN
	-- Obtener id del contacto del usuario
    SELECT @ID_CONTACTO :=  id_contacto FROM hc_pacientes
		WHERE hc_pacientes.id_paciente= _id_paciente;
    -- Se actualiza el contacto del paciente
    
	UPDATE hc_contacto
	SET
	nombre_contacto = _nombre_contacto,apellido_contacto =_apellido_contacto,
    telefono_1=_telefono_1 , telefono_2 = _telefono_2, id_parentezco = _id_parentezco
	WHERE id_contacto = @ID_CONTACTO;
    
    UPDATE hc_pacientes
	SET
	id_usuario = _id_usuario,
    num_expediente = _num_expediente
    WHERE id_paciente =  _id_paciente;
END$$
DELIMITER ;

call actualizarPaciente(2,1, "w1","ContactoNombre","Apellido Contacto", "88128888","88128888",1);

