var express= require('express');
var app = express();
var server=require('http').createServer(app);
var bodyparser = require('body-parser');
var mysql = require('mysql');
//var io = require('socket.io')(server);

app.use(express.static(__dirname + '/public')); //serving statics files like css, js, images
app.use(bodyparser.json());

var port=process.env.PORT || 3000; //this is for heroku

//--------Set database connection ------------------------
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

let connection = mysql.createConnection(localMysql);
connection.connect((err)=>{//intenta conectarse local
    if(!err){
        console.log('Local DB connection succeded');
    }else{
        console.log('Local DB Connection failed \n Error'+err);
        connection = mysql.createConnection(cloudMysql);
        connection.connect((err)=>{
            if(!err){
                console.log('Remote DB connection succeded');
            }else{
                console.log('Remote DB Connection failed \n Error'+err);
            }
        });
    }
});

//---------------------End set database connection-------------
/* Separando rutas */
const routeTest=require('./routes/test.js');
app.use(routeTest);

/* End routes*/

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
  res.send('<br/></br><div style="text-align: center;" ><h1>Project X is running...</h1></div>');
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


/*******************************departamentos***************************** */
/**************Lista todas las departamentos que existen en la base de datos */
app.get('/departamentos',(req, res)=>{
  connection.query("SELECT * from hc_departamento \
                    INNER JOIN hc_pais\
                    WHERE hc_departamento.id_pais = hc_pais.id_pais", function(err, rows, fields) {
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
                    INNER JOIN hc_pais\
                    WHERE hc_departamento.id_departamento = ? and \
                    hc_departamento.id_pais = hc_pais.id_pais", [req.params.iddepartamento],function(err, rows, fields) {
      if (!err)
          res.send(rows);
        else{
          var unexpectedError = MESSAGES.unexpected_error;
          unexpectedError.excepcion= err;
          res.send(unexpectedError);
        }
      });
});

/*Obtiene las departamentos de un pais para obtenerlas se debe llamar de la siguiente manera /paises/:idpais/departamentos*/
app.get('/paises/:idpais/departamentos/',(req, res)=>{
  connection.query("SELECT * from hc_departamento \
                    INNER JOIN hc_pais\
                    WHERE hc_departamento.id_pais = ? and \
                    hc_departamento.id_pais = hc_pais.id_pais", [req.params.idpais],function(err, rows, fields) {
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


server.listen(port, function(){
  console.log('Server listening on *:'+port);
});
