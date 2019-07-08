const mysql = require('mysql');

//--------Set database connection ------------------------
const cloudMysql={ //para conexion remota
  connectionLimit : 10, //por default es 10
  host: "sql9.freesqldatabase.com",
  user: "sql9297610",
  password: "ANArgtCTgB",
  database:"sql9297610"
};
const localMysql={ //conexion local
   host: "localhost",
   user: "root",
   password: "password",
   database:"mydb"
 };

//usando un cluster de conexion
let poolCluster = mysql.createPoolCluster();
poolCluster.add('LOCAL', localMysql); //nombres LOCAL, REMOTE son arbitrarios
poolCluster.add('REMOTE', cloudMysql); // (NOMBRE, configuración a usar)

poolCluster.getConnection(function (err, connection) {
    if (!err) {
       console.log('DB connection succeded, Server: '+connection.config.host);
    }else {
       console.log('No se puedo establecer conexión con nigún servidor MySQL \n Error: '+err);
    }
});


  // //creando nuevo pool
  // pool = mysql.createPool(localMysql);//intenta conexion local
  // pool.getConnection((err,connection)=>{
  //     if (err){ // not connected!
  //         pool = mysql.createPool(cloudMysql);//intenta conexion remota
  //         pool.getConnection(function(err,connection) { //(err,connection) Nota revisar si se necesita hacer
  //             if(err){                      //un connection.release();
  //                 console.log('Remote DB Connection failed \n Error: '+err);
  //             }else{
  //                 console.log('Remote DB connection succeded');
  //             }
  //         });
  //
  //         console.log('Local DB Connection failed \n Error: '+err);
  //     }else {
  //         console.log('Local DB connection succeded');
  //     }
  // });



module.exports=poolCluster;//exports.pool = pool;
