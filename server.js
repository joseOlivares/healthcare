var express= require('express');
var app = express();
var server=require('http').createServer(app);
var bodyparser = require('body-parser');
var mysql      = require('mysql');
//var io = require('socket.io')(server);

app.use(express.static(__dirname + '/public')); //serving statics files like css, js, images
app.use(bodyparser.json());

var port=process.env.PORT || 3000; //this is for heroku


var connection = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "password",
    database:"mydb",
    insecureAuth : true,
    multipleStatements:true
});

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


/*Obtener la lista de todos los paises*/
app.get('/paises',(req, res)=>{
    connection.query("SELECT * from `mydb`.`hc_pais`", function(err, rows, fields) {
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
app.get('/paises/:id',(req, res)=>{
    connection.query("SELECT * from `mydb`.`hc_pais` WHERE id_pais = ? ", [req.params.id], function(err, rows, fields) {
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
app.delete('/paises/:id',(req, res)=>{
    connection.query("DELETE from `mydb`.`hc_pais` WHERE id_pais = ? ", [req.params.id], function(err, rows, fields) {
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

Donde Pais siempre debe ser igual a 0 para indicar que es un nuevo pais
y NombrePais es el nombre del pais
*/

app.post('/paises',(req, res)=>{
    let emp = req.body;
    var sql = "INSERT INTO `mydb`.`hc_pais`(nombre_pais) VALUES(?)"
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
    var sql = "update `mydb`.`hc_pais` set nombre_pais = ? \
               WHERE id_pais = ?;"
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

server.listen(port, function(){
  console.log('Server listening on *:'+port);
});
