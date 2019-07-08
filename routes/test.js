//aqui van todas las rutas relacioandas
const express= require('express');
const router=express.Router();
//const mysql = require('mysql');

const dbPool=require('../dbconn/db.js');//Importing database connection pool


router.get('/test',(req, res)=>{
  res.send('<br/></br><div style="text-align: center;" >Test route response</div>');
});

router.get('/reservas',(req, res)=>{
  res.send('<br/></br><div style="text-align: center;" >Test route reservas</div>');
});

router.get('/testpaises',(req, res)=>{
      //console.log(dbPool);
      dbPool.getConnection(function(err,connection) {
        // Use the connection
        const myQuery='SELECT * from hc_pais';
        //original connection.query(insertMsg,[msgContent],function(err, rows)
        //[msgContent] es un array de parametros correspondientes al insertMsg
        connection.query(myQuery,function(err,rows) {
            if(err){
              console.log(err);//un error ocurrió
              res.send('Oops, ocurrió un problema al tratar de obtener la info!');
              //res.end;
              return;
            }else{
              res.send(rows); //enviando respuesta
              console.log('Select paises usando modulo mysql en archivo JS, OK!');
            }
          // release connection
          connection.release();
          // Don't use the connection here, it has been returned to the pool.
        });
      });
});


module.exports=router;
