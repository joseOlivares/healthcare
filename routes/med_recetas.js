
/********************************************************************************************************* */
/******************************************med-recetas******************************************************* */
/********************************************************************************************************* */


const express= require('express');
const router=express.Router();

const dbPool=require('../dbconn/db.js');//Importing database connection pool

const MESSAGES = require('../messages/messages.js');


/*Obtiene las med-recetas de una receta para obtenerlas se debe llamar de la siguiente manera /rest/api/recetas/:idreceta/med-recetas*/
router.get('/rest/api/recetas/:idreceta/med-recetas/',(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("SELECT * from hc_med_recetas \
                        WHERE hc_med_recetas.id_receta = ?", [req.params.idreceta],function(err, rows, fields) {
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
  
  
/**************Lista todas las med-recetas que existen en la base de datos */
router.get('/rest/api/med-recetas',(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("SELECT * from hc_med_recetas", function(err, rows, fields) {
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
  
/*Obtiene una receta por su id, Para obtenerlo se debe enviar el request /rest/api/med-recetas/id de la receta*/
router.get('/rest/api/med-recetas/:idmedreceta',(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("SELECT * from hc_med_recetas \
                        WHERE hc_med_recetas.id_med_receta = ?", [req.params.idmedreceta],function(err, rows, fields) {
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
  
  
  
/*Para borrar se debe enviar el request /rest/api/med-recetas/id del med-receta*/
router.delete('/rest/api/med-recetas/:idmedreceta',(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("DELETE from hc_med_recetas WHERE id_med_receta = ? ", [req.params.idmedreceta], function(err, rows, fields) {
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
Agregar nueva med-receta
Para llamarlo se debe enviar en el postman el siguiente body
{
"id_receta":1,
"id_medicamento":1,
"indicaciones":"Indicaciones largo 500"
}

Donde  
indicaciones es las indicaciones para tomar el medicamento
id_receta = el id de la receta
id_medicamento = el id del medicamento
*/
  
router.post('/rest/api/med-recetas',(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        let emp = req.body;
        var sql = "INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones) VALUES(?,?)";
        connection.query(sql, [emp.id_id_receta, emp.id_medicamento, emp.indicaciones], function(err, rows, fields) {
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
"id_med_receta":1,
"id_receta":1,
"id_medicamento":1,
"indicaciones":"Indicaciones largo 500"
}

Donde  
indicaciones es las indicaciones para tomar el medicamento
id_receta = el id de la receta
id_medicamento = el id del medicamento

Donde id_receta es el id de la receta y nombre_receta es el nuevo nombre de la receta*/

router.put('/rest/api/med-recetas',(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        let emp = req.body;
        var sql = "update hc_med-recetas set id_receta= ?, id_medicamento = ?, indicaciones =?\
                WHERE id_med_receta = ?;";
        connection.query(sql, [emp.id_id_receta, emp.id_medicamento, emp.indicaciones, emp.id_med_receta], function(err, rows, fields) {
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