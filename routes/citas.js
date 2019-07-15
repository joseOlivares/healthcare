
/********************************************************************************************************* */
/******************************************  CITAS  ****************************************************** */
/********************************************************************************************************* */


const express= require('express');
const router=express.Router();

const dbPool=require('../dbconn/db.js');//Importing database connection pool

const MESSAGES = require('../messages/messages.js');

//---- Usando JsonWebTokens----------------------------------------
const verifyToken=require('../tools/verify_token.js');//funcion de validacion de token



/**************Lista todas las citas que existen en la base de datos */
router.get('/rest/api/citas',verifyToken,(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("SELECT * FROM hc_citas", function(err, rows, fields) {
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
  
/*Obtiene una cita por su id, Para obtenerlo se debe enviar el request /rest/api/citas/id de la cita*/
router.get('/rest/api/citas/:idcita',verifyToken,(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("SELECT * FROM hc_citas WHERE hc_citas.id_cita = ?", [req.params.idcita],function(err, rows, fields) {
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


/**** Obtiene las citas filtrando tanto por idmedico como idcita 
 * 
 * Para que no se tome en cuentra un parametro en la busqueda se debe ingresar * en el id
 * 
 * 
 * De la siguiente manera /rest/api/citas/* /idmedico/* /idpaciente/2
 * 
 *
 * 
 *********************************************/
router.get('/rest/api/citas/*/idmedico/:idmedico/idpaciente/:idpaciente',verifyToken,(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        let idPaciente = req.params.idpaciente;
        let idMedico = req.params.idmedico;
        let sql = "";
        if(idPaciente =="*" && idMedico =="*")
            sql = "SELECT * FROM hc_citas";
        else if(idPaciente=="*")
            sql = "SELECT * FROM hc_citas WHERE hc_citas.id_medico = idMedico";
        else if(idMedico =="*")
            sql = "SELECT * FROM hc_citas WHERE hc_citas.id_paciente = idPaciente";
        else
            sql = "SELECT * FROM hc_citas WHERE hc_citas.id_medico = idMedico and hc_citas.id_paciente = idPaciente"
        connection.query(sql, function(err, rows, fields)  {
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
  
/*Para borrar se debe enviar el request /rest/api/citas/id del cita*/
router.delete('/rest/api/citas/:idcita',verifyToken,(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("DELETE from hc_citas WHERE id_cita = ? ", [req.params.idcita], function(err, rows, fields) {
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
Agregar nueva cita
Para llamarlo se debe enviar en el postman el siguiente body
{
    "id_paciente":1,
    "id_medico":1,
    "titulo":"Titulo",
    "descripcion":"Descripcion",
    "fecha_cita":"22041992",
    "fecha_creacion":"fecha_creacion"
}
Donde:
id_paciente     = Id de la tabla pacientes
id_medico       = Id de la tabla medicos
titulo          = Titulo de la cita
descripcion     = Descipcion de la cita
fecha_cita      = fecha de la cita
fecha_creacion  = fecha de creacion de la cita
*/

router.post('/rest/api/citas',verifyToken,(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        let emp = req.body;
        var sql = "INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico) VALUES (?,?,?,?,?,?)";
        connection.query(sql, 
                        [emp.id_titulo, emp.descripcion, emp.fecha_cita, emp.fecha_creacion,
                        emp.id_paciente, emp.id_medico], 
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
Actualizar cita
Para llamarlo se debe enviar en el postman el siguiente body
{
    "id_cita"
    "id_paciente":1,
    "id_medico":1,
    "titulo":"Titulo",
    "descripcion":"Descripcion",
    "fecha_cita":"22041992",
    "fecha_creacion":"fecha_creacion"
}
Donde:
id_cita         = Id de la cita a actualizar
id_paciente     = Id de la tabla pacientes
id_medico       = Id de la tabla medicos
titulo          = Titulo de la cita
descripcion     = Descipcion de la cita
fecha_cita      = fecha de la cita
fecha_creacion  = fecha de creacion de la cita
*/

router.put('/rest/api/citas',verifyToken,(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        let emp = req.body;
        var sql = "update hc_citas set id_paciente = ?, id_medico = ?, titulo = ?, descripcion = ?, fecha_cita = ?, fecha_creacion = ? \
        WHERE hc_citas.id_cita = ?";
        connection.query(sql, 
                        [emp.id_paciente, emp.id_medico,emp.titulo, emp.descripcion,
                        emp.fecha_cita,emp.fecha_creacion,emp.id_cita],
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