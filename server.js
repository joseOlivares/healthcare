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

var connection = mysql.createConnection(cloudMysql);

connection.connect((err)=>{
    if(!err)
        console.log('DB connection succeded');
    else
        console.log('DB Connection failed \n Error'+err);
});


app.get('/', function(req, res){
  //res.sendFile(__dirname + '/index.html');
  res.send('Project X is running...');
});


/*Obtener la lista de todos los paises*/
app.get('/paises',(req, res)=>{
    connection.query("SELECT * from hc_pais", function(err, rows, fields) {
        if (!err)
          res.send(rows);
        else
          console.log('Error while performing Query.'+err);
      });
});

/*Obtiene un pais por su id, Para obtenerlo se debe enviar el request /paises/id del pais*/
app.get('/paises/:id',(req, res)=>{
    connection.query("SELECT * from hc_pais WHERE id_pais = ? ", [req.params.id], function(err, rows, fields) {
        if (!err)
          res.send(rows);
        else
          console.log('Error while performing Query.'+err);
      });
});
/*Para borrar se debe enviar el request /paises/id del pais*/
app.delete('/paises/:id',(req, res)=>{
    connection.query("DELETE * from `mydb`.`hc_pais` WHERE id_pais = ? ", [req.params.id], function(err, rows, fields) {
        if (!err)
          res.send(rows);
        else
          console.log('Error while performing Query.'+err);
      });
});

/*Para llamarlo se debe enviar en el postman el siguiente body
{
	"Pais":0,
	"NombrePais":"United States"
}

Donde Pais siempre debe ser igual a 0 para indicar que es un nuevo pais
y NombrePais es el nombre del pais
*/

app.post('/paises',(req, res)=>{
    let emp = req.body;
    var sql = "SET @_Pais = ?; SET @_NombrePais = ?;\
               CALL PaisAgregarOActualizar(@_Pais, @_NombrePais);"
    connection.query(sql, [emp.Pais, emp.NombrePais], function(err, rows, fields) {
        if (!err){
            rows.forEach(element => {
                if(element.constructor == Array){
                    res.send("id = "+element[0].id_pais);
                    //res.send(rows);
                }
            });
        }
        else
          console.log('Error while performing Query.'+err);
      });
});


/*Para llamarlo se debe enviar en el postman el siguiente body
{
	"Pais":2,
	"NombrePais":"United States"
}

Donde Pais es el id del pais y NombrePais es el nuevo nombre*/

app.put('/paises',(req, res)=>{
    let emp = req.body;
    var sql = "SET @_Pais = ?; SET @_NombrePais = ?;\
               CALL PaisAgregarOActualizar(@_Pais, @_NombrePais);"
    connection.query(sql, [emp.Pais, emp.NombrePais], function(err, rows, fields) {
        if (!err){
            res.send('updated successfully');
        }
        else
          console.log('Error while performing Query.'+err);
      });
});

server.listen(port, function(){
  console.log('Server listening on *:'+port);
});
