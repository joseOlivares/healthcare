
/********************************************************************************************************* */
/******************************************  diagnosticos  ****************************************************** */
/********************************************************************************************************* */



const express= require('express');
const router=express.Router();

const dbPool=require('../dbconn/db.js');//Importing database connection pool

const MESSAGES = require('../messages/messages.js');

//---- Usando JsonWebTokens----------------------------------------
const verifyToken=require('../tools/verify_token.js');//funcion de validacion de token


/**************Lista todas las diagnosticos que existen en la base de datos */
router.get('/rest/api/diagnosticos',verifyToken,(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("SELECT * FROM hc_diagnosticos", function(err, rows, fields) {
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
  
/*Obtiene una diagnostico por su id, Para obtenerlo se debe enviar el request /rest/api/diagnosticos/id de la diagnostico*/
router.get('/rest/api/diagnosticos/:iddiagnostico',verifyToken,(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("SELECT * FROM hc_diagnosticos WHERE hc_diagnosticos.id_diagnostico = ?", [req.params.iddiagnostico],function(err, rows, fields) {
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


/**** Obtiene las diagnosticos filtrando tanto por idmedico como iddiagnostico 
 * 
 * Para que no se tome en cuentra un parametro en la busqueda se debe ingresar * en el id
 * 
 * 
 * De la siguiente manera /rest/api/diagnosticos/* /idmedico/* /idpaciente/2
 * 
 *
 * 
 *********************************************/
router.get('/rest/api/diagnosticos/*/idmedico/:idmedico/idpaciente/:idpaciente',verifyToken,(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        let idPaciente = req.params.idpaciente;
        let idMedico = req.params.idmedico;
        let sql = "";
        if(idPaciente =="*" && idMedico =="*")
            sql = "SELECT * FROM hc_diagnosticos";
        else if(idPaciente=="*")
            sql = "SELECT * FROM hc_diagnosticos WHERE hc_diagnosticos.id_medico = idMedico";
        else if(idMedico =="*")
            sql = "SELECT * FROM hc_diagnosticos WHERE hc_diagnosticos.id_paciente = idPaciente";
        else
            sql = "SELECT * FROM hc_diagnosticos WHERE hc_diagnosticos.id_medico = idMedico and hc_diagnosticos.id_paciente = idPaciente"
        connection.query("SELECT * FROM hc_diagnosticos", function(err, rows, fields)  {
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
  
/*Para borrar se debe enviar el request /rest/api/diagnosticos/id del diagnostico*/
router.delete('/rest/api/diagnosticos/:iddiagnostico',verifyToken,(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("DELETE from hc_diagnosticos WHERE id_diagnostico = ? ", [req.params.iddiagnostico], function(err, rows, fields) {
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
Agregar nueva diagnostico
Para llamarlo se debe enviar en el postman el siguiente body
{
    "id_paciente":1,
    "id_medico":1,
    "titulo":"Titulo",
    "descripcion":"Descripcion",
    "fecha":"22041992"
}
Donde:
id_paciente     = Id de la tabla pacientes
id_medico       = Id de la tabla medicos
titulo          = Titulo de la diagnostico
descripcion     = Descipcion de la diagnostico
fecha           = fecha de la diagnostico
*/

router.post('/rest/api/diagnosticos',verifyToken,(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        let emp = req.body;
        var sql = "INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico) VALUES (?,?,?,?,?,?)";
        connection.query(sql, 
                        [emp.id_titulo, emp.descripcion, emp.fecha,emp.id_paciente, emp.id_medico], 
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
Actualizar diagnostico
Para llamarlo se debe enviar en el postman el siguiente body
{
    "id_diagnostico"
    "id_paciente":1,
    "id_medico":1,
    "titulo":"Titulo",
    "descripcion":"Descripcion",
    "fecha":"22041992"
}
Donde:
id_diagnostico  = Id de la diagnostico a actualizar
id_paciente     = Id de la tabla pacientes
id_medico       = Id de la tabla medicos
titulo          = Titulo de la diagnostico
descripcion     = Descipcion de la diagnostico
fecha           = fecha de la diagnostico
*/

router.put('/rest/api/diagnosticos',verifyToken,(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        let emp = req.body;
        var sql = "update hc_diagnosticos set id_paciente = ?, id_medico = ?, titulo = ?, descripcion = ?, fecha = ?\
        WHERE hc_diagnosticos.id_diagnostico = ?";
        connection.query(sql, 
                        [emp.id_paciente, emp.id_medico,emp.titulo, emp.descripcion,
                        emp.fecha,id_diagnostico],
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