CREATE DATABASE BasePT;

USE BasePT;

CREATE TABLE administrador (
    id_administrador INT NOT NULL AUTO_INCREMENT,
    nombreAdministrador VARCHAR(25),
    apPaternoAdministrador VARCHAR(25),
    apMaternoAdministrador VARCHAR(25),
    emailAdministrador VARCHAR(30),
    passAdministrador VARCHAR(30),
    generoAdministrador ENUM('Masculino', 'Femenino'),
    PRIMARY KEY (id_administrador)
);

-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

CREATE TABLE especialista (
    id_especialista INT NOT NULL AUTO_INCREMENT,
    nombreEspecialista VARCHAR(25),
    apPaternoEspecialista VARCHAR(25),
    apMaternoEspecialista VARCHAR(25),
    emailEspecialista VARCHAR(30),
    passEspecialista VARCHAR(30),
    generoEspecialista ENUM('Masculino', 'Femenino'),
    fotoEspecialista LONGBLOB NOT NULL,
    PRIMARY KEY (id_especialista)
);

-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

CREATE TABLE paciente(
id_paciente INT NOT NULL AUTO_INCREMENT,
id_especialista INT NOT NULL,
nombrePaciente VARCHAR(25),
apPaternoPaciente VARCHAR(25),
apMaternoPaciente VARCHAR(25),
padecimientoPaciente VARCHAR(25),
edadPaciente INT,
emailPaciente VARCHAR(30),
passPaciente VARCHAR(30),
generoPaciente ENUM('Masculino', 'Femenino'),
fotoPaciente longblob not null,

PRIMARY KEY(id_paciente),
INDEX(id_especialista),
FOREIGN KEY (id_especialista) REFERENCES especialista(id_especialista)
);

-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
CREATE TABLE dispositivosAdquisicion(
id_dispositivo INT NOT NULL AUTO_INCREMENT,
id_paciente INT NOT NULL,
nombreDispositivo VARCHAR(25),
direccionMAC VARCHAR(20),
PRIMARY KEY(id_dispositivo),
INDEX(id_dispositivo),
FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente)
);


-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

CREATE TABLE cita(
folio_cita INT NOT NULL AUTO_INCREMENT,
id_paciente INT NOT NULL,
fechaCita DATE,
horaCita TIME,
duracionCita TIME,
observaciones VARCHAR(200),
electrodos VARCHAR(1000),
PRIMARY KEY(folio_cita),
INDEX(id_paciente),
FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente)
);

-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

CREATE TABLE grabacionCanal(
id_grabacion INT NOT NULL AUTO_INCREMENT,
folio_cita INT NOT NULL,
nombreArchivo VARCHAR(100),

PRIMARY KEY(id_grabacion),
INDEX(folio_cita),
FOREIGN KEY (folio_cita) REFERENCES cita(folio_cita)
);

-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

CREATE TABLE resultadosGenerales(
id_resultadosGenerales INT NOT NULL AUTO_INCREMENT,
folio_cita INT,
zonaCerebral VARCHAR(25),
tipoOndaDominante ENUM('Frecuencia-alpha', 'Ritmo-alpha', 'Frecuencia-beta', 'Ritmo-beta',
					   'Frecuencia-delta', 'Ritmo-delta', 'Frecuencia-theta', 'Ritmo-theta',
					   'Frecuencia-gamma', 'Ritmo-gamma', 'No-asignado'),
porcentajeTipoOnda DOUBLE,

PRIMARY KEY(id_resultadosGenerales),
INDEX(folio_cita),
FOREIGN KEY (folio_cita) REFERENCES cita(folio_cita)
);

-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

/* CREATE TABLE estudio(
folio_estudio INT NOT NULL AUTO_INCREMENT,
folio_cita INT NOT NULL,
id_resultadosGenerales INT NOT NULL,
fechaEstudio DATE,
duracionEstudio TIME,

PRIMARY KEY(folio_estudio),
INDEX(id_resultadosGenerales, folio_cita),
FOREIGN KEY (id_resultadosGenerales) REFERENCES resultadosGenerales(id_resultadosGenerales),
FOREIGN KEY (folio_cita) REFERENCES cita(folio_cita)
);
 */
-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

CREATE TABLE resultadoSegmento(
id_resultadoSegmento INT NOT NULL AUTO_INCREMENT,
id_grabacion INT NOT NULL,
segundo INT,
canal VARCHAR(15),
frecuenciaDominante DOUBLE,
tipoOnda ENUM('Ritmo-alpha', 'Frecuencia-alpha', 'Ritmo-beta', 'Frecuencia-beta', 
			  'Ritmo-delta', 'Frecuencia-delta', 'Ritmo-theta','Frecuencia-theta', 
              'Ritmo-gamma', 'Frecuencia-gamma', 'No-asignado'),
senal NVARCHAR(10240),

PRIMARY KEY(id_resultadoSegmento),
INDEX(id_grabacion),
FOREIGN KEY (id_grabacion) REFERENCES grabacionCanal(id_grabacion)
);


CREATE TABLE resultadoCanal(
id_resultadoCanal INT NOT NULL AUTO_INCREMENT,
id_grabacion INT NOT NULL,
canal VARCHAR(15),
tipoOndaDominanteCanal ENUM('Ritmo-alpha', 'Frecuencia-alpha', 'Ritmo-beta',  'Frecuencia-beta', 
							'Ritmo-delta', 'Frecuencia-delta', 'Ritmo-theta', 'Frecuencia-theta', 
							'Ritmo-gamma', 'Frecuencia-gamma', 'No-asignado'),
frecuenciaDominanteCanal DOUBLE,
promedioAmplitudesCanal DOUBLE,
porcentajeAparicionRitmoAlpha DOUBLE,
porcentajeAparicionRitmoBeta DOUBLE,
porcentajeAparicionRitmoDelta DOUBLE,
porcentajeAparicionRitmoTheta DOUBLE,
porcentajeAparicionFrecuenciaAlpha DOUBLE,
porcentajeAparicionFrecuenciaBeta DOUBLE,
porcentajeAparicionFrecienciaDelta DOUBLE,
porcentajeAparicionFrecuenciaTheta DOUBLE,
promedioAmplitudesRitmoAlpha DOUBLE,
promedioAmplitudesRitmoBeta DOUBLE,
promedioAmplitudesRitmoDelta DOUBLE,
promedioAmplitudesRitmoTheta DOUBLE,
promedioAmplitudesFrecuenciaAlpha DOUBLE,
promedioAmplitudesFrecuenciaBeta DOUBLE,
promedioAmplitudesFrecuenciaDelta DOUBLE,
promedioAmplitudesFrecuenciaTheta DOUBLE,
promedioFrecuenciasRitmoAlpha DOUBLE,
promedioFrecuenciasRitmoBeta DOUBLE,
promedioFrecuenciasRitmoDelta DOUBLE,
promedioFrecuenciasRitmoTheta DOUBLE,
promedioFrecuenciasFrecuenciaAlpha DOUBLE,
promedioFrecuenciasFrecuenciaBeta DOUBLE,
promedioFrecuenciasFrecuenciaDelta DOUBLE,
promedioFrecuenciasFrecuenciaTheta DOUBLE,

PRIMARY KEY(id_resultadoCanal),
INDEX(id_grabacion),
FOREIGN KEY (id_grabacion) REFERENCES grabacionCanal(id_grabacion)
);