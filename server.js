var express= require('express');
var app = express();
var server=require('http').createServer(app);
var bodyparser = require('body-parser');
var mysql = require('mysql');
//var io = require('socket.io')(server);

app.use(express.static(__dirname + '/public')); //serving statics files like css, js, images
app.use(bodyparser.json());

var port=process.env.PORT || 3000; //this is for heroku

var cloudMysql={ //para conexion remota
  host: "sql9.freesqldatabase.com",
  user: "sql9297610",
  password: "ANArgtCTgB",
  database:"sql9297610",
  insecureAuth : true,
  multipleStatements:true
};
 var localMysql={ //conexion local
   host: "localhost",
   user: "root",
   password: "password",
   database:"mydb",
   insecureAuth : true,
   multipleStatements:true
 };

var connection = mysql.createConnection(localMysql);

connection.connect((err)=>{
    if(!err)
        console.log('DB connection succeded');
    else
        console.log('DB Connection failed \n Error'+err);
});

/***************MESSAGES */
const MESSAGES = {
  "delete_row_does_not_exist":{"message":"La fila a borrar no existe"},
  "delete_row_successfull":{"message":"La fila fue borrada satisfactoriamente"},
  "insert_row_successfull":{"message":"La fila fue insertada satisfactoriamente"},
  "update_row_successfull":{"message":"La fila fue actualizada satisfactoriamente"},
  "update_row_id_does_not_exist":{"message":"La fila no puede ser actualizada ya que el id no existe"},
  "unexpected_error":{"message":"Ocurrio un error inesperado ", "excepcion":{}},
}



app.get('/', function(req, res){
  //res.sendFile(__dirname + '/index.html');
  res.send('Project X is running...');
});

/************************************PAISES****************************************** */
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


/*******************************CIUDADES***************************** */
/**************Lista todas las ciudades que existen en la base de datos */
app.get('/ciudades',(req, res)=>{
  connection.query("SELECT * from hc_ciudad \
                    INNER JOIN hc_pais\
                    WHERE hc_ciudad.id_pais = hc_pais.id_pais", function(err, rows, fields) {
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
                    INNER JOIN hc_pais\
                    WHERE hc_ciudad.id_ciudad = ? and \
                    hc_ciudad.id_pais = hc_pais.id_pais", [req.params.idciudad],function(err, rows, fields) {
      if (!err)
          res.send(rows);
        else{
          var unexpectedError = MESSAGES.unexpected_error;
          unexpectedError.excepcion= err;
          res.send(unexpectedError);
        }
      });
});

/*Obtiene las ciudades de un pais para obtenerlas se debe llamar de la siguiente manera /paises/:idpais/ciudades*/
app.get('/paises/:idpais/ciudades/',(req, res)=>{
  connection.query("SELECT * from hc_ciudad \
                    INNER JOIN hc_pais\
                    WHERE hc_ciudad.id_pais = ? and \
                    hc_ciudad.id_pais = hc_pais.id_pais", [req.params.idpais],function(err, rows, fields) {
      if (!err)
          res.send(rows);
        else{
          var unexpectedError = MESSAGES.unexpected_error;
          unexpectedError.excepcion= err;
          res.send(unexpectedError);
        }
      });
});


/*Para borrar se debe enviar el request /ciudades/id del pais*/
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
  "id_pais":1
}

Donde  nombre_ciudad es el nombre de la ciudad y id_pais es el id de pais
*/

app.post('/ciudades',(req, res)=>{
  let emp = req.body;
  var sql = "INSERT INTO hc_ciudad(nombre_ciudad, id_pais) VALUES(?,?)";
  connection.query(sql, [emp.nombre_ciudad, emp.id_pais], function(err, rows, fields) {
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


server.listen(port, function(){
  console.log('Server listening on *:'+port);
});
