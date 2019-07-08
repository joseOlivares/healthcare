var express= require('express');
var app = express();
var server=require('http').createServer(app);
var bodyparser = require('body-parser');
var mysql = require('mysql');
//var io = require('socket.io')(server);
const connection=require('../dbconn/db.js');//Importing database connection pool

app.use(express.static(__dirname + '/public')); //serving statics files like css, js, images
app.use(bodyparser.json());

var port=process.env.PORT || 3000; //this is for heroku

//--------Set database connection ------------------------


//---------------------End set database connection-------------
/* Separando rutas */
const routeTest=require('./routes/test.js');
app.use(routeTest);

/* End routes*/

/***************MESSAGES */
const MESSAGES = {
  "delete_row_does_not_exist":{"message":"La fila a borrar no existe","data":""},
  "delete_row_successfull":{"message":"La fila fue borrada satisfactoriamente","data":""},
  "insert_row_successfull":{"message":"La fila fue insertada satisfactoriamente","data":""},
  "update_row_successfull":{"message":"La fila fue actualizada satisfactoriamente","data":""},
  "update_row_id_does_not_exist":{"message":"La fila no puede ser actualizada ya que el id no existe","data":""},
  "unexpected_error":{"message":"Ocurrio un error inesperado ", "excepcion":""},
}



app.get('/', function(req, res){
  //res.sendFile(__dirname + '/index.html');
  res.send('<br/></br><div style="text-align: center;" ><h1>Project X is running...</h1></div>');
});

/********************************************************************************************************* */
/******************************************PAISES******************************************************* */
/********************************************************************************************************* */

/*Obtener la lista de todos los paises*/
app.get('/paises',(req, res)=>{
    connection.query("SELECT * from hc_pais", function(err, rows, fields) {
        if (!err)
          res.send(rows);
        else{
          var unexpectedError = MESSAGES.unexpected_error;
          unexpectedError.excepcion= err;
          res.send(unexpectedError);
        }
      });
});

/*Obtiene un pais por su id, Para obtenerlo se debe enviar el request /paises/id del pais*/
app.get('/paises/:idpais',(req, res)=>{
    connection.query("SELECT * from hc_pais WHERE id_pais = ? ", [req.params.idpais], function(err, rows, fields) {
        if (!err)
          res.send(rows);
        else{
          var unexpectedError = MESSAGES.unexpected_error;
          unexpectedError.excepcion= err;
          res.send(unexpectedError);
        }
      });
});


/*Para borrar se debe enviar el request /paises/id del pais*/
app.delete('/paises/:idpais',(req, res)=>{
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
});

/*
Agregar nuevo país
Para llamarlo se debe enviar en el postman el siguiente body
{
	"nombre_pais":"United States"
}

Donde  NombrePais es el nombre del pais
*/

app.post('/paises',(req, res)=>{
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
});


/*Para llamarlo se debe enviar en el postman el siguiente body
{
	"id_pais":2,
	"nombre_pais":"United States"
}

Donde Pais es el id del pais y NombrePais es el nuevo nombre*/

app.put('/paises',(req, res)=>{
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
});


/********************************************************************************************************* */
/******************************************DEPARTAMENTOS******************************************************* */
/********************************************************************************************************* */
/*Obtiene las departamentos de un pais para obtenerlas se debe llamar de la siguiente manera /paises/:idpais/departamentos*/
app.get('/paises/:idpais/departamentos/',(req, res)=>{
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
});


/**************Lista todas las departamentos que existen en la base de datos, */
app.get('/departamentos',(req, res)=>{
  connection.query("SELECT * from hc_departamento", function(err, rows, fields) {
      if (!err)
        res.send(rows);
      else{
        var unexpectedError = MESSAGES.unexpected_error;
        unexpectedError.excepcion= err;
        res.send(unexpectedError);
      }
    });
});

/*Obtiene una departamento por su id, Para obtenerlo se debe enviar el request /departamentos/id de la departamento*/
app.get('/departamentos/:iddepartamento',(req, res)=>{
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
});


/*Para borrar se debe enviar el request /departamentos/id del pais*/
app.delete('/departamentos/:iddepartamento',(req, res)=>{
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

app.post('/departamentos',(req, res)=>{
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
});


/*Para llamarlo se debe enviar en el postman el siguiente body
{
"id_departamento":2,
"nombre_departamento":"Miami"
}

Donde id_departamento es el id de la departamento y nombre_departamento es el nuevo nombre de la departamento*/

app.put('/departamentos',(req, res)=>{
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
});

/********************************************************************************************************* */
/******************************************CIUDADES******************************************************* */
/********************************************************************************************************* */

/*Obtiene las ciudades de un departamento para obtenerlas se debe llamar de la siguiente manera /departamentos/:iddepartamento/ciudades*/
app.get('/departamentos/:iddepartamento/ciudades/',(req, res)=>{
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
});


/**************Lista todas las ciudades que existen en la base de datos */
app.get('/ciudades',(req, res)=>{
  connection.query("SELECT * from hc_ciudad", function(err, rows, fields) {
      if (!err)
        res.send(rows);
      else{
        var unexpectedError = MESSAGES.unexpected_error;
        unexpectedError.excepcion= err;
        res.send(unexpectedError);
      }
    });
});

/*Obtiene una ciudad por su id, Para obtenerlo se debe enviar el request /ciudades/id de la ciudad*/
app.get('/ciudades/:idciudad',(req, res)=>{
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
});


/*Para borrar se debe enviar el request /ciudades/id del departamento*/
app.delete('/ciudades/:idciudad',(req, res)=>{
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

app.post('/ciudades',(req, res)=>{
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
});


/*Para llamarlo se debe enviar en el postman el siguiente body
{
"id_ciudad":2,
"nombre_ciudad":"Miami"
}

Donde id_ciudad es el id de la ciudad y nombre_ciudad es el nuevo nombre de la ciudad*/

app.put('/ciudades',(req, res)=>{
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
});


/********************************************************************************************************* */
/******************************************direcciones******************************************************* */
/********************************************************************************************************* */

/*Obtiene las direcciones de un ciudad para obtenerlas se debe llamar de la siguiente manera /ciudades/:idciudad/direcciones*/
app.get('/ciudades/:idciudad/direcciones/',(req, res)=>{
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
});


/**************Lista todas las direcciones que existen en la base de datos */
app.get('/direcciones',(req, res)=>{
  connection.query("SELECT * from hc_direccion ", function(err, rows, fields) {
      if (!err)
        res.send(rows);
      else{
        var unexpectedError = MESSAGES.unexpected_error;
        unexpectedError.excepcion= err;
        res.send(unexpectedError);
      }
    });
});

/*Obtiene una direccion por su id, Para obtenerlo se debe enviar el request /direcciones/id de la direccion*/
app.get('/direcciones/:iddireccion',(req, res)=>{
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
});


/*Para borrar se debe enviar el request /direcciones/id del ciudad*/
app.delete('/direcciones/:iddireccion',(req, res)=>{
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

app.post('/direcciones',(req, res)=>{
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
});


/*Para llamarlo se debe enviar en el postman el siguiente body
{
"id_direccion":2,
"nombre_direccion":"Miami"
}

Donde id_direccion es el id de la direccion y nombre_direccion es el nuevo nombre de la direccion*/

app.put('/direcciones',(req, res)=>{
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
});

/********************************************************************************************************* */
/******************************************usuarios******************************************************* */
/********************************************************************************************************* */


/**************Lista todas las usuarios que existen en la base de datos */
app.get('/usuarios',(req, res)=>{
  connection.query("CALL obtenerUsuarios() ", function(err, rows, fields) {
      if (!err)
        res.send(rows);
      else{
        var unexpectedError = MESSAGES.unexpected_error;
        unexpectedError.excepcion= err;
        res.send(unexpectedError);
      }
    });
});

/*Obtiene una usuario por su id, Para obtenerlo se debe enviar el request /usuarios/id de la usuario*/
app.get('/usuarios/:idusuario',(req, res)=>{
  connection.query("CALL obtenerUsuario(?)", [req.params.idusuario],function(err, rows, fields) {
      if (!err)
          res.send(rows);
        else{
          var unexpectedError = MESSAGES.unexpected_error;
          unexpectedError.excepcion= err;
          res.send(unexpectedError);
        }
      });
});


/*Para borrar se debe enviar el request /usuarios/id del usuario*/
app.delete('/usuarios/:idusuario',(req, res)=>{
  connection.query("DELETE from hc_usuarios WHERE id_usuarios = ? ", [req.params.idusuario], function(err, rows, fields) {
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
});



/*
Agregar nuevo usuario
Para llamarlo se debe enviar en el postman el siguiente body
{
	"nombres":"dato",
	"status":"dato",
	"apellidos":"dato",
	"correo":"dato",
	"password":"dato",
	"id_tipo_documento":1,
	"numero_documento":"dato",
	"id_sexo":1,
	"id_estado_civil":1,
	"fecha_nacimiento":"dato",
	"profesion":"dato",
	"conyugue":"dato",
	"tel_casa":"dato",
	"celular":"dato",
  "lugar_trabajo":"dato",
  "direccion":"dato",
	"id_ciudad":1
}
Donde:
  nombres           = Nombres del usuario
  status            = Status del usuario
  apellidos         = Apellidos del usuario
  correo            = Correo del usuario
  password          = Password del usuario
  id_tipo_documento = Id de tabla con el tipo documento de identificacion del usuario
  numero_documento  = Numero de documento de identificacion del usuario
  id_sexo           = Id de la tabla con el sexo de usuario
  id_estado_civil   = Id de la tabla con el estado civil del usuario
  fecha_nacimiento  = Fecha de nacimiento del usuario
  profesion         = Profesion del usuario
  conyugue          = Nombre del conyugue del usuario
  tel_casa          = Numero de telefono de la casa del usuario
  celular           = Numero de telefono del celular del usuario
  lugar_trabajo     = Lugar de trabajo del usuario
  direccion         = Direccion del usuario
  id_ciudad         = Id de la tabla ciudad donde vive el usuario
*/

app.post('/usuarios',(req, res)=>{
  let emp = req.body;
  var sql = "CALL crearUsuario(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
  connection.query(sql,
                   [emp.nombres,emp.status,emp.apellidos,emp.correo,
                    emp.password,emp.id_tipo_documento,emp.numero_documento,
                    emp.id_sexo,emp.id_estado_civil,emp.fecha_nacimiento,
                    emp.profesion,emp.conyugue,emp.tel_casa,emp.celular,
                    emp.lugar_trabajo,emp.direccion,emp.id_ciudad],
                  function(err, rows, fields) {
      if (!err){
        let resultMessage = MESSAGES.insert_row_successfull;
        resultMessage.data = rows;
        res.send(MESSAGES.insert_row_successfull);
      }
      else{
        console.log(emp.id_sexo);
        var unexpectedError = MESSAGES.unexpected_error;
        unexpectedError.excepcion= err;
        res.send(unexpectedError);
      }
    });
});


/*
Actualizar usuario
Para llamarlo se debe enviar en el postman el siguiente body
{
  "id_usuario":1,
	"nombres":"dato",
	"status":"dato",
	"apellidos":"dato",
	"correo":"dato",
	"password":"dato",
	"id_tipo_documento":1,
	"numero_documento":"dato",
	"id_sexo":1,
	"id_estado_civil":1,
	"fecha_nacimiento":"dato",
	"profesion":"dato",
	"conyugue":"dato",
	"tel_casa":"dato",
	"celular":"dato",
  "lugar_trabajo":"dato",
  "direccion":"dato",
	"id_ciudad":1
}
Donde:
  id_usuario        = id de la tabla del usuario
  nombres           = Nombres del usuario
  status            = Status del usuario
  apellidos         = Apellidos del usuario
  correo            = Correo del usuario
  password          = Password del usuario
  id_tipo_documento = Id de tabla con el tipo documento de identificacion del usuario
  numero_documento  = Numero de documento de identificacion del usuario
  id_sexo           = Id de la tabla con el sexo de usuario
  id_estado_civil   = Id de la tabla con el estado civil del usuario
  fecha_nacimiento  = Fecha de nacimiento del usuario
  profesion         = Profesion del usuario
  conyugue          = Nombre del conyugue del usuario
  tel_casa          = Numero de telefono de la casa del usuario
  celular           = Numero de telefono del celular del usuario
  lugar_trabajo     = Lugar de trabajo del usuario
  direccion         = Direccion del usuario
  id_ciudad         = Id de la tabla ciudad donde vive el usuario
*/

app.put('/usuarios',(req, res)=>{
  let emp = req.body;
  var sql = "CALL actualizarUsuario(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
  connection.query(sql,
                   [emp.id_usuario,
                    emp.nombres,emp.status,emp.apellidos,emp.correo,
                    emp.password,emp.id_tipo_documento,emp.numero_documento,
                    emp.id_sexo,emp.id_estado_civil,emp.fecha_nacimiento,
                    emp.profesion,emp.conyugue,emp.tel_casa,emp.celular,
                    emp.lugar_trabajo,emp.direccion,emp.id_ciudad],
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
});



server.listen(port, function(){
  console.log('Server listening on *:'+port);
});
