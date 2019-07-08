
/********************************************************************************************************* */
/******************************************medicos******************************************************* */
/********************************************************************************************************* */


const express= require('express');
const router=express.Router();

const dbPool=require('../dbconn/db.js');//Importing database connection pool

const MESSAGES = require('../messages/messages.js');


/**************Lista todas las medicos que existen en la base de datos */
router.get('/rest/api/medicos',(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("SELECT * FROM hc_medicos", function(err, rows, fields) {
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
  
/*Obtiene una medico por su id, Para obtenerlo se debe enviar el request /rest/api/medicos/id de la medico*/
router.get('/rest/api/medicos/:idmedico',(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("SELECT * FROM hc_medicos WHERE id_medico = ?", [req.params.idmedico],function(err, rows, fields) {
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
  
  
/*Para borrar se debe enviar el request /rest/api/medicos/id del medico*/
router.delete('/rest/api/medicos/:idmedico',(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("DELETE from hc_medicos WHERE id_medico = ? ", [req.params.idmedico], function(err, rows, fields) {
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
Agregar nuevo medico
Para llamarlo se debe enviar en el postman el siguiente body
{
    "id_usuario":1,
    "identicacion_medica":1
}
Donde:
id_usuario = Id de la tabla usuarios
identificacion_medica = Identificacion medica del medico
*/

router.post('/rest/api/medicos',(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        let emp = req.body;
        var sql = "INSERT INTO hc_medicos(id_usuario, identificacion_medica) VALUES(?,?)";
        connection.query(sql, 
                        [emp.id_usuario, emp.identificacion_medica], 
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
Actualizar medico
Para llamarlo se debe enviar en el postman el siguiente body
{
    "id_medico":1,
    "id_usuario":1,
    "identicacion_medica":1
}
Donde:
id_usuario = Id de la tabla usuarios
identificacion_medica = Identificacion medica del medico
*/

router.put('/rest/api/medicos',(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        let emp = req.body;
        var sql = "update hc_medicos set id_usuario = ?, identificacion_medica = ? \
        WHERE id_medico = ?";
        connection.query(sql, 
                        [emp.id_usuario, emp.identificacion_medica,emp.id_medico],
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