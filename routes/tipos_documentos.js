
/********************************************************************************************************* */
/******************************************  tipo_documento  ****************************************************** */
/********************************************************************************************************* */


const express= require('express');
const router=express.Router();

const dbPool=require('../dbconn/db.js');//Importing database connection pool

const MESSAGES = require('../messages/messages.js');


/**************Lista todas las tipo_documento que existen en la base de datos */
router.get('/rest/api/tipos-documentos',(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("SELECT * FROM hc_tipo_documento", function(err, rows, fields) {
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
  
/*Obtiene una tipo_documento por su id, Para obtenerlo se debe enviar el request /rest/api/tipos-documentos/id de la tipo_documento*/
router.get('/rest/api/tipos-documentos/:idtipo_documento',(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("SELECT * FROM hc_tipo_documento WHERE hc_tipo_documento.id_tipo_documento = ?", [req.params.idtipo_documento],function(err, rows, fields) {
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

  
/*Para borrar se debe enviar el request /rest/api/tipos-documentos/id del tipo_documento*/
router.delete('/rest/api/tipos-documentos/:idtipo_documento',(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("DELETE from hc_tipo_documento WHERE id_tipo_documento = ? ", [req.params.idtipo_documento], function(err, rows, fields) {
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
Agregar nuevo tipo_documento
Para llamarlo se debe enviar en el postman el siguiente body
{
    "nombre_documento":"Nombre"
}
Donde:
nombre_documento = Nombre del estado civil
*/

router.post('/rest/api/tipos-documentos',(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        let emp = req.body;
        var sql = "INSERT INTO  hc_tipo_documento(nombre_documento) VALUES (?)";
        connection.query(sql, 
                        [emp.nombre_documento], 
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
Actualizar tipo_documento
Para llamarlo se debe enviar en el postman el siguiente body
{
    "id_tipo_documento":1,
    "nombre_documento":"Nombre"
}
Donde:
id_tipo_documento         = Id de la tipo_documento a actualizar
nombre_tipo_documento     = Nombre del estado civil
*/

router.put('/rest/api/tipos-documentos',(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        let emp = req.body;
        var sql = "update hc_tipo_documento set nombre_documento = ? \
        WHERE hc_tipo_documento.id_tipo_documento = ?";
        connection.query(sql, 
                        [emp.nombre_tipo_documento,emp.id_tipo_documento],
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