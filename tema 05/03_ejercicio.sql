-- Actividad 5.3
-- Tema 5: Lenguaje SQL - DDL
-- Descripción: Tipos de dato numérico

-- borro y creo la base de datos si existe y no existe repectivamente
DROP DATABASE IF EXISTS tipo_datos;
CREATE DATABASE IF NOT EXISTS tipo_datos;

-- poner 
USE tipo_datos;

-- borro y creo la tabla tipo_datos_num
DROP TABLE IF EXISTS tipo_datos_num;
CREATE TABLE IF NOT EXISTS tipo_datos_num (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    num_camiseta TINYINT UNSIGNED,
    diferencia_goles SMALLINT,
    goles_a_favor SMALLINT UNSIGNED,
    goles_en_contra SMALLINT UNSIGNED,
    num_habitantes INT UNSIGNED,
    humedad FLOAT (3, 2),
    precipitaciones SMALLINT UNSIGNED,
    temperatura_max FLOAT (5, 2),
    temperatura_min FLOAT (5, 2),
    velocidad_viento SMALLINT UNSIGNED,
    altura SMALLINT UNSIGNED,
    precio DECIMAL (10, 2),
    sueldo DECIMAL (10, 2),
    seno DOUBLE (30,29),
    coseno DOUBLE (30,29),
    tangente SMALLINT UNSIGNED
) CHARACTER SET = 'UTF8MB4' COLLATE = 'utf8mb4_general_ci';

-- añadir tres registros válidos a la tabla anterior
INSERT INTO tipo_datos_num VALUES
(
	NULL,
    34,
    -5,
    56,
    45,
    345000,
	0.90,
    300,
    45.56,
    -12.78,
    500,
    10000,
    45.67,
    45000,
    0.5678,
    0.785,
    34
);