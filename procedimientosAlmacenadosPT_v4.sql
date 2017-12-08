use BasePT;
-- Procedimientos para la inserción de los datos
-- 1. Insertar Administrador

DELIMITER %
CREATE PROCEDURE BasePT.insertarAdmin(IN nombre VARCHAR(25), 
							  IN apellidoPaterno VARCHAR(25), 
							  IN apellidoMaterno VARCHAR(25), 
							  IN email VARCHAR(25), 
							  IN passAdmin VARCHAR(15), 
							  IN genero ENUM('Masculino','Femenino'),
                              OUT resultado VARCHAR(100))
BEGIN
	IF NOT EXISTS (SELECT a.id_administrador FROM BasePT.administrador AS a WHERE a.emailAdministrador=email)
	THEN       
		INSERT INTO BasePT.administrador(nombreAdministrador, 
										apPaternoAdministrador, 
										apMaternoAdministrador, 
										emailAdministrador,
										passAdministrador,
										generoAdministrador) 
		VALUES(nombre, apellidoPaterno, apellidoMaterno, email, passAdmin, genero);
		SET resultado = 'Usuario registrado correctamente';
	ELSE
		SET resultado = 'El email ya tiene una cuenta asociada';
	END IF;
END; %

-- 2. Insertar Especialista ****

DELIMITER %
CREATE PROCEDURE BasePT.insertarEspecialista(IN nombre VARCHAR(25), 
									IN  apellidoPaterno VARCHAR(25), 
									IN apellidoMaterno VARCHAR(25), 
									IN email VARCHAR(30), 
									IN passEspecialista VARCHAR(30), 
									IN genero ENUM('Masculino','Femenino'),
									IN foto LONGBLOB,
                                    OUT resultado VARCHAR(100))
BEGIN
	IF NOT EXISTS (SELECT e.id_especialista FROM BasePT.especialista AS e WHERE e.emailEspecialista=email) 
	THEN
		INSERT INTO BasePT.especialista(nombreEspecialista,
										apPaternoEspecialista,
										apMaternoEspecialista,
										emailEspecialista,
										passEspecialista,
										generoEspecialista,
										fotoEspecialista) 
		VALUES(nombre,apellidoPaterno,apellidoMaterno,email,passEspecialista,genero,foto);
		SET resultado = 'Usuario registrado correctamente';
	ELSE
		SET resultado = 'El email ya tiene una cuenta asociada';
	END IF;
END; %

-- 3. Insertar Paciente ****
DELIMITER %
CREATE PROCEDURE BasePT.insertarPaciente(IN id_especialista INT,
								  IN nombre VARCHAR(25), 
								  IN apellidoPaterno VARCHAR(25), 
								  IN apellidoMaterno VARCHAR(25),
                                  IN padecimiento VARCHAR(25),
								  IN edad INT,
								  IN email VARCHAR(30), 
								  IN passPaciente VARCHAR(30), 
								  IN genero ENUM('Masculino','Femenino'),
								  IN foto LONGBLOB,
                                  OUT resultado VARCHAR(100))
BEGIN
		IF NOT EXISTS (SELECT p.id_paciente FROM BasePT.paciente AS p WHERE p.emailPaciente=email) 
		THEN
			IF EXISTS (SELECT e.id_especialista FROM especialista AS e WHERE e.id_especialista=id_especialista)
            THEN
				INSERT INTO BasePT.paciente(id_especialista,
												nombrePaciente,
												apPaternoPaciente,
												apMaternoPaciente,
                                                padecimientoPaciente,
												edadPaciente,
												emailPaciente,
												passPaciente,
												generoPaciente,
												fotoPaciente) 
				VALUES(id_especialista,nombre,apellidoPaterno,apellidoMaterno,padecimiento,edad,email,passPaciente,genero,foto);
				
				SET resultado = 'Usuario registrado correctamente';
			ELSE
				SET resultado = 'No existe el especialista que se ingresó';
            END IF;
			ELSE
				SET resultado = 'El email ya tiene una cuenta asociada';
		END IF;
	
END; %

-- Insertar dispositivos adquisicion

DELIMITER %
CREATE PROCEDURE BasePT.insertarDispositivo(IN paciente_id INT,
								  IN nombreDispositivo VARCHAR(25), 
								  IN direccionMAC VARCHAR(20), 
                                  OUT respuesta VARCHAR(100))
BEGIN
	IF NOT EXISTS (SELECT da.id_dispositivo FROM BasePT.dispositivosAdquisicion AS da join BasePT.paciente AS p 
				ON da.id_paciente=p.id_paciente AND p.id_paciente=paciente_id and da.direccionMAC=direccionMAC)
	THEN
		INSERT INTO BasePT.dispositivosAdquisicion(id_paciente, nombreDispositivo, direccionMAC) 
				VALUES(paciente_id, nombreDispositivo, direccionMAC);
		SET respuesta = 'Dispositivo agregado correctamente';		
    ELSE
		SET respuesta = CONCAT('Error, El dispositivo ', direccionMAC,' ya esta agregado');
    END IF;

END; %

-- drop procedure
-- 4. Insertar Cita

DELIMITER %
CREATE PROCEDURE BasePT.insertarCita(IN id_paciente INT,
								  IN fechaCita DATE, 
								  IN horaCita TIME,
								  IN duracionCita TIME,
								  IN observaciones VARCHAR(200),
                                  IN electrodos VARCHAR(1000),
								  OUT respuesta VARCHAR(100))
BEGIN
	IF EXISTS (SELECT p.id_paciente FROM BasePT.paciente AS p WHERE p.id_paciente=id_paciente)
	THEN
		INSERT INTO BasePT.cita(id_paciente,
									fechaCita,
									horaCita,
									duracionCita,
									observaciones,
                                    electrodos) 
		VALUES(id_paciente, fechaCita, horaCita, duracionCita, observaciones, electrodos);
		SET respuesta='Cita registrada correctamente';
	ELSE
		SET respuesta = 'Error, El ID del paciente ingresado no existe';
	END IF;
END; %



-- 5. Insertar Grbacion

DELIMITER %
CREATE PROCEDURE BasePT.insertarGrabacion(IN folio_cita INT,
										IN nombreArchivo VARCHAR(100), 
										OUT respuesta INT)
