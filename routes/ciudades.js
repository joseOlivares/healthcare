
/********************************************************************************************************* */
/******************************************CIUDADES******************************************************* */
/********************************************************************************************************* */


const express= require('express');
const router=express.Router();

const dbPool=require('../dbconn/db.js');//Importing database connection pool

const MESSAGES = require('../messages/messages.js');

//---- Usando JsonWebTokens----------------------------------------
const verifyToken=require('../tools/verify_token.js');//funcion de validacion de token



/*Obtiene las ciudades de un departamento para obtenerlas se debe llamar de la siguiente manera /rest/api/departamentos/:iddepartamento/ciudades*/
router.get('/rest/api/departamentos/:iddepartamento/ciudades/',verifyToken,(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("SELECT * from hc_ciudad \
                        WHERE hc_ciudad.id_departamento = ?", [req.params.iddepartamento],function(err, rows, fields) {
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
  
  
/**************Lista todas las ciudades que existen en la base de datos */
router.get('/rest/api/ciudades',verifyToken,(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("SELECT * from hc_ciudad", function(err, rows, fields) {
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
  
/*Obtiene una ciudad por su id, Para obtenerlo se debe enviar el request /rest/api/ciudades/id de la ciudad*/
router.get('/rest/api/ciudades/:idciudad',verifyToken,(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("SELECT * from hc_ciudad \
                        WHERE hc_ciudad.id_ciudad = ?", [req.params.idciudad],function(err, rows, fields) {
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
  
  
/*Para borrar se debe enviar el request /rest/api/ciudades/id del departamento*/
router.delete('/rest/api/ciudades/:idciudad',verifyToken,(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("DELETE from hc_ciudad WHERE id_ciudad = ? ", [req.params.idciudad], function(err, rows, fields) {
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
Agregar nueva ciudad
Para llamarlo se debe enviar en el postman el siguiente body
{
"nombre_ciudad":"Miami",
"id_departamento":1
}

Donde  nombre_ciudad es el nombre de la ciudad y id_departamento es el id de departamento
*/
  
router.post('/rest/api/ciudades',verifyToken,(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        let emp = req.body;
        var sql = "INSERT INTO hc_ciudad(nombre_ciudad, id_departamento) VALUES(?,?)";
        connection.query(sql, [emp.nombre_ciudad, emp.id_departamento], function(err, rows, fields) {
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
"id_ciudad":2,
"nombre_ciudad":"Miami"
}

Donde id_ciudad es el id de la ciudad y nombre_ciudad es el nuevo nombre de la ciudad*/

router.put('/rest/api/ciudades',verifyToken,(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        let emp = req.body;
        var sql = "update hc_ciudad set nombre_ciudad = ? \
                WHERE id_ciudad = ?;";
        connection.query(sql, [emp.nombre_ciudad, emp.id_ciudad], function(err, rows, fields) {
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