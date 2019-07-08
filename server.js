var express= require('express');
var app = express();
var server=require('http').createServer(app);
var bodyparser = require('body-parser');
var mysql = require('mysql');
//var io = require('socket.io')(server);

app.use(express.static(__dirname + '/public')); //serving statics files like css, js, images
app.use(bodyparser.json());

var port=process.env.PORT || 3000; //this is for heroku

//---------------------End set database connection-------------
/* Separando rutas */
const routeTest=require('./routes/test.js');
const routePaises=require('./routes/paises.js');
const routeDepartamentos=require('./routes/departamentos.js');
const routeCiudades=require('./routes/ciudades.js');
const routeDirecciones=require('./routes/direcciones.js');
const routeUsuarios=require('./routes/usuarios.js');
app.use(routeTest);
app.use(routePaises);
app.use(routeDepartamentos);
app.use(routeCiudades);
app.use(routeDirecciones);
app.use(routeUsuarios);
/* End routes*/

app.get('/', function(req, res){
  //res.sendFile(__dirname + '/index.html');
  res.send('<br/></br><div style="text-align: center;" ><h1>Project X is running...</h1></div>');
});

server.listen(port, function(){
  console.log('Server listening on *:'+port);
});
