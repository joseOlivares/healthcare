
/********************************************************************************************************* */
/******************************************  usuarios_roles  ****************************************************** */
/********************************************************************************************************* */


const express= require('express');
const router=express.Router();

const dbPool=require('../dbconn/db.js');//Importing database connection pool

const MESSAGES = require('../messages/messages.js');

//---- Usando JsonWebTokens----------------------------------------
const verifyToken=require('../tools/verify_token.js');//funcion de validacion de token



/**************Lista todas las usuarios_roles que existen en la base de datos */
router.get('/rest/api/usuarios-roles',verifyToken,(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("SELECT * FROM hc_usuarios_roles", function(err, rows, fields) {
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
  
/*Obtiene una rol por su id, Para obtenerlo se debe enviar el request /rest/api/usuarios-roles/id de la rol*/
router.get('/rest/api/usuarios-roles/:idusuariorol',verifyToken,(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("SELECT * FROM hc_usuarios_roles WHERE hc_usuarios_roles.id_usuario_rol = ?", [req.params.idusuariorol],function(err, rows, fields) {
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

/*Obtiene  los roles asociados a un usuario /rest/api/usuarios-roles/* /1*/
router.get('/rest/api/usuarios-roles/*/rol/idusuario',verifyToken,(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("CALL obtenerUsuarioRoles(?);", [req.params.idusuario],function(err, rows, fields) {
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



  
/*Para borrar se debe enviar el request /rest/api/usuarios-roles/id del rol*/
router.delete('/rest/api/usuarios_roles/:idusuariorol',verifyToken,(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        connection.query("DELETE from hc_usuarios_roles WHERE id_usuario_rol = ? ", [req.params.idusuariosrol], function(err, rows, fields) {
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
Agregar nueva rol
Para llamarlo se debe enviar en el postman el siguiente body
{
    "id_rol":1,
    "id_usuario":1
}
Donde:
id_rol = id del rol
id_usuario = id del usuario
*/

router.post('/rest/api/usuarios-roles',verifyToken,(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        let emp = req.body;
        var sql = "INSERT INTO  hc_usuarios_roles(id_usuario, id_rol) VALUES (?,?)";
        connection.query(sql, 
                        [emp.id_usuario, emp.id_rol], 
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
Actualizar rol
Para llamarlo se debe enviar en el postman el siguiente body
{
    "id_rol":1,
    "id_usuario":1,
    "id_usuario_rol"
}
Donde:
id_rol = id del rol
id_usuario = id del usuario
id_usuario_rol id del usuario_rol
*/

router.put('/rest/api/usuarios-roles',verifyToken,(req, res)=>{
	dbPool.getConnection(function(err,connection) {
        let emp = req.body;
        var sql = "update hc_usuarios_roles set id_rol = ?, id_usuario = ? \
        WHERE hc_usuarios_roles.id_usuario_rol = ?";
        connection.query(sql, 
                        [emp.id_rol,emp.id_usuario, emp.id_usuario_rol],
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