USE sql9297610;

DELETE FROM hc_med_recetas;
DELETE FROM hc_medicamentos;
DELETE FROM hc_recetas;
DELETE FROM hc_diagnosticos;
DELETE FROM hc_citas;
DELETE FROM hc_medicos;
DELETE FROM hc_pacientes;
DELETE FROM hc_contacto;
DELETE FROM hc_parentezco;
DELETE FROM hc_usuarios_roles;
DELETE FROM hc_usuarios;
DELETE FROM hc_roles;
DELETE FROM hc_tipo_documento;
DELETE FROM hc_sexo;
DELETE FROM hc_estado_civil;
DELETE FROM hc_direccion;
DELETE FROM hc_ciudad;
DELETE FROM hc_departamento;
DELETE FROM hc_pais;

DROP table IF EXISTS hc_med_recetas;
DROP table IF EXISTS  hc_medicamentos;
DROP table IF EXISTS  hc_recetas;
DROP table IF EXISTS  hc_diagnosticos;
DROP table IF EXISTS  hc_citas;
DROP table IF EXISTS  hc_medicos;
DROP table IF EXISTS  hc_pacientes;
DROP table IF EXISTS  hc_contacto;
DROP table IF EXISTS  hc_parentezco;
DROP table IF EXISTS  hc_usuarios_roles;
DROP table IF EXISTS  hc_usuarios;
DROP table IF EXISTS  hc_roles;
DROP table IF EXISTS  hc_tipo_documento;
DROP table IF EXISTS  hc_sexo;
DROP table IF EXISTS  hc_estado_civil;
DROP table IF EXISTS  hc_direccion;
DROP table IF EXISTS  hc_ciudad;
DROP table IF EXISTS  hc_departamento;
DROP table IF EXISTS  hc_pais;

DROP PROCEDURE IF EXISTS actualizarPaciente;
DROP PROCEDURE IF EXISTS actualizarUsuario;
DROP PROCEDURE IF EXISTS crearPaciente;
DROP PROCEDURE IF EXISTS crearUsuario;
DROP PROCEDURE IF EXISTS debug_msg;
DROP PROCEDURE IF EXISTS obtenerPaciente;
DROP PROCEDURE IF EXISTS obtenerPacientes;
DROP PROCEDURE IF EXISTS obtenerUsuario;
DROP PROCEDURE IF EXISTS obtenerUsuarioRoles;
DROP PROCEDURE IF EXISTS obtenerUsuarios;
DROP PROCEDURE IF EXISTS validarUsuario;


CREATE TABLE `hc_medicamentos` (
  `id_medicamento` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_medicamento` varchar(45) NOT NULL,
  PRIMARY KEY (`id_medicamento`)
);

CREATE TABLE `hc_pais` (
  `id_pais` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_pais` varchar(45) NOT NULL,
  PRIMARY KEY (`id_pais`)
);

CREATE TABLE `hc_departamento` (
  `id_departamento` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_departamento` varchar(45) NOT NULL,
  `id_pais` int(11) NOT NULL,
  PRIMARY KEY (`id_departamento`),
  KEY `fk_hc_departamento_hc_pais1_idx` (`id_pais`),
  CONSTRAINT `fk_hc_departamento_hc_pais1` FOREIGN KEY (`id_pais`) REFERENCES `hc_pais` (`id_pais`)
);

CREATE TABLE `hc_ciudad` (
  `id_ciudad` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_ciudad` varchar(45) NOT NULL,
  `id_departamento` int(11) NOT NULL,
  PRIMARY KEY (`id_ciudad`),
  KEY `fk_hc_ciudad_hc_departamento1_idx` (`id_departamento`),
  CONSTRAINT `fk_hc_ciudad_hc_departamento1` FOREIGN KEY (`id_departamento`) REFERENCES `hc_departamento` (`id_departamento`)
);

CREATE TABLE `hc_direccion` (
  `id_direccion` int(11) NOT NULL AUTO_INCREMENT,
  `info_direccion` varchar(250) NOT NULL,
  `id_ciudad` int(11) NOT NULL,
  PRIMARY KEY (`id_direccion`),
  KEY `fk_hc_direccion_hc_ciudad1_idx` (`id_ciudad`),
  CONSTRAINT `fk_hc_direccion_hc_ciudad1` FOREIGN KEY (`id_ciudad`) REFERENCES `hc_ciudad` (`id_ciudad`)
) ;


CREATE TABLE `hc_roles` (
  `id_rol` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_rol` varchar(45) NOT NULL,
  PRIMARY KEY (`id_rol`)
);

CREATE TABLE `hc_tipo_documento` (
  `id_tipo_documento` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_documento` varchar(45) NOT NULL,
  PRIMARY KEY (`id_tipo_documento`)
);

CREATE TABLE `hc_sexo` (
  `id_sexo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_sexo` varchar(45) NOT NULL,
  PRIMARY KEY (`id_sexo`)
);

