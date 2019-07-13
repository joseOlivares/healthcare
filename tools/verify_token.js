var jwt = require('jsonwebtoken');

function verifyToken(req,res,next){
  console.log("Entra en tools/verifytoken.js");
  //Get auth header
  const bearerheader=req.headers['authorization'];
  if (!bearerheader) {
    return res.status(403).send({auth:false, message: 'No token provided.' });
  }

  const bearer=bearerheader.split(' ');
  const bearerToken=bearer[1];
  req.token=bearerToken;
  // verifies secret and checks exp
  jwt.verify(bearerToken,'palabrasecreta', function(err, authData) {
    if (err)
      return res.status(500).send({auth:false, message: 'Failed to authenticate token.' });

    //res.locals.culaquierNombreVariable  sirve para agregar variables a la respuesta
    res.locals.authenticated={
      auth: true,
      message: 'Authenticated token OK...',
      authData
    };

    next();
  });
}
//-----------------------------------------

module.exports=verifyToken;
