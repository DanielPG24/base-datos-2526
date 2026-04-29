-- Lenguaje SQL-DDL



-- uso la base de datos de testeo
USE test;

DROP TABLE IF EXISTS alumnos;
CREATE TABLE IF NOT EXISTS alumnos(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    apellidos VARCHAR(45) NOT NULL,
    dni CHAR(9) NOT NULL,
    fecha_nac DATE,
	edad VARCHAR(99) NOT NULL,
    poblacion VARCHAR(20),
    direccion VARCHAR(255) NOT NULL,
    cpostal TINYINT,
    provincia TINYINT UNSIGNED,
    nacionalidad VARCHAR(20),
    telefono VARCHAR(13),
    email VARCHAR(60)
);
