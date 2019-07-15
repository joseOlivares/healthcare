
/********************************************************************************************************* */
/******************************************  sexo  ****************************************************** */
/********************************************************************************************************* */


const express= require('express');
const router=express.Router();

const dbPool=require('../dbconn/db.js');//Importing database connection pool

const MESSAGES = require('../messages/messages.js');

//---- Usando JsonWebTokens----------------------------------------
const verifyToken=require('../tools/verify_token.js');//funcion de validacion de token



/**************Lista todas las sexo que existen en la base de datos */
router.get('/rest/api/sexos',verifyToken,(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("SELECT * FROM hc_sexo", function(err, rows, fields) {
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
  
/*Obtiene una sexo por su id, Para obtenerlo se debe enviar el request /rest/api/sexos/id de la sexo*/
router.get('/rest/api/sexos/:idsexo',verifyToken,(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("SELECT * FROM hc_sexo WHERE hc_sexo.id_sexo = ?", [req.params.idsexo],function(err, rows, fields) {
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

  
/*Para borrar se debe enviar el request /rest/api/sexos/id del sexo*/
router.delete('/rest/api/sexos/:idsexo',verifyToken,(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("DELETE from hc_sexo WHERE id_sexo = ? ", [req.params.idsexo], function(err, rows, fields) {
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
Agregar nuevo sexo
Para llamarlo se debe enviar en el postman el siguiente body
{
    "nombre_sexo":"Nombre"
}
Donde:
nombre_sexo = Nombre del estado civil
*/

router.post('/rest/api/sexos',verifyToken,(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        let emp = req.body;
        var sql = "INSERT INTO  hc_sexo(nombre_sexo) VALUES (?)";
        connection.query(sql, 
                        [emp.nombre_sexo], 
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
Actualizar sexo
Para llamarlo se debe enviar en el postman el siguiente body
{
    "id_sexo":1,
    "nombre_sexo":"Nombre"
}
Donde:
id_sexo         = Id de la sexo a actualizar
nombre_sexo     = Nombre del estado civil
*/

router.put('/rest/api/sexos',verifyToken,(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        let emp = req.body;
        var sql = "update hc_sexo set nombre_sexo = ? \
        WHERE hc_sexo.id_sexo = ?";
        connection.query(sql, 
                        [emp.nombre_sexo,emp.id_sexo],
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