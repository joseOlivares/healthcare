var express= require('express');
var app = express();
var server=require('http').createServer(app);
//var io = require('socket.io')(server);

app.use(express.static(__dirname + '/public')); //serving statics files like css, js, images
var port=process.env.PORT || 3000; //this is for heroku


app.get('/', function(req, res){
  //res.sendFile(__dirname + '/index.html');
  res.send('Project X is running...');
});



server.listen(port, function(){
  console.log('Server listening on *:'+port);
});
