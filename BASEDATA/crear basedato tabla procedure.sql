-- Eliminar la base de datos 'attendance' si existe
DROP DATABASE IF EXISTS attendance;

-- Crear la base de datos 'attendance'
CREATE DATABASE attendance;

-- Usar la base de datos 'attendance'
USE attendance;

-- Procedimiento almacenado para insertar o actualizar registros en la tabla 'persons'
DELIMITER $$
CREATE PROCEDURE insertar_o_actualizar (
    IN p_id INT, 
    IN p_dni INT, 
    IN p_digito INT, 
    IN p_lastname VARCHAR(255), 
    IN p_name VARCHAR(255), 
    IN p_cargo INT, 
    IN p_estado INT(1)
)
BEGIN
    IF p_id = 0 THEN
        -- Insertar nuevo registro
        INSERT INTO persons (dni, digito, lastname, name, cargo, estado)
        VALUES (p_dni, p_digito, p_lastname, p_name, p_cargo, p_estado);
    ELSE
        -- Actualizar registro existente
        UPDATE persons
        SET dni = p_dni, digito = p_digito, lastname = p_lastname, name = p_name, cargo = p_cargo, estado = p_estado
        WHERE id = p_id;
    END IF;
END$$
DELIMITER ;

-- Tabla 'persons' para almacenar información personal
CREATE TABLE persons (
  id int(11) NOT NULL AUTO_INCREMENT,
  dni int(11) NOT NULL,
  digito int(11) NOT NULL DEFAULT 1,
  lastname varchar(255) NOT NULL,
  name varchar(255) NOT NULL,
  cargo int(11) NOT NULL,
  estado tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Tabla 'cursos' para almacenar información de los cursos
CREATE TABLE cursos (
  id int(11) NOT NULL AUTO_INCREMENT,
  ano int(2) NOT NULL,
  División varchar(10) NOT NULL,
  Asignatura varchar(100) NOT NULL,
  turno varchar(10) NOT NULL,
  persons_id int(11) NOT NULL,
  estado tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (id),
  KEY fk_cursos_persons (persons_id),
  CONSTRAINT fk_cursos_persons FOREIGN KEY (persons_id) REFERENCES persons (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Tabla 'horarios' para almacenar los horarios de los cursos
CREATE TABLE horarios (
  id int(11) NOT NULL AUTO_INCREMENT,
  curso_id int(11) NOT NULL,
  dia_semana varchar(15) NOT NULL,
  hora_inicio time NOT NULL,
  hora_fin time NOT NULL,
  PRIMARY KEY (id),
  KEY fk_horarios_cursos (curso_id),
  CONSTRAINT fk_horarios_cursos FOREIGN KEY (curso_id) REFERENCES cursos (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Tabla 'asistencia' para almacenar la asistencia a los cursos
CREATE TABLE asistencia (
  id int(20) NOT NULL AUTO_INCREMENT,
  persons_id int(11) NOT NULL,
  curso_id int(11) NOT NULL,
  fecha date NOT NULL,
  hora_entrada time DEFAULT NULL,
  hora_salida time DEFAULT NULL,
  PRIMARY KEY (id),
  KEY fk_asistencia_persons (persons_id),
  KEY fk_asistencia_cursos (curso_id),
  CONSTRAINT fk_asistencia_persons FOREIGN KEY (persons_id) REFERENCES persons (id),
  CONSTRAINT fk_asistencia_cursos FOREIGN KEY (curso_id) REFERENCES cursos (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