CREATE TABLE `hc_estado_civil` (
  `id_estado_civil` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_estado_civil` varchar(45) NOT NULL,
  PRIMARY KEY (`id_estado_civil`)
);

CREATE TABLE `hc_parentezco` (
  `id_parentezco` int(11) NOT NULL AUTO_INCREMENT,
  `valor_parentezco` varchar(45) NOT NULL,
  PRIMARY KEY (`id_parentezco`)
);
CREATE TABLE `hc_contacto` (
  `id_contacto` int(11) NOT NULL AUTO_INCREMENT COMMENT 'contacto de paciente.',
  `nombre_contacto` varchar(45) DEFAULT NULL,
  `apellido_contacto` varchar(45) DEFAULT NULL,
  `telefono_1` varchar(45) DEFAULT NULL,
  `telefono_2` varchar(45) DEFAULT NULL,
  `id_parentezco` int(11) NOT NULL,
  PRIMARY KEY (`id_contacto`),
  KEY `fk_hc_contacto_parentezco1_idx` (`id_parentezco`),
  CONSTRAINT `fk_hc_contacto_parentezco1` FOREIGN KEY (`id_parentezco`) REFERENCES `hc_parentezco` (`id_parentezco`)
);

CREATE TABLE `hc_usuarios` (
  `id_usuarios` int(11) NOT NULL AUTO_INCREMENT,
  `nombres` varchar(45) NOT NULL,
  `status` varchar(45) NOT NULL COMMENT 'de alta o de baja.',
  `apellidos` varchar(45) NOT NULL,
  `correo` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `id_tipo_documento` int(11) NOT NULL,
  `numero_documento` varchar(45) NOT NULL,
  `id_sexo` int(11) NOT NULL,
  `id_estado_civil` int(11) NOT NULL,
  `fecha_nacimiento` varchar(45) NOT NULL,
  `profesion` varchar(45) DEFAULT NULL,
  `conyugue` varchar(45) DEFAULT NULL,
  `tel_casa` varchar(45) DEFAULT NULL,
  `celular` varchar(45) DEFAULT NULL,
  `lugar_trabajo` varchar(45) DEFAULT NULL,
  `id_direccion` int(11) NOT NULL,
  PRIMARY KEY (`id_usuarios`),
  KEY `fk_hc_usuarios_ch_tipo_documento1_idx` (`id_tipo_documento`),
  KEY `fk_hc_usuarios_hc_sexo1_idx` (`id_sexo`),
  KEY `fk_hc_usuarios_hc_estado_civil1_idx` (`id_estado_civil`),
  KEY `fk_hc_usuarios_hc_direccion1_idx` (`id_direccion`),
  CONSTRAINT `fk_hc_usuarios_ch_tipo_documento1` FOREIGN KEY (`id_tipo_documento`) REFERENCES `hc_tipo_documento` (`id_tipo_documento`),
  CONSTRAINT `fk_hc_usuarios_hc_direccion1` FOREIGN KEY (`id_direccion`) REFERENCES `hc_direccion` (`id_direccion`),
  CONSTRAINT `fk_hc_usuarios_hc_estado_civil1` FOREIGN KEY (`id_estado_civil`) REFERENCES `hc_estado_civil` (`id_estado_civil`),
  CONSTRAINT `fk_hc_usuarios_hc_sexo1` FOREIGN KEY (`id_sexo`) REFERENCES `hc_sexo` (`id_sexo`)
);

CREATE TABLE `hc_usuarios_roles` (
  `id_usuario` int(11) NOT NULL,
  `id_rol` int(11) NOT NULL,
  `id_usuarios_roles` int(11) NOT NULL,
  PRIMARY KEY (`id_usuarios_roles`),
  KEY `fk_hc_usuarios_has_hc_roles_hc_roles1_idx` (`id_rol`),
  KEY `fk_hc_usuarios_has_hc_roles_hc_usuarios1_idx` (`id_usuario`),
  CONSTRAINT `fk_hc_usuarios_has_hc_roles_hc_roles1` FOREIGN KEY (`id_rol`) REFERENCES `hc_roles` (`id_rol`),
  CONSTRAINT `fk_hc_usuarios_has_hc_roles_hc_usuarios1` FOREIGN KEY (`id_usuario`) REFERENCES `hc_usuarios` (`id_usuarios`)
);
CREATE TABLE `hc_medicos` (
  `id_medico` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `identificacion_medica` varchar(45) NOT NULL COMMENT 'numero de acreditacion del doctor.',
  PRIMARY KEY (`id_medico`),
  KEY `fk_hc_medicos_hc_usuarios1_idx` (`id_usuario`),
  CONSTRAINT `fk_hc_medicos_hc_usuarios1` FOREIGN KEY (`id_usuario`) REFERENCES `hc_usuarios` (`id_usuarios`)
);

CREATE TABLE `hc_pacientes` (
  `id_paciente` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `num_expediente` varchar(45) NOT NULL,
  `id_contacto` int(11) NOT NULL,
  PRIMARY KEY (`id_paciente`),
  KEY `fk_hc_pacientes_hc_usuarios1_idx` (`id_usuario`),
  KEY `fk_hc_pacientes_hc_contacto1_idx` (`id_contacto`),
  CONSTRAINT `fk_hc_pacientes_hc_contacto1` FOREIGN KEY (`id_contacto`) REFERENCES `hc_contacto` (`id_contacto`),
  CONSTRAINT `fk_hc_pacientes_hc_usuarios1` FOREIGN KEY (`id_usuario`) REFERENCES `hc_usuarios` (`id_usuarios`)
);

CREATE TABLE `hc_citas` (
  `id_cita` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(45) DEFAULT NULL,
  `descripcion` varchar(500) DEFAULT NULL,
  `fecha_cita` varchar(45) DEFAULT NULL,
  `fecha_creacion` varchar(45) DEFAULT NULL,
  `id_paciente` int(11) NOT NULL,
  `id_medico` int(11) NOT NULL,
  PRIMARY KEY (`id_cita`),
  KEY `fk_hc_citas_hc_pacientes1_idx` (`id_paciente`),
  KEY `fk_hc_citas_hc_medicos1_idx` (`id_medico`),
  CONSTRAINT `fk_hc_citas_hc_medicos1` FOREIGN KEY (`id_medico`) REFERENCES `hc_medicos` (`id_medico`),
  CONSTRAINT `fk_hc_citas_hc_pacientes1` FOREIGN KEY (`id_paciente`) REFERENCES `hc_pacientes` (`id_paciente`)
) ;

CREATE TABLE `hc_diagnosticos` (
  `id_diagnostico` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(500) NOT NULL,
  `titulo` varchar(45) NOT NULL COMMENT 'nombre de la enfermedad que padece el paciente',
  `fecha` datetime NOT NULL,
  `id_paciente` int(11) NOT NULL,
  `id_medico` int(11) NOT NULL,
  PRIMARY KEY (`id_diagnostico`),
  KEY `fk_hc_diagnosticos_hc_usuarios_idx` (`id_paciente`),
  KEY `fk_hc_diagnosticos_hc_medicos1_idx` (`id_medico`),
  CONSTRAINT `fk_hc_diagnosticos_hc_medicos1` FOREIGN KEY (`id_medico`) REFERENCES `hc_medicos` (`id_medico`),
  CONSTRAINT `fk_hc_diagnosticos_hc_usuarios` FOREIGN KEY (`id_paciente`) REFERENCES `hc_pacientes` (`id_paciente`)
);

CREATE TABLE `hc_recetas` (
  `id_receta` int(11) NOT NULL AUTO_INCREMENT,
  `id_diagnostico` int(11) NOT NULL,
  `fecha_emision` datetime NOT NULL,
  PRIMARY KEY (`id_receta`),
  KEY `fk_hc_recetas_hc_diagnosticos1_idx` (`id_diagnostico`),
  CONSTRAINT `fk_hc_recetas_hc_diagnosticos1` FOREIGN KEY (`id_diagnostico`) REFERENCES `hc_diagnosticos` (`id_diagnostico`)
);


CREATE TABLE `hc_med_recetas` (
  `id_medicamento` int(11) NOT NULL,
  `id_receta` int(11) NOT NULL,
  `id_med_recetas` int(11) NOT NULL AUTO_INCREMENT,
  `indicaciones` varchar(500) NOT NULL,
  PRIMARY KEY (`id_med_recetas`),
  KEY `fk_hc_medicamentos_has_hc_recetas_hc_recetas1_idx` (`id_receta`),
  KEY `fk_hc_medicamentos_has_hc_recetas_hc_medicamentos1_idx` (`id_medicamento`),
  CONSTRAINT `fk_hc_medicamentos_has_hc_recetas_hc_medicamentos1` FOREIGN KEY (`id_medicamento`) REFERENCES `hc_medicamentos` (`id_medicamento`),
  CONSTRAINT `fk_hc_medicamentos_has_hc_recetas_hc_recetas1` FOREIGN KEY (`id_receta`) REFERENCES `hc_recetas` (`id_receta`)
);

DELIMITER $$
CREATE PROCEDURE `actualizarPaciente`(
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

DELIMITER $$
CREATE PROCEDURE `actualizarUsuario`(
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
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `crearPaciente`(
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
    -- La siguiente linea se debe comentar al ejecutar el archivo en phpmyadmin,  se descomenta despues de cargar los datos
	-- SELECT LAST_INSERT_ID();
END$$
DELIMITER ;

DELIMITER $$
CREATE  PROCEDURE `crearUsuario`(
IN _nombres varchar(45), IN _status varchar(45),IN _apellidos varchar(45),
IN _correo varchar(45),IN _password varchar(45),IN _id_tipo_documento INT,
IN _numero_documento varchar(45),IN _id_sexo INT,IN _id_estado_civil INT,
IN _fecha_nacimiento varchar(45),IN _profesion varchar(45),IN _conyugue varchar(45),
IN _tel_casa varchar(45),IN _celular varchar(45),IN _lugar_trabajo varchar(45), 
IN _direccion varchar(250), IN _id_ciudad INT)
BEGIN
	-- Insertar direccion
	INSERT INTO `hc_direccion`
	(`info_direccion`,`id_ciudad`)
	VALUES(_direccion,_id_ciudad);

	SET @ID_DIRECCION = LAST_INSERT_ID();
	INSERT INTO `hc_usuarios`
	(`nombres`,`status`,`apellidos`,`correo`,`password`,`id_tipo_documento`,`numero_documento`,`id_sexo`,
	`id_estado_civil`,`fecha_nacimiento`,`profesion`,`conyugue`,`tel_casa`,`celular`,`lugar_trabajo`,`id_direccion`)
	VALUES
	(_nombres,_status,_apellidos,_correo,_password,_id_tipo_documento,_numero_documento,_id_sexo,
    _id_estado_civil,_fecha_nacimiento,_profesion,_conyugue,_tel_casa,_celular,_lugar_trabajo,@ID_DIRECCION);
    -- La siguiente linea se debe comentar al ejecutar el archivo en phpmyadmin, se descomenta despues de cargar los datos
	-- SELECT LAST_INSERT_ID();
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `obtenerPaciente`(
IN _id_paciente INT)
BEGIN
SELECT * FROM hc_pacientes
	INNER JOIN hc_contacto ON hc_pacientes.id_contacto = hc_contacto.id_contacto
WHERE hc_pacientes.id_paciente = _id_paciente;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `obtenerPacientes`()
BEGIN
SELECT * FROM hc_pacientes
	INNER JOIN hc_contacto ON hc_pacientes.id_contacto = hc_contacto.id_contacto;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `obtenerUsuario`(
IN _id_usuario INT)
BEGIN
SELECT * FROM hc_usuarios 
	INNER JOIN hc_direccion ON hc_usuarios.id_direccion = hc_direccion.id_direccion
    INNER JOIN hc_tipo_documento ON hc_usuarios.id_tipo_documento = hc_tipo_documento.id_tipo_documento
    INNER JOIN hc_sexo ON hc_usuarios.id_sexo = hc_sexo.id_sexo
    INNER JOIN hc_estado_civil ON hc_estado_civil.id_estado_civil = hc_usuarios.id_estado_civil
WHERE hc_usuarios.id_usuarios = _id_usuario;
END$$
DELIMITER ;

DELIMITER $$
CREATE  PROCEDURE `obtenerUsuarioRoles`(
IN _id_usuario INT)
BEGIN
SELECT * FROM hc_usuarios_roles
	INNER JOIN hc_roles ON hc_usuarios_roles.id_rol = hc_roles.id_rol
WHERE hc_usuarios_roles.id_usuario = _id_usuario;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `obtenerUsuarios`()
BEGIN
SELECT * FROM hc_usuarios 
	INNER JOIN hc_direccion ON hc_usuarios.id_direccion = hc_direccion.id_direccion
    INNER JOIN hc_tipo_documento ON hc_usuarios.id_tipo_documento = hc_tipo_documento.id_tipo_documento
    INNER JOIN hc_sexo ON hc_usuarios.id_sexo = hc_sexo.id_sexo
    INNER JOIN hc_estado_civil ON hc_estado_civil.id_estado_civil = hc_usuarios.id_estado_civil;
END$$
DELIMITER ;

DELIMITER $$
CREATE  PROCEDURE `validarUsuario`(
	IN `email` VARCHAR(45),
	IN `pass` VARCHAR(45)
)
    READS SQL DATA
    COMMENT 'Procedimiento que valida la existencia de un usuario '
SELECT id_usuarios, nombres, apellidos, correo
    FROM hc_usuarios
    WHERE correo= email and password=pass$$
DELIMITER ;



ALTER TABLE hc_med_recetas AUTO_INCREMENT = 1;
ALTER TABLE hc_medicamentos AUTO_INCREMENT = 1;
ALTER TABLE hc_recetas AUTO_INCREMENT = 1;
ALTER TABLE hc_diagnosticos AUTO_INCREMENT = 1;
ALTER TABLE hc_citas AUTO_INCREMENT = 1;
ALTER TABLE hc_medicos AUTO_INCREMENT = 1;
ALTER TABLE hc_pacientes AUTO_INCREMENT = 1;
ALTER TABLE hc_contacto AUTO_INCREMENT = 1;
ALTER TABLE hc_parentezco AUTO_INCREMENT = 1;
ALTER TABLE hc_usuarios_roles AUTO_INCREMENT = 1;
ALTER TABLE hc_usuarios AUTO_INCREMENT = 1;
ALTER TABLE hc_roles AUTO_INCREMENT = 1;
ALTER TABLE hc_tipo_documento AUTO_INCREMENT = 1;
ALTER TABLE hc_sexo AUTO_INCREMENT = 1;
ALTER TABLE hc_estado_civil AUTO_INCREMENT = 1;
ALTER TABLE hc_direccion AUTO_INCREMENT = 1;
ALTER TABLE hc_ciudad AUTO_INCREMENT = 1;
ALTER TABLE hc_departamento AUTO_INCREMENT = 1;
ALTER TABLE hc_pais AUTO_INCREMENT = 1;



INSERT INTO hc_pais(nombre_pais) VALUES("Costa Rica");
INSERT INTO hc_pais(nombre_pais) VALUES("Panama");
INSERT INTO hc_pais(nombre_pais) VALUES("Nicaragua");
INSERT INTO hc_pais(nombre_pais) VALUES("El Salvador");
INSERT INTO hc_pais(nombre_pais) VALUES("Honduras");
INSERT INTO hc_pais(nombre_pais) VALUES("Guatemala");
INSERT INTO hc_pais(nombre_pais) VALUES("Belize");
INSERT INTO hc_pais(nombre_pais) VALUES("Mexico");
INSERT INTO hc_pais(nombre_pais) VALUES("Estados Unidos");
INSERT INTO hc_pais(nombre_pais) VALUES("Canada");
INSERT INTO hc_pais(nombre_pais) VALUES("Groenlandia");
INSERT INTO hc_pais(nombre_pais) VALUES("Cuba");
INSERT INTO hc_pais(nombre_pais) VALUES("Republica Dominicana");
INSERT INTO hc_pais(nombre_pais) VALUES("Haiti");
INSERT INTO hc_pais(nombre_pais) VALUES("Trinidad y Tobago");
INSERT INTO hc_pais(nombre_pais) VALUES("Jamaica");
INSERT INTO hc_pais(nombre_pais) VALUES("Colombia");
INSERT INTO hc_pais(nombre_pais) VALUES("Venezuela");
INSERT INTO hc_pais(nombre_pais) VALUES("Peru");
INSERT INTO hc_pais(nombre_pais) VALUES("Ecuador");
INSERT INTO hc_pais(nombre_pais) VALUES("Bolivia");
INSERT INTO hc_pais(nombre_pais) VALUES("Uruguay");
INSERT INTO hc_pais(nombre_pais) VALUES("Paraguay");
INSERT INTO hc_pais(nombre_pais) VALUES("Chile");
INSERT INTO hc_pais(nombre_pais) VALUES("Argentina");
INSERT INTO hc_pais(nombre_pais) VALUES("Brasil");
INSERT INTO hc_pais(nombre_pais) VALUES("Canada");

INSERT INTO hc_departamento(nombre_departamento, id_pais) VALUES("San José",1);
INSERT INTO hc_departamento(nombre_departamento, id_pais) VALUES("Alajuela",1);
INSERT INTO hc_departamento(nombre_departamento, id_pais) VALUES("Cartago",1);
INSERT INTO hc_departamento(nombre_departamento, id_pais) VALUES("Heredia",1);
INSERT INTO hc_departamento(nombre_departamento, id_pais) VALUES("Guanacaste",1);
INSERT INTO hc_departamento(nombre_departamento, id_pais) VALUES("Puntarenas",1);
INSERT INTO hc_departamento(nombre_departamento, id_pais) VALUES("Limón",1);

INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Central",1);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Escazú",1);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Desamparados",1);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Puriscal",1);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Tarrazú",1);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Aserrí",1);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Mora",1);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Goicoechea",1);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Santa Ana",1);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Alajuelita",1);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Vázquez De Coronado",1);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Acosta",1);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Tibás",1);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Moravia",1);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Montes De Oca",1);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Turrubares",1);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Dota",1);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Curridabat",1);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Pérez Zeledón",1);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("León Cortés Castro",1);

INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Central",2);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("San Ramón",2);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Grecia",2);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("San Mateo",2);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Atenas",2);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Naranjo",2);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Palmares",2);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Poás",2);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Orotina",2);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("San Carlos",2);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Zarcero",2);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Valverde Vega",2);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Upala",2);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Los Chiles",2);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Guatuso",2);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Río Cuarto",2);

INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Central",3);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Paraíso",3);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("La Unión",3);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Jiménez",3);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Turrialba",3);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Alvarado",3);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Oreamuno",3);


INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Central",4);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Barva",4);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Santo Domingo",4);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Santa Barbara",4);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("San Rafael",4);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("San Isidro",4);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Belén",4);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Flores",4);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("San Pablo",4);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Sarapiquí",4);



INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Liberia",5);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Nicoya",5);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Santa Cruz",5);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Bagaces",5);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Carrillo",5);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Cañas",5);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Abangares",5);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Tilarán",5);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Nandayure",5);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("La Cruz",5);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Hojancha",5);


INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Central",6);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Esparza",6);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Buenos Aires",6);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Montes De Oro",6);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Osa",6);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Quepos",6);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Golfito",6);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Coto Brus",6);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Parrita",6);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Corredores",6);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Garabito",6);

INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Central",7);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Pococí",7);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Siquirres",7);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Talamanca",7);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Matina",7);
INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES("Guácimo",7);

INSERT INTO hc_estado_civil(nombre_estado_civil) VALUES("Soltero");
INSERT INTO hc_estado_civil(nombre_estado_civil) VALUES("Casado");

INSERT INTO hc_sexo(nombre_sexo) VALUES("Masculino");
INSERT INTO hc_sexo(nombre_sexo) VALUES("Femenino");

INSERT INTO hc_tipo_documento(nombre_documento) VALUES("Cedula");
INSERT INTO hc_tipo_documento(nombre_documento) VALUES("Pasaporte");

INSERT INTO hc_roles(nombre_rol) VALUES("Medico");
INSERT INTO hc_roles(nombre_rol) VALUES("Paciente");
INSERT INTO hc_roles(nombre_rol) VALUES("Administrador");

INSERT INTO  hc_parentezco(valor_parentezco) VALUES ("Padre");
INSERT INTO  hc_parentezco(valor_parentezco) VALUES ("Madre");

INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Abacavir Sulfate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Abatacept");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Abilify");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Acamprosate Calcium");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Accretropin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Aceon");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Aci-Jel");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Acthrel");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Actimmune");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Actisite");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Acular");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Acular LS");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Acuvail");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Adagen");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Adapalene");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Adcirca");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Adefovir Dipivoxil");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Adenoscan");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Adenosine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Adipex-P");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("AdreView");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Advair HFA");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Aerospan HFA");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Agalsidase Beta");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Aggrenox");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Akineton");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Alamast");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Albenza");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Aldactazide");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Aldactone");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Aldoril");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Aldurazyme");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Alemtuzumab");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Alglucosidase Alfa");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Allegra-D");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Allegra D 24 Hour");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Alli");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Aloprim");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Alora");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Alphanate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Altace");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Altocor");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Altoprev");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Alupent");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Amantadine Hydrochloride");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Amerge");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Amifostine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Amiloride");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Aminosalicylic Acid");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Aminosyn II 8.5%");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Amlodipine Besylate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Amoxapine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Amytal Sodium");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Anabolic steroids");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Anadrol-50");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Antithrombin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Antivenin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Antivert");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Aredia");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Aricept");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Armodafinil");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Arranon");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Artane");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Asclera");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Ascorbic Acid");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Astemizole");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Atacand");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Atacand HCT");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Atazanavir Sulfate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Atomoxetine HCl");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Atridox");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Atripla");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Atropen");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Augmentin XR");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Avage");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Avandia");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Avastin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Avinza");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Axid");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Azasan");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Azasite");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Azelaic Acid");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Azelastine Hydrochloride");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Azilect");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Azmacort");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Balsalazide");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Benazepril");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Benzocaine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Benzoyl Peroxide Gel");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Benzphetamine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Benztropine Mesylate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Bepreve");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Betagan");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Bethanechol");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Betimol");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Betoptic S");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Bevacizumab");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("BiCNU");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Biperiden");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Bismuth Subcitrate Potassium");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Bismuth Subsalicylate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Blocadren");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Boniva");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Bontril");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Boostrix");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Botulinum Toxin Type A");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Bravelle");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Brevibloc");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Bromocriptine Mesylate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Brovana");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Budesonide");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Buprenorphine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Buspar");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Buspirone");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Busulfan");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Busulfex");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Cabergoline");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Caduet");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Calcitonin-Salmon");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Calcium Chloride");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Calcium Disodium Versenate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Calcium Gluconate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Campral");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Canasa");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Cancidas");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Captopril");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Carac");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Carbatrol");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Cardiolite");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Carisoprodol");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Carmustine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Carvedilol");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Casodex");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Caspofungin Acetate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Cataflam");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Catapres");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Catapres-TTS");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Caverject");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Cedax");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Cefditoren Pivoxil");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Cefixime");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Cefizox");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Cefotetan");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Ceftazidime");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Ceftibuten");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Ceftin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Cefzil");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Celestone Soluspan");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Celexa");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("CellCept");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Cellulose");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Celontin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Cephalexin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Cerebyx");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Ceretec");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Cerubidine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Cerumenex");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Cervidil");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Cetirizine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Cetraxal");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Cetrotide");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Cetuximab");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Chantix");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Chibroxin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Chlorambucil");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Chloramphenicol Sodium Succinate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Chloroprocaine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Chlorpheniramine Maleate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Chlorpromazine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Chlorpropamide");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Chlorthalidone");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Cholera Vaccine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Chorionic Gonadotropin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Ciclopirox Gel");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Cilostazol");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Cinobac");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Cipro");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Cipro XR");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Cisapride");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Clarinex");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Clarithromycin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Claritin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Cleocin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Cleviprex");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Climara Pro");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Clinoril");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Clobetasol Propionate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Clocortolone");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Clofarabine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Clonidine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Clorazepate Dipotassium");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Clorpres");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Clotrimazole");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Cocaine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Codeine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Cognex");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Colazal");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Colchicine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Colcrys");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Colesevelam Hcl");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Combivir");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Conjugated Estrogens");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Copaxone");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Corgard");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Cosmegen");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Coumadin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Crolom");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Cromolyn Sodium");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Cubicin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Curosurf");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Cuvposa");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Cyanocobalamin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Cyclobenzaprine Hcl");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Cyclophosphamide");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Cyclosporine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Cylert");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Cymbalta");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Cyproheptadine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Cystadane");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Cytogam");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Cytomel");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Dacarbazine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Daraprim");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Darvocet-N");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Darvon Compound");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Dasatinib");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Daunorubicin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Daypro");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Daypro Alta");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("DDAVP Nasal Spray");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Demadex");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Demeclocycline HCl");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Demser");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Depacon");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("DepoDur");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Desferal");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Desogen");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Desonate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("DesOwen");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Detrol");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Detrol LA");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Dexlansoprazole");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Dexmethylphenidate Hydrochloride");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Dexrazoxane");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Diamox Sequels");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Dicyclomine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Didanosine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Diethylpropion");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Differin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Diflucan");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Digoxin Immune Fab");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Diovan HCT");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Diphenhydramine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Diphtheria-Tetanus Vaccine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Diprolene AF");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Dipyridamole");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Ditropan");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Dobutamine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Dofetilide");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Dolophine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Donepezil Hydrochloride");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Dopamine Hydrochloride");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Dopar");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Dopram");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Doral");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Doryx");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Dorzolamide");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Dovonex");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Doxacurium Chloride");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Doxapram");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Doxazosin Mesylate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Doxepin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Doxercalciferol");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Doxil");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Doxycycline");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Doxycycline Hyclate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Drisdol");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Dronabinol");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Drospirenone and Estradiol");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Duetact");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Duraclon");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Dynacirc");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Dynacirc CR");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Dynapen");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Dyphylline");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Econazole Nitrate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Edrophonium");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Efavirenz");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Elaprase");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Elavil");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Eletriptan hydrobromide");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Eligard");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Ellence");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Elmiron");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Elspar");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Emadine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Emcyt");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Emedastine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Empirin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Emsam");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Emtricitabine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Emtriva");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Endocet");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Endometrin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Enflurane");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Engerix-B");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Entereg");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Eovist");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Epinephrine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Epipen");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Epirubicin hydrochloride");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Epivir");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Equetro");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Eraxis");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Erbitux");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Ergocalciferol");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Erlotinib");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Erythrocin Stearate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Esomeprazole Sodium");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Essential Amino Acids");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Estrace");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Estradiol");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Estradiol Acetate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Estradiol valerate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Estratest");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Estropipate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Eszopiclone");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Etanercept");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Ethacrynic Acid");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Ethambutol");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Ethinyl Estradiol");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Ethiodol");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Ethosuximide");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Etidocaine HCl");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Etidronate Disodium");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Etopophos");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Etrafon");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Eulexin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Evista");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Evoxac");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Exelderm");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Exjade");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Extavia");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Factor IX Complex");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Factrel");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Famciclovir");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Famotidine Injection");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Famvir");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Fansidar");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Febuxostat");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Feridex I.V.");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Fesoterodine Fumarate Extended");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Finacea");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Flector");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Flonase");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Florinef");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Floxuridine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Fluconazole");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Flucytosine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Fludara");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Fludarabine Phosphate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Fludrocortisone");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Flumazenil");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("FluMist");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Fluocinolone Acetonide");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Fluoroplex");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Fluorouracil");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Fluoxetine Hydrochloride");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Flurbiprofen");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Fluress");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Fluticasone Propionate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Fluvirin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("FML");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Folic Acid");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Follitropin Alfa");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Follitropin Beta");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Fomepizole");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Foradil Aerolizer");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Foradil Certihaler");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Forane");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Fosamax Plus D");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Fosamprenavir Calcium");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Foscavir");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Fosphenytoin Sodium");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Fragmin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Frovatriptan Succinate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Fulvestrant");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Fungizone");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Furadantin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Furosemide");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Furoxone");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Fuzeon");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Gabitril");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Gadobenate Dimeglumine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Gadofosveset Trisodium");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Galsulfase");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Gamunex");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Geocillin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Geodon");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Gleevec");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Glucophage XR");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Glucovance");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Glyburide");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Glycopyrrolate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Glynase");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Glyset");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Gold Sodium Thiomalate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Gonadorelin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Gonal-F");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Gonal-f RFF");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Grifulvin V");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Griseofulvin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Guanethidine Monosulfate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Gynazole");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Haemophilus b Conjugate Vaccine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Halcinonide");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Haldol");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Halobetasol Propionate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Haloperidol");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Healon");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("HepaGam B");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Heparin Lock Flush");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("HepatAmine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Hepatitis A Vaccine, Inactivated");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Hepatitis B Immune Globulin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Hepflush-10");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Herceptin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Hexachlorophene");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("HibTITER");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Hivid");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Human Secretin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Humira");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Humulin N");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Hyalgan");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Hydrocodone Bitartrate and Acetaminophen");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Hydroxyethyl Starch");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Hylenex");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Hyoscyamine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Hytrin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Ibuprofen Lysine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Idamycin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Idamycin PFS");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Ifosfamide");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Iloperidone");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Imipramine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Imiquimod");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Imitrex");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Immune Globulin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Immune Globulin Intravenous");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Implanon");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Inderal LA");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Indigo Carmine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("InnoPran XL");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Insulin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Insulin Aspart");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Intelence");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Intralipid 20%");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Intuniv");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Invanz");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Invega");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Inversine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Ionamin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Irinotecan Hydrochloride");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Isentress");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Ismo");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Isocarboxazid");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Isoptin SR");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Isopto Carpine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Isopto Hyoscine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Istalol");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Isuprel");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Ixempra");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Jalyn");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Janumet");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Je-Vax");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("K-LOR");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Kaletra");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Kariva");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Kenalog");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Kinlytic");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Klonopin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Kuvan");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Kytril");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Labetalol");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("lacosamide");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Lamisil");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Lamivudine / Zidovudine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Latanoprost");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Letairis");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Letrozole");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Leuprolide Acetate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Leustatin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Levalbuterol");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Levaquin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Levemir");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Levo-T");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Levocabastine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Levofloxacin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Levonorgestrel");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Levonorgestrel and Ethinyl Estradiol");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Levonorgestrel Implants");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Levonorgestrel, Ethinyl Estradiol");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Lexapro");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Lexiscan");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Lexxel");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Librium");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Lidex");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Lidoderm");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Linezolid");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Lipofen");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Liposyn II");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Liraglutide");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Lisinopril and Hydrochlorothiazide");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Locoid");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Lodine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Loperamide Hcl");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Lopid");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Loprox Gel");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Loracarbef");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Lortab");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Lotemax");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Lotensin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Lotronex");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Lovenox");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Loxapine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Loxitane");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Lucentis");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Luvox CR");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Lybrel");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("M-M-R");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Malarone");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Malathion");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Mandol");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Mangafodipir");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Maraviroc");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Marinol");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Maxitrol");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Mecasermin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Meclofenamate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Mefloquine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Melphalan");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Menactra");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Menest");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Menotropins");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Mephobarbital");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Mequinol and Tretinoin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Meropenem");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Merrem I.V.");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Mesalamine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Mesna");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Mestinon");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Metadate ER");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Metaglip");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Metaproterenol Sulfate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Metaxalone");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Metformin Hcl");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Methadone Hydrochloride");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Methadose Oral Concentrate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Methazolamide");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Methenamine Hippurate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Methergine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Methohexital Sodium");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Methyclothiazide");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Methyldopa");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Methylene Blue");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Methylergonovine Maleate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Methylin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Methyltestosterone");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Metipranolol");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Metoclopramide");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Metoprolol Tartrate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("MetroLotion");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Metyrapone");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Metyrosine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Miacalcin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Micro-K");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Micronase");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Micronized Glyburide");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Midazolam");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Midodrine Hydrochloride");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Milrinone");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Minocin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Minocycline");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Minoxidil");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Miochol-E");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Miostat");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Mitomycin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Mobic");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Modafinil");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Monistat");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Monistat-Derm");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Morrhuate Sodium");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Motrin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Moxatag");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Mozobil");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Multaq");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Multi Vitamin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Multihance");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Mustargen");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Mutamycin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Myambutol");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Mycamine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Mycelex");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Mycophenolic Acid");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Myfortic");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Mykrox");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Myobloc");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Myochrysine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Nafcillin Sodium");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Naftifine Hcl");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Nalmefene Hydrochloride");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Naltrexone");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Naproxen");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Nascobal");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Natazia");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Natrecor");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Navelbine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Nebcin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Nebivolol Tablets");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Nedocromil");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Nelarabine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Nelfinavir Mesylate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("NeoProfen");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Neostigmine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Nephramine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Nesacaine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Neulasta");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Nexavar");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Niaspan");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Nicotrol");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Nicotrol NS");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Nilandron");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Nilotinib Capsules");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Nimbex");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Nimotop");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Nitroglycerin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("NitroMist");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Nizatidine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Nizoral");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Noctec");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Nor-QD");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Norethindrone and Ethinyl Estradiol");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Noritate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Nortriptyline Hydrochloride");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Norvasc");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("NovoLog Mix 70/30");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Novoseven");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Numorphan");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Nutropin AQ");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Nutropin Depot");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Nydrazid");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Omeprazole");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Omnaris");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Opana");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Opticrom");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("OptiMARK");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Optipranolol");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Oracea");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Oraqix");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Orfadin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Orlaam");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Orlistat");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Orudis");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Ovcon");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Ovide");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Oxandrolone");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Oxaprozin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Oxistat");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Oxsoralen-Ultra");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Oxycodone HCl");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Oxycodone Hydrochloride");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Oxycontin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Oxymetholone");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Oxymorphone");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Oxytetracycline");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Paclitaxel");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Palifermin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Paliperidone");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Palonosetron hydrochloride");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Panhematin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Pantoprazole");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Parafon Forte");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Parnate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Paser");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Pataday");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Pazopanib");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Pediapred");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("PEG 3350");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Pegfilgrastim");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Pemirolast Potassium");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Penciclovir");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Penicillamine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Penlac");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Pentetate Zinc Trisodium");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Pentobarbital");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Pentoxifylline");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Perflutren");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Perindopril Erbumine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Permax");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Persantine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Pfizerpen");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Phenazopyridine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Phenelzine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Phenobarbital");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Phenoxybenzamine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Phenylephrine HCl");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Phenylephrine Hydrochloride");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Phenytoin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Phosphate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Photofrin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Pilocarpine Hydrochloride");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Pilopine HS");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Pindolol");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Pipracil");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Piroxicam");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Plaquenil");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("PlasmaLyte A");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Plavix");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Plenaxis");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Pletal");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Pneumovax");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Podophyllin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Polidocanol");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Polyethylene Glycol 3350");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Polythiazide");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Pramipexole");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Pred-G");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Prednicarbate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Prednisolone Acetate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Prednisone");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Prefest");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Pregnyl");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Premarin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Prepidil");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Prevpac");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Priftin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Primacor");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Primaquine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Primidone");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Prinivil");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Prinzide");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Pristiq");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Procainamide");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Procalamine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Prochlorperazine Maleate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("ProHance");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Proleukin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Prolixin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Promethazine HCl");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Promethazine Hydrochloride");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Prometrium");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Propecia");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Proquin XR");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Prostin VR Pediatric");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Protein C Concentrate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Protopic");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Protriptyline Hydrochloride");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Proventil HFA");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Provisc");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Provocholine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Pulmicort Flexhaler");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Pylera");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Pyrazinamide");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Pyridium");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Pyridostigmine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Qualaquin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Quazepam");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Quinidine Sulfate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Quixin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Rabies Vaccine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Raltegravir");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Ranexa");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Ranitidine Hcl");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Rapamune");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Rasagiline");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Raxar");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Rebetol");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Remicade");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Remifentanil");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Renese");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("ReoPro");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Rescriptor");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Rescula");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Revatio");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Revex");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Revia");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Reyataz");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Rezulin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Rhinocort Aqua");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Rhogam Ultra-Filtered Plus");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("RiaSTAP");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Rifamate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Riomet");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Risperidone");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Ritalin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Rituximab");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Rivastigmine Tartrate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Robinul");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Rosiglitazone Maleate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Rotarix");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("RotaTeq");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Roxicet");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Roxicodone");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Ryzolt");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Sabril");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Sacrosidase");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Samsca");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Sanctura");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Santyl");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Saphris");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Scopolamine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Seasonale");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Selegiline Hydrochloride");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Selsun");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Septra");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Serax");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Sertraline Hcl");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Serzone");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Sevoflurane");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Sibutramine Hydrochloride Monohydrate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Silenor");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Simponi");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Sirolimus");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Sitagliptin Metformin HCL");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Slow-K");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Sodium Bicarbonate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Sodium ferric gluconate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Sodium Iodide I 131");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Sodium Polystyrene Sulfonate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Sodium Sulfacetamide");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Soma Compound");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Somatrem");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Somatropin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Sonata");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Soriatane");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Sotradecol");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Spiriva");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Sporanox");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Sprix");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Sprycel");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Stalevo");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Starlix");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Stavudine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Streptokinase");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Strontium-89");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Suboxone");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Succimer");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Succinylcholine Chloride");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Sucralfate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Sulfamylon");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Sunitinib Malate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Sutent");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Synthroid");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Synvisc");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Syprine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Tacrolimus");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Talacen");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Talwin Nx");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Tamiflu");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Tamoxifen Citrate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Tapazole");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Targretin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Tasmar");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Tegretol");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Tekturna HCT");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Telavancin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Telbivudine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Telmisartan");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Temovate Scalp");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Temozolomide");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Temsirolimus");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Teniposide");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Terazol 3, Terazol 7");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Tessalon");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Testolactone");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Testred");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Teveten HCT");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Theracys");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Thiabendazole");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Thiethylperazine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Thiopental Sodium");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Thioridazine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Thiothixene Hcl");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Thrombin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Thyrolar");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Thyrotropin Alfa");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Tiazac");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Ticarcillin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Tinzaparin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Tirosint");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Tizanidine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Tobrex");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Tofranil-PM");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Tolazamide");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Tolmetin Sodium");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Tonocard");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Topicort");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Topiramate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Topotecan Hydrochloride");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Toradol");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Torsemide");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Toviaz");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Tramadol Hcl");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Tranxene");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Trastuzumab");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Trasylol");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Tretinoin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Trexall");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Tri-Sprintec");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Triamcinolone Acetonide");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Triazolam");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Tribenzor");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Trientine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Trihexyphenidyl");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Trilipix");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Trilisate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Trimethadione");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Trimethoprim");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Trimethoprim and Sulfamethoxazole");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Trimetrexate Glucuronate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Trizivir");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Trovafloxacin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Trovan");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Trusopt");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Trypan Blue");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Tussionex");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Tysabri");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Tyvaso");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Uloric");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Ultiva");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Ultram");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Ultrase");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Ultravate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Unasyn");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Urex");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Ursodiol");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Vagistat-1");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Valacyclovir Hydrochloride");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Valganciclovir Hcl");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Valium");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Valproic Acid");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Valsartan and Hydrochlorothiazide");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Vancomycin Hydrochloride");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Vaprisol");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Vasocidin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Vasotec");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Vasovist");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Vectibix");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Vectical");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Velosulin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Veltin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Venlafaxine Hydrochloride");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Veramyst");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Vermox");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Vesanoid");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("VESIcare");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Vibramycin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Vicodin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Vicodin HP");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Vicoprofen");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Victoza");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Vimovo");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Vimpat");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Vinblastine Sulfate");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Viokase");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Vioxx");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Viread");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("VisionBlue");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Vistide");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Vitamin K1");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Vivactil");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Vivelle-Dot");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Vusion");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Vytorin");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Winstrol");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Xigris");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Xolair");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Yellow Fever Vaccine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Zaditor");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Zalcitabine");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Zanosar");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Zelnorm");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Zemaira");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Zemplar");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Zestoretic");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Zestril");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Ziconotide");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Zingo");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Zmax");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Zocor");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Zolinza");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Zolmitriptan");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Zonalon");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Zoster Vaccine Live");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Zosyn");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Zyclara");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Zyflo");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Zylet");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Zyloprim");
INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES ("Zymaxid");


call crearUsuario('سارینا','','کوتی','سارینا.کوتی@example.com','chopper',1,'0',2,1,'undefined','','','0997-267-1133','0997-267-1133','بیرجند','بیرجند','1');
call crearUsuario('melissa','','fleming','melissa.fleming@example.com','sick',2,'1',2,2,'undefined','','','0740-304-475','0740-304-475','winchester','winchester','2');
call crearUsuario('christoffer','','christiansen','christoffer.christiansen@example.com','samuel',1,'2',1,1,'undefined','','','05761325','05761325','overby lyng','overby lyng','3');
call crearUsuario('valtteri','','pulkkinen','valtteri.pulkkinen@example.com','peepee',2,'3',1,2,'undefined','','','041-829-79-61','041-829-79-61','parikkala','parikkala','4');
call crearUsuario('todd','','beck','todd.beck@example.com','rrrrr',1,'4',1,1,'undefined','','','0768-374-878','0768-374-878','wakefield','wakefield','5');
call crearUsuario('kayla','','hall','kayla.hall@example.com','lickit',2,'5',2,2,'undefined','','','(932)-142-5202','(932)-142-5202','whangarei','whangarei','6');
call crearUsuario('jimmie','','simmons','jimmie.simmons@example.com','stang',1,'6',1,1,'undefined','','','0702-239-646','0702-239-646','bangor','bangor','7');
call crearUsuario('benedikt','','hein','benedikt.hein@example.com','katie1',2,'7',1,2,'undefined','','','0170-2625830','0170-2625830','börde','börde','8');
call crearUsuario('aloïs','','moulin','aloïs.moulin@example.com','silver',1,'8',1,1,'undefined','','','(334)-138-2260','(334)-138-2260','berolle','berolle','9');
call crearUsuario('noah','','smith','noah.smith@example.com','kane',2,'9',1,2,'undefined','','','314-264-1915','314-264-1915','inverness','inverness','10');
call crearUsuario('noah','','dupont','noah.dupont@example.com','adidas',1,'10',1,1,'undefined','','','(280)-900-0140','(280)-900-0140','vucherens','vucherens','11');
call crearUsuario('necati','','nalbantoğlu','necati.nalbantoğlu@example.com','deborah',2,'11',1,2,'undefined','','','(566)-322-5199','(566)-322-5199','şırnak','şırnak','12');
call crearUsuario('nerea','','mendez','nerea.mendez@example.com','4567',1,'12',2,1,'undefined','','','600-927-322','600-927-322','guadalajara','guadalajara','13');
call crearUsuario('arnold','','gardner','arnold.gardner@example.com','black',2,'13',1,2,'undefined','','','0413-155-625','0413-155-625','australian capital territory','australian capital territory','14');
call crearUsuario('julia','','cano','julia.cano@example.com','cumshot',1,'14',2,1,'undefined','','','614-327-163','614-327-163','gijón','gijón','15');
call crearUsuario('annika','','schulte','annika.schulte@example.com','bullseye',2,'15',2,2,'undefined','','','0175-0109961','0175-0109961','berchtesgadener land','berchtesgadener land','16');
call crearUsuario('justin','','harcourt','justin.harcourt@example.com','summit',1,'16',1,1,'undefined','','','645-852-4078','645-852-4078','kingston','kingston','17');
call crearUsuario('باران','','پارسا','باران.پارسا@example.com','pumper',2,'17',2,2,'undefined','','','0994-542-1811','0994-542-1811','نجف‌آباد','نجف‌آباد','18');
call crearUsuario('noah','','bonnet','noah.bonnet@example.com','gateway',1,'18',1,1,'undefined','','','(653)-097-7179','(653)-097-7179','epesses','epesses','19');
call crearUsuario('eemil','','neva','eemil.neva@example.com','mustang',2,'19',1,2,'undefined','','','041-819-96-18','041-819-96-18','juupajoki','juupajoki','20');
call crearUsuario('léonard','','arnaud','léonard.arnaud@example.com','bonjour',1,'20',1,1,'undefined','','','06-29-05-29-92','06-29-05-29-92','reims','reims','21');
call crearUsuario('leevi','','wiitala','leevi.wiitala@example.com','europe',2,'21',1,2,'undefined','','','042-873-60-73','042-873-60-73','merijärvi','merijärvi','22');
call crearUsuario('alma','','thomsen','alma.thomsen@example.com','moomoo',1,'22',2,1,'undefined','','','85041366','85041366','juelsminde','juelsminde','23');
call crearUsuario('mia','','li','mia.li@example.com','christa',2,'23',2,2,'undefined','','','168-828-2650','168-828-2650','deer lake','deer lake','24');
call crearUsuario('james','','warren','james.warren@example.com','coconut',1,'24',1,1,'undefined','','','0789-598-522','0789-598-522','dundee','dundee','25');
call crearUsuario('signe','','olsen','signe.olsen@example.com','feeling',2,'25',2,2,'undefined','','','19695354','19695354','sundby','sundby','26');
call crearUsuario('adam','','porter','adam.porter@example.com','wanda',1,'26',1,1,'undefined','','','0419-934-681','0419-934-681','australian capital territory','australian capital territory','27');
call crearUsuario('marcus','','andersen','marcus.andersen@example.com','1003',2,'27',1,2,'undefined','','','88776448','88776448','vesterborg','vesterborg','28');
call crearUsuario('melissa','','fritz','melissa.fritz@example.com','superstar',1,'28',2,1,'undefined','','','0171-5413142','0171-5413142','schierbrok','schierbrok','29');
call crearUsuario('kasper','','klessens','kasper.klessens@example.com','komodo',2,'29',1,2,'undefined','','','(958)-321-7397','(958)-321-7397','hendrik-ido-ambacht','hendrik-ido-ambacht','30');
call crearUsuario('isaltino','','rocha','isaltino.rocha@example.com','sandy1',1,'30',1,1,'undefined','','','(36) 0570-2025','(36) 0570-2025','marília','marília','31');
call crearUsuario('abigail','','hamilton','abigail.hamilton@example.com','google',2,'31',2,2,'undefined','','','081-273-7886','081-273-7886','swords','swords','32');
call crearUsuario('mason','','abraham','mason.abraham@example.com','belle',1,'32',1,1,'undefined','','','807-178-9585','807-178-9585','westport','westport','33');
call crearUsuario('esat','','hamzaoğlu','esat.hamzaoğlu@example.com','sable',2,'33',1,2,'undefined','','','(215)-408-5458','(215)-408-5458','manisa','manisa','34');
call crearUsuario('rinesh','','tielen','rinesh.tielen@example.com','weather',1,'34',1,1,'undefined','','','(017)-009-0789','(017)-009-0789','kerkrade','kerkrade','35');
call crearUsuario('delphine','','taylor','delphine.taylor@example.com','2233',2,'35',2,2,'undefined','','','602-884-3078','602-884-3078','chesterville','chesterville','36');
call crearUsuario('jake','','brown','jake.brown@example.com','ramones',1,'36',1,1,'undefined','','','(427)-211-8595','(427)-211-8595','nelson','nelson','37');
call crearUsuario('guillermo','','saez','guillermo.saez@example.com','santiago',2,'37',1,2,'undefined','','','686-658-217','686-658-217','mérida','mérida','38');
call crearUsuario('judith','','schmitz','judith.schmitz@example.com','prissy',1,'38',2,1,'undefined','','','0171-7824648','0171-7824648','mittweida','mittweida','39');
call crearUsuario('tammy','','bowman','tammy.bowman@example.com','plato',2,'39',2,2,'undefined','','','081-064-2923','081-064-2923','carrigaline','carrigaline','40');
call crearUsuario('arnold','','allen','arnold.allen@example.com','frank',1,'40',1,1,'undefined','','','081-841-6903','081-841-6903','lusk','lusk','41');
call crearUsuario('پرنیا','','جعفری','پرنیا.جعفری@example.com','jerome',2,'41',2,2,'undefined','','','0901-034-5061','0901-034-5061','قزوین','قزوین','42');
call crearUsuario('gilbert','','willis','gilbert.willis@example.com','tinkerbe',1,'42',1,1,'undefined','','','(016)-019-8853','(016)-019-8853','savannah','savannah','43');
call crearUsuario('selma','','andersen','selma.andersen@example.com','lkjhgfds',2,'43',2,2,'undefined','','','25728984','25728984','nimtofte','nimtofte','44');
call crearUsuario('lara','','metzger','lara.metzger@example.com','gateway',1,'44',2,1,'undefined','','','0178-3288824','0178-3288824','hannover','hannover','45');
call crearUsuario('andrea','','hernandez','andrea.hernandez@example.com','lowrider',2,'45',2,2,'undefined','','','649-994-475','649-994-475','zaragoza','zaragoza','46');
call crearUsuario('johanne','','christiansen','johanne.christiansen@example.com','menace',1,'46',2,1,'undefined','','','51301720','51301720','ugerløse','ugerløse','47');
call crearUsuario('alfred','','nielsen','alfred.nielsen@example.com','stinker',2,'47',1,2,'undefined','','','13271213','13271213','saltum','saltum','48');
call crearUsuario('dawn','','neal','dawn.neal@example.com','chevy1',1,'48',2,1,'undefined','','','(562)-488-7757','(562)-488-7757','berkeley','berkeley','49');
call crearUsuario('charlie','','palmer','charlie.palmer@example.com','deedee',2,'49',1,2,'undefined','','','081-156-7483','081-156-7483','portmarnock','portmarnock','50');
call crearUsuario('romain','','noel','romain.noel@example.com','jackoff',1,'50',1,1,'undefined','','','(479)-467-1253','(479)-467-1253','servion','servion','51');
call crearUsuario('lino','','lucas','lino.lucas@example.com','thethe',2,'51',1,2,'undefined','','','06-50-42-33-52','06-50-42-33-52','nantes','nantes','52');
call crearUsuario('clinton','','bennett','clinton.bennett@example.com','cigars',1,'52',1,1,'undefined','','','0412-466-504','0412-466-504','launceston','launceston','53');
call crearUsuario('sandra','','lucas','sandra.lucas@example.com','toonarmy',2,'53',2,2,'undefined','','','(937)-800-4403','(937)-800-4403','cugy vd','cugy vd','54');
call crearUsuario('valtteri','','mikkola','valtteri.mikkola@example.com','stocking',1,'54',1,1,'undefined','','','043-242-17-73','043-242-17-73','asikkala','asikkala','55');
call crearUsuario('özkan','','tekelioğlu','özkan.tekelioğlu@example.com','coventry',2,'55',1,2,'undefined','','','(074)-376-7384','(074)-376-7384','afyonkarahisar','afyonkarahisar','56');
call crearUsuario('soren','','guillaume','soren.guillaume@example.com','candle',1,'56',1,1,'undefined','','','06-57-69-13-70','06-57-69-13-70','nice','nice','57');
call crearUsuario('çetin','','oraloğlu','çetin.oraloğlu@example.com','softail',2,'57',1,2,'undefined','','','(946)-987-9632','(946)-987-9632','bartın','bartın','58');
call crearUsuario('serena','','moraes','serena.moraes@example.com','cheech',1,'58',2,1,'undefined','','','(13) 4903-3154','(13) 4903-3154','volta redonda','volta redonda','59');
call crearUsuario('enora','','aubert','enora.aubert@example.com','porsche9',2,'59',2,2,'undefined','','','(964)-085-6735','(964)-085-6735','syens','syens','60');
call crearUsuario('siiri','','ojala','siiri.ojala@example.com','tongue',1,'60',2,1,'undefined','','','045-354-12-27','045-354-12-27','pihtipudas','pihtipudas','61');
call crearUsuario('benjamin','','patel','benjamin.patel@example.com','cartman',2,'61',1,2,'undefined','','','(788)-424-7144','(788)-424-7144','masterton','masterton','62');
call crearUsuario('pearl','','wilson','pearl.wilson@example.com','4545',1,'62',2,1,'undefined','','','(467)-185-1554','(467)-185-1554','moreno valley','moreno valley','63');
call crearUsuario('sara','','johansen','sara.johansen@example.com','123456789',2,'63',2,2,'undefined','','','52918686','52918686','noerre alslev','noerre alslev','64');
call crearUsuario('roberto','','delgado','roberto.delgado@example.com','royal',1,'64',1,1,'undefined','','','661-893-159','661-893-159','mérida','mérida','65');
call crearUsuario('harold','','simpson','harold.simpson@example.com','some',2,'65',1,2,'undefined','','','0707-006-496','0707-006-496','wells','wells','66');
call crearUsuario('gregory','','fleming','gregory.fleming@example.com','1995',1,'66',1,1,'undefined','','','(544)-797-0164','(544)-797-0164','orange','orange','67');
call crearUsuario('laurie','','bouchard','laurie.bouchard@example.com','twelve',2,'67',2,2,'undefined','','','697-407-8294','697-407-8294','elgin','elgin','68');
call crearUsuario('dora','','barnes','dora.barnes@example.com','sally',1,'68',2,1,'undefined','','','0410-268-463','0410-268-463','devonport','devonport','69');
call crearUsuario('phillip','','torres','phillip.torres@example.com','jupiter',2,'69',1,2,'undefined','','','(323)-188-2019','(323)-188-2019','toledo','toledo','70');
call crearUsuario('rosemary','','robinson','rosemary.robinson@example.com','advance',1,'70',2,1,'undefined','','','(565)-785-2730','(565)-785-2730','eugene','eugene','71');
call crearUsuario('anton','','christensen','anton.christensen@example.com','jonathon',2,'71',1,2,'undefined','','','80126212','80126212','fredeikssund','fredeikssund','72');
call crearUsuario('emily','','wright','emily.wright@example.com','lllll',1,'72',2,1,'undefined','','','(425)-585-7582','(425)-585-7582','palmerston north','palmerston north','73');
call crearUsuario('alisa','','niva','alisa.niva@example.com','cosmos',2,'73',2,2,'undefined','','','048-525-99-88','048-525-99-88','hämeenkyrö','hämeenkyrö','74');
call crearUsuario('naja','','larsen','naja.larsen@example.com','dirtbike',1,'74',2,1,'undefined','','','47342413','47342413','stokkemarke','stokkemarke','75');
call crearUsuario('alysha','','van de westelaken','alysha.vande westelaken@example.com','redbaron',2,'75',2,2,'undefined','','','(841)-927-0719','(841)-927-0719','zoetermeer','zoetermeer','76');
call crearUsuario('ahmet','','akyüz','ahmet.akyüz@example.com','24682468',1,'76',1,1,'undefined','','','(078)-562-3269','(078)-562-3269','malatya','malatya','77');
call crearUsuario('alexis','','faure','alexis.faure@example.com','mephisto',2,'77',1,2,'undefined','','','06-45-22-40-00','06-45-22-40-00','nancy','nancy','78');
call crearUsuario('nanna','','pedersen','nanna.pedersen@example.com','davids',1,'78',2,1,'undefined','','','43672992','43672992','aarhus','aarhus','79');
call crearUsuario('charlotte','','lee','charlotte.lee@example.com','bedford',2,'79',2,2,'undefined','','','(290)-731-9178','(290)-731-9178','gisborne','gisborne','80');
call crearUsuario('alexandra','','henry','alexandra.henry@example.com','mullet',1,'80',2,1,'undefined','','','081-381-7401','081-381-7401','nenagh','nenagh','81');
call crearUsuario('jeremiah','','graham','jeremiah.graham@example.com','gilbert',2,'81',1,2,'undefined','','','(666)-480-0019','(666)-480-0019','san antonio','san antonio','1');
call crearUsuario('oscar','','christiansen','oscar.christiansen@example.com','gggggggg',1,'82',1,1,'undefined','','','38396305','38396305','﻿aaborg øst','﻿aaborg øst','2');
call crearUsuario('nella','','kangas','nella.kangas@example.com','bird',2,'83',2,2,'undefined','','','044-023-32-46','044-023-32-46','kiuruvesi','kiuruvesi','3');
call crearUsuario('melinda','','hughes','melinda.hughes@example.com','chai',1,'84',2,1,'undefined','','','0458-640-664','0458-640-664','warrnambool','warrnambool','4');
call crearUsuario('väinö','','huotari','väinö.huotari@example.com','5424',2,'85',1,2,'undefined','','','042-857-08-93','042-857-08-93','lapinlahti','lapinlahti','5');
call crearUsuario('eduardo','','van de woestijne','eduardo.vande woestijne@example.com','cyclones',1,'86',1,1,'undefined','','','(509)-465-1330','(509)-465-1330','baarle-nassau','baarle-nassau','6');
call crearUsuario('mustafa','','hamzaoğlu','mustafa.hamzaoğlu@example.com','clancy',2,'87',1,2,'undefined','','','(645)-838-2501','(645)-838-2501','muş','muş','7');
call crearUsuario('enzo','','sanchez','enzo.sanchez@example.com','damage',1,'88',1,1,'undefined','','','06-97-94-63-87','06-97-94-63-87','nîmes','nîmes','8');
call crearUsuario('leo','','honkala','leo.honkala@example.com','sam123',2,'89',1,2,'undefined','','','045-040-65-62','045-040-65-62','närpes','närpes','9');
call crearUsuario('dylan','','soto','dylan.soto@example.com','jamesbon',1,'90',1,1,'undefined','','','0460-413-927','0460-413-927','maitland','maitland','10');
call crearUsuario('joan','','vega','joan.vega@example.com','asia',2,'91',1,2,'undefined','','','603-901-577','603-901-577','torrejón de ardoz','torrejón de ardoz','11');
call crearUsuario('wyatt','','rhodes','wyatt.rhodes@example.com','lisalisa',1,'92',1,1,'undefined','','','0764-930-829','0764-930-829','birmingham','birmingham','12');
call crearUsuario('angela','','newman','angela.newman@example.com','1234567',2,'93',2,2,'undefined','','','081-718-3989','081-718-3989','celbridge','celbridge','13');
call crearUsuario('alani','','gonçalves','alani.gonçalves@example.com','green',1,'94',2,1,'undefined','','','(71) 6433-4022','(71) 6433-4022','juazeiro','juazeiro','14');
call crearUsuario('rachel','','lambert','rachel.lambert@example.com','jerome',2,'95',2,2,'undefined','','','(850)-005-6759','(850)-005-6759','bussy-chardonney','bussy-chardonney','15');
call crearUsuario('florence','','newman','florence.newman@example.com','danzig',1,'96',2,1,'undefined','','','081-451-6846','081-451-6846','tuam','tuam','16');
call crearUsuario('sharon','','jimenez','sharon.jimenez@example.com','jason',2,'97',2,2,'undefined','','','0714-691-465','0714-691-465','peterborough','peterborough','17');
call crearUsuario('becky','','holmes','becky.holmes@example.com','fastball',1,'98',2,1,'undefined','','','081-326-3849','081-326-3849','newbridge','newbridge','18');
call crearUsuario('leo','','pierce','leo.pierce@example.com','pass123',2,'99',1,2,'undefined','','','0737-232-385','0737-232-385','southampton','southampton','19');
call crearUsuario('اميرمحمد','','جعفری','اميرمحمد.جعفری@example.com','qwert1',1,'100',1,1,'undefined','','','0999-396-3738','0999-396-3738','گلستان','گلستان','20');
call crearUsuario('julie','','cole','julie.cole@example.com','100000',2,'101',2,2,'undefined','','','0790-578-725','0790-578-725','stoke-on-trent','stoke-on-trent','21');
call crearUsuario('sammy','','gregory','sammy.gregory@example.com','carter',1,'102',1,1,'undefined','','','081-513-7721','081-513-7721','castlebar','castlebar','22');
call crearUsuario('lucas','','harris','lucas.harris@example.com','decker',2,'103',1,2,'undefined','','','405-581-1720','405-581-1720','winfield','winfield','23');
call crearUsuario('leo','','abraham','leo.abraham@example.com','fruity',1,'104',1,1,'undefined','','','122-307-5945','122-307-5945','chatham','chatham','24');
call crearUsuario('stephanie','','lawson','stephanie.lawson@example.com','mohawk',2,'105',2,2,'undefined','','','081-904-6460','081-904-6460','tullow','tullow','25');
call crearUsuario('jeffrey','','myers','jeffrey.myers@example.com','karate',1,'106',1,1,'undefined','','','(449)-485-5688','(449)-485-5688','tulsa','tulsa','26');
call crearUsuario('morgan','','riviere','morgan.riviere@example.com','mayday',2,'107',1,2,'undefined','','','06-11-81-82-31','06-11-81-82-31','amiens','amiens','27');
call crearUsuario('آنیتا','','كامياران','آنیتا.كامياران@example.com','puppet',1,'108',2,1,'undefined','','','0995-752-6408','0995-752-6408','قم','قم','28');
call crearUsuario('rita','','rezende','rita.rezende@example.com','longdong',2,'109',2,2,'undefined','','','(42) 6069-0555','(42) 6069-0555','imperatriz','imperatriz','29');
call crearUsuario('volkan','','tazegül','volkan.tazegül@example.com','sunfire',1,'110',1,1,'undefined','','','(320)-301-1432','(320)-301-1432','şanlıurfa','şanlıurfa','30');
call crearUsuario('ane','','van kessel','ane.vankessel@example.com','pirate',2,'111',1,2,'undefined','','','(575)-275-2642','(575)-275-2642','uden','uden','31');
call crearUsuario('nívia','','cardoso','nívia.cardoso@example.com','gregor',1,'112',2,1,'undefined','','','(14) 9768-6550','(14) 9768-6550','gravataí','gravataí','32');
call crearUsuario('aurélien','','leroy','aurélien.leroy@example.com','darkman',2,'113',1,2,'undefined','','','06-17-90-10-30','06-17-90-10-30','asnières-sur-seine','asnières-sur-seine','33');
call crearUsuario('arlo','','jackson','arlo.jackson@example.com','unreal',1,'114',1,1,'undefined','','','(272)-347-0860','(272)-347-0860','timaru','timaru','34');
call crearUsuario('emine','','barentsen','emine.barentsen@example.com','anne',2,'115',2,2,'undefined','','','(131)-731-5524','(131)-731-5524','boxmeer','boxmeer','35');
call crearUsuario('naomi','','white','naomi.white@example.com','zurich',1,'116',2,1,'undefined','','','0411-714-063','0411-714-063','kalgoorlie','kalgoorlie','36');
call crearUsuario('cindy','','perez','cindy.perez@example.com','llllll',2,'117',2,2,'undefined','','','(039)-560-6844','(039)-560-6844','victorville','victorville','37');
call crearUsuario('debbie','','may','debbie.may@example.com','payton',1,'118',2,1,'undefined','','','081-579-9760','081-579-9760','edenderry','edenderry','38');
call crearUsuario('carsta','','rocha','carsta.rocha@example.com','soccer12',2,'119',1,2,'undefined','','','(60) 1416-4953','(60) 1416-4953','arapongas','arapongas','39');
call crearUsuario('consuelo','','arias','consuelo.arias@example.com','marianne',1,'120',2,1,'undefined','','','681-462-456','681-462-456','torrejón de ardoz','torrejón de ardoz','40');
call crearUsuario('stella','','guillot','stella.guillot@example.com','1066',2,'121',2,2,'undefined','','','(385)-232-9840','(385)-232-9840','bottens','bottens','41');
call crearUsuario('marcus','','walker','marcus.walker@example.com','girfriend',1,'122',1,1,'undefined','','','(690)-027-1079','(690)-027-1079','auckland','auckland','42');
call crearUsuario('عسل','','مرادی','عسل.مرادی@example.com','zaq12wsx',2,'123',2,2,'undefined','','','0925-326-2063','0925-326-2063','پاکدشت','پاکدشت','43');
call crearUsuario('باران','','یاسمی','باران.یاسمی@example.com','satan666',1,'124',2,1,'undefined','','','0908-264-0594','0908-264-0594','پاکدشت','پاکدشت','44');
call crearUsuario('noah','','poulsen','noah.poulsen@example.com','zelda',2,'125',1,2,'undefined','','','53705244','53705244','nr åby','nr åby','45');
call crearUsuario('priteche','','fogaça','priteche.fogaça@example.com','jabber',1,'126',1,1,'undefined','','','(57) 6145-5813','(57) 6145-5813','jaboatão dos guararapes','jaboatão dos guararapes','46');
call crearUsuario('edgar','','friedrich','edgar.friedrich@example.com','maddie',2,'127',1,2,'undefined','','','0174-6711492','0174-6711492','trier','trier','47');
call crearUsuario('benjamin','','beck','benjamin.beck@example.com','bergkamp',1,'128',1,1,'undefined','','','0459-316-814','0459-316-814','sunshine coast','sunshine coast','48');
call crearUsuario('sofie','','sørensen','sofie.sørensen@example.com','trick',2,'129',2,2,'undefined','','','75873392','75873392','frederiksberg','frederiksberg','49');
call crearUsuario('alizee','','leroux','alizee.leroux@example.com','turtle',1,'130',2,1,'undefined','','','06-89-25-69-04','06-89-25-69-04','reims','reims','50');
call crearUsuario('sheryl','','carr','sheryl.carr@example.com','ziggy',2,'131',2,2,'undefined','','','0731-134-689','0731-134-689','aberdeen','aberdeen','51');
call crearUsuario('emeline','','charles','emeline.charles@example.com','karen',1,'132',2,1,'undefined','','','(311)-279-7621','(311)-279-7621','romanel-sur-lausanne','romanel-sur-lausanne','52');
call crearUsuario('ariana','','thompson','ariana.thompson@example.com','hungry',2,'133',2,2,'undefined','','','(403)-255-8521','(403)-255-8521','christchurch','christchurch','53');
call crearUsuario('jeremy','','weiss','jeremy.weiss@example.com','mone',1,'134',1,1,'undefined','','','0172-9704083','0172-9704083','lüchow-dannenberg','lüchow-dannenberg','54');
call crearUsuario('marcos','','soto','marcos.soto@example.com','roll',2,'135',1,2,'undefined','','','685-327-108','685-327-108','alcobendas','alcobendas','55');
call crearUsuario('sofia','','sales','sofia.sales@example.com','kaiser',1,'136',2,1,'undefined','','','(69) 6275-4624','(69) 6275-4624','catanduva','catanduva','56');
call crearUsuario('anna','','miller','anna.miller@example.com','siobhan',2,'137',2,2,'undefined','','','0757-774-062','0757-774-062','ely','ely','57');
call crearUsuario('donald','','riley','donald.riley@example.com','clevelan',1,'138',1,1,'undefined','','','(804)-650-8144','(804)-650-8144','dumas','dumas','58');
call crearUsuario('melany','','wijngaard','melany.wijngaard@example.com','eagle',2,'139',2,2,'undefined','','','(727)-033-9347','(727)-033-9347','staphorst','staphorst','59');
call crearUsuario('mathias','','nielsen','mathias.nielsen@example.com','336699',1,'140',1,1,'undefined','','','10676217','10676217','århus c.','århus c.','60');
call crearUsuario('claire','','garcia','claire.garcia@example.com','showing',2,'141',2,2,'undefined','','','(358)-286-2903','(358)-286-2903','bournens','bournens','61');
call crearUsuario('ashley','','tucker','ashley.tucker@example.com','feet',1,'142',2,1,'undefined','','','081-346-8038','081-346-8038','listowel','listowel','62');
call crearUsuario('alyssa','','andre','alyssa.andre@example.com','clover',2,'143',2,2,'undefined','','','06-61-26-48-78','06-61-26-48-78','mulhouse','mulhouse','63');
call crearUsuario('summer','','wood','summer.wood@example.com','malice',1,'144',2,1,'undefined','','','(631)-847-8482','(631)-847-8482','palmerston north','palmerston north','64');
call crearUsuario('natércio','','castro','natércio.castro@example.com','blanca',2,'145',1,2,'undefined','','','(24) 9586-4164','(24) 9586-4164','olinda','olinda','65');
call crearUsuario('terrence','','king','terrence.king@example.com','cwoui',1,'146',1,1,'undefined','','','0446-337-253','0446-337-253','australian capital territory','australian capital territory','66');
call crearUsuario('william','','david','william.david@example.com','pinkfloyd',2,'147',1,2,'undefined','','','(494)-541-3062','(494)-541-3062','aclens','aclens','67');
call crearUsuario('irene','','morales','irene.morales@example.com','field',1,'148',2,1,'undefined','','','625-790-958','625-790-958','lorca','lorca','68');
call crearUsuario('آرمیتا','','سلطانی نژاد','آرمیتا.سلطانینژاد@example.com','nudes',2,'149',2,2,'undefined','','','0904-946-2757','0904-946-2757','زنجان','زنجان','69');
call crearUsuario('stefan','','siebert','stefan.siebert@example.com','sommer',1,'150',1,1,'undefined','','','0175-8081099','0175-8081099','kleve','kleve','70');
call crearUsuario('amy','','miller','amy.miller@example.com','soft',2,'151',2,2,'undefined','','','567-629-4636','567-629-4636','st. antoine','st. antoine','71');
call crearUsuario('noélie','','roux','noélie.roux@example.com','282828',1,'152',2,1,'undefined','','','06-68-19-42-68','06-68-19-42-68','paris','paris','72');
call crearUsuario('enrique','','brewer','enrique.brewer@example.com','deaths',2,'153',1,2,'undefined','','','081-445-2504','081-445-2504','newcastle west','newcastle west','73');
call crearUsuario('abssilão','','rodrigues','abssilão.rodrigues@example.com','emerson',1,'154',1,1,'undefined','','','(12) 1563-0822','(12) 1563-0822','pinhais','pinhais','74');
call crearUsuario('liam','','walters','liam.walters@example.com','training',2,'155',1,2,'undefined','','','0438-376-652','0438-376-652','devonport','devonport','75');
call crearUsuario('nicole','','curtis','nicole.curtis@example.com','tunafish',1,'156',2,1,'undefined','','','081-784-8292','081-784-8292','carrick-on-suir','carrick-on-suir','76');
call crearUsuario('deolindo','','vieira','deolindo.vieira@example.com','darklord',2,'157',1,2,'undefined','','','(93) 2134-8962','(93) 2134-8962','varginha','varginha','77');
call crearUsuario('miguel','','sanz','miguel.sanz@example.com','gilligan',1,'158',1,1,'undefined','','','636-912-353','636-912-353','valladolid','valladolid','78');
call crearUsuario('karen','','stanley','karen.stanley@example.com','virus',2,'159',2,2,'undefined','','','081-988-5646','081-988-5646','loughrea','loughrea','79');
call crearUsuario('tammy','','hayes','tammy.hayes@example.com','harley1',1,'160',2,1,'undefined','','','081-647-6483','081-647-6483','athlone','athlone','80');
call crearUsuario('شایان','','حسینی','شایان.حسینی@example.com','instant',2,'161',1,2,'undefined','','','0946-021-2412','0946-021-2412','ساوه','ساوه','81');
call crearUsuario('konrad','','siebert','konrad.siebert@example.com','horny',1,'162',1,1,'undefined','','','0176-8482149','0176-8482149','osterode am harz','osterode am harz','1');
call crearUsuario('ben','','perry','ben.perry@example.com','01234567',2,'163',1,2,'undefined','','','(412)-745-4263','(412)-745-4263','west jordan','west jordan','2');
call crearUsuario('joaquin','','hidalgo','joaquin.hidalgo@example.com','kris',1,'164',1,1,'undefined','','','614-654-138','614-654-138','mérida','mérida','3');
call crearUsuario('pauline','','perez','pauline.perez@example.com','oicu812',2,'165',2,2,'undefined','','','(189)-609-2928','(189)-609-2928','aclens','aclens','4');
call crearUsuario('tom','','wolff','tom.wolff@example.com','budlight',1,'166',1,1,'undefined','','','0175-3665364','0175-3665364','vechta','vechta','5');
call crearUsuario('oona','','latvala','oona.latvala@example.com','121212',2,'167',2,2,'undefined','','','049-372-50-45','049-372-50-45','vimpeli','vimpeli','6');
call crearUsuario('james','','lévesque','james.lévesque@example.com','hamish',1,'168',1,1,'undefined','','','294-215-3722','294-215-3722','shelbourne','shelbourne','7');
call crearUsuario('femia','','pruijssers','femia.pruijssers@example.com','grandpa',2,'169',2,2,'undefined','','','(328)-454-1571','(328)-454-1571','ferwerderadiel','ferwerderadiel','8');
call crearUsuario('laly','','da silva','laly.dasilva@example.com','design',1,'170',2,1,'undefined','','','(082)-419-9335','(082)-419-9335','villars-le-terroir','villars-le-terroir','9');
call crearUsuario('ross','','nichols','ross.nichols@example.com','blaze',2,'171',1,2,'undefined','','','081-438-6677','081-438-6677','kilcock','kilcock','10');
call crearUsuario('sarah','','oliver','sarah.oliver@example.com','boat',1,'172',2,1,'undefined','','','0761-814-654','0761-814-654','manchester','manchester','11');
call crearUsuario('jeanne','','nelson','jeanne.nelson@example.com','313131',2,'173',2,2,'undefined','','','0418-190-097','0418-190-097','geelong','geelong','12');
call crearUsuario('bernard','','wilson','bernard.wilson@example.com','japanes',1,'174',1,1,'undefined','','','0727-970-211','0727-970-211','preston','preston','13');
call crearUsuario('darius','','conrad','darius.conrad@example.com','qwerqwer',2,'175',1,2,'undefined','','','0171-7784156','0171-7784156','osterode am harz','osterode am harz','14');
call crearUsuario('malthe','','andersen','malthe.andersen@example.com','junk',1,'176',1,1,'undefined','','','12918640','12918640','lemvig','lemvig','15');
call crearUsuario('emma','','manni','emma.manni@example.com','tzpvaw',2,'177',2,2,'undefined','','','043-835-10-98','043-835-10-98','geta','geta','16');
call crearUsuario('druso','','nascimento','druso.nascimento@example.com','goldstar',1,'178',1,1,'undefined','','','(05) 2501-9070','(05) 2501-9070','vespasiano','vespasiano','17');
call crearUsuario('greta','','van limpt','greta.vanlimpt@example.com','abcdefgh',2,'179',2,2,'undefined','','','(332)-879-4592','(332)-879-4592','culemborg','culemborg','18');
call crearUsuario('نيما','','جعفری','نيما.جعفری@example.com','insert',1,'180',1,1,'undefined','','','0912-030-9784','0912-030-9784','همدان','همدان','19');
call crearUsuario('ستایش','','یاسمی','ستایش.یاسمی@example.com','kill',2,'181',2,2,'undefined','','','0930-256-0917','0930-256-0917','بجنورد','بجنورد','20');
call crearUsuario('marcus','','rasmussen','marcus.rasmussen@example.com','wayer',1,'182',1,1,'undefined','','','22688318','22688318','gjerlev','gjerlev','21');
call crearUsuario('peter','','bell','peter.bell@example.com','dannyboy',2,'183',1,2,'undefined','','','0745-196-827','0745-196-827','ely','ely','22');
call crearUsuario('hector','','guerrero','hector.guerrero@example.com','godfather',1,'184',1,1,'undefined','','','696-963-949','696-963-949','alcobendas','alcobendas','23');
call crearUsuario('arnaud','','lo','arnaud.lo@example.com','dogfood',2,'185',1,2,'undefined','','','905-307-4254','905-307-4254','maitland','maitland','24');
call crearUsuario('julienne','','lelieveld','julienne.lelieveld@example.com','casey1',1,'186',2,1,'undefined','','','(014)-370-6505','(014)-370-6505','leeuwarden','leeuwarden','25');
call crearUsuario('aurélien','','fontai','aurélien.fontai@example.com','debra',2,'187',1,2,'undefined','','','(364)-916-4680','(364)-916-4680','epesses','epesses','26');
call crearUsuario('valdemar','','nielsen','valdemar.nielsen@example.com','bluedog',1,'188',1,1,'undefined','','','10899723','10899723','allinge','allinge','27');
call crearUsuario('fabio','','dupont','fabio.dupont@example.com','shelly',2,'189',1,2,'undefined','','','(503)-255-0533','(503)-255-0533','denens','denens','28');
call crearUsuario('mathew','','richards','mathew.richards@example.com','milo',1,'190',1,1,'undefined','','','0457-239-253','0457-239-253','sunshine coast','sunshine coast','29');
call crearUsuario('nonato','','pires','nonato.pires@example.com','phish',2,'191',1,2,'undefined','','','(62) 3725-1840','(62) 3725-1840','são paulo','são paulo','30');
call crearUsuario('marjorie','','steward','marjorie.steward@example.com','obsidian',1,'192',2,1,'undefined','','','0446-772-290','0446-772-290','traralgon','traralgon','31');
call crearUsuario('mia','','sanchez','mia.sanchez@example.com','again',2,'193',2,2,'undefined','','','0729-610-908','0729-610-908','preston','preston','32');
call crearUsuario('efe','','aydan','efe.aydan@example.com','qwert',1,'194',1,1,'undefined','','','(360)-024-6328','(360)-024-6328','artvin','artvin','33');
call crearUsuario('giselle','','monteiro','giselle.monteiro@example.com','shou',2,'195',2,2,'undefined','','','(71) 5848-8742','(71) 5848-8742','americana','americana','34');
call crearUsuario('theo','','bader','theo.bader@example.com','blast',1,'196',1,1,'undefined','','','0173-7423089','0173-7423089','münster','münster','35');
call crearUsuario('cassandre','','leroux','cassandre.leroux@example.com','spooge',2,'197',2,2,'undefined','','','06-09-96-38-18','06-09-96-38-18','versailles','versailles','36');
call crearUsuario('edgar','','shelton','edgar.shelton@example.com','mmmm',1,'198',1,1,'undefined','','','0467-658-105','0467-658-105','warrnambool','warrnambool','37');
call crearUsuario('isabel','','jackson','isabel.jackson@example.com','corvette',2,'199',2,2,'undefined','','','(570)-687-7371','(570)-687-7371','gisborne','gisborne','38');
call crearUsuario('helena','','wirth','helena.wirth@example.com','panic',1,'200',2,1,'undefined','','','0173-4867633','0173-4867633','traunstein','traunstein','39');
call crearUsuario('clotildes','','da rosa','clotildes.darosa@example.com','dank',2,'201',2,2,'undefined','','','(65) 9912-7496','(65) 9912-7496','itabira','itabira','40');
call crearUsuario('buse','','dağdaş','buse.dağdaş@example.com','paulie',1,'202',2,1,'undefined','','','(855)-841-4810','(855)-841-4810','malatya','malatya','41');
call crearUsuario('amelia','','mercier','amelia.mercier@example.com','forest',2,'203',2,2,'undefined','','','(168)-747-5950','(168)-747-5950','echandens-denges','echandens-denges','42');
call crearUsuario('maureen','','ramos','maureen.ramos@example.com','blabla',1,'204',2,1,'undefined','','','0486-809-748','0486-809-748','coffs harbour','coffs harbour','43');
call crearUsuario('solène','','lemaire','solène.lemaire@example.com','harold',2,'205',2,2,'undefined','','','06-41-57-50-80','06-41-57-50-80','metz','metz','44');
call crearUsuario('ernest','','williamson','ernest.williamson@example.com','2112',1,'206',1,1,'undefined','','','081-571-7090','081-571-7090','tramore','tramore','45');
call crearUsuario('florian','','hahn','florian.hahn@example.com','iron',2,'207',1,2,'undefined','','','0170-0421455','0170-0421455','ostprignitz-ruppin','ostprignitz-ruppin','46');
call crearUsuario('jalisa','','köhler','jalisa.köhler@example.com','joker1',1,'208',2,1,'undefined','','','(462)-622-9092','(462)-622-9092','leiden','leiden','47');

insert into hc_medicos(id_usuario, identificacion_medica) VALUES(1,'1');
insert into hc_medicos(id_usuario, identificacion_medica) VALUES(5,'5');
insert into hc_medicos(id_usuario, identificacion_medica) VALUES(9,'9');
insert into hc_medicos(id_usuario, identificacion_medica) VALUES(13,'13');
insert into hc_medicos(id_usuario, identificacion_medica) VALUES(17,'17');
insert into hc_medicos(id_usuario, identificacion_medica) VALUES(21,'21');
insert into hc_medicos(id_usuario, identificacion_medica) VALUES(25,'25');
insert into hc_medicos(id_usuario, identificacion_medica) VALUES(29,'29');
insert into hc_medicos(id_usuario, identificacion_medica) VALUES(33,'33');
insert into hc_medicos(id_usuario, identificacion_medica) VALUES(37,'37');
insert into hc_medicos(id_usuario, identificacion_medica) VALUES(41,'41');
insert into hc_medicos(id_usuario, identificacion_medica) VALUES(45,'45');
insert into hc_medicos(id_usuario, identificacion_medica) VALUES(49,'49');
insert into hc_medicos(id_usuario, identificacion_medica) VALUES(53,'53');
insert into hc_medicos(id_usuario, identificacion_medica) VALUES(57,'57');
insert into hc_medicos(id_usuario, identificacion_medica) VALUES(61,'61');
insert into hc_medicos(id_usuario, identificacion_medica) VALUES(65,'65');
insert into hc_medicos(id_usuario, identificacion_medica) VALUES(69,'69');
insert into hc_medicos(id_usuario, identificacion_medica) VALUES(73,'73');
insert into hc_medicos(id_usuario, identificacion_medica) VALUES(77,'77');
insert into hc_medicos(id_usuario, identificacion_medica) VALUES(81,'81');
insert into hc_medicos(id_usuario, identificacion_medica) VALUES(85,'85');
insert into hc_medicos(id_usuario, identificacion_medica) VALUES(89,'89');
insert into hc_medicos(id_usuario, identificacion_medica) VALUES(93,'93');
insert into hc_medicos(id_usuario, identificacion_medica) VALUES(97,'97');
insert into hc_medicos(id_usuario, identificacion_medica) VALUES(101,'101');
insert into hc_medicos(id_usuario, identificacion_medica) VALUES(105,'105');
insert into hc_medicos(id_usuario, identificacion_medica) VALUES(109,'109');
insert into hc_medicos(id_usuario, identificacion_medica) VALUES(113,'113');
insert into hc_medicos(id_usuario, identificacion_medica) VALUES(117,'117');
insert into hc_medicos(id_usuario, identificacion_medica) VALUES(121,'121');
insert into hc_medicos(id_usuario, identificacion_medica) VALUES(125,'125');
insert into hc_medicos(id_usuario, identificacion_medica) VALUES(129,'129');
insert into hc_medicos(id_usuario, identificacion_medica) VALUES(133,'133');
insert into hc_medicos(id_usuario, identificacion_medica) VALUES(137,'137');
insert into hc_medicos(id_usuario, identificacion_medica) VALUES(141,'141');
insert into hc_medicos(id_usuario, identificacion_medica) VALUES(145,'145');
insert into hc_medicos(id_usuario, identificacion_medica) VALUES(149,'149');
insert into hc_medicos(id_usuario, identificacion_medica) VALUES(153,'153');
insert into hc_medicos(id_usuario, identificacion_medica) VALUES(157,'157');
insert into hc_medicos(id_usuario, identificacion_medica) VALUES(161,'161');
insert into hc_medicos(id_usuario, identificacion_medica) VALUES(165,'165');
insert into hc_medicos(id_usuario, identificacion_medica) VALUES(169,'169');
insert into hc_medicos(id_usuario, identificacion_medica) VALUES(173,'173');
insert into hc_medicos(id_usuario, identificacion_medica) VALUES(177,'177');
insert into hc_medicos(id_usuario, identificacion_medica) VALUES(181,'181');
insert into hc_medicos(id_usuario, identificacion_medica) VALUES(185,'185');
insert into hc_medicos(id_usuario, identificacion_medica) VALUES(189,'189');
insert into hc_medicos(id_usuario, identificacion_medica) VALUES(193,'193');
insert into hc_medicos(id_usuario, identificacion_medica) VALUES(197,'197');
insert into hc_medicos(id_usuario, identificacion_medica) VALUES(201,'201');
insert into hc_medicos(id_usuario, identificacion_medica) VALUES(205,'205');
insert into hc_medicos(id_usuario, identificacion_medica) VALUES(209,'209');

CALL crearPaciente(2,'1','fleming','fleming','0740-304-475','0740-304-475',2);
CALL crearPaciente(3,'2','christiansen','christiansen','05761325','05761325',1);
CALL crearPaciente(4,'3','pulkkinen','pulkkinen','041-829-79-61','041-829-79-61',2);
CALL crearPaciente(6,'5','hall','hall','(932)-142-5202','(932)-142-5202',2);
CALL crearPaciente(7,'6','simmons','simmons','0702-239-646','0702-239-646',1);
CALL crearPaciente(8,'7','hein','hein','0170-2625830','0170-2625830',2);
CALL crearPaciente(10,'9','smith','smith','314-264-1915','314-264-1915',2);
CALL crearPaciente(11,'10','dupont','dupont','(280)-900-0140','(280)-900-0140',1);
CALL crearPaciente(12,'11','nalbantoğlu','nalbantoğlu','(566)-322-5199','(566)-322-5199',2);
CALL crearPaciente(14,'13','gardner','gardner','0413-155-625','0413-155-625',2);
CALL crearPaciente(15,'14','cano','cano','614-327-163','614-327-163',1);
CALL crearPaciente(16,'15','schulte','schulte','0175-0109961','0175-0109961',2);
CALL crearPaciente(18,'17','پارسا','پارسا','0994-542-1811','0994-542-1811',2);
CALL crearPaciente(19,'18','bonnet','bonnet','(653)-097-7179','(653)-097-7179',1);
CALL crearPaciente(20,'19','neva','neva','041-819-96-18','041-819-96-18',2);
CALL crearPaciente(22,'21','wiitala','wiitala','042-873-60-73','042-873-60-73',2);
CALL crearPaciente(23,'22','thomsen','thomsen','85041366','85041366',1);
CALL crearPaciente(24,'23','li','li','168-828-2650','168-828-2650',2);
CALL crearPaciente(26,'25','olsen','olsen','19695354','19695354',2);
CALL crearPaciente(27,'26','porter','porter','0419-934-681','0419-934-681',1);
CALL crearPaciente(28,'27','andersen','andersen','88776448','88776448',2);
CALL crearPaciente(30,'29','klessens','klessens','(958)-321-7397','(958)-321-7397',2);
CALL crearPaciente(31,'30','rocha','rocha','(36) 0570-2025','(36) 0570-2025',1);
CALL crearPaciente(32,'31','hamilton','hamilton','081-273-7886','081-273-7886',2);
CALL crearPaciente(34,'33','hamzaoğlu','hamzaoğlu','(215)-408-5458','(215)-408-5458',2);
CALL crearPaciente(35,'34','tielen','tielen','(017)-009-0789','(017)-009-0789',1);
CALL crearPaciente(36,'35','taylor','taylor','602-884-3078','602-884-3078',2);
CALL crearPaciente(38,'37','saez','saez','686-658-217','686-658-217',2);
CALL crearPaciente(39,'38','schmitz','schmitz','0171-7824648','0171-7824648',1);
CALL crearPaciente(40,'39','bowman','bowman','081-064-2923','081-064-2923',2);
CALL crearPaciente(42,'41','جعفری','جعفری','0901-034-5061','0901-034-5061',2);
CALL crearPaciente(43,'42','willis','willis','(016)-019-8853','(016)-019-8853',1);
CALL crearPaciente(44,'43','andersen','andersen','25728984','25728984',2);
CALL crearPaciente(46,'45','hernandez','hernandez','649-994-475','649-994-475',2);
CALL crearPaciente(47,'46','christiansen','christiansen','51301720','51301720',1);
CALL crearPaciente(48,'47','nielsen','nielsen','13271213','13271213',2);
CALL crearPaciente(50,'49','palmer','palmer','081-156-7483','081-156-7483',2);
CALL crearPaciente(51,'50','noel','noel','(479)-467-1253','(479)-467-1253',1);
CALL crearPaciente(52,'51','lucas','lucas','06-50-42-33-52','06-50-42-33-52',2);
CALL crearPaciente(54,'53','lucas','lucas','(937)-800-4403','(937)-800-4403',2);
CALL crearPaciente(55,'54','mikkola','mikkola','043-242-17-73','043-242-17-73',1);
CALL crearPaciente(56,'55','tekelioğlu','tekelioğlu','(074)-376-7384','(074)-376-7384',2);
CALL crearPaciente(58,'57','oraloğlu','oraloğlu','(946)-987-9632','(946)-987-9632',2);
CALL crearPaciente(59,'58','moraes','moraes','(13) 4903-3154','(13) 4903-3154',1);
CALL crearPaciente(60,'59','aubert','aubert','(964)-085-6735','(964)-085-6735',2);
CALL crearPaciente(62,'61','patel','patel','(788)-424-7144','(788)-424-7144',2);
CALL crearPaciente(63,'62','wilson','wilson','(467)-185-1554','(467)-185-1554',1);
CALL crearPaciente(64,'63','johansen','johansen','52918686','52918686',2);
CALL crearPaciente(66,'65','simpson','simpson','0707-006-496','0707-006-496',2);
CALL crearPaciente(67,'66','fleming','fleming','(544)-797-0164','(544)-797-0164',1);
CALL crearPaciente(68,'67','bouchard','bouchard','697-407-8294','697-407-8294',2);
CALL crearPaciente(70,'69','torres','torres','(323)-188-2019','(323)-188-2019',2);
CALL crearPaciente(71,'70','robinson','robinson','(565)-785-2730','(565)-785-2730',1);
CALL crearPaciente(72,'71','christensen','christensen','80126212','80126212',2);
CALL crearPaciente(74,'73','niva','niva','048-525-99-88','048-525-99-88',2);
CALL crearPaciente(75,'74','larsen','larsen','47342413','47342413',1);
CALL crearPaciente(76,'75','van de westelaken','van de westelaken','(841)-927-0719','(841)-927-0719',2);
CALL crearPaciente(78,'77','faure','faure','06-45-22-40-00','06-45-22-40-00',2);
CALL crearPaciente(79,'78','pedersen','pedersen','43672992','43672992',1);
CALL crearPaciente(80,'79','lee','lee','(290)-731-9178','(290)-731-9178',2);
CALL crearPaciente(82,'81','graham','graham','(666)-480-0019','(666)-480-0019',2);
CALL crearPaciente(83,'82','christiansen','christiansen','38396305','38396305',1);
CALL crearPaciente(84,'83','kangas','kangas','044-023-32-46','044-023-32-46',2);
CALL crearPaciente(86,'85','huotari','huotari','042-857-08-93','042-857-08-93',2);
CALL crearPaciente(87,'86','van de woestijne','van de woestijne','(509)-465-1330','(509)-465-1330',1);
CALL crearPaciente(88,'87','hamzaoğlu','hamzaoğlu','(645)-838-2501','(645)-838-2501',2);
CALL crearPaciente(90,'89','honkala','honkala','045-040-65-62','045-040-65-62',2);
CALL crearPaciente(91,'90','soto','soto','0460-413-927','0460-413-927',1);
CALL crearPaciente(92,'91','vega','vega','603-901-577','603-901-577',2);
CALL crearPaciente(94,'93','newman','newman','081-718-3989','081-718-3989',2);
CALL crearPaciente(95,'94','gonçalves','gonçalves','(71) 6433-4022','(71) 6433-4022',1);
CALL crearPaciente(96,'95','lambert','lambert','(850)-005-6759','(850)-005-6759',2);
CALL crearPaciente(98,'97','jimenez','jimenez','0714-691-465','0714-691-465',2);
CALL crearPaciente(99,'98','holmes','holmes','081-326-3849','081-326-3849',1);
CALL crearPaciente(100,'99','pierce','pierce','0737-232-385','0737-232-385',2);
CALL crearPaciente(102,'101','cole','cole','0790-578-725','0790-578-725',2);
CALL crearPaciente(103,'102','gregory','gregory','081-513-7721','081-513-7721',1);
CALL crearPaciente(104,'103','harris','harris','405-581-1720','405-581-1720',2);
CALL crearPaciente(106,'105','lawson','lawson','081-904-6460','081-904-6460',2);
CALL crearPaciente(107,'106','myers','myers','(449)-485-5688','(449)-485-5688',1);
CALL crearPaciente(108,'107','riviere','riviere','06-11-81-82-31','06-11-81-82-31',2);
CALL crearPaciente(110,'109','rezende','rezende','(42) 6069-0555','(42) 6069-0555',2);
CALL crearPaciente(111,'110','tazegül','tazegül','(320)-301-1432','(320)-301-1432',1);
CALL crearPaciente(112,'111','van kessel','van kessel','(575)-275-2642','(575)-275-2642',2);
CALL crearPaciente(114,'113','leroy','leroy','06-17-90-10-30','06-17-90-10-30',2);
CALL crearPaciente(115,'114','jackson','jackson','(272)-347-0860','(272)-347-0860',1);
CALL crearPaciente(116,'115','barentsen','barentsen','(131)-731-5524','(131)-731-5524',2);
CALL crearPaciente(118,'117','perez','perez','(039)-560-6844','(039)-560-6844',2);
CALL crearPaciente(119,'118','may','may','081-579-9760','081-579-9760',1);
CALL crearPaciente(120,'119','rocha','rocha','(60) 1416-4953','(60) 1416-4953',2);
CALL crearPaciente(122,'121','guillot','guillot','(385)-232-9840','(385)-232-9840',2);
CALL crearPaciente(123,'122','walker','walker','(690)-027-1079','(690)-027-1079',1);
CALL crearPaciente(124,'123','مرادی','مرادی','0925-326-2063','0925-326-2063',2);
CALL crearPaciente(126,'125','poulsen','poulsen','53705244','53705244',2);
CALL crearPaciente(127,'126','fogaça','fogaça','(57) 6145-5813','(57) 6145-5813',1);
CALL crearPaciente(128,'127','friedrich','friedrich','0174-6711492','0174-6711492',2);
CALL crearPaciente(130,'129','sørensen','sørensen','75873392','75873392',2);
CALL crearPaciente(131,'130','leroux','leroux','06-89-25-69-04','06-89-25-69-04',1);
CALL crearPaciente(132,'131','carr','carr','0731-134-689','0731-134-689',2);
CALL crearPaciente(134,'133','thompson','thompson','(403)-255-8521','(403)-255-8521',2);
CALL crearPaciente(135,'134','weiss','weiss','0172-9704083','0172-9704083',1);
CALL crearPaciente(136,'135','soto','soto','685-327-108','685-327-108',2);
CALL crearPaciente(138,'137','miller','miller','0757-774-062','0757-774-062',2);
CALL crearPaciente(139,'138','riley','riley','(804)-650-8144','(804)-650-8144',1);
CALL crearPaciente(140,'139','wijngaard','wijngaard','(727)-033-9347','(727)-033-9347',2);
CALL crearPaciente(142,'141','garcia','garcia','(358)-286-2903','(358)-286-2903',2);
CALL crearPaciente(143,'142','tucker','tucker','081-346-8038','081-346-8038',1);
CALL crearPaciente(144,'143','andre','andre','06-61-26-48-78','06-61-26-48-78',2);
CALL crearPaciente(146,'145','castro','castro','(24) 9586-4164','(24) 9586-4164',2);
CALL crearPaciente(147,'146','king','king','0446-337-253','0446-337-253',1);
CALL crearPaciente(148,'147','david','david','(494)-541-3062','(494)-541-3062',2);
CALL crearPaciente(150,'149','سلطانی نژاد','سلطانی نژاد','0904-946-2757','0904-946-2757',2);
CALL crearPaciente(151,'150','siebert','siebert','0175-8081099','0175-8081099',1);
CALL crearPaciente(152,'151','miller','miller','567-629-4636','567-629-4636',2);
CALL crearPaciente(154,'153','brewer','brewer','081-445-2504','081-445-2504',2);
CALL crearPaciente(155,'154','rodrigues','rodrigues','(12) 1563-0822','(12) 1563-0822',1);
CALL crearPaciente(156,'155','walters','walters','0438-376-652','0438-376-652',2);
CALL crearPaciente(158,'157','vieira','vieira','(93) 2134-8962','(93) 2134-8962',2);
CALL crearPaciente(159,'158','sanz','sanz','636-912-353','636-912-353',1);
CALL crearPaciente(160,'159','stanley','stanley','081-988-5646','081-988-5646',2);
CALL crearPaciente(162,'161','حسینی','حسینی','0946-021-2412','0946-021-2412',2);
CALL crearPaciente(163,'162','siebert','siebert','0176-8482149','0176-8482149',1);
CALL crearPaciente(164,'163','perry','perry','(412)-745-4263','(412)-745-4263',2);
CALL crearPaciente(166,'165','perez','perez','(189)-609-2928','(189)-609-2928',2);
CALL crearPaciente(167,'166','wolff','wolff','0175-3665364','0175-3665364',1);
CALL crearPaciente(168,'167','latvala','latvala','049-372-50-45','049-372-50-45',2);
CALL crearPaciente(170,'169','pruijssers','pruijssers','(328)-454-1571','(328)-454-1571',2);
CALL crearPaciente(171,'170','da silva','da silva','(082)-419-9335','(082)-419-9335',1);
CALL crearPaciente(172,'171','nichols','nichols','081-438-6677','081-438-6677',2);
CALL crearPaciente(174,'173','nelson','nelson','0418-190-097','0418-190-097',2);
CALL crearPaciente(175,'174','wilson','wilson','0727-970-211','0727-970-211',1);
CALL crearPaciente(176,'175','conrad','conrad','0171-7784156','0171-7784156',2);
CALL crearPaciente(178,'177','manni','manni','043-835-10-98','043-835-10-98',2);
CALL crearPaciente(179,'178','nascimento','nascimento','(05) 2501-9070','(05) 2501-9070',1);
CALL crearPaciente(180,'179','van limpt','van limpt','(332)-879-4592','(332)-879-4592',2);
CALL crearPaciente(182,'181','یاسمی','یاسمی','0930-256-0917','0930-256-0917',2);
CALL crearPaciente(183,'182','rasmussen','rasmussen','22688318','22688318',1);
CALL crearPaciente(184,'183','bell','bell','0745-196-827','0745-196-827',2);
CALL crearPaciente(186,'185','lo','lo','905-307-4254','905-307-4254',2);
CALL crearPaciente(187,'186','lelieveld','lelieveld','(014)-370-6505','(014)-370-6505',1);
CALL crearPaciente(188,'187','fontai','fontai','(364)-916-4680','(364)-916-4680',2);
CALL crearPaciente(190,'189','dupont','dupont','(503)-255-0533','(503)-255-0533',2);
CALL crearPaciente(191,'190','richards','richards','0457-239-253','0457-239-253',1);
CALL crearPaciente(192,'191','pires','pires','(62) 3725-1840','(62) 3725-1840',2);
CALL crearPaciente(194,'193','sanchez','sanchez','0729-610-908','0729-610-908',2);
CALL crearPaciente(195,'194','aydan','aydan','(360)-024-6328','(360)-024-6328',1);
CALL crearPaciente(196,'195','monteiro','monteiro','(71) 5848-8742','(71) 5848-8742',2);
CALL crearPaciente(198,'197','leroux','leroux','06-09-96-38-18','06-09-96-38-18',2);
CALL crearPaciente(199,'198','shelton','shelton','0467-658-105','0467-658-105',1);
CALL crearPaciente(200,'199','jackson','jackson','(570)-687-7371','(570)-687-7371',2);
CALL crearPaciente(202,'201','da rosa','da rosa','(65) 9912-7496','(65) 9912-7496',2);
CALL crearPaciente(203,'202','dağdaş','dağdaş','(855)-841-4810','(855)-841-4810',1);
CALL crearPaciente(204,'203','mercier','mercier','(168)-747-5950','(168)-747-5950',2);
CALL crearPaciente(206,'205','lemaire','lemaire','06-41-57-50-80','06-41-57-50-80',2);
CALL crearPaciente(207,'206','williamson','williamson','081-571-7090','081-571-7090',1);
CALL crearPaciente(208,'207','hahn','hahn','0170-0421455','0170-0421455',2);

INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #2','descripcion #2','2','2',1,1);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #3','descripcion #3','3','3',1,1);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #3','descripcion #3','3','3',2,1);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #4','descripcion #4','4','4',2,1);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #4','descripcion #4','4','4',3,1);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #5','descripcion #5','5','5',3,1);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #6','descripcion #6','6','6',4,2);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #7','descripcion #7','7','7',4,2);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #7','descripcion #7','7','7',5,2);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #8','descripcion #8','8','8',5,2);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #8','descripcion #8','8','8',6,2);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #9','descripcion #9','9','9',6,2);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #10','descripcion #10','10','10',7,3);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #11','descripcion #11','11','11',7,3);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #11','descripcion #11','11','11',8,3);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #12','descripcion #12','12','12',8,3);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #12','descripcion #12','12','12',9,3);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #13','descripcion #13','13','13',9,3);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #14','descripcion #14','14','14',10,4);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #15','descripcion #15','15','15',10,4);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #15','descripcion #15','15','15',11,4);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #16','descripcion #16','16','16',11,4);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #16','descripcion #16','16','16',12,4);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #17','descripcion #17','17','17',12,4);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #18','descripcion #18','18','18',13,5);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #19','descripcion #19','19','19',13,5);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #19','descripcion #19','19','19',14,5);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #20','descripcion #20','20','20',14,5);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #20','descripcion #20','20','20',15,5);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #21','descripcion #21','21','21',15,5);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #22','descripcion #22','22','22',16,6);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #23','descripcion #23','23','23',16,6);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #23','descripcion #23','23','23',17,6);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #24','descripcion #24','24','24',17,6);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #24','descripcion #24','24','24',18,6);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #25','descripcion #25','25','25',18,6);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #26','descripcion #26','26','26',19,7);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #27','descripcion #27','27','27',19,7);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #27','descripcion #27','27','27',20,7);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #28','descripcion #28','28','28',20,7);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #28','descripcion #28','28','28',21,7);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #29','descripcion #29','29','29',21,7);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #30','descripcion #30','30','30',22,8);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #31','descripcion #31','31','31',22,8);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #31','descripcion #31','31','31',23,8);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #32','descripcion #32','32','32',23,8);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #32','descripcion #32','32','32',24,8);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #33','descripcion #33','33','33',24,8);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #34','descripcion #34','34','34',25,9);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #35','descripcion #35','35','35',25,9);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #35','descripcion #35','35','35',26,9);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #36','descripcion #36','36','36',26,9);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #36','descripcion #36','36','36',27,9);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #37','descripcion #37','37','37',27,9);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #38','descripcion #38','38','38',28,10);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #39','descripcion #39','39','39',28,10);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #39','descripcion #39','39','39',29,10);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #40','descripcion #40','40','40',29,10);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #40','descripcion #40','40','40',30,10);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #41','descripcion #41','41','41',30,10);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #42','descripcion #42','42','42',31,11);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #43','descripcion #43','43','43',31,11);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #43','descripcion #43','43','43',32,11);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #44','descripcion #44','44','44',32,11);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #44','descripcion #44','44','44',33,11);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #45','descripcion #45','45','45',33,11);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #46','descripcion #46','46','46',34,12);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #47','descripcion #47','47','47',34,12);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #47','descripcion #47','47','47',35,12);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #48','descripcion #48','48','48',35,12);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #48','descripcion #48','48','48',36,12);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #49','descripcion #49','49','49',36,12);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #50','descripcion #50','50','50',37,13);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #51','descripcion #51','51','51',37,13);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #51','descripcion #51','51','51',38,13);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #52','descripcion #52','52','52',38,13);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #52','descripcion #52','52','52',39,13);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #53','descripcion #53','53','53',39,13);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #54','descripcion #54','54','54',40,14);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #55','descripcion #55','55','55',40,14);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #55','descripcion #55','55','55',41,14);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #56','descripcion #56','56','56',41,14);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #56','descripcion #56','56','56',42,14);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #57','descripcion #57','57','57',42,14);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #58','descripcion #58','58','58',43,15);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #59','descripcion #59','59','59',43,15);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #59','descripcion #59','59','59',44,15);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #60','descripcion #60','60','60',44,15);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #60','descripcion #60','60','60',45,15);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #61','descripcion #61','61','61',45,15);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #62','descripcion #62','62','62',46,16);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #63','descripcion #63','63','63',46,16);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #63','descripcion #63','63','63',47,16);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #64','descripcion #64','64','64',47,16);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #64','descripcion #64','64','64',48,16);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #65','descripcion #65','65','65',48,16);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #66','descripcion #66','66','66',49,17);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #67','descripcion #67','67','67',49,17);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #67','descripcion #67','67','67',50,17);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #68','descripcion #68','68','68',50,17);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #68','descripcion #68','68','68',51,17);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #69','descripcion #69','69','69',51,17);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #70','descripcion #70','70','70',52,18);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #71','descripcion #71','71','71',52,18);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #71','descripcion #71','71','71',53,18);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #72','descripcion #72','72','72',53,18);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #72','descripcion #72','72','72',54,18);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #73','descripcion #73','73','73',54,18);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #74','descripcion #74','74','74',55,19);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #75','descripcion #75','75','75',55,19);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #75','descripcion #75','75','75',56,19);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #76','descripcion #76','76','76',56,19);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #76','descripcion #76','76','76',57,19);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #77','descripcion #77','77','77',57,19);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #78','descripcion #78','78','78',58,20);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #79','descripcion #79','79','79',58,20);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #79','descripcion #79','79','79',59,20);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #80','descripcion #80','80','80',59,20);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #80','descripcion #80','80','80',60,20);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #81','descripcion #81','81','81',60,20);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #82','descripcion #82','82','82',61,21);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #83','descripcion #83','83','83',61,21);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #83','descripcion #83','83','83',62,21);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #84','descripcion #84','84','84',62,21);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #84','descripcion #84','84','84',63,21);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #85','descripcion #85','85','85',63,21);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #86','descripcion #86','86','86',64,22);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #87','descripcion #87','87','87',64,22);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #87','descripcion #87','87','87',65,22);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #88','descripcion #88','88','88',65,22);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #88','descripcion #88','88','88',66,22);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #89','descripcion #89','89','89',66,22);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #90','descripcion #90','90','90',67,23);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #91','descripcion #91','91','91',67,23);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #91','descripcion #91','91','91',68,23);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #92','descripcion #92','92','92',68,23);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #92','descripcion #92','92','92',69,23);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #93','descripcion #93','93','93',69,23);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #94','descripcion #94','94','94',70,24);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #95','descripcion #95','95','95',70,24);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #95','descripcion #95','95','95',71,24);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #96','descripcion #96','96','96',71,24);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #96','descripcion #96','96','96',72,24);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #97','descripcion #97','97','97',72,24);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #98','descripcion #98','98','98',73,25);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #99','descripcion #99','99','99',73,25);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #99','descripcion #99','99','99',74,25);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #100','descripcion #100','100','100',74,25);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #100','descripcion #100','100','100',75,25);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #101','descripcion #101','101','101',75,25);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #102','descripcion #102','102','102',76,26);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #103','descripcion #103','103','103',76,26);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #103','descripcion #103','103','103',77,26);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #104','descripcion #104','104','104',77,26);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #104','descripcion #104','104','104',78,26);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #105','descripcion #105','105','105',78,26);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #106','descripcion #106','106','106',79,27);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #107','descripcion #107','107','107',79,27);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #107','descripcion #107','107','107',80,27);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #108','descripcion #108','108','108',80,27);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #108','descripcion #108','108','108',81,27);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #109','descripcion #109','109','109',81,27);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #110','descripcion #110','110','110',82,28);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #111','descripcion #111','111','111',82,28);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #111','descripcion #111','111','111',83,28);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #112','descripcion #112','112','112',83,28);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #112','descripcion #112','112','112',84,28);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #113','descripcion #113','113','113',84,28);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #114','descripcion #114','114','114',85,29);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #115','descripcion #115','115','115',85,29);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #115','descripcion #115','115','115',86,29);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #116','descripcion #116','116','116',86,29);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #116','descripcion #116','116','116',87,29);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #117','descripcion #117','117','117',87,29);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #118','descripcion #118','118','118',88,30);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #119','descripcion #119','119','119',88,30);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #119','descripcion #119','119','119',89,30);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #120','descripcion #120','120','120',89,30);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #120','descripcion #120','120','120',90,30);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #121','descripcion #121','121','121',90,30);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #122','descripcion #122','122','122',91,31);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #123','descripcion #123','123','123',91,31);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #123','descripcion #123','123','123',92,31);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #124','descripcion #124','124','124',92,31);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #124','descripcion #124','124','124',93,31);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #125','descripcion #125','125','125',93,31);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #126','descripcion #126','126','126',94,32);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #127','descripcion #127','127','127',94,32);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #127','descripcion #127','127','127',95,32);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #128','descripcion #128','128','128',95,32);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #128','descripcion #128','128','128',96,32);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #129','descripcion #129','129','129',96,32);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #130','descripcion #130','130','130',97,33);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #131','descripcion #131','131','131',97,33);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #131','descripcion #131','131','131',98,33);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #132','descripcion #132','132','132',98,33);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #132','descripcion #132','132','132',99,33);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #133','descripcion #133','133','133',99,33);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #134','descripcion #134','134','134',100,34);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #135','descripcion #135','135','135',100,34);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #135','descripcion #135','135','135',101,34);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #136','descripcion #136','136','136',101,34);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #136','descripcion #136','136','136',102,34);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #137','descripcion #137','137','137',102,34);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #138','descripcion #138','138','138',103,35);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #139','descripcion #139','139','139',103,35);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #139','descripcion #139','139','139',104,35);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #140','descripcion #140','140','140',104,35);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #140','descripcion #140','140','140',105,35);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #141','descripcion #141','141','141',105,35);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #142','descripcion #142','142','142',106,36);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #143','descripcion #143','143','143',106,36);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #143','descripcion #143','143','143',107,36);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #144','descripcion #144','144','144',107,36);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #144','descripcion #144','144','144',108,36);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #145','descripcion #145','145','145',108,36);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #146','descripcion #146','146','146',109,37);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #147','descripcion #147','147','147',109,37);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #147','descripcion #147','147','147',110,37);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #148','descripcion #148','148','148',110,37);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #148','descripcion #148','148','148',111,37);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #149','descripcion #149','149','149',111,37);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #150','descripcion #150','150','150',112,38);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #151','descripcion #151','151','151',112,38);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #151','descripcion #151','151','151',113,38);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #152','descripcion #152','152','152',113,38);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #152','descripcion #152','152','152',114,38);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #153','descripcion #153','153','153',114,38);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #154','descripcion #154','154','154',115,39);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #155','descripcion #155','155','155',115,39);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #155','descripcion #155','155','155',116,39);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #156','descripcion #156','156','156',116,39);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #156','descripcion #156','156','156',117,39);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #157','descripcion #157','157','157',117,39);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #158','descripcion #158','158','158',118,40);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #159','descripcion #159','159','159',118,40);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #159','descripcion #159','159','159',119,40);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #160','descripcion #160','160','160',119,40);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #160','descripcion #160','160','160',120,40);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #161','descripcion #161','161','161',120,40);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #162','descripcion #162','162','162',121,41);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #163','descripcion #163','163','163',121,41);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #163','descripcion #163','163','163',122,41);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #164','descripcion #164','164','164',122,41);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #164','descripcion #164','164','164',123,41);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #165','descripcion #165','165','165',123,41);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #166','descripcion #166','166','166',124,42);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #167','descripcion #167','167','167',124,42);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #167','descripcion #167','167','167',125,42);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #168','descripcion #168','168','168',125,42);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #168','descripcion #168','168','168',126,42);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #169','descripcion #169','169','169',126,42);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #170','descripcion #170','170','170',127,43);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #171','descripcion #171','171','171',127,43);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #171','descripcion #171','171','171',128,43);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #172','descripcion #172','172','172',128,43);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #172','descripcion #172','172','172',129,43);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #173','descripcion #173','173','173',129,43);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #174','descripcion #174','174','174',130,44);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #175','descripcion #175','175','175',130,44);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #175','descripcion #175','175','175',131,44);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #176','descripcion #176','176','176',131,44);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #176','descripcion #176','176','176',132,44);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #177','descripcion #177','177','177',132,44);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #178','descripcion #178','178','178',133,45);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #179','descripcion #179','179','179',133,45);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #179','descripcion #179','179','179',134,45);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #180','descripcion #180','180','180',134,45);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #180','descripcion #180','180','180',135,45);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #181','descripcion #181','181','181',135,45);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #182','descripcion #182','182','182',136,46);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #183','descripcion #183','183','183',136,46);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #183','descripcion #183','183','183',137,46);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #184','descripcion #184','184','184',137,46);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #184','descripcion #184','184','184',138,46);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #185','descripcion #185','185','185',138,46);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #186','descripcion #186','186','186',139,47);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #187','descripcion #187','187','187',139,47);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #187','descripcion #187','187','187',140,47);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #188','descripcion #188','188','188',140,47);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #188','descripcion #188','188','188',141,47);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #189','descripcion #189','189','189',141,47);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #190','descripcion #190','190','190',142,48);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #191','descripcion #191','191','191',142,48);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #191','descripcion #191','191','191',143,48);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #192','descripcion #192','192','192',143,48);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #192','descripcion #192','192','192',144,48);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #193','descripcion #193','193','193',144,48);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #194','descripcion #194','194','194',145,49);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #195','descripcion #195','195','195',145,49);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #195','descripcion #195','195','195',146,49);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #196','descripcion #196','196','196',146,49);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #196','descripcion #196','196','196',147,49);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #197','descripcion #197','197','197',147,49);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #198','descripcion #198','198','198',148,50);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #199','descripcion #199','199','199',148,50);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #199','descripcion #199','199','199',149,50);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #200','descripcion #200','200','200',149,50);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #200','descripcion #200','200','200',150,50);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #201','descripcion #201','201','201',150,50);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #202','descripcion #202','202','202',151,51);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #203','descripcion #203','203','203',151,51);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #203','descripcion #203','203','203',152,51);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #204','descripcion #204','204','204',152,51);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #204','descripcion #204','204','204',153,51);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #205','descripcion #205','205','205',153,51);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #206','descripcion #206','206','206',154,52);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #207','descripcion #207','207','207',154,52);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #207','descripcion #207','207','207',155,52);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #208','descripcion #208','208','208',155,52);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                              VALUES ('cita #208','descripcion #208','208','208',156,52);
INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico)                             VALUES ('cita #209','descripcion #209','209','209',156,52);

INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #2','descripcion #2','1000-01-01 00:00:00',1,1);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #3','descripcion #3','1000-01-01 00:00:00',1,1);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #3','descripcion #3','1000-01-01 00:00:00',2,1);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #4','descripcion #4','1000-01-01 00:00:00',2,1);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #4','descripcion #4','1000-01-01 00:00:00',3,1);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #5','descripcion #5','1000-01-01 00:00:00',3,1);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #6','descripcion #6','1000-01-01 00:00:00',4,2);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #7','descripcion #7','1000-01-01 00:00:00',4,2);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #7','descripcion #7','1000-01-01 00:00:00',5,2);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #8','descripcion #8','1000-01-01 00:00:00',5,2);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #8','descripcion #8','1000-01-01 00:00:00',6,2);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #9','descripcion #9','1000-01-01 00:00:00',6,2);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #10','descripcion #10','1000-01-01 00:00:00',7,3);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #11','descripcion #11','1000-01-01 00:00:00',7,3);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #11','descripcion #11','1000-01-01 00:00:00',8,3);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #12','descripcion #12','1000-01-01 00:00:00',8,3);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #12','descripcion #12','1000-01-01 00:00:00',9,3);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #13','descripcion #13','1000-01-01 00:00:00',9,3);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #14','descripcion #14','1000-01-01 00:00:00',10,4);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #15','descripcion #15','1000-01-01 00:00:00',10,4);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #15','descripcion #15','1000-01-01 00:00:00',11,4);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #16','descripcion #16','1000-01-01 00:00:00',11,4);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #16','descripcion #16','1000-01-01 00:00:00',12,4);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #17','descripcion #17','1000-01-01 00:00:00',12,4);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #18','descripcion #18','1000-01-01 00:00:00',13,5);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #19','descripcion #19','1000-01-01 00:00:00',13,5);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #19','descripcion #19','1000-01-01 00:00:00',14,5);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #20','descripcion #20','1000-01-01 00:00:00',14,5);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #20','descripcion #20','1000-01-01 00:00:00',15,5);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #21','descripcion #21','1000-01-01 00:00:00',15,5);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #22','descripcion #22','1000-01-01 00:00:00',16,6);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #23','descripcion #23','1000-01-01 00:00:00',16,6);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #23','descripcion #23','1000-01-01 00:00:00',17,6);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #24','descripcion #24','1000-01-01 00:00:00',17,6);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #24','descripcion #24','1000-01-01 00:00:00',18,6);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #25','descripcion #25','1000-01-01 00:00:00',18,6);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #26','descripcion #26','1000-01-01 00:00:00',19,7);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #27','descripcion #27','1000-01-01 00:00:00',19,7);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #27','descripcion #27','1000-01-01 00:00:00',20,7);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #28','descripcion #28','1000-01-01 00:00:00',20,7);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #28','descripcion #28','1000-01-01 00:00:00',21,7);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #29','descripcion #29','1000-01-01 00:00:00',21,7);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #30','descripcion #30','1000-01-01 00:00:00',22,8);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #31','descripcion #31','1000-01-01 00:00:00',22,8);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #31','descripcion #31','1000-01-01 00:00:00',23,8);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #32','descripcion #32','1000-01-01 00:00:00',23,8);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #32','descripcion #32','1000-01-01 00:00:00',24,8);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #33','descripcion #33','1000-01-01 00:00:00',24,8);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #34','descripcion #34','1000-01-01 00:00:00',25,9);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #35','descripcion #35','1000-01-01 00:00:00',25,9);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #35','descripcion #35','1000-01-01 00:00:00',26,9);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #36','descripcion #36','1000-01-01 00:00:00',26,9);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #36','descripcion #36','1000-01-01 00:00:00',27,9);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #37','descripcion #37','1000-01-01 00:00:00',27,9);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #38','descripcion #38','1000-01-01 00:00:00',28,10);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #39','descripcion #39','1000-01-01 00:00:00',28,10);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #39','descripcion #39','1000-01-01 00:00:00',29,10);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #40','descripcion #40','1000-01-01 00:00:00',29,10);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #40','descripcion #40','1000-01-01 00:00:00',30,10);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #41','descripcion #41','1000-01-01 00:00:00',30,10);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #42','descripcion #42','1000-01-01 00:00:00',31,11);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #43','descripcion #43','1000-01-01 00:00:00',31,11);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #43','descripcion #43','1000-01-01 00:00:00',32,11);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #44','descripcion #44','1000-01-01 00:00:00',32,11);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #44','descripcion #44','1000-01-01 00:00:00',33,11);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #45','descripcion #45','1000-01-01 00:00:00',33,11);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #46','descripcion #46','1000-01-01 00:00:00',34,12);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #47','descripcion #47','1000-01-01 00:00:00',34,12);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #47','descripcion #47','1000-01-01 00:00:00',35,12);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #48','descripcion #48','1000-01-01 00:00:00',35,12);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #48','descripcion #48','1000-01-01 00:00:00',36,12);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #49','descripcion #49','1000-01-01 00:00:00',36,12);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #50','descripcion #50','1000-01-01 00:00:00',37,13);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #51','descripcion #51','1000-01-01 00:00:00',37,13);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #51','descripcion #51','1000-01-01 00:00:00',38,13);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #52','descripcion #52','1000-01-01 00:00:00',38,13);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #52','descripcion #52','1000-01-01 00:00:00',39,13);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #53','descripcion #53','1000-01-01 00:00:00',39,13);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #54','descripcion #54','1000-01-01 00:00:00',40,14);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #55','descripcion #55','1000-01-01 00:00:00',40,14);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #55','descripcion #55','1000-01-01 00:00:00',41,14);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #56','descripcion #56','1000-01-01 00:00:00',41,14);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #56','descripcion #56','1000-01-01 00:00:00',42,14);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #57','descripcion #57','1000-01-01 00:00:00',42,14);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #58','descripcion #58','1000-01-01 00:00:00',43,15);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #59','descripcion #59','1000-01-01 00:00:00',43,15);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #59','descripcion #59','1000-01-01 00:00:00',44,15);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #60','descripcion #60','1000-01-01 00:00:00',44,15);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #60','descripcion #60','1000-01-01 00:00:00',45,15);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #61','descripcion #61','1000-01-01 00:00:00',45,15);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #62','descripcion #62','1000-01-01 00:00:00',46,16);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #63','descripcion #63','1000-01-01 00:00:00',46,16);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #63','descripcion #63','1000-01-01 00:00:00',47,16);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #64','descripcion #64','1000-01-01 00:00:00',47,16);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #64','descripcion #64','1000-01-01 00:00:00',48,16);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #65','descripcion #65','1000-01-01 00:00:00',48,16);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #66','descripcion #66','1000-01-01 00:00:00',49,17);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #67','descripcion #67','1000-01-01 00:00:00',49,17);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #67','descripcion #67','1000-01-01 00:00:00',50,17);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #68','descripcion #68','1000-01-01 00:00:00',50,17);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #68','descripcion #68','1000-01-01 00:00:00',51,17);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #69','descripcion #69','1000-01-01 00:00:00',51,17);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #70','descripcion #70','1000-01-01 00:00:00',52,18);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #71','descripcion #71','1000-01-01 00:00:00',52,18);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #71','descripcion #71','1000-01-01 00:00:00',53,18);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #72','descripcion #72','1000-01-01 00:00:00',53,18);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #72','descripcion #72','1000-01-01 00:00:00',54,18);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #73','descripcion #73','1000-01-01 00:00:00',54,18);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #74','descripcion #74','1000-01-01 00:00:00',55,19);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #75','descripcion #75','1000-01-01 00:00:00',55,19);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #75','descripcion #75','1000-01-01 00:00:00',56,19);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #76','descripcion #76','1000-01-01 00:00:00',56,19);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #76','descripcion #76','1000-01-01 00:00:00',57,19);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #77','descripcion #77','1000-01-01 00:00:00',57,19);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #78','descripcion #78','1000-01-01 00:00:00',58,20);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #79','descripcion #79','1000-01-01 00:00:00',58,20);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #79','descripcion #79','1000-01-01 00:00:00',59,20);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #80','descripcion #80','1000-01-01 00:00:00',59,20);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #80','descripcion #80','1000-01-01 00:00:00',60,20);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #81','descripcion #81','1000-01-01 00:00:00',60,20);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #82','descripcion #82','1000-01-01 00:00:00',61,21);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #83','descripcion #83','1000-01-01 00:00:00',61,21);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #83','descripcion #83','1000-01-01 00:00:00',62,21);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #84','descripcion #84','1000-01-01 00:00:00',62,21);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #84','descripcion #84','1000-01-01 00:00:00',63,21);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #85','descripcion #85','1000-01-01 00:00:00',63,21);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #86','descripcion #86','1000-01-01 00:00:00',64,22);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #87','descripcion #87','1000-01-01 00:00:00',64,22);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #87','descripcion #87','1000-01-01 00:00:00',65,22);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #88','descripcion #88','1000-01-01 00:00:00',65,22);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #88','descripcion #88','1000-01-01 00:00:00',66,22);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #89','descripcion #89','1000-01-01 00:00:00',66,22);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #90','descripcion #90','1000-01-01 00:00:00',67,23);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #91','descripcion #91','1000-01-01 00:00:00',67,23);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #91','descripcion #91','1000-01-01 00:00:00',68,23);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #92','descripcion #92','1000-01-01 00:00:00',68,23);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #92','descripcion #92','1000-01-01 00:00:00',69,23);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #93','descripcion #93','1000-01-01 00:00:00',69,23);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #94','descripcion #94','1000-01-01 00:00:00',70,24);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #95','descripcion #95','1000-01-01 00:00:00',70,24);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #95','descripcion #95','1000-01-01 00:00:00',71,24);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #96','descripcion #96','1000-01-01 00:00:00',71,24);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #96','descripcion #96','1000-01-01 00:00:00',72,24);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #97','descripcion #97','1000-01-01 00:00:00',72,24);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #98','descripcion #98','1000-01-01 00:00:00',73,25);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #99','descripcion #99','1000-01-01 00:00:00',73,25);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #99','descripcion #99','1000-01-01 00:00:00',74,25);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #100','descripcion #100','1000-01-01 00:00:00',74,25);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #100','descripcion #100','1000-01-01 00:00:00',75,25);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #101','descripcion #101','1000-01-01 00:00:00',75,25);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #102','descripcion #102','1000-01-01 00:00:00',76,26);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #103','descripcion #103','1000-01-01 00:00:00',76,26);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #103','descripcion #103','1000-01-01 00:00:00',77,26);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #104','descripcion #104','1000-01-01 00:00:00',77,26);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #104','descripcion #104','1000-01-01 00:00:00',78,26);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #105','descripcion #105','1000-01-01 00:00:00',78,26);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #106','descripcion #106','1000-01-01 00:00:00',79,27);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #107','descripcion #107','1000-01-01 00:00:00',79,27);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #107','descripcion #107','1000-01-01 00:00:00',80,27);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #108','descripcion #108','1000-01-01 00:00:00',80,27);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #108','descripcion #108','1000-01-01 00:00:00',81,27);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #109','descripcion #109','1000-01-01 00:00:00',81,27);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #110','descripcion #110','1000-01-01 00:00:00',82,28);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #111','descripcion #111','1000-01-01 00:00:00',82,28);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #111','descripcion #111','1000-01-01 00:00:00',83,28);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #112','descripcion #112','1000-01-01 00:00:00',83,28);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #112','descripcion #112','1000-01-01 00:00:00',84,28);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #113','descripcion #113','1000-01-01 00:00:00',84,28);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #114','descripcion #114','1000-01-01 00:00:00',85,29);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #115','descripcion #115','1000-01-01 00:00:00',85,29);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #115','descripcion #115','1000-01-01 00:00:00',86,29);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #116','descripcion #116','1000-01-01 00:00:00',86,29);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #116','descripcion #116','1000-01-01 00:00:00',87,29);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #117','descripcion #117','1000-01-01 00:00:00',87,29);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #118','descripcion #118','1000-01-01 00:00:00',88,30);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #119','descripcion #119','1000-01-01 00:00:00',88,30);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #119','descripcion #119','1000-01-01 00:00:00',89,30);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #120','descripcion #120','1000-01-01 00:00:00',89,30);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #120','descripcion #120','1000-01-01 00:00:00',90,30);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #121','descripcion #121','1000-01-01 00:00:00',90,30);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #122','descripcion #122','1000-01-01 00:00:00',91,31);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #123','descripcion #123','1000-01-01 00:00:00',91,31);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #123','descripcion #123','1000-01-01 00:00:00',92,31);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #124','descripcion #124','1000-01-01 00:00:00',92,31);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #124','descripcion #124','1000-01-01 00:00:00',93,31);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #125','descripcion #125','1000-01-01 00:00:00',93,31);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #126','descripcion #126','1000-01-01 00:00:00',94,32);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #127','descripcion #127','1000-01-01 00:00:00',94,32);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #127','descripcion #127','1000-01-01 00:00:00',95,32);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #128','descripcion #128','1000-01-01 00:00:00',95,32);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #128','descripcion #128','1000-01-01 00:00:00',96,32);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #129','descripcion #129','1000-01-01 00:00:00',96,32);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #130','descripcion #130','1000-01-01 00:00:00',97,33);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #131','descripcion #131','1000-01-01 00:00:00',97,33);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #131','descripcion #131','1000-01-01 00:00:00',98,33);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #132','descripcion #132','1000-01-01 00:00:00',98,33);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #132','descripcion #132','1000-01-01 00:00:00',99,33);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #133','descripcion #133','1000-01-01 00:00:00',99,33);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #134','descripcion #134','1000-01-01 00:00:00',100,34);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #135','descripcion #135','1000-01-01 00:00:00',100,34);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #135','descripcion #135','1000-01-01 00:00:00',101,34);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #136','descripcion #136','1000-01-01 00:00:00',101,34);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #136','descripcion #136','1000-01-01 00:00:00',102,34);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #137','descripcion #137','1000-01-01 00:00:00',102,34);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #138','descripcion #138','1000-01-01 00:00:00',103,35);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #139','descripcion #139','1000-01-01 00:00:00',103,35);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #139','descripcion #139','1000-01-01 00:00:00',104,35);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #140','descripcion #140','1000-01-01 00:00:00',104,35);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #140','descripcion #140','1000-01-01 00:00:00',105,35);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #141','descripcion #141','1000-01-01 00:00:00',105,35);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #142','descripcion #142','1000-01-01 00:00:00',106,36);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #143','descripcion #143','1000-01-01 00:00:00',106,36);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #143','descripcion #143','1000-01-01 00:00:00',107,36);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #144','descripcion #144','1000-01-01 00:00:00',107,36);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #144','descripcion #144','1000-01-01 00:00:00',108,36);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #145','descripcion #145','1000-01-01 00:00:00',108,36);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #146','descripcion #146','1000-01-01 00:00:00',109,37);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #147','descripcion #147','1000-01-01 00:00:00',109,37);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #147','descripcion #147','1000-01-01 00:00:00',110,37);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #148','descripcion #148','1000-01-01 00:00:00',110,37);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #148','descripcion #148','1000-01-01 00:00:00',111,37);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #149','descripcion #149','1000-01-01 00:00:00',111,37);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #150','descripcion #150','1000-01-01 00:00:00',112,38);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #151','descripcion #151','1000-01-01 00:00:00',112,38);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #151','descripcion #151','1000-01-01 00:00:00',113,38);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #152','descripcion #152','1000-01-01 00:00:00',113,38);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #152','descripcion #152','1000-01-01 00:00:00',114,38);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #153','descripcion #153','1000-01-01 00:00:00',114,38);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #154','descripcion #154','1000-01-01 00:00:00',115,39);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #155','descripcion #155','1000-01-01 00:00:00',115,39);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #155','descripcion #155','1000-01-01 00:00:00',116,39);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #156','descripcion #156','1000-01-01 00:00:00',116,39);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #156','descripcion #156','1000-01-01 00:00:00',117,39);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #157','descripcion #157','1000-01-01 00:00:00',117,39);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #158','descripcion #158','1000-01-01 00:00:00',118,40);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #159','descripcion #159','1000-01-01 00:00:00',118,40);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #159','descripcion #159','1000-01-01 00:00:00',119,40);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #160','descripcion #160','1000-01-01 00:00:00',119,40);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #160','descripcion #160','1000-01-01 00:00:00',120,40);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #161','descripcion #161','1000-01-01 00:00:00',120,40);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #162','descripcion #162','1000-01-01 00:00:00',121,41);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #163','descripcion #163','1000-01-01 00:00:00',121,41);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #163','descripcion #163','1000-01-01 00:00:00',122,41);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #164','descripcion #164','1000-01-01 00:00:00',122,41);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #164','descripcion #164','1000-01-01 00:00:00',123,41);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #165','descripcion #165','1000-01-01 00:00:00',123,41);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #166','descripcion #166','1000-01-01 00:00:00',124,42);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #167','descripcion #167','1000-01-01 00:00:00',124,42);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #167','descripcion #167','1000-01-01 00:00:00',125,42);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #168','descripcion #168','1000-01-01 00:00:00',125,42);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #168','descripcion #168','1000-01-01 00:00:00',126,42);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #169','descripcion #169','1000-01-01 00:00:00',126,42);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #170','descripcion #170','1000-01-01 00:00:00',127,43);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #171','descripcion #171','1000-01-01 00:00:00',127,43);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #171','descripcion #171','1000-01-01 00:00:00',128,43);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #172','descripcion #172','1000-01-01 00:00:00',128,43);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #172','descripcion #172','1000-01-01 00:00:00',129,43);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #173','descripcion #173','1000-01-01 00:00:00',129,43);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #174','descripcion #174','1000-01-01 00:00:00',130,44);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #175','descripcion #175','1000-01-01 00:00:00',130,44);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #175','descripcion #175','1000-01-01 00:00:00',131,44);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #176','descripcion #176','1000-01-01 00:00:00',131,44);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #176','descripcion #176','1000-01-01 00:00:00',132,44);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #177','descripcion #177','1000-01-01 00:00:00',132,44);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #178','descripcion #178','1000-01-01 00:00:00',133,45);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #179','descripcion #179','1000-01-01 00:00:00',133,45);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #179','descripcion #179','1000-01-01 00:00:00',134,45);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #180','descripcion #180','1000-01-01 00:00:00',134,45);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #180','descripcion #180','1000-01-01 00:00:00',135,45);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #181','descripcion #181','1000-01-01 00:00:00',135,45);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #182','descripcion #182','1000-01-01 00:00:00',136,46);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #183','descripcion #183','1000-01-01 00:00:00',136,46);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #183','descripcion #183','1000-01-01 00:00:00',137,46);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #184','descripcion #184','1000-01-01 00:00:00',137,46);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #184','descripcion #184','1000-01-01 00:00:00',138,46);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #185','descripcion #185','1000-01-01 00:00:00',138,46);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #186','descripcion #186','1000-01-01 00:00:00',139,47);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #187','descripcion #187','1000-01-01 00:00:00',139,47);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #187','descripcion #187','1000-01-01 00:00:00',140,47);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #188','descripcion #188','1000-01-01 00:00:00',140,47);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #188','descripcion #188','1000-01-01 00:00:00',141,47);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #189','descripcion #189','1000-01-01 00:00:00',141,47);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #190','descripcion #190','1000-01-01 00:00:00',142,48);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #191','descripcion #191','1000-01-01 00:00:00',142,48);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #191','descripcion #191','1000-01-01 00:00:00',143,48);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #192','descripcion #192','1000-01-01 00:00:00',143,48);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #192','descripcion #192','1000-01-01 00:00:00',144,48);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #193','descripcion #193','1000-01-01 00:00:00',144,48);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #194','descripcion #194','1000-01-01 00:00:00',145,49);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #195','descripcion #195','1000-01-01 00:00:00',145,49);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #195','descripcion #195','1000-01-01 00:00:00',146,49);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #196','descripcion #196','1000-01-01 00:00:00',146,49);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #196','descripcion #196','1000-01-01 00:00:00',147,49);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #197','descripcion #197','1000-01-01 00:00:00',147,49);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #198','descripcion #198','1000-01-01 00:00:00',148,50);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #199','descripcion #199','1000-01-01 00:00:00',148,50);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #199','descripcion #199','1000-01-01 00:00:00',149,50);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #200','descripcion #200','1000-01-01 00:00:00',149,50);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #200','descripcion #200','1000-01-01 00:00:00',150,50);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #201','descripcion #201','1000-01-01 00:00:00',150,50);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #202','descripcion #202','1000-01-01 00:00:00',151,51);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #203','descripcion #203','1000-01-01 00:00:00',151,51);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #203','descripcion #203','1000-01-01 00:00:00',152,51);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #204','descripcion #204','1000-01-01 00:00:00',152,51);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #204','descripcion #204','1000-01-01 00:00:00',153,51);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #205','descripcion #205','1000-01-01 00:00:00',153,51);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #206','descripcion #206','1000-01-01 00:00:00',154,52);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #207','descripcion #207','1000-01-01 00:00:00',154,52);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #207','descripcion #207','1000-01-01 00:00:00',155,52);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #208','descripcion #208','1000-01-01 00:00:00',155,52);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #208','descripcion #208','1000-01-01 00:00:00',156,52);
INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)                               VALUES ('diagnostico #209','descripcion #209','1000-01-01 00:00:00',156,52);

INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(1,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(2,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(3,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(4,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(5,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(6,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(7,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(8,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(9,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(10,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(11,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(12,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(13,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(14,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(15,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(16,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(17,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(18,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(19,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(20,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(21,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(22,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(23,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(24,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(25,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(26,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(27,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(28,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(29,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(30,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(31,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(32,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(33,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(34,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(35,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(36,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(37,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(38,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(39,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(40,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(41,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(42,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(43,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(44,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(45,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(46,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(47,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(48,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(49,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(50,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(51,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(52,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(53,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(54,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(55,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(56,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(57,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(58,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(59,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(60,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(61,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(62,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(63,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(64,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(65,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(66,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(67,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(68,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(69,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(70,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(71,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(72,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(73,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(74,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(75,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(76,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(77,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(78,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(79,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(80,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(81,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(82,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(83,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(84,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(85,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(86,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(87,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(88,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(89,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(90,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(91,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(92,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(93,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(94,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(95,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(96,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(97,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(98,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(99,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(100,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(101,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(102,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(103,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(104,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(105,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(106,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(107,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(108,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(109,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(110,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(111,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(112,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(113,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(114,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(115,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(116,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(117,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(118,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(119,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(120,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(121,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(122,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(123,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(124,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(125,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(126,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(127,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(128,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(129,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(130,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(131,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(132,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(133,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(134,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(135,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(136,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(137,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(138,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(139,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(140,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(141,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(142,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(143,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(144,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(145,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(146,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(147,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(148,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(149,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(150,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(151,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(152,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(153,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(154,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(155,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(156,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(157,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(158,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(159,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(160,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(161,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(162,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(163,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(164,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(165,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(166,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(167,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(168,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(169,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(170,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(171,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(172,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(173,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(174,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(175,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(176,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(177,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(178,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(179,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(180,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(181,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(182,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(183,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(184,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(185,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(186,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(187,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(188,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(189,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(190,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(191,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(192,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(193,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(194,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(195,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(196,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(197,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(198,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(199,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(200,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(201,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(202,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(203,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(204,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(205,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(206,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(207,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(208,'1000-01-01 00:00:00');
INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(209,'1000-01-01 00:00:00');

INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(1,1,'indicaciones #1');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(2,2,'indicaciones #2');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(3,3,'indicaciones #3');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(4,4,'indicaciones #4');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(5,5,'indicaciones #5');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(6,6,'indicaciones #6');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(7,7,'indicaciones #7');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(8,8,'indicaciones #8');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(9,9,'indicaciones #9');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(10,10,'indicaciones #10');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(11,11,'indicaciones #11');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(12,12,'indicaciones #12');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(13,13,'indicaciones #13');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(14,14,'indicaciones #14');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(15,15,'indicaciones #15');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(16,16,'indicaciones #16');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(17,17,'indicaciones #17');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(18,18,'indicaciones #18');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(19,19,'indicaciones #19');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(20,20,'indicaciones #20');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(21,21,'indicaciones #21');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(22,22,'indicaciones #22');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(23,23,'indicaciones #23');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(24,24,'indicaciones #24');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(25,25,'indicaciones #25');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(26,26,'indicaciones #26');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(27,27,'indicaciones #27');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(28,28,'indicaciones #28');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(29,29,'indicaciones #29');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(30,30,'indicaciones #30');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(31,31,'indicaciones #31');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(32,32,'indicaciones #32');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(33,33,'indicaciones #33');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(34,34,'indicaciones #34');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(35,35,'indicaciones #35');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(36,36,'indicaciones #36');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(37,37,'indicaciones #37');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(38,38,'indicaciones #38');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(39,39,'indicaciones #39');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(40,40,'indicaciones #40');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(41,41,'indicaciones #41');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(42,42,'indicaciones #42');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(43,43,'indicaciones #43');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(44,44,'indicaciones #44');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(45,45,'indicaciones #45');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(46,46,'indicaciones #46');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(47,47,'indicaciones #47');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(48,48,'indicaciones #48');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(49,49,'indicaciones #49');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(50,50,'indicaciones #50');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(51,51,'indicaciones #51');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(52,52,'indicaciones #52');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(53,53,'indicaciones #53');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(54,54,'indicaciones #54');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(55,55,'indicaciones #55');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(56,56,'indicaciones #56');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(57,57,'indicaciones #57');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(58,58,'indicaciones #58');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(59,59,'indicaciones #59');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(60,60,'indicaciones #60');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(61,61,'indicaciones #61');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(62,62,'indicaciones #62');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(63,63,'indicaciones #63');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(64,64,'indicaciones #64');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(65,65,'indicaciones #65');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(66,66,'indicaciones #66');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(67,67,'indicaciones #67');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(68,68,'indicaciones #68');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(69,69,'indicaciones #69');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(70,70,'indicaciones #70');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(71,71,'indicaciones #71');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(72,72,'indicaciones #72');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(73,73,'indicaciones #73');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(74,74,'indicaciones #74');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(75,75,'indicaciones #75');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(76,76,'indicaciones #76');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(77,77,'indicaciones #77');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(78,78,'indicaciones #78');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(79,79,'indicaciones #79');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(80,80,'indicaciones #80');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(81,81,'indicaciones #81');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(82,82,'indicaciones #82');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(83,83,'indicaciones #83');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(84,84,'indicaciones #84');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(85,85,'indicaciones #85');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(86,86,'indicaciones #86');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(87,87,'indicaciones #87');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(88,88,'indicaciones #88');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(89,89,'indicaciones #89');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(90,90,'indicaciones #90');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(91,91,'indicaciones #91');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(92,92,'indicaciones #92');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(93,93,'indicaciones #93');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(94,94,'indicaciones #94');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(95,95,'indicaciones #95');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(96,96,'indicaciones #96');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(97,97,'indicaciones #97');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(98,98,'indicaciones #98');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(99,99,'indicaciones #99');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(100,100,'indicaciones #100');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(101,101,'indicaciones #101');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(102,102,'indicaciones #102');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(103,103,'indicaciones #103');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(104,104,'indicaciones #104');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(105,105,'indicaciones #105');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(106,106,'indicaciones #106');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(107,107,'indicaciones #107');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(108,108,'indicaciones #108');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(109,109,'indicaciones #109');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(110,110,'indicaciones #110');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(111,111,'indicaciones #111');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(112,112,'indicaciones #112');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(113,113,'indicaciones #113');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(114,114,'indicaciones #114');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(115,115,'indicaciones #115');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(116,116,'indicaciones #116');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(117,117,'indicaciones #117');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(118,118,'indicaciones #118');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(119,119,'indicaciones #119');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(120,120,'indicaciones #120');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(121,121,'indicaciones #121');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(122,122,'indicaciones #122');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(123,123,'indicaciones #123');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(124,124,'indicaciones #124');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(125,125,'indicaciones #125');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(126,126,'indicaciones #126');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(127,127,'indicaciones #127');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(128,128,'indicaciones #128');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(129,129,'indicaciones #129');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(130,130,'indicaciones #130');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(131,131,'indicaciones #131');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(132,132,'indicaciones #132');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(133,133,'indicaciones #133');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(134,134,'indicaciones #134');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(135,135,'indicaciones #135');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(136,136,'indicaciones #136');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(137,137,'indicaciones #137');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(138,138,'indicaciones #138');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(139,139,'indicaciones #139');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(140,140,'indicaciones #140');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(141,141,'indicaciones #141');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(142,142,'indicaciones #142');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(143,143,'indicaciones #143');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(144,144,'indicaciones #144');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(145,145,'indicaciones #145');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(146,146,'indicaciones #146');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(147,147,'indicaciones #147');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(148,148,'indicaciones #148');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(149,149,'indicaciones #149');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(150,150,'indicaciones #150');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(151,151,'indicaciones #151');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(152,152,'indicaciones #152');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(153,153,'indicaciones #153');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(154,154,'indicaciones #154');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(155,155,'indicaciones #155');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(156,156,'indicaciones #156');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(157,157,'indicaciones #157');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(158,158,'indicaciones #158');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(159,159,'indicaciones #159');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(160,160,'indicaciones #160');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(161,161,'indicaciones #161');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(162,162,'indicaciones #162');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(163,163,'indicaciones #163');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(164,164,'indicaciones #164');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(165,165,'indicaciones #165');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(166,166,'indicaciones #166');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(167,167,'indicaciones #167');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(168,168,'indicaciones #168');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(169,169,'indicaciones #169');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(170,170,'indicaciones #170');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(171,171,'indicaciones #171');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(172,172,'indicaciones #172');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(173,173,'indicaciones #173');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(174,174,'indicaciones #174');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(175,175,'indicaciones #175');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(176,176,'indicaciones #176');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(177,177,'indicaciones #177');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(178,178,'indicaciones #178');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(179,179,'indicaciones #179');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(180,180,'indicaciones #180');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(181,181,'indicaciones #181');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(182,182,'indicaciones #182');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(183,183,'indicaciones #183');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(184,184,'indicaciones #184');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(185,185,'indicaciones #185');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(186,186,'indicaciones #186');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(187,187,'indicaciones #187');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(188,188,'indicaciones #188');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(189,189,'indicaciones #189');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(190,190,'indicaciones #190');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(191,191,'indicaciones #191');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(192,192,'indicaciones #192');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(193,193,'indicaciones #193');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(194,194,'indicaciones #194');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(195,195,'indicaciones #195');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(196,196,'indicaciones #196');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(197,197,'indicaciones #197');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(198,198,'indicaciones #198');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(199,199,'indicaciones #199');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(200,200,'indicaciones #200');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(201,201,'indicaciones #201');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(202,202,'indicaciones #202');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(203,203,'indicaciones #203');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(204,204,'indicaciones #204');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(205,205,'indicaciones #205');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(206,206,'indicaciones #206');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(207,207,'indicaciones #207');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(208,208,'indicaciones #208');
INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones)                                  VALUES(209,209,'indicaciones #209');