/*Usuarios obtenidos del siguiente repositorio de github https://github.com/pixelastic/fakeusers*/

const fs = require('fs');

/*Read file with fake users*/
let rawdata = fs.readFileSync('fake-users.json');  
let users = JSON.parse(rawdata);  

let newUsers =[];
let indexUser = 0;
users.forEach(element => {
    let nombres = element.first_name;
    let status  ="";
    let apellidos = element.last_name;
    let correo = element.email;
    let password = element.password;
    let id_tipo_documento = (indexUser%2) +1;
    let numero_documento = indexUser;
    let id_sexo = (element.gender == "male" )  ? 1: 2;
    let id_estado_civil =  (indexUser%2) +1;
    let fecha_nacimiento = element.birthday;
    let profesion = "";
    let conyugue = "";
    let tel_casa = element.phone_number;
    let celular = element.phone_number;
    let lugar_trabajo = element.location.city;
    let direccion =  element.location.city;
    let ciudad = (indexUser%81) +1;

    let sqlStatement = "call crearUsuario('"+nombres+"','"+status+"','"+apellidos+"','"+correo+"','"+password+"',"+id_tipo_documento+
                       ",'"+numero_documento+"',"+id_sexo+","+id_estado_civil+",'"+fecha_nacimiento+"','"+profesion+"','"+conyugue+
                       "','"+tel_casa+"','"+celular+"','"+lugar_trabajo+"','"+direccion+"','"+ciudad+"')";
    newUsers.push(sqlStatement);
    indexUser++;
});



let data = JSON.stringify(newUsers);  
fs.writeFileSync('sql-statements-create-fake-users.json', data);  