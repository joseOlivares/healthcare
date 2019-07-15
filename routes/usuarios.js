
/********************************************************************************************************* */
/******************************************usuarios******************************************************* */
/********************************************************************************************************* */


const express= require('express');
const router=express.Router();

const dbPool=require('../dbconn/db.js');//Importing database connection pool

const MESSAGES = require('../messages/messages.js');

//---- Usando JsonWebTokens----------------------------------------
const verifyToken=require('../tools/verify_token.js');//funcion de validacion de token


/**************Lista todas las usuarios que existen en la base de datos */
router.get('/rest/api/usuarios',verifyToken,(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("CALL obtenerUsuarios() ", function(err, rows, fields) {
            if (!err)
                res.send(rows);
            else{
                var unexpectedError = MESSAGES.unexpected_error;
                unexpectedError.excepcion= err;
                res.send(unexpectedError);
            }
        });
        // release connection
        connection.release();
    });   
});
  
/*Obtiene una usuario por su id, Para obtenerlo se debe enviar el request /rest/api/usuarios/id de la usuario*/
router.get('/rest/api/usuarios/:idusuario',verifyToken,(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("CALL obtenerUsuario(?)", [req.params.idusuario],function(err, rows, fields) {
            if (!err)
                res.send(rows);
            else{
                var unexpectedError = MESSAGES.unexpected_error;
                unexpectedError.excepcion= err;
                res.send(unexpectedError);
            }
        });
        // release connection
        connection.release();
    });
});
  
  
/*Para borrar se debe enviar el request /rest/api/usuarios/id del usuario*/
router.delete('/rest/api/usuarios/:idusuario',verifyToken,(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("DELETE from hc_usuarios WHERE id_usuarios = ? ", [req.params.idusuario], function(err, rows, fields) {
            if (!err){
                var insertedRows = rows.affectedRows;
                var resultMessage = "";
                if(insertedRows==0){
                    resultMessage = MESSAGES.delete_row_does_not_exist;
                    resultMessage.data = rows;
                }
                else{
                    resultMessage = MESSAGES.delete_row_successfull;
                    resultMessage.data = rows;
                }
                res.send(resultMessage);
            }
            else{
                var unexpectedError = MESSAGES.unexpected_error;
                unexpectedError.excepcion= err;
                res.send(unexpectedError);
            }
        });
        // release connection
        connection.release();
    });
});
  
  
  
/*
Agregar nuevo usuario
Para llamarlo se debe enviar en el postman el siguiente body
{
    "nombres":"dato",
    "status":"dato",
    "apellidos":"dato",
    "correo":"dato",
    "password":"dato",
    "id_tipo_documento":1,
    "numero_documento":"dato",
    "id_sexo":1,
    "id_estado_civil":1,
    "fecha_nacimiento":"dato",
    "profesion":"dato",
    "conyugue":"dato",
    "tel_casa":"dato",
    "celular":"dato",
"lugar_trabajo":"dato",
"direccion":"dato",
    "id_ciudad":1
}
Donde:
nombres           = Nombres del usuario
status            = Status del usuario
apellidos         = Apellidos del usuario
correo            = Correo del usuario
password          = Password del usuario
id_tipo_documento = Id de tabla con el tipo documento de identificacion del usuario
numero_documento  = Numero de documento de identificacion del usuario
id_sexo           = Id de la tabla con el sexo de usuario
id_estado_civil   = Id de la tabla con el estado civil del usuario
fecha_nacimiento  = Fecha de nacimiento del usuario
profesion         = Profesion del usuario
conyugue          = Nombre del conyugue del usuario
tel_casa          = Numero de telefono de la casa del usuario
celular           = Numero de telefono del celular del usuario
lugar_trabajo     = Lugar de trabajo del usuario
direccion         = Direccion del usuario
id_ciudad         = Id de la tabla ciudad donde vive el usuario
*/

router.post('/rest/api/usuarios',verifyToken,(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        let emp = req.body;
        var sql = "CALL crearUsuario(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        connection.query(sql, 
                        [emp.nombres,emp.status,emp.apellidos,emp.correo,
                        emp.password,emp.id_tipo_documento,emp.numero_documento,
                        emp.id_sexo,emp.id_estado_civil,emp.fecha_nacimiento,
                        emp.profesion,emp.conyugue,emp.tel_casa,emp.celular,
                        emp.lugar_trabajo,emp.direccion,emp.id_ciudad], 
                        function(err, rows, fields) {
            if (!err){
                let resultMessage = MESSAGES.insert_row_successfull;
                resultMessage.data = rows;
                res.send(MESSAGES.insert_row_successfull);
            }
            else{
                var unexpectedError = MESSAGES.unexpected_error;
                unexpectedError.excepcion= err;
                res.send(unexpectedError);
            }
        });
        // release connection
        connection.release();
    });
});
  
  
/*
Actualizar usuario
Para llamarlo se debe enviar en el postman el siguiente body
{
"id_usuario":1,
    "nombres":"dato",
    "status":"dato",
    "apellidos":"dato",
    "correo":"dato",
    "password":"dato",
    "id_tipo_documento":1,
    "numero_documento":"dato",
    "id_sexo":1,
    "id_estado_civil":1,
    "fecha_nacimiento":"dato",
    "profesion":"dato",
    "conyugue":"dato",
    "tel_casa":"dato",
    "celular":"dato",
"lugar_trabajo":"dato",
"direccion":"dato",
    "id_ciudad":1
}
Donde:
id_usuario        = id de la tabla del usuario
nombres           = Nombres del usuario
status            = Status del usuario
apellidos         = Apellidos del usuario
correo            = Correo del usuario
password          = Password del usuario
id_tipo_documento = Id de tabla con el tipo documento de identificacion del usuario
numero_documento  = Numero de documento de identificacion del usuario
id_sexo           = Id de la tabla con el sexo de usuario
id_estado_civil   = Id de la tabla con el estado civil del usuario
fecha_nacimiento  = Fecha de nacimiento del usuario
profesion         = Profesion del usuario
conyugue          = Nombre del conyugue del usuario
tel_casa          = Numero de telefono de la casa del usuario
celular           = Numero de telefono del celular del usuario
lugar_trabajo     = Lugar de trabajo del usuario
direccion         = Direccion del usuario
id_ciudad         = Id de la tabla ciudad donde vive el usuario
*/

router.put('/rest/api/usuarios',verifyToken,(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        let emp = req.body;
        var sql = "CALL actualizarUsuario(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        connection.query(sql, 
                        [emp.id_usuario,
                        emp.nombres,emp.status,emp.apellidos,emp.correo,
                        emp.password,emp.id_tipo_documento,emp.numero_documento,
                        emp.id_sexo,emp.id_estado_civil,emp.fecha_nacimiento,
                        emp.profesion,emp.conyugue,emp.tel_casa,emp.celular,
                        emp.lugar_trabajo,emp.direccion,emp.id_ciudad],
                        function(err, rows, fields) {
            if (!err){
                var updatedRows = rows.affectedRows;
                var resultMessage = "";
                if(updatedRows==0){
                    resultMessage = MESSAGES.update_row_id_does_not_exist;
                    resultMessage.data = rows;
                }
                else{
                    resultMessage = MESSAGES.update_row_successfull;
                    resultMessage.data = rows;
                }
                res.send(resultMessage);
            }
            else{
                var unexpectedError = MESSAGES.unexpected_error;
                unexpectedError.excepcion= err;
                res.send(unexpectedError);
            }
        });
        // release connection
        connection.release();
    });
});
  
module.exports=router;