/********************************************************************************************************* */
/******************************************DEPARTAMENTOS******************************************************* */
/********************************************************************************************************* */


const express= require('express');
const router=express.Router();

const dbPool=require('../dbconn/db.js');//Importing database connection pool

const MESSAGES = require('../messages/messages.js');


/*Obtiene las departamentos de un pais para obtenerlas se debe llamar de la siguiente manera /rest/api/paises/:idpais/departamentos*/
router.get('/rest/api/paises/:idpais/departamentos/',(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("SELECT * from hc_departamento \
                        WHERE hc_departamento.id_pais = ?", [req.params.idpais],function(err, rows, fields) {
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
  
  
/**************Lista todas las departamentos que existen en la base de datos, */
router.get('/rest/api/departamentos',(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("SELECT * from hc_departamento", function(err, rows, fields) {
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
  
/*Obtiene una departamento por su id, Para obtenerlo se debe enviar el request /rest/api/departamentos/id de la departamento*/
router.get('/rest/api/departamentos/:iddepartamento',(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("SELECT * from hc_departamento \
                        WHERE hc_departamento.id_departamento = ?", [req.params.iddepartamento],function(err, rows, fields) {
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
  
  
  /*Para borrar se debe enviar el request /rest/api/departamentos/id del pais*/
router.delete('/rest/api/departamentos/:iddepartamento',(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("DELETE from hc_departamento WHERE id_departamento = ? ", [req.params.iddepartamento], function(err, rows, fields) {
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
Agregar nueva departamento
Para llamarlo se debe enviar en el postman el siguiente body
{
"nombre_departamento":"Miami",
"id_pais":1
}

Donde  nombre_departamento es el nombre de la departamento y id_pais es el id de pais
*/
  
router.post('/rest/api/departamentos',(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        let emp = req.body;
        var sql = "INSERT INTO hc_departamento(nombre_departamento, id_pais) VALUES(?,?)";
        connection.query(sql, [emp.nombre_departamento, emp.id_pais], function(err, rows, fields) {
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
"id_departamento":2,
"nombre_departamento":"Miami"
}

Donde id_departamento es el id de la departamento y nombre_departamento es el nuevo nombre de la departamento*/

router.put('/rest/api/departamentos',(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        let emp = req.body;
        var sql = "update hc_departamento set nombre_departamento = ? \
                WHERE id_departamento = ?;";
        connection.query(sql, [emp.nombre_departamento, emp.id_departamento], function(err, rows, fields) {
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