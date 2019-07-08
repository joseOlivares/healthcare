
/********************************************************************************************************* */
/******************************************  estados_civiles  ****************************************************** */
/********************************************************************************************************* */


const express= require('express');
const router=express.Router();

const dbPool=require('../dbconn/db.js');//Importing database connection pool

const MESSAGES = require('../messages/messages.js');


/**************Lista todas las estados_civiles que existen en la base de datos */
router.get('/rest/api/estados-civiles',(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("SELECT * FROM hc_estado_civil", function(err, rows, fields) {
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
  
/*Obtiene una estado_civil por su id, Para obtenerlo se debe enviar el request /rest/api/estados_civiles/id de la estado_civil*/
router.get('/rest/api/estados-civiles/:idestado_civil',(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("SELECT * FROM hc_estado_civil WHERE hc_estado_civil.id_estado_civil = ?", [req.params.idestado_civil],function(err, rows, fields) {
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

  
/*Para borrar se debe enviar el request /rest/api/estados_civiles/id del estado_civil*/
router.delete('/rest/api/estados-civiles/:idestado_civil',(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("DELETE from hc_estado_civil WHERE id_estado_civil = ? ", [req.params.idestado_civil], function(err, rows, fields) {
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
Agregar nuevo estado_civil
Para llamarlo se debe enviar en el postman el siguiente body
{
    "nombre_estado_civil":"Nombre"
}
Donde:
nombre_estado_civil = Nombre del estado civil
*/

router.post('/rest/api/estados-civiles',(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        let emp = req.body;
        var sql = "INSERT INTO  hc_estado_civil(nombre_estado_civil) VALUES (?)";
        connection.query(sql, 
                        [emp.nombre_estado_civil], 
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
Actualizar estado_civil
Para llamarlo se debe enviar en el postman el siguiente body
{
    "id_estado_civil":1,
    "nombre_estado_civil":"Nombre"
}
Donde:
id_estado_civil         = Id de la estado_civil a actualizar
nombre_estado_civil     = Nombre del estado civil
*/

router.put('/rest/api/estados-civiles',(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        let emp = req.body;
        var sql = "update hc_estado_civil set nombre_estado_civil = ? \
        WHERE hc_estado_civil.id_estado_civil = ?";
        connection.query(sql, 
                        [emp.nombre_estado_civil,emp.id_estado_civil],
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