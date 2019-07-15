
/********************************************************************************************************* */
/******************************************recetas******************************************************* */
/********************************************************************************************************* */


const express= require('express');
const router=express.Router();

const dbPool=require('../dbconn/db.js');//Importing database connection pool

const MESSAGES = require('../messages/messages.js');

//---- Usando JsonWebTokens----------------------------------------
const verifyToken=require('../tools/verify_token.js');//funcion de validacion de token



/*Obtiene las recetas de un diagnostico para obtenerlas se debe llamar de la siguiente manera /rest/api/diagnosticos/:iddiagnostico/recetas*/
router.get('/rest/api/diagnosticos/:iddiagnostico/recetas/',verifyToken,(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("SELECT * from hc_recetas \
                        WHERE hc_receta.id_diagnostico = ?", [req.params.iddiagnostico],function(err, rows, fields) {
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
  
  
/**************Lista todas las recetas que existen en la base de datos */
router.get('/rest/api/recetas',verifyToken,(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("SELECT * from hc_recetas", function(err, rows, fields) {
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
  
/*Obtiene una receta por su id, Para obtenerlo se debe enviar el request /rest/api/recetas/id de la receta*/
router.get('/rest/api/recetas/:idreceta',verifyToken,(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("SELECT * from hc_recetas \
                        WHERE hc_receta.id_receta = ?", [req.params.idreceta],function(err, rows, fields) {
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
  
  
  
/*Para borrar se debe enviar el request /rest/api/recetas/id del diagnostico*/
router.delete('/rest/api/recetas/:idreceta',verifyToken,(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("DELETE from hc_recetas WHERE id_receta = ? ", [req.params.idreceta], function(err, rows, fields) {
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
Agregar nueva receta
Para llamarlo se debe enviar en el postman el siguiente body
{
"fecha_emision":"fecha",
"id_diagnostico":1
}

Donde  nombre_receta es el nombre de la receta y id_diagnostico es el id de diagnostico
*/
  
router.post('/rest/api/recetas',verifyToken,(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        let emp = req.body;
        var sql = "INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES(?,?)";
        connection.query(sql, [emp.id_diagnostico, emp.fecha_emision], function(err, rows, fields) {
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
"fecha_emision":"fecha",
"id_diagnostico":1,
"id_receta":1
}

Donde id_receta es el id de la receta y nombre_receta es el nuevo nombre de la receta*/

router.put('/rest/api/recetas',verifyToken,(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        let emp = req.body;
        var sql = "update hc_recetas set id_diagnostico = ?, fecha_emision = ? \
                WHERE id_receta = ?;";
        connection.query(sql, [emp.id_diagnostico, emp.fecha_emision, emp.id_receta], function(err, rows, fields) {
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