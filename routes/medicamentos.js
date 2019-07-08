
/********************************************************************************************************* */
/******************************************  medicamentos  ****************************************************** */
/********************************************************************************************************* */


const express= require('express');
const router=express.Router();

const dbPool=require('../dbconn/db.js');//Importing database connection pool

const MESSAGES = require('../messages/messages.js');


/**************Lista todas las medicamentos que existen en la base de datos */
router.get('/rest/api/medicamentos',(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("SELECT * FROM hc_medicamentos", function(err, rows, fields) {
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
  
/*Obtiene una medicamento por su id, Para obtenerlo se debe enviar el request /rest/api/medicamentos/id de la medicamento*/
router.get('/rest/api/medicamentos/:idmedicamento',(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("SELECT * FROM hc_medicamentos WHERE hc_medicamento.id_medicamento = ?", [req.params.idmedicamento],function(err, rows, fields) {
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

  
/*Para borrar se debe enviar el request /rest/api/medicamentos/id del medicamento*/
router.delete('/rest/api/medicamentos/:idmedicamento',(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("DELETE from hc_medicamentos WHERE id_medicamento = ? ", [req.params.idmedicamento], function(err, rows, fields) {
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
Agregar nuevo medicamento
Para llamarlo se debe enviar en el postman el siguiente body
{
    "nombre_medicamento":"Nombre"
}
Donde:
nombre_medicamento = Nombre del estado civil
*/

router.post('/rest/api/medicamentos',(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        let emp = req.body;
        var sql = "INSERT INTO  hc_medicamentos(nombre_medicamento) VALUES (?)";
        connection.query(sql, 
                        [emp.nombre_medicamento], 
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
Actualizar medicamento
Para llamarlo se debe enviar en el postman el siguiente body
{
    "id_medicamento":1,
    "nombre_medicamento":"Nombre"
}
Donde:
id_medicamento         = Id de la medicamento a actualizar
nombre_medicamento     = Nombre del estado civil
*/

router.put('/rest/api/medicamentos',(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        let emp = req.body;
        var sql = "update hc_medicamentos set nombre_medicamento = ? \
        WHERE hc_medicamento.id_medicamento = ?";
        connection.query(sql, 
                        [emp.nombre_medicamento,emp.id_medicamento],
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