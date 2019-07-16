/*Usuarios obtenidos del siguiente repositorio de github https://github.com/pixelastic/fakeusers*/

const fs = require('fs');

/*Read file with fake users*/
let rawdata = fs.readFileSync('fake-users.json');  
let users = JSON.parse(rawdata);  

let newUsers ="";
let newMedicos = "";
let newPacientes = "";
let newCitas = "";
let newDiagnosticos = "";
let newRecetas = "";
let newMedRecetas = "";
let indexUser = 0;
let idMedico = 0;
let idPaciente = 0;
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
    


    let sqlStatementUser = "call crearUsuario('"+nombres+"','"+status+"','"+apellidos+"','"+correo+"','"+password+"',"+id_tipo_documento+
                       ",'"+numero_documento+"',"+id_sexo+","+id_estado_civil+",'"+fecha_nacimiento+"','"+profesion+"','"+conyugue+
                       "','"+tel_casa+"','"+celular+"','"+lugar_trabajo+"','"+direccion+"','"+ciudad+"');";
    newUsers += "\n"+sqlStatementUser;
    let sqlStatementMedico = "insert into hc_medicos(id_usuario, identificacion_medica) VALUES("+(indexUser+1)+",'"+(indexUser+1)+"');";
    if(indexUser%4 ==0){
        newMedicos += "\n"+sqlStatementMedico;
        idMedico = idMedico+1;
    }
    let sqlStatementPaciente = "CALL crearPaciente("+(indexUser+1)+",'"+indexUser+"','"+apellidos+"','"+apellidos+"','"+tel_casa+"','"+celular+"',"+(indexUser%2+1)+");";
    if(indexUser%4!=0){
        newPacientes  += "\n"+sqlStatementPaciente;
        idPaciente++;
    }
    let sqlStatementCitas1 ="INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico) \
                             VALUES ('cita #"+(indexUser+1)+"','descripcion #"+(indexUser+1)+"','"+(indexUser+1)+"','"
                             +(indexUser+1)+"',"+idPaciente+","+(idMedico)+");";
    let sqlStatementCitas2 ="INSERT INTO  hc_citas(titulo, descripcion, fecha_cita, fecha_creacion, id_paciente, id_medico) \
                            VALUES ('cita #"+(indexUser+2)+"','descripcion #"+(indexUser+2)+"','"+(indexUser+2)+"','"
                            +(indexUser+2)+"',"+idPaciente+","+(idMedico)+");";
    if(indexUser%4!=0){
        newCitas  += "\n"+ sqlStatementCitas1;
        newCitas  += "\n"+sqlStatementCitas2;
    }

    let sqlStatementDiagnosticos1 ="INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)  \
                             VALUES ('diagnostico #"+(indexUser+1)+"','descripcion #"+(indexUser+1)+"','1000-01-01 00:00:00',"
                             +idPaciente+","+(idMedico)+");";
    let sqlStatementDiagnosticos2 ="INSERT INTO  hc_diagnosticos(titulo, descripcion, fecha, id_paciente, id_medico)  \
                             VALUES ('diagnostico #"+(indexUser+2)+"','descripcion #"+(indexUser+2)+"','1000-01-01 00:00:00',"
                             +idPaciente+","+(idMedico)+");";

    
    if(indexUser%4!=0){
        newDiagnosticos  += "\n"+ sqlStatementDiagnosticos1;
        newDiagnosticos  += "\n"+ sqlStatementDiagnosticos2;
    }

    let sqlStatementRecetas ="INSERT INTO hc_recetas(id_diagnostico,fecha_emision) VALUES("+(indexUser+1)+",'1000-01-01 00:00:00');";

    newRecetas  += "\n"+ sqlStatementRecetas;
    

    let sqlStatementMedRecetas ="INSERT INTO hc_med_recetas(id_receta,id_medicamento, indicaciones) \
                                 VALUES("+(indexUser+1)+","+(indexUser+1)+",'indicaciones #"+(indexUser+1)+"');";

    
    
    newMedRecetas  += "\n"+ sqlStatementMedRecetas;
    
   
    indexUser++;
});


let newData = newUsers+"\n"+newMedicos+"\n"+newPacientes+"\n"+newCitas+"\n"+newDiagnosticos+"\n"+newRecetas+"\n"+newMedRecetas;


fs.writeFileSync('sql-statements-create-fake-users-clean.sql', newUsers);  
fs.writeFileSync('sql-statements-create-fake-medics-clean.sql', newMedicos);  
fs.writeFileSync('sql-statements-create-fake-pacientes-clean.sql', newPacientes);  
fs.writeFileSync('sql-statements-create-fake-citas-clean.sql', newCitas);  
fs.writeFileSync('sql-statements-create-fake-diagnosticos-clean.sql', newDiagnosticos);  
fs.writeFileSync('sql-statements-create-fake-recetas-clean.sql', newRecetas);  
fs.writeFileSync('sql-statements-create-fake-med-recetas-clean.sql', newMedRecetas);  
fs.writeFileSync('sql-statements-create-fake-data-clean.sql', newData);  

