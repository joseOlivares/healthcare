/********************************************************************************************************* */
/******************************************direcciones******************************************************* */
/********************************************************************************************************* */

const express= require('express');
const router=express.Router();

const dbPool=require('../dbconn/db.js');//Importing database connection pool

const MESSAGES = require('../messages/messages.js');

//---- Usando JsonWebTokens----------------------------------------
const verifyToken=require('../tools/verify_token.js');//funcion de validacion de token



/*Obtiene las direcciones de un ciudad para obtenerlas se debe llamar de la siguiente manera /rest/api/ciudades/:idciudad/direcciones*/
router.get('/rest/api/ciudades/:idciudad/direcciones/',verifyToken,(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("SELECT * from hc_direccion \
                        WHERE hc_direccion.id_ciudad = ?", [req.params.idciudad],function(err, rows, fields) {
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
  
  
/**************Lista todas las direcciones que existen en la base de datos */
router.get('/rest/api/direcciones',verifyToken,(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("SELECT * from hc_direccion ", function(err, rows, fields) {
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
  
/*Obtiene una direccion por su id, Para obtenerlo se debe enviar el request /rest/api/direcciones/id de la direccion*/
router.get('/rest/api/direcciones/:iddireccion',verifyToken,(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("SELECT * from hc_direccion \
                        WHERE hc_direccion.id_direccion = ?", [req.params.iddireccion],function(err, rows, fields) {
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
  
  
/*Para borrar se debe enviar el request /rest/api/direcciones/id del ciudad*/
router.delete('/rest/api/direcciones/:iddireccion',verifyToken,(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("DELETE from hc_direccion WHERE id_direccion = ? ", [req.params.iddireccion], function(err, rows, fields) {
            if (!err){
                var insertedRows = rows.affectedRows;
                var resultMessage = "";
                if(insertedRows==0)
                    resultMessage = MESSAGES.delete_row_does_not_exist;
                else
                    resultMessage = MESSAGES.delete_row_successfull;
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
Agregar nueva direccion
Para llamarlo se debe enviar en el postman el siguiente body
{
"nombre_direccion":"Miami",
"id_ciudad":1
}

Donde  nombre_direccion es el nombre de la direccion y id_ciudad es el id de ciudad
*/

router.post('/rest/api/direcciones',verifyToken,(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        let emp = req.body;
        var sql = "INSERT INTO hc_direccion(nombre_direccion, id_ciudad) VALUES(?,?)";
        connection.query(sql, [emp.nombre_direccion, emp.id_ciudad], function(err, rows, fields) {
            if (!err){
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
  
  
/*Para llamarlo se debe enviar en el postman el siguiente body
{
"id_direccion":2,
"nombre_direccion":"Miami"
}

Donde id_direccion es el id de la direccion y nombre_direccion es el nuevo nombre de la direccion*/

router.put('/rest/api/direcciones',verifyToken,(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        let emp = req.body;
        var sql = "update hc_direccion set nombre_direccion = ? \
                    WHERE id_direccion = ?;";
        connection.query(sql, [emp.nombre_direccion, emp.id_direccion], function(err, rows, fields) {
            if (!err){
                var insertedRows = rows.affectedRows;
                var resultMessage = "";
                if(insertedRows==0)
                    resultMessage = MESSAGES.update_row_id_does_not_exist;
                else
                    resultMessage = MESSAGES.update_row_successfull;
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