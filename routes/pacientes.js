
/********************************************************************************************************* */
/******************************************pacientes******************************************************* */
/********************************************************************************************************* */


const express= require('express');
const router=express.Router();

const dbPool=require('../dbconn/db.js');//Importing database connection pool

const MESSAGES = require('../messages/messages.js');

//---- Usando JsonWebTokens----------------------------------------
const verifyToken=require('../tools/verify_token.js');//funcion de validacion de token


/**************Lista todas las pacientes que existen en la base de datos */
router.get('/rest/api/pacientes',verifyToken,(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("call obtenerPacientes()", function(err, rows, fields) {
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
  
/*Obtiene una paciente por su id, Para obtenerlo se debe enviar el request /rest/api/pacientes/id de la paciente*/
router.get('/rest/api/pacientes/:idpaciente',verifyToken,(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("call obtenerPaciente(?)", [req.params.idpaciente],function(err, rows, fields) {
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
  
  
/*Para borrar se debe enviar el request /rest/api/pacientes/id del paciente*/
router.delete('/rest/api/pacientes/:idpaciente',verifyToken,(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("DELETE from hc_pacientes WHERE id_paciente = ? ", [req.params.idpaciente], function(err, rows, fields) {
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
Agregar nuevo paciente
Para llamarlo se debe enviar en el postman el siguiente body
{
    "id_usuario":1,
    "num_expediente":"1234",
    "nombre_contacto":"Nombre",
    "apellido_contacto":"apellido",
    "telefono_1":"12345678",
    "telefono_2":"12343434",
    "id_parentezco":1
}
Donde:
id_usuario = Id de la tabla usuarios
num_expediente = numero del expediente del paciente
nombre_contacto = Nombre del contacto del paciente
apellido_contacto = Apellido del contacto del paciente
telefono_1 = Telefono principal del contacto
telefono_2 = Telefono secundario del contacto
id_parentezco = Id de la tabla parentezco 
*/

router.post('/rest/api/pacientes',verifyToken,(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        let emp = req.body;
        var sql = "CALL crearPaciente(?,?,?,?,?,?,?)";
        connection.query(sql, 
                        [emp.id_usuario, emp.num_expediente, emp.nombre_contacto, emp.apellido_contanto,
                        emp.telefono1, emp.telefono2, emp.id_parentezco], 
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
Actualizar paciente
Para llamarlo se debe enviar en el postman el siguiente body
{
    "id_paciente":1,
    "id_usuario":1,
    "identicacion_medica":1
}
Donde:
id_usuario = Id de la tabla usuarios
identificacion_medica = Identificacion medica del paciente
*/

router.put('/rest/api/pacientes',verifyToken,(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        let emp = req.body;
        var sql = "update hc_pacientes set id_usuario = ?, identificacion_medica = ? \
        WHERE id_paciente = ?";
        connection.query(sql, 
                        [emp.id_usuario, emp.identificacion_medica,emp.id_paciente],
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