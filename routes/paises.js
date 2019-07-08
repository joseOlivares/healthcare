/********************************************************************************************************* */
/******************************************PAISES******************************************************* */
/********************************************************************************************************* */

const express= require('express');
const router=express.Router();

const dbPool=require('../dbconn/db.js');//Importing database connection pool

const MESSAGES = require('../messages/messages.js')//Importing global messages


/*Obtener la lista de todos los paises*/
router.get('/paises',(req, res)=>{
    dbPool.getConnection(function(err,connection) {
        connection.query("SELECT * from hc_pais", function(err, rows, fields) {
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

/*Obtiene un pais por su id, Para obtenerlo se debe enviar el request /paises/id del pais*/
router.get('/paises/:idpais',(req, res)=>{
    dbPool.getConnection(function(err,connection) {
        connection.query("SELECT * from hc_pais WHERE id_pais = ? ", [req.params.idpais], function(err, rows, fields) {
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


/*Para borrar se debe enviar el request /paises/id del pais*/
router.delete('/paises/:idpais',(req, res)=>{
    dbPool.getConnection(function(err,connection) {
        connection.query("DELETE from hc_pais WHERE id_pais = ? ", [req.params.idpais], function(err, rows, fields) {
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
Agregar nuevo país
Para llamarlo se debe enviar en el postman el siguiente body
{
	"nombre_pais":"United States"
}

Donde  NombrePais es el nombre del pais
*/

router.post('/paises',(req, res)=>{
    dbPool.getConnection(function(err,connection) {
        let emp = req.body;
        var sql = "INSERT INTO hc_pais(nombre_pais) VALUES(?)";
        connection.query(sql, [emp.nombre_pais], function(err, rows, fields) {
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
	"id_pais":2,
	"nombre_pais":"United States"
}

Donde Pais es el id del pais y NombrePais es el nuevo nombre*/

router.put('/paises',(req, res)=>{
    dbPool.getConnection(function(err,connection) {
        let emp = req.body;
        var sql = "update hc_pais set nombre_pais = ? \
                WHERE id_pais = ?;";
        connection.query(sql, [emp.nombre_pais, emp.id_pais], function(err, rows, fields) {
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