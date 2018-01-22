call BasePT.insertarAdmin('Fernando', 'Hernandez', 'Molina', 'admin@gmail.com', 'admin123', 'Masculino',@result);
select @result;


call BasePT.insertarEspecialista('j','z','t','j@j.com','123456','Masculino',1245,@result);
select @result;
call BasePT.insertarEspecialista('f','h','m','f@f.com','123456','Masculino',22222,@result);
select @result;
call BasePT.insertarEspecialista('Fernando','Gomez','Garza','fgg@gmail.com','123456','Masculino',22222,@result);
select @result;
call BasePT.insertarEspecialista('Prueba','p','p','prueba@prueba.com','123456','Masculino',22222,@result);
select @result;


call BasePT.insertarPaciente(1,'jorge','zepeda','tinoco','epilepsia',23,'jorzet.94@gmail.com','audir8','Masculino',940702,@result);
select @result;
call BasePT.insertarPaciente(1,'fernando','hernandez','molina','demensia',23,'fhdo.94@gmail.com','fer1234','Masculino',940520,@result);
select @result;
call BasePT.insertarPaciente(1,'daniel','perez','hernandez','epilepsia',22,'dan.dimadom@gmail.com','qwerty','Masculino',456789,@result);
select @result;
call BasePT.insertarPaciente(2,'ariel','espindola','pizano','parkinson',22,'tonatihu.espindola@gmail.com','qwerty123','Masculino',192837465,@result);
select @result;
call BasePT.insertarPaciente(1,'alan','hernandez','molina','epilepsia',20,'alan@gmail.com','123456789','Masculino',456789,@result);
select @result;
call BasePT.insertarPaciente(1,'carlos','hernandez','perez','epilepsia',40,'carlos@gmail.com','123','Masculino',456789,@result);
select @result;
call BasePT.insertarPaciente(3,'Jorge','Zepeda','Tinoco','epilepsia',23,'jzt@gmail.com','123','Masculino',456789,@result);
select @result;
call BasePT.insertarPaciente(3,'Jorge','Zepeda','Tinoco','epilepsia',23,'jorzet.94@gmail.com','12345','Masculino',456789,@result);
select @result;

call BasePT.insertarPaciente(3,'Fernando','Hernandez','Molina','epilepsia',23,'fdohm.1994@gmail.com ','12345','Masculino',456789,@result);
select @result;

call BasePT.insertarDispositivo(3,'raspberry','B8:27:EB:48:E9:A2', @result);
select @result;
call BasePT.insertarDispositivo(3,'FP1','CC:2F:DE:C6:61:D2', @result);
select @result;
call BasePT.insertarDispositivo(3,'FP2','C5:2C:8A:46:C7:74', @result);
select @result;


call BasePT.insertarDispositivo(9,'raspberry','B8:27:EB:48:E9:A2', @result);
select @result;
call BasePT.insertarDispositivo(9,'FP1','CC:2F:DE:C6:61:D2', @result);
select @result;
call BasePT.insertarDispositivo(9,'FP2','C5:2C:8A:46:C7:74', @result);
select @result;

call BasePT.mostrarDispositivosPaciente(6,@result);
select @result;

call BasePT.eliminarDispositivoPaciente(3,7,@result);
select @result;

call BasePT.obtenerCitasPorEspecialista(2,@result);
select @result;



call BasePT.insertarCita(1,'2017-04-13','13:00','4:00','Coloca correctamente tus electrodos','FP1,FP2',@result);
select @result;
call BasePT.insertarCita(2,'2017-04-14','15:00','8:00','Coloca correctamente tus electrodos','FP1,FP2',@result);
select @result;
call BasePT.insertarCita(3,'2017-12-15','14:00','6:00','Coloca correctamente tus electrodos','FP1,FP2',@result);
select @result;
call BasePT.insertarCita(4,'2017-03-14','15:00','7:00','pon bien tus electrodos','FP1,FP2',@result);
select @result;
call BasePT.insertarCita(4,'2017-03-15','15:00','7:00','pon bien tus electrodos','FP1,FP2',@result);
select @result;
call BasePT.insertarCita(14,'2017-03-15','15:00','00:00:10','pon bien tus electrodos','FP1,FP2',@result);
select @result;
call BasePT.insertarCita(7,'2017-11-26','11:30','00:00:10','Coloca correctamente tus electrodos','FP1,FP2',@result);
select @result;
call BasePT.insertarCita(7,'2017-12-10','11:30','00:00:10','Coloca correctamente tus electrodos','FP1',@result);
select @result;
call BasePT.insertarCita(3,'2017-12-05','11:30','00:00:10','Coloca correctamente tus electrodos','FP1,FP2',@result);
select @result;
call BasePT.insertarCita(3,'2017-12-11','11:30','00:00:10','Coloca correctamente tus electrodos','FP1',@result);
select @result;

call BasePT.insertarCita(3,'2017-12-17','11:30','00:00:10','Coloca correctamente tus electrodos','FP2',@result);
select @result;

call BasePT.insertarCita(3,'2017-12-17','11:50','00:00:10','Coloca correctamente tus electrodos','FP1',@result);
select @result;

call BasePT.insertarCita(3,'2017-12-20','11:50','10:00:00','Coloca correctamente tus electrodos','FP1',@result);
select @result;

call BasePT.insertarCita(9,'2017-12-20','11:50','10:00:00','Coloca correctamente tus electrodos','FP1',@result);
select @result;

call BasePT.insertarCita(9,'2017-12-20','11:50','00:00:20','Coloca correctamente tus electrodos','FP1',@result);
select @result;

call BasePT.insertarCita(3,'2017-12-25','11:50','00:00:20','Coloca correctamente tus electrodos','FP1',@result);
select @result;

call BasePT.insertarCita(3,'2018-01-06','11:50','00:00:20','Coloca correctamente tus electrodos','FP1',@result);
select @result;

call BasePT.insertarCita(1,'2018-01-14','11:00','00:00:20','Coloca correctamente tus electrodos','FP1',@result);
select @result;

call BasePT.insertarCita(1,'2018-01-21','19:010','00:00:20','Coloca correctamente tus electrodos','FP1,FP2',@result);
select @result;

call BasePT.obtenerCitasPorEspecialista(3,@result);
select @result;

call BasePT.insertarGrabacion(1,'grabacion2',@result);
select @result;
call BasePT.insertarGrabacion(16,'grabacion1',@result);
select @result;
call BasePT.insertarGrabacion(2,'Jorge/grabacion-13-11-19',@result);
select @result;
call BasePT.insertarGrabacion(2,'Fernando/grabacion-13-11-17',@result);
select @result;
call BasePT.insertarGrabacion(3,'Daniel/grabacion-13-10-17',@result);
select @result;
call BasePT.insertarGrabacion(4,'Juan/grabacion-13-10-17',@result);
select @result;

call BasePT.insertarResultadosCanal(6,'FP1', 'Ritmo-alpha', 50, 10.2,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8, 1,2,3,4,5,6,7,8, @result);
select @result;

call BasePT.insertarResultadosGenerales(16,'oxipital','frecuencia-alpha',20.3,@result);
select @result;
call BasePT.insertarResultadosGenerales(2, 1,'parental','frecuencia-beta',15.1,@result);
select @result;
call BasePT.insertarResultadosGenerales(3, 2,'frontal','frecuencia-theta',30.6,@result);
select @result;
call BasePT.insertarResultadosGenerales(4, 2,'frontoparental','frecuencia-delta',19.5,@result);
select @result;


call BasePT.insertarResultadosSegmento(6,1,'FP1',0.00045,'frecuencia-alpha','[1,2,3,4,5]',@result);
select @result;
call BasePT.insertarResultadosSegmento(1,2,'F1T1',0.00025,'frecuencia-delta','[6,7,8,9,10]',@result);
select @result;
call BasePT.insertarResultadosSegmento(1,3,'F1T1',0.00015,'frecuencia-gamma','[11,12,13,14,15]',@result);
select @result;
call BasePT.insertarResultadosSegmento(1,4,'F1T1',0.00085,'frecuencia-theta','[16,17,18,19,20]',@result);
select @result;
call BasePT.insertarResultadosSegmento(1,5,'F1T2',0.00085,'frecuencia-alpha','[16,13,12,11,11]',@result);
select @result;

call BasePT.obtenerDatosUsuario('j@j.com','123456',@result);
select @result;
call BasePT.obtenerDatosUsuario('jorzet.94@gmail.com','audir8',@result);
select @result;
call BasePT.obtenerDatosUsuario('jzt@gmail.com','123',@result);
select @result;


