
/********************************************************************************************************* */
/******************************************  parentezco  ****************************************************** */
/********************************************************************************************************* */


const express= require('express');
const router=express.Router();

const dbPool=require('../dbconn/db.js');//Importing database connection pool

const MESSAGES = require('../messages/messages.js');


/**************Lista todas las parentezco que existen en la base de datos */
router.get('/rest/api/parentezcos',(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("SELECT * FROM hc_parentezco", function(err, rows, fields) {
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
  
/*Obtiene una parentezco por su id, Para obtenerlo se debe enviar el request /rest/api/parentezcos/id de la parentezco*/
router.get('/rest/api/parentezcos/:idparentezco',(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("SELECT * FROM hc_parentezco WHERE hc_parentezco.id_parentezco = ?", [req.params.idparentezco],function(err, rows, fields) {
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

  
/*Para borrar se debe enviar el request /rest/api/parentezcos/id del parentezco*/
router.delete('/rest/api/parentezcos/:idparentezco',(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("DELETE from hc_parentezco WHERE id_parentezco = ? ", [req.params.idparentezco], function(err, rows, fields) {
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
Agregar nuevo parentezco
Para llamarlo se debe enviar en el postman el siguiente body
{
    "valor_parentezco":"Nombre"
}
Donde:
valor_parentezco = Nombre del parentezco
*/

router.post('/rest/api/parentezcos',(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        let emp = req.body;
        var sql = "INSERT INTO  hc_parentezco(valor_parentezco) VALUES (?)";
        connection.query(sql, 
                        [emp.valor_parentezco], 
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
Actualizar parentezco
Para llamarlo se debe enviar en el postman el siguiente body
{
    "id_parentezco":1,
    "valor_parentezco":"Nombre"
}
Donde:
id_parentezco         = Id de la parentezco a actualizar
valor_parentezco     = Nombre del parentezco
*/

router.put('/rest/api/parentezcos',(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        let emp = req.body;
        var sql = "update hc_parentezco set valor_parentezco = ? \
        WHERE hc_parentezco.id_parentezco = ?";
        connection.query(sql, 
                        [emp.valor_parentezco,emp.id_parentezco],
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