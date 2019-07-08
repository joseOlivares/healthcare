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
const routeMedicos=require('./routes/medicos.js');
const routePacientes=require('./routes/pacientes.js');
const routeCitas=require('./routes/citas.js');
const routeDiagnosticos=require('./routes/diagnosticos.js');
const routeEstadosCiviles=require('./routes/estados_civiles.js');
const routeSexos=require('./routes/sexos.js');
const routeTipoDocumentos=require('./routes/tipos_documentos.js');
const routeMedicamentos=require('./routes/medicamentos.js');
const routeRecetas=require('./routes/recetas.js');
const routeParentezcos=require('./routes/parentezcos.js');
const routeMedReceta=require('./routes/med_recetas.js');
const routeUsuarioRoles=require('./routes/usuarios_roles.js');
app.use(routeTest);
app.use(routePaises);
app.use(routeDepartamentos);
app.use(routeCiudades);
app.use(routeDirecciones);
app.use(routeUsuarios);
app.use(routeMedicos);
app.use(routePacientes);
app.use(routeCitas);
app.use(routeDiagnosticos);
app.use(routeEstadosCiviles);
app.use(routeSexos);
app.use(routeTipoDocumentos);
app.use(routeMedicamentos);
app.use(routeRecetas);
app.use(routeParentezcos);
app.use(routeParentezcos);
app.use(routeMedReceta);
app.use(routeUsuarioRoles);
/* End routes*/

app.get('/', function(req, res){
  //res.sendFile(__dirname + '/index.html');
  res.send('<br/></br><div style="text-align: center;" ><h1>Project X is running...</h1></div>');
});

server.listen(port, function(){
  console.log('Server listening on *:'+port);
});