call BasePT.mostrarResultadosTodosLosSegmentos(7, @result);
select @result;


call BasePT.mostrarDatosPaciente(1,@result);
select @result;
call BasePT.mostrarDatosPaciente(3,@result);
select @result;

call BasePT.mostrarDatosEspecialista(1,@result);
select @result;
call BasePT.mostrarDatosEspecialista(2,@result);
select @result;

call mostrarEspecialistas(@result);
select @result;

call BasePT.mostrarPacientesDeEspecialista(1,@result);
select @result;
call BasePT.mostrarPacientesDeEspecialista(2,@result);
select @result;

call BasePT.mostrarCitaPaciente(1,1,@result);
select @result;
call BasePT.mostrarCitaPaciente(2,2,@result);
select @result;

call BasePT.obtenerCitasPaciente(1,@result); 
select @result;
call BasePT.obtenerCitasPaciente(3,@result);
select @result;

call BasePT.mostrarResultadosGenerales(3,@result);
select @result;

call obtenerDatosUsuario('admin@gmail.con','admin123',@result);
select @result;

select * from especialista;
select * from paciente;
select * from administrador;

select * from basept.especialista;

call BasePT.mostrarResultadosPorCanal(1, 'FP2', @result);
select @result;

call BasePT.mostrarResultadosPorSegmento(7, 'FP1', 1,@result);
select @result;


call BasePT.mostrarResultadosPorIntervalo(24, 'FP1', 15,15,@result);
select @result;

call BasePT.getEmailAndPassword('jzt@gmail.com',@result);
select @result;

call BasePT.mostrarResultadosPorCanal(7,'FP1',@result);
select @result;

use basept;

select * from BasePT.administrador;
select *from BasePT.paciente;
select * from BasePT.especialista;
select * from BasePT.cita;
select * from BasePT.dispositivosAdquisicion;
select * from BasePT.grabacionCanal;
select * from BasePT.resultadoCanal;
select * from BasePT.resultadoSegmento;
select * from BasePT.resultadosGenerales;
select * from BasePT.dispositivosAdquisicion;

update BasePT.resultadoCanal set anormal=false where id_resultadoCanal>0;
update BasePT.resultadoSegmento set anormal = false where id_resultadoSegmento>0;

update BasePT.cita set electrodos = 'FP1,FP2' where id_paciente = 3;
update BasePT.cita set fechaCita = '2017-12-03' where id_paciente = 3;

update BasePT.paciente set emailPaciente = 'h@hhh.com' where id_paciente=8;

delete from BasePT.resultadoSegmento where id_resultadoSegmento in (141,142,143,144,145,146,147,148,149,150);
delete from BasePT.resultadoCanal where id_resultadoCanal=18;
delete from BasePT.grabacionCanal where id_grabacion=26;
delete from BasePT.grabacionCanal where id_grabacion=30;

drop table BasePT.resultadoSegmento;
drop table BasePT.resultadoCanal; 
drop table BasePT.resultadosGenerales;

delete from BasePT.grabacionCanal where id_grabacion=17;
delete from BasePT.grabacionCanal where id_grabacion=18;
delete from BasePT.grabacionCanal where id_grabacion=19;
delete from BasePT.grabacionCanal where id_grabacion=20;

call BasePT.eliminarCita(13, @result);
select @result;

call BasePT.eliminarPaciente(3, @result);
select @result;

call BasePT.eliminarEspecialista(3, @result);
select @result;

call BasePT.eliminarDispositivoPaciente(7,1, @result);
call BasePT.eliminarDispositivoPaciente(5,2, @result);

delete from paciente where id_paciente = 7;

SELECT * FROM BasePT.cita as c JOIN 
		(SELECT p.id_paciente, p.id_especialista, p.nombrePaciente, p.apPaternoPaciente, p.apMaternoPaciente, p.padecimientoPaciente, p.edadPaciente, p.emailPaciente, p.generoPaciente, p.fotoPaciente
		FROM BasePT.paciente AS p JOIN BasePT.especialista AS e 
		ON p.id_especialista = e.id_especialista
        	AND e.id_especialista = 2) AS pac ON pac.id_paciente = c.id_paciente
        	AND c.fechaCita >= now() LIMIT 6;