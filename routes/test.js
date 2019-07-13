//aqui van todas las rutas relacioandas
const express= require('express');
const router=express.Router();
const jwt=require('jsonwebtoken');
const dbPool=require('../dbconn/db.js');//Importing database connection pool


//---- Usando JsonWebTokens----------------------------------------
const verifyToken=require('../tools/verify_token.js');//funcion de validacion de token

router.post('/testlogin',(req, res)=>{
  console.log("/testlogin");
  console.log("Req.body.user: "+req.body.email);
  console.log("Req.body.pass: "+req.body.pass);
  //test user sin conectarse a la base
  //aqui tendriamos que autenticar este usuario en la BD y luego psarlo a jwt
  const user={ id:1, username:'jluis', email:'jluis@test.com' };
  const exp=30;//30 segundos
  jwt.sign({user:user},'palabrasecreta',{ expiresIn: exp } ,(err,token)=>{
    res.json({
      token
    });
  });
});

router.post('/testlogindb',(req, res)=>{
  console.log("/testlogindb");
  console.log("Req.body.user: "+req.body.email);
  console.log("Req.body.pass: "+req.body.pass);
  //para conectarse a la base remota  email: luismash@hotmail.com  pass: 777
 //validamos el usuario en la base de datos
  dbPool.getConnection(function(err,connection) {
        const sql="call validarUsuario(?)";//query
        const params=[req.body.email.trim(),req.body.pass.trim()];//Parametros
        const exp=35;//30 segundos de expiracion para el token
        connection.query(sql,[params], function(err, rows, fields) {
            if (!err){
                console.log("Registros encontrados ", rows[0].length);
                console.log("rows ", rows[0]);
                //console.log("fields ", fields);
                if (rows[0].length===1) {//si encontró un registro
                let user={id:rows[0][0].id_usuarios,username:rows[0][0].nombres,email:rows[0][0].correo};
                    //creamos el token
                    jwt.sign({user:user},'palabrasecreta',{ expiresIn: exp } ,(err,token)=>{
                      res.json({
                        token
                      });
                    });
                }else {
                      res.json({message:"Error de autenticación, Usuario o Password no válido..."});
                }
            }else{
                res.json({message:"Error de conexión a la base de datos..."});
            }
        });
        // release connection
        connection.release();
    });

});


router.post('/testInsertPais',verifyToken,(req,res)=>{
  //res.status(200).send(result);
  let resultado=res.locals.authenticated;
  resultado.msg2='Pais insertado correctamente';
  res.json(resultado);
});

// function verifyToken(req,res,next){
//   //Get auth header evaluae
//   const bearerheader=req.headers['authorization'];
//   if (typeof bearerheader!=='undefined'){
//       //obteniendo el Token
//       const bearer=bearerheader.split(' ');
//       const bearerToken=bearer[1];
//       req.token=bearerToken;
//       //next
//       next();
//   }else {
//     //403 forbidden
//     res.sendStatus(403); //token no definido
//   }
//   //Format verifyToken
//   //Authorization: Bearer <access_token>
// }

//-----------------END JsonWebTokens------------------------


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
