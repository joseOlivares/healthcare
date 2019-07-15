const express= require('express');
const router=express.Router();

const jwt=require('jsonwebtoken');

const dbPool=require('../dbconn/db.js');//Importing database connection pool


//---- Usando JsonWebTokens----------------------------------------
router.post('/login',(req, res)=>{
  //test user
  //aqui tendriamos que autenticar este usuario en la BD y luego psarlo a jwt
  const user={ id:1, username:'jluis', email:'jluis@test.com' };
  const exp=3000;//3 segundos
  jwt.sign({user:user},'palabrasecreta',{ expiresIn: exp } ,(err,token)=>{
    res.json({
      token
    });
  });
});

router.post('/insertPais', verifyToken,(req,res)=>{
  jwt.verify(req.token,'palabrasecreta',(err,authData)=>{
      if (err) {
        res.sendStatus(403);
      }else {
          res.json({
            message: 'Pais insertado...',
            authData
          });
      }
  });

});

function verifyToken(req,res,next){
  //Get auth header evaluae
  const bearerheader=req.headers['authorization'];
  if (typeof bearerheader!=='undefined'){
      //obteniendo el Token
      const bearer=bearerheader.split(' ');
      const bearerToken=bearer[1];
      req.token=bearerToken;
      //next
      next();
  }else {
    //403 forbidden
    res.sendStatus(403); //token no definido
  }

  //Format verifyToken
  //Authorization: Bearer <access_token>
}
//-----------------------------------------

module.exports=router;