BEGIN
	IF NOT EXISTS (SELECT id_grabacion from BasePT.grabacionCanal as g where g.nombreArchivo=nombreArchivo)
	THEN
		INSERT INTO BasePT.grabacionCanal(folio_cita,
									nombreArchivo) 
		VALUES(folio_cita, nombreArchivo);
		set respuesta =  LAST_INSERT_ID();
	ELSE
		set respuesta = -1;
	END IF;
END; %



-- 6. Insertar Resultados Generales

DELIMITER %
CREATE PROCEDURE BasePT.insertarResultadosGenerales(IN folio_cita INT,
													IN zonaCerebral VARCHAR(25),
													IN tipoOndaDominante ENUM('Frecuencia-alpha', 'Ritmo-alpha', 'Frecuencia-beta', 'Ritmo-beta',
																			  'Frecuencia-delta', 'Ritmo-delta', 'Frecuencia-theta','Ritmo-theta',
																			  'Frecuencia-gamma', 'Ritmo-gamma', 'No-asignado'),
													IN porcentajeTipoOnda DOUBLE, 
													OUT respuesta varchar(100))
BEGIN
		INSERT INTO BasePT.resultadosGenerales(folio_cita,
												zonaCerebral,
												tipoOndaDominante,
												porcentajeTipoOnda) 
		VALUES(folio_cita, zonaCerebral, tipoOndaDominante, porcentajeTipoOnda);
		SET respuesta = 'Resultados almacenados correctamente';
END; %


-- 7. Insertar Resultados Segmento

DELIMITER %
CREATE PROCEDURE BasePT.insertarResultadosSegmento(IN id_grabacion INT,
													IN segundo INT,
													IN canal VARCHAR(15),
													IN frecuenciaDominante DOUBLE,
													IN tipoOnda ENUM('Ritmo-alpha', 'Frecuencia-alpha', 'Ritmo-beta',  'Frecuencia-beta', 
																	 'Ritmo-delta', 'Frecuencia-delta', 'Ritmo-theta', 'Frecuencia-theta', 
																	 'Ritmo-gamma', 'Frecuencia-gamma', 'No-asignado'),
													senal NVARCHAR(10240),
													OUT respuesta varchar(100))
BEGIN
	IF EXISTS ( SELECT g.id_grabacion FROM BasePT.grabacionCanal AS g WHERE g.id_grabacion=id_grabacion)
    THEN
		INSERT INTO BasePT.resultadoSegmento(id_grabacion,
												segundo,
												canal,
												frecuenciaDominante,
                                                tipoOnda,
                                                senal) 
		VALUES(id_grabacion, segundo, canal, frecuenciaDominante, tipoOnda, senal);
		SET respuesta = 'Resultados almacenados corresctamente';
    ELSE
		SET respuesta = 'El ID de la grabacion no existe';
    END IF;
END; %



DELIMITER %
CREATE PROCEDURE BasePT.insertarResultadosCanal(IN id_grabacion INT,
												IN canal VARCHAR(15),
												IN tipoOndaDominanteCanal ENUM('Ritmo-alpha',  'Frecuencia-alpha', 'Ritmo-beta', 'Frecuencia-beta', 
																			   'Ritmo-delta', 'Frecuencia-delta','Ritmo-theta','Frecuencia-theta', 
																			   'Ritmo-gamma', 'Frecuencia-gamma','No-asignado'),
												IN frecuenciaDominanteCanal DOUBLE,
												IN promedioAmplitudesCanal DOUBLE,
												IN porcentajeAparicionRitmoAlpha DOUBLE,
												IN porcentajeAparicionRitmoBeta DOUBLE,
												IN porcentajeAparicionRitmoDelta DOUBLE,
												IN porcentajeAparicionRitmoTheta DOUBLE,
												IN porcentajeAparicionFrecuenciaAlpha DOUBLE,
												IN porcentajeAparicionFrecuenciaBeta DOUBLE,
												IN porcentajeAparicionFrecienciaDelta DOUBLE,
												IN porcentajeAparicionFrecuenciaTheta DOUBLE,
												IN promedioAmplitudesRitmoAlpha DOUBLE,
												IN promedioAmplitudesRitmoBeta DOUBLE,
												IN promedioAmplitudesRitmoDelta DOUBLE,
												IN promedioAmplitudesRitmoTheta DOUBLE,
												IN promedioAmplitudesFrecuenciaAlpha DOUBLE,
												IN promedioAmplitudesFrecuenciaBeta DOUBLE,
												IN promedioAmplitudesFrecuenciaDelta DOUBLE,
												IN promedioAmplitudesFrecuenciaTheta DOUBLE,
												IN promedioFrecuenciasRitmoAlpha DOUBLE,
												IN promedioFrecuenciasRitmoBeta DOUBLE,
												IN promedioFrecuenciasRitmoDelta DOUBLE,
												IN promedioFrecuenciasRitmoTheta DOUBLE,
												IN promedioFrecuenciasFrecuenciaAlpha DOUBLE,
												IN promedioFrecuenciasFrecuenciaBeta DOUBLE,
												IN promedioFrecuenciasFrecuenciaDelta DOUBLE,
												IN promedioFrecuenciasFrecuenciaTheta DOUBLE,
												OUT respuesta varchar(100))
BEGIN
	IF EXISTS ( SELECT gc.id_grabacion FROM BasePT.grabacionCanal AS gc WHERE gc.id_grabacion = id_grabacion)
    THEN
		INSERT INTO BasePT.resultadoCanal(id_grabacion,
											canal,
											tipoOndaDominanteCanal,
											frecuenciaDominanteCanal,
											promedioAmplitudesCanal,
											porcentajeAparicionRitmoAlpha,
											porcentajeAparicionRitmoBeta,
											porcentajeAparicionRitmoDelta,
											porcentajeAparicionRitmoTheta,
											porcentajeAparicionFrecuenciaAlpha,
											porcentajeAparicionFrecuenciaBeta,
											porcentajeAparicionFrecienciaDelta,
											porcentajeAparicionFrecuenciaTheta,
											promedioAmplitudesRitmoAlpha,
											promedioAmplitudesRitmoBeta,
											promedioAmplitudesRitmoDelta,
											promedioAmplitudesRitmoTheta,
											promedioAmplitudesFrecuenciaAlpha,
											promedioAmplitudesFrecuenciaBeta,
											promedioAmplitudesFrecuenciaDelta,
											promedioAmplitudesFrecuenciaTheta,
                                            promedioFrecuenciasRitmoAlpha,
											promedioFrecuenciasRitmoBeta,
											promedioFrecuenciasRitmoDelta,
											promedioFrecuenciasRitmoTheta,
											promedioFrecuenciasFrecuenciaAlpha,
											promedioFrecuenciasFrecuenciaBeta,
											promedioFrecuenciasFrecuenciaDelta,
											promedioFrecuenciasFrecuenciaTheta) 
		VALUES(id_grabacion,canal,tipoOndaDominanteCanal,frecuenciaDominanteCanal,promedioAmplitudesCanal,
				porcentajeAparicionRitmoAlpha,porcentajeAparicionRitmoBeta,porcentajeAparicionRitmoDelta,
				porcentajeAparicionRitmoTheta,porcentajeAparicionFrecuenciaAlpha,porcentajeAparicionFrecuenciaBeta,
				porcentajeAparicionFrecienciaDelta,porcentajeAparicionFrecuenciaTheta,promedioAmplitudesRitmoAlpha,
				promedioAmplitudesRitmoBeta,promedioAmplitudesRitmoDelta,promedioAmplitudesRitmoTheta,
				promedioAmplitudesFrecuenciaAlpha,promedioAmplitudesFrecuenciaBeta,promedioAmplitudesFrecuenciaDelta,
				promedioAmplitudesFrecuenciaTheta,promedioFrecuenciasRitmoAlpha,promedioFrecuenciasRitmoBeta,
				promedioFrecuenciasRitmoDelta,promedioFrecuenciasRitmoTheta,promedioFrecuenciasFrecuenciaAlpha,
				promedioFrecuenciasFrecuenciaBeta,promedioFrecuenciasFrecuenciaDelta,promedioFrecuenciasFrecuenciaTheta);
		SET respuesta = 'Resultados almacenados corresctamente';
    ELSE
		SET respuesta = 'El ID de la grabacion no existe';
    END IF;
END; %

-- 9. Insertar Estudio
/*
DELIMITER %
CREATE PROCEDURE BasePT.insertarEstudio(IN folio_cita INT,
									  IN id_resutadosGenerales INT,
									  IN fechaEstudio DATE, 
									  IN duracionEstudio TIME,
									  OUT respuesta VARCHAR(100))
BEGIN
	IF EXISTS (SELECT c.folio_cita FROM BasePT.cita AS c WHERE c.folio_cita=folio_cita)
	THEN
		IF EXISTS (SELECT rg.id_resultadosGenerales FROM BasePT.resultadosgenerales AS rg WHERE rg.id_resultadosGenerales=id_resutadosGenerales)
		THEN
			INSERT INTO BasePT.estudio(folio_cita,
										id_resultadosGenerales,
										fechaEstudio,
										duracionEstudio) 
			VALUES(folio_cita, id_resultadosGenerales, fechaEstudio, duracionEstudio);
			SET respuesta = 'Estudio registrado correctamente';
		ELSE
			SET respuesta = 'No existe el ID correspondiente a los resultados generales';
		END IF;
	ELSE
		SET respuesta = 'El folio de la cita ingresada no existe';
	END IF;
END; %
*/
-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- << Procedimiento para obtener datos apartir de un Log In <<
-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

DELIMITER %
CREATE PROCEDURE BasePT.obtenerDatosUsuario (IN email varchar(30),
                                        IN hashPassword varchar(30),
                                       OUT respuesta int)
                                             
BEGIN
    -- si es un paciente
    IF EXISTS (select p.id_paciente from BasePT.paciente as p where p.emailPaciente=email)
    THEN
        -- si su email y el password coinciden
        IF EXISTS (select p.id_paciente from BasePT.paciente as p where p.emailPaciente=email and p.passPaciente=hashPassword)
        THEN
            -- Obtiene un paciente
            select p.id_paciente,p.id_especialista, e.nombreEspecialista, p.nombrePaciente, p.apPaternoPaciente, p.apMaternoPaciente, p.padecimientoPaciente, p.edadPaciente, p.emailPaciente, p.generoPaciente, p.fotoPaciente
            from BasePT.paciente  as p JOIN BasePT.especialista as e
            on p.id_especialista = e.id_especialista
            and p.emailPaciente=email;
            set respuesta =  1; -- tipo usuario paciente
        ELSE
            set respuesta = 0; -- contraseña incorrecta
            END IF;
    -- si es un especialista
    ELSEIF EXISTS (select e.id_especialista from BasePT.especialista as e where e.emailEspecialista=email)
    THEN
        -- si su email y password coinciden
        IF EXISTS (select e.id_especialista from BasePT.especialista as e where e.emailEspecialista=email and e.passEspecialista=hashPassword)
        THEN
            -- Obtiene un especialista
            select e.id_especialista,e.nombreEspecialista,e.apPaternoEspecialista,e.apMaternoEspecialista,e.emailEspecialista,e.generoEspecialista,e.fotoEspecialista
            from BasePT.especialista as e
            where e.emailEspecialista=email;
            set respuesta =  2; -- tipo usuario igual especialista
        ELSE
            set respuesta = 0; -- contraseña incorrecta
        END IF;
    -- si es un administrador
    ELSEIF EXISTS (select a.id_administrador from BasePT.administrador as a where a.emailAdministrador = email)
    THEN
        -- si su email y password coinciden
        IF EXISTS (select a.id_administrador from BasePT.administrador as a where a.emailAdministrador =  email and a.passAdministrador = hashPassword)
        THEN
            -- Obtiene un administrador
            select * 
            from BasePT.administrador as a
            where a.emailAdministrador = email;
            set respuesta = 3; -- tipo usuario igual a Administrador
        ELSE
            set respuesta = 0; -- contraseña incorrecta
        END IF;
    ELSE
        set respuesta = -1; -- no tiene cuenta
    END IF;
    -- END IF;
END; %
 

-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- <<< Obtiene los datos del paciente excepto el password <<<
-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

-- **********

DELIMITER %
CREATE PROCEDURE BasePT.mostrarDatosPaciente (IN paciente_id int,
									   OUT respuesta VARCHAR(100))
                                            
BEGIN
	-- si existe el ID del paciente
	IF EXISTS (SELECT p.id_paciente FROM BasePT.paciente AS p WHERE p.id_paciente=paciente_id)
	THEN
		-- Obtiene un paciente
        SELECT p.id_paciente, p.id_especialista , p.nombrePaciente, p.apPaternoPaciente, p.apMaternoPaciente, p.padecimientoPaciente, p.edadPaciente, p.emailPaciente, p.generoPaciente, p.fotoPaciente
        FROM BasePT.paciente AS p 
        WHERE p.id_paciente=paciente_id;
		
        set respuesta =  'OK';
	ELSE
		set respuesta = 'El usuario no existe';
	END IF;
END; %

-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- << Obtiene los datos de los dispositivos de un paciente <<
-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

-- **********

DELIMITER %
CREATE PROCEDURE BasePT.mostrarDispositivosPaciente (IN paciente_id int,
									   OUT respuesta VARCHAR(100))
                                            
BEGIN
	-- si existe el ID del paciente
	IF EXISTS (SELECT p.id_paciente FROM BasePT.paciente AS p WHERE p.id_paciente=paciente_id)
	THEN
		IF EXISTS (SELECT da.id_dispositivo FROM BasePT.dispositivosAdquisicion AS da join BasePT.paciente AS p 
				ON da.id_paciente=p.id_paciente AND p.id_paciente=paciente_id)
		THEN
			-- Obtiene un paciente
			SELECT *
			FROM BasePT.dispositivosAdquisicion AS da
			WHERE da.id_paciente=paciente_id;
			
			set respuesta =  'OK';
        ELSE
			set respuesta =  'El paciente aun no tiene dispositivos registrados';
        END IF;
	ELSE
		set respuesta = 'El usuario no existe';
	END IF;
END; %


-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- < Obtiene los datos del especialista excepto el password <
-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

 -- **********
 
DELIMITER %
CREATE PROCEDURE BasePT.mostrarDatosEspecialista (IN especialista_id int,
												  OUT respuesta VARCHAR(100))
BEGIN
	-- si existe el id del paciente
	IF EXISTS (SELECT e.id_especialista FROM BasePT.especialista AS e WHERE e.id_especialista=especialista_id)
	THEN
		-- Obtiene un especialista
        SELECT e.id_especialista, e.nombreEspecialista, e.apPaternoEspecialista, e.apMaternoEspecialista, e.emailEspecialista, e.generoEspecialista, e.fotoEspecialista
        FROM BasePT.especialista AS e 
        WHERE e.id_especialista=especialista_id;
		
        set respuesta =  'OK';
	ELSE
		set respuesta = 'El usuario no existe';
	END IF;
END; %

-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- < Despliega una lista de los especialistas con sus datos <
-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

DELIMITER %
CREATE PROCEDURE BasePT.mostrarEspecialistas (OUT respuesta VARCHAR(100))
BEGIN
		-- Obtiene los especialistas disponibles
        SELECT e.id_especialista, e.nombreEspecialista, e.apPaternoEspecialista, e.apMaternoEspecialista, e.emailEspecialista, e.generoEspecialista, e.fotoEspecialista
        FROM BasePT.especialista AS e;
        set respuesta =  'OK';

END; %

-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- << Obtiene un listado de los pacientes correspondientes <<
-- << 				a al ID del especialista               <<
-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

-- ************************

DELIMITER %
CREATE PROCEDURE BasePT.mostrarPacientesDeEspecialista (IN especialista_id INT,
														OUT respuesta VARCHAR(100))
BEGIN
	IF EXISTS (SELECT e.id_especialista FROM BasePT.especialista AS e WHERE e.id_especialista=especialista_id)
    THEN
		-- Obtiene los especialistas disponibles
        SELECT p.id_paciente, p.id_especialista, p.nombrePaciente, p.apPaternoPaciente, p.apMaternoPaciente, p.padecimientoPaciente, p.edadPaciente, p.emailPaciente, p.generoPaciente, p.fotoPaciente
        FROM BasePT.paciente AS p JOIN BasePT.especialista AS e 
        ON p.id_especialista=e.id_especialista
        AND e.id_especialista=especialista_id;
        set respuesta =  'OK';
	ELSE
		set respuesta =  'El ID del especialista no existe';
    END IF;
END; %

-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- << Obtiene la informacion de la cita correspondiente al << 
-- << 					ID del paciente				  	   <<
-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

-- ***********************

DELIMITER %
CREATE PROCEDURE BasePT.mostrarCitaPaciente (IN cita_id INT,
											IN paciente_id INT,
											OUT respuesta VARCHAR(100))
BEGIN
	IF EXISTS (SELECT c.folio_cita FROM BasePT.cita AS c WHERE c.folio_cita=cita_id)
	THEN
		IF EXISTS (SELECT p.id_paciente FROM BasePT.paciente AS p WHERE p.id_paciente=paciente_id)
		THEN
			-- Obtiene los especialistas disponibles
			SELECT c.folio_cita, c.id_paciente, c.fechaCita, c.horaCita, c.duracionCita, c.observaciones, c.electrodos
			FROM BasePT.paciente AS p JOIN BasePT.cita AS c
			ON p.id_paciente=c.id_paciente
			AND p.id_paciente=paciente_id
			AND c.folio_cita=cita_id;
			SET respuesta =  'OK';
		ELSE
			SET respuesta =  'El ID del paciente no existe';
		END IF;
	ELSE
		SET respuesta =  'El ID de la cita no existe';
	END IF;
END; %

-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- << Obtiene un listado de las citas correspondientes al  <<
-- <<                ID de un paciente					   <<
-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

DELIMITER %
CREATE PROCEDURE BasePT.obtenerCitasPaciente (IN paciente_id INT,
												OUT respuesta VARCHAR(100))
BEGIN
	IF EXISTS (SELECT p.id_paciente FROM BasePT.paciente AS p WHERE p.id_paciente=paciente_id)
    THEN
		-- Obtiene los especialistas disponibles
        SELECT c.folio_cita, c.id_paciente, c.fechaCita, c.horaCita, c.duracionCita, c.observaciones, c.electrodos
        FROM BasePT.paciente AS p JOIN BasePT.cita AS c
        ON p.id_paciente=c.id_paciente
        AND p.id_paciente=paciente_id;
        set respuesta =  'OK';
	ELSE
		set respuesta =  'El ID del paciente no existe';
    END IF;
END; %


DELIMITER %
CREATE PROCEDURE BasePT.mostrarEstudioPaciente (IN folio_cita INT,
												IN paciente_id INT,
												OUT respuesta VARCHAR(100))
BEGIN
	IF EXISTS (SELECT p.id_paciente FROM BasePT.paciente AS p WHERE p.id_paciente=paciente_id)
    THEN
		
        SELECT rg.id_grabacion, c.folio_cita, rg.id_resultadosGenerales, c.fechaCita, c.horaCita, c.duracionCita, c.electrodos,
				rg.zonaCerebral, rg.tipoOndaDominante, rg.porcentajeTipoOnda
        FROM BasePT.cita AS c JOIN BasePT.resultadosgenerales AS rg
        ON c.folio_cita=rg.folio_cita
        AND c.folio_cita=folio_cita
        AND c.id_paciente = paciente_id
        AND rg.id_grabacion IN
			(SELECT id_grabacion 
			FROM BasePT.paciente AS p JOIN BasePT.grabacion AS g
			ON p.id_paciente=g.id_paciente
			AND p.id_paciente=paciente_id);
        set respuesta =  'OK';
	ELSE
		set respuesta =  'El ID del paciente no existe';
    END IF;
END; %

-- 8. Mostrar resultados por canal

DELIMITER %
CREATE PROCEDURE BasePT.mostrarResultadosPorCanal (IN folio_cita INT,
												IN canal varchar(15),
												OUT respuesta VARCHAR(100))
BEGIN
	IF EXISTS (SELECT c.folio_cita FROM BasePT.cita AS c WHERE c.folio_cita = folio_cita)
    THEN
		-- Obtiene los resultados de todos los seguntos
        SELECT * 
        FROM BasePT.resultadoCanal AS rc
        WHERE rc.id_grabacion IN
			(SELECT gc.id_grabacion
			FROM BasePT.cita AS c JOIN BasePT.grabacionCanal AS gc
			ON gc.folio_cita = c.folio_cita) AND rc.canal = canal;
        set respuesta =  'OK';
	ELSE
		set respuesta =  'El ID del paciente no existe';
    END IF;
END; %

-- 8. Mostrar resultados por segmentos de un segundo

DELIMITER %
CREATE PROCEDURE BasePT.mostrarResultadosPorSegmento (IN folio_cita INT,
														IN canal varchar(15),
														IN segundo INT,
														OUT respuesta VARCHAR(100))
BEGIN
	IF EXISTS (SELECT c.folio_cita FROM BasePT.cita AS c WHERE c.folio_cita = folio_cita)
    THEN
		-- Obtiene los resultados de un segundo de grabacion de un canal
        SELECT * 
        FROM BasePT.resultadoSegmento AS rs
        WHERE rs.id_grabacion IN
			(SELECT gc.id_grabacion
			FROM BasePT.grabacionCanal AS gc JOIN BasePT.cita AS c
			ON gc.folio_cita = c.folio_cita)
		AND rs.canal = canal
        AND rs.segundo = segundo;
        set respuesta =  'OK';
	ELSE
		set respuesta =  'El folio de la cita no existe';
    END IF;
END; % 

-- Obtención de las citas próximas de un especialista de sus diversos pacientes
 
DELIMITER %
CREATE PROCEDURE obtenerCitasPorEspecialista (IN especialista_id INT, 
                        OUT resultado varchar(100))
BEGIN
    IF EXISTS (select e.id_especialista from BasePT.especialista as e where e.id_especialista = especialista_id)
    THEN
        -- obtener todos los pacientes de ese especialista
        SELECT * FROM BasePT.cita as c JOIN
        (SELECT p.id_paciente, p.id_especialista, p.nombrePaciente, p.apPaternoPaciente, p.apMaternoPaciente, p.padecimientoPaciente, p.edadPaciente, p.emailPaciente, p.generoPaciente, p.fotoPaciente
        FROM BasePT.paciente AS p JOIN BasePT.especialista AS e 
        ON p.id_especialista = e.id_especialista
            AND e.id_especialista = especialista_id) AS pac ON pac.id_paciente = c.id_paciente
            AND c.fechaCita >= now() order by c.fechaCita asc  LIMIT 6;
	END IF;
END; %

/*DELIMITER %
CREATE PROCEDURE BasePT.mostrarResultadosVariosSegmentos (IN paciente_id INT,
														IN desdeSegundo INT,
														IN hastaSegundo INT,
														OUT respuesta VARCHAR(100))
BEGIN
	IF EXISTS (SELECT p.id_paciente FROM BasePT.paciente AS p WHERE p.id_paciente=paciente_id)
    THEN
		-- Obtiene los resultados de un intervalo
        SELECT * 
        FROM BasePT.resultadosegmento AS rs
        WHERE rs.id_grabacion IN
			(SELECT g.id_grabacion
			FROM BasePT.paciente AS p JOIN BasePT.grabacionCanal AS g
			ON p.id_paciente=g.id_paciente
			AND p.id_paciente=paciente_id)
		AND rs.segundo BETWEEN desdeSegundo AND hastaSegundo;
        set respuesta =  'OK';
	ELSE
		set respuesta =  'El ID del paciente no existe';
    END IF;
END; % */

-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- >>>>>>>>>>>>>>>Procedimientos de actualización de datos <<<<<<<<<<<<<<<<<<<<
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

-- 1. Actualizar datos del Especialista

DELIMITER %
CREATE PROCEDURE actualizarDatosEspecialista(IN especialista_id int,
											 IN nombre varchar(25), 
									         IN apellidoPaterno varchar(25), 
									         IN apellidoMaterno varchar(25), 
									         IN email varchar(25), 
									         IN passEspecialistaN varchar(15), 
									         IN genero enum('Masculino','Femenino'),
									         IN foto longblob,
											 OUT resultado VARCHAR(100))
BEGIN
	IF EXISTS (SELECT id_especialista from BasePT.especialista where id_especialista = especialista_id) THEN

		UPDATE BasePT.especialista
        SET nombreEspecialista = nombre,
			apPaternoEspecialista = apellidoPaterno,
            apMaternoEspecialista = apellidoMaterno,
            emailEspecialista = email,
            passEspecialista = passEspecialistaN,
            generoEspecialista = genero,
            fotoEspecialista = foto
        WHERE id_especialista = especialista_id;
		SET resultado = 'Datos de usuario actualizados correctamente';
	ELSE
		SET resultado = 'El usuario no existe';
	END IF;
END; %

-- 2. Actualizar datos del paciente

DELIMITER %
CREATE PROCEDURE actualizarDatosPaciente(IN paciente_id int,
										 IN nombre varchar(25), 
										 IN apellidoPaterno varchar(25), 
										 IN apellidoMaterno varchar(25),
										 IN padecimiento varchar(25),
										 IN edad int,
										 IN email varchar(25), 
										 IN passPacienteN varchar(15), 
										 IN genero enum('Masculino','Femenino'),
										 IN foto longblob,
										 OUT resultado VARCHAR(100))
BEGIN
	IF EXISTS (SELECT id_paciente from BasePT.paciente where id_paciente = paciente_id) THEN

		UPDATE BasePT.paciente
        SET nombrePaciente = nombre,
			apPaternoPaciente = apellidoPaterno,
            apMaternoPaciente = apellidoMaterno,
			padecimientoPaciente = padecimiento,
            edadPaciente = edad,
            emailPaciente = email,
            passPaciente = passEspecialistaN,
            generoPaciente = genero,
            fotoPaciente = foto
        WHERE id_paciente = paciente_id;
		SET resultado = 'Datos de usuario actualizados correctamente';
	ELSE
		SET resultado = 'El usuario no existe';
	END IF;
END; %

-- 3. Actualizar datos de la cita

DELIMITER %
CREATE PROCEDURE actualizarDatosCita(IN cita_folio int,
									 IN fechaCitaN DATE,
									 IN horaCitaN TIME,
									 IN duracionN TIME,
									 IN observacionesN VARCHAR(200),
                                     IN electrodosN VARCHAR(1000),
									 OUT resultado VARCHAR(100))
BEGIN
	IF EXISTS (SELECT folio_cita from BasePT.cita where folio_cita = cita_folio) THEN

		UPDATE BasePT.cita
        SET fechaCita = fechaCitaN,
			horaCita = horaCitaN,
			duracionCita = duracionN,
            observaciones = observacionesN,
            electrodos = electrodos
        WHERE folio_cita = cita_folio;
		SET resultado = 'Datos de la cita actualizados correctamente';
	ELSE
		SET resultado = 'La cita no existe';
	END IF;
END; %


-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- >>>>>>>>>>>>>Prodcedimeintos de eliminación de datos <<<<<<<<<<<<<<<<<<<<
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

/* -- Eliminar resultado de un segmento

DELIMITER %
CREATE PROCEDURE eliminarResultadoSegmento (IN resultadoSegmento_id int,
											OUT respuesta varchar(100))
                                            
BEGIN
	IF EXISTS (select id_resultadoSegmento from BasePT.resultadoSegmento
			   where BasePT.resultadoSegmento.id_resultadoSegmento = resultadoSegmento_id)
	THEN
		delete from BasePT.resultadoSegmento where id_resultadoSegmento = resultadoSegmento_id;
        set respuesta =  'Datos eliminados correctamente';
	ELSE
		set respuesta = 'No existen los datos a eliminar';
	END IF;
END; %

-- Eliminar resultado de un canal

DELIMITER %
CREATE PROCEDURE eliminarResultadoCanal (IN resultadoCanal_id int,
										 OUT respuesta varchar(100))
                                            
BEGIN
	IF EXISTS (select id_resultadoCanal from BasePT.resultadoCanal
			   where BasePT.resultadoCanal.id_resultadoCanal = resultadoCanal_id)
	THEN
		delete from BasePT.resultadoCanal where id_resultadoCanal = resultadoCanal_id;
        set respuesta =  'Datos eliminados correctamente';
	ELSE
		set respuesta = 'No existen los datos a eliminar';
	END IF;
END; %

-- Eliminar Grabación de un canal

DELIMITER %
CREATE PROCEDURE eliminarGrabacion(IN grabacion_id int, 
								  OUT resultado varchar(100))
BEGIN
	IF EXISTS (SELECT id_grabacion from BasePT.grabacionCanal where BasePT.grabacionCanal.id_grabacion = grabacion_id)
	THEN

		-- elimna el resultado del segmento asociado a la grabacion a eliminar 
		delete from BasePT.resultadoSegmento where id_grabacion = grabacion_id;
		-- elimna el resultado de canal asociado a la grabacion a eliminar 
		delete from BasePT.resultadoCanal where id_grabacion = grabacion_id;

		delete from BasePT.grabacionCanal where BasePT.grabacionCanal.id_grabacion = grabacion_id;
		set resultado = 'Datos eliminados correctamente';
	ELSE
		set resultado = 'No existen los datos a eliminar';
	END IF;
END; %

-- Eliminar Resultados Generales

DELIMITER %
CREATE PROCEDURE eliminarResultadosGenerales(IN resultadosGenerales_id int, 
								             OUT resultado varchar(100))
BEGIN
	IF EXISTS (SELECT id_resultadosGenerales from BasePT.resultadosGenerales 
			   where BasePT.resultadosGenerales.id_resultadosGenerales = resultadosGenerales_id)
	THEN
		-- elimina los resultadoSegmento asociados a los resultados generalea a eliminar 
		delete from BasePT.resultadoSegmento
		where BasePT.resultadoSegmento.id_resultadoSegmento = (
		select id_resultadoSegmento from resultadoSegmento where id_grabacion = 
									(select id_grabacion from resultadosGenerales
									where id_resultadosGenerales = resultadosGenerales_id));
		-- elimina los resultadoCanal asociado a los resultados generalea a eliminar
		delete from BasePT.resultadoCanal
		where BasePT.resultadoCanal.id_resultadoCanal = (
		select id_resultadoCanal from resultadoCanal where id_grabacion = 
									(select id_grabacion from resultadosGenerales
									where id_resultadosGenerales = resultadosGenerales_id));
		-- elimina la la grabacion asociada a los resultados generales 
		delete from BasePT.grabacionCanal
		where BasePT.grabacionCanal.id_grabacion = (
		select id_grabacion from resultadosGenerales
							where id_resultadosGenerales = resultadosGenerales_id);

		delete from BasePT.resultadosGenerales 
        where BasePT.resultadosGenerales.id_resultadosGenerales = resultadosGenerales_id;
		set resultado = 'Datos eliminados correctamente';
	ELSE
		set resultado = 'No existen los datos a eliminar';
	END IF;
END; %

*/
-- Eliminar cita (con o sin resultados)

DELIMITER %
CREATE PROCEDURE eliminarCita (IN cita_folio int,
							   OUT resultado varchar(100))
                                            
BEGIN
	
    set FOREIGN_KEY_CHECKS  = 0;
    set SQL_SAFE_UPDATES = 0;

	IF EXISTS (SELECT c.folio_cita FROM BasePT.cita AS c
			   where c.folio_cita = cita_folio)
	THEN
		
		if exists (select rs.id_resultadosGenerales from BasePT.resultadosGenerales as rs where rs.folio_cita = cita_folio)
		THEN
		-- elimina los resultados generales asociados
			delete from BasePT.resultadosGenerales
			where BasePT.resultadosGenerales.folio_cita = cita_folio;
		
		-- elimina los resultados de cada segemento de todos los canales registrados en esta cita
			delete from BasePT.resultadoSegmento
            where BasePT.resultadoSegmento.id_grabacion in (
				select gc.id_grabacion from BasePT.grabacionCanal as gc
                where gc.folio_cita = cita_folio);
                
		-- elimina los resultados de cada canal de la cita
			delete from BasePT.resultadoCanal
            where BasePT.resultadoCanal.id_grabacion in (
				select gc.id_grabacion from BasePT.grabacionCanal as gc
                where gc.folio_cita = cita_folio);
			
		-- elimina las grabaciones de cada canal
			delete from BasePT.grabacionCanal
            where BasePT.grabacionCanal.folio_cita = cita_folio;
        
        -- elimina la cita
			delete from BasePT.cita where BasePT.cita.folio_cita = cita_folio;
			set resultado =  'Datos eliminados correctamente';
		else
			delete from BasePT.cita where BasePT.cita.folio_cita = cita_folio;
			SET resultado = 'Datos eliminados correctamente';
		END IF;
	ELSE
		set resultado = 'No existe la cita a eliminar';
	END IF;
    
    set FOREIGN_KEY_CHECKS  = 1;
    set SQL_SAFE_UPDATES = 1;
    
END; %


-- Eliminar dispositivo paciente (bien)

DELIMITER %
CREATE PROCEDURE eliminarDispositivoPaciente(IN dispositivo_id int, 
											 IN paciente_id int,
								  OUT resultado varchar(100))
BEGIN
	IF EXISTS (SELECT p.id_paciente from BasePT.paciente as p where p.id_paciente  = paciente_id)
	THEN
		IF EXISTS (SELECT da.id_dispositivo from BasePT.dispositivosadquisicion as da where da.id_dispositivo  = dispositivo_id)
		THEN
			IF EXISTS (SELECT da.id_dispositivo from BasePT.dispositivosadquisicion as da join BasePT.paciente as p
			on da.id_paciente=p.id_paciente and da.id_dispositivo=dispositivo_id)
			THEN
				-- elimna el resultado del segmento asociado a la grabacion a eliminar 
				delete from BasePT.dispositivosadquisicion where id_dispositivo = dispositivo_id and id_paciente= paciente_id;
				set resultado = 'OK';
			ELSE
				set resultado = 'Este dispositivo no esta asociado al paciente';
			END IF;
		ELSE
			set resultado = 'Este dispositivo no existe';
        END IF;
	ELSE
		set resultado = 'No existen el usuario';
	END IF;
END; %

-- Eliminar un paciente

DELIMITER %
CREATE PROCEDURE eliminarPaciente (IN paciente_id int,
							   OUT resultado varchar(100))
                                            
BEGIN
	
    set FOREIGN_KEY_CHECKS  = 0;
    set SQL_SAFE_UPDATES = 0; -- necesarias para eliminar mas de un registro

	IF EXISTS (SELECT p.id_paciente FROM BasePT.paciente AS p
			   where p.id_paciente = paciente_id)
	THEN
		IF EXISTS (select da.id_dispositivo from BasePT.dispositivosAdquisicion as da where da.id_paciente = paciente_id)
        THEN 
        -- elimina los dispositivos que tenga registrado el paciente
        
			delete from BasePT.dispositivosAdquisicion 
            where BasePT.dispositivosAdquisicion.id_paciente = paciente_id;
            
        END IF;
        -- si tiene citas los elimina jutno con los resultados
        IF EXISTS (select c.folio_cita from BasePT.cita as c where c.id_paciente = paciente_id)
        THEN
			-- elimina los resultados generales asociados a las citas
				delete from BasePT.resultadosGenerales
				where BasePT.resultadosGenerales.folio_cita in (select c.folio_cita from BasePT.cita as c where
					c.id_paciente = paciente_id);
			
			-- elimina los resultados de cada segemento de todos los canales registrados en las citas del paciente
				delete from BasePT.resultadoSegmento
				where BasePT.resultadoSegmento.id_grabacion in (
					select gc.id_grabacion from BasePT.grabacionCanal as gc
					where gc.folio_cita in (select c.folio_cita from BasePT.cita as c 
                        where c.id_paciente = paciente_id));
					
			-- elimina los resultados de cada canal de las citas
				delete from BasePT.resultadoCanal
				where BasePT.resultadoCanal.id_grabacion in (
					select gc.id_grabacion from BasePT.grabacionCanal as gc
					where gc.folio_cita in (select c.folio_cita from BasePT.cita as c 
                        where c.id_paciente = paciente_id));
				
			-- elimina las grabaciones de cada canal de las citas
				delete from BasePT.grabacionCanal
				where BasePT.grabacionCanal.folio_cita in (select c.folio_cita from BasePT.cita as c where
					c.id_paciente = paciente_id);
			
			-- elimina las citas
				delete from BasePT.cita where BasePT.cita.id_paciente = paciente_id;
                
			-- elimina el paciente
				delete from BasePT.paciente where BasePT.paciente.id_paciente = paciente_id;
                
				set resultado =  'Datos eliminados correctamente';
		ELSE
				delete from BasePT.paciente where BasePT.paciente.id_paciente = paciente_id;
				SET resultado = 'Datos eliminados correctamente';
		END IF;
	ELSE
		set resultado = 'No existe el paciente a eliminar';
	END IF;
    
    set FOREIGN_KEY_CHECKS  = 1;
    set SQL_SAFE_UPDATES = 1;
    
END; %

-- Eliminar un especialista

DELIMITER %
CREATE PROCEDURE eliminarEspecialista(IN especialista_id int,
							   OUT resultado varchar(100))
                                            
BEGIN
	
    set FOREIGN_KEY_CHECKS  = 0;
    set SQL_SAFE_UPDATES = 0; -- necesarias para eliminar mas de un registro

	IF EXISTS (SELECT e.id_especialista FROM BasePT.especialista AS e
			   where e.id_especialista = especialista_id)
	THEN
    -- Si tiene pacientes registrados
		IF EXISTS (select p.id_paciente from BasePT.paciente as p where p.id_especialista = especialista_id)
        THEN 
        
        -- elimina los dispositivos que tengan registrados los pacientes del especialista
			delete from BasePT.dispositivosAdquisicion 
            where BasePT.dispositivosAdquisicion.id_paciente in (select p.id_paciente from BasePT.paciente as p 
				where p.id_especialista = especialista_id);
        
			-- si tienen citas las elimina junto con los resultados
			IF EXISTS (select c.folio_cita from BasePT.cita as c where c.id_paciente in
				(select p.id_paciente from BasePT.paciente as p where p.id_especialista = especialista_id))
			THEN
				-- elimina los resultados generales asociados a las citas
					delete from BasePT.resultadosGenerales
					where BasePT.resultadosGenerales.folio_cita in (select c.folio_cita from BasePT.cita as c where
						c.id_paciente in (select p.id_paciente from BasePT.paciente as p 
							where p.id_especialista = especialista_id));
				
				-- elimina los resultados de cada segemento de todos los canales registrados en las citas de los pacientes
					delete from BasePT.resultadoSegmento
					where BasePT.resultadoSegmento.id_grabacion in (
						select gc.id_grabacion from BasePT.grabacionCanal as gc
						where gc.folio_cita in (select c.folio_cita from BasePT.cita as c 
							where c.id_paciente in (select p.id_paciente from BasePT.paciente as p 
								where p.id_especialista = especialista_id)));
						
				-- elimina los resultados de cada canal de las citas
					delete from BasePT.resultadoCanal
					where BasePT.resultadoCanal.id_grabacion in (
						select gc.id_grabacion from BasePT.grabacionCanal as gc
						where gc.folio_cita in (select c.folio_cita from BasePT.cita as c 
							where c.id_paciente in (select p.id_paciente from BasePT.paciente as p 
								where p.id_especialista = especialista_id)));
					
				-- elimina las grabaciones de cada canal de las citas
					delete from BasePT.grabacionCanal
					where BasePT.grabacionCanal.folio_cita in (select c.folio_cita from BasePT.cita as c where
						c.id_paciente in (select p.id_paciente from BasePT.paciente as p 
							where p.id_especialista = especialista_id));
				
				-- elimina las citas
					delete from BasePT.cita where BasePT.cita.id_paciente in (select p.id_paciente from BasePT.paciente as p 
							where p.id_especialista = especialista_id);
					
				-- elimina los pacientes
					delete from BasePT.paciente where BasePT.paciente.id_especialista = especialista_id;
                            
				-- eimina al especialista
					delete from BasePT.especialista where BasePT.especialista.id_especialista = especialista_id;
					
					set resultado =  'Datos eliminados correctamente';
                    
				END IF;
		ELSE
				delete from BasePT.especialista where BasePT.especialista.id_especialista = especialista_id;
                
				SET resultado = 'Datos eliminados correctamente';
		END IF;
	ELSE
		set resultado = 'No existe el especialista a eliminar';
	END IF;
    
    set FOREIGN_KEY_CHECKS  = 1;
    set SQL_SAFE_UPDATES = 1;
    
END; %



DELIMITER %
CREATE PROCEDURE BasePT.getEmailAndPassword(IN email VARCHAR(25), 
                              OUT resultado VARCHAR(100))
BEGIN
	-- si es un paciente
    IF EXISTS (select p.id_paciente from BasePT.paciente as p where p.emailPaciente=email)
    THEN
     
            -- Obtiene un paciente
            select  p.emailPaciente, p.passPaciente
            from BasePT.paciente  as p 
            where p.emailPaciente=email;
            set resultado =  'OK'; -- tipo usuario paciente
        
    -- si es un especialista
    ELSEIF EXISTS (select e.id_especialista from BasePT.especialista as e where e.emailEspecialista=email)
    THEN
      
            -- Obtiene un especialista
            select e.emailEspecialista,e.passEspecialista
            from BasePT.especialista as e
            where e.emailEspecialista=email;
            set resultado =  'OK'; -- tipo usuario igual especialista
        
    -- si es un administrador
    ELSEIF EXISTS (select a.id_administrador from BasePT.administrador as a where a.emailAdministrador = email)
    THEN

            -- Obtiene un administrador
            select a.emailAdministrador, a.passAdministrador
            from BasePT.administrador as a
            where a.emailAdministrador = email;
            set resultado = 'OK'; -- tipo usuario igual a Administrador
     
    ELSE
        set resultado = ''; -- no tiene cuenta
    END IF;
END; %
