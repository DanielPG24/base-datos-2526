-- Actividad: 5.14
-- Tema: Lenguaje SQL - DDL
-- Módulo: Base de Datos
-- Curso: 25/26
-- Nombre: Daniel Pino

-- Creación de la base de datos
DROP DATABASE IF EXISTS empleados_taller;
CREATE DATABASE IF NOT EXISTS empleados_taller;

-- Usar base de datos empleados_taller
USE empleados_taller;

-- Crear tabla clientes
DROP TABLE IF EXISTS clientes;
CREATE TABLE IF NOT EXISTS clientes(
	nombre VARCHAR(25) NOT NULL,
    apellidos VARCHAR(45) NOT NULL,
	poblacion VARCHAR(50),
	nacionalidad VARCHAR(30) DEFAULT 'España',
    email VARCHAR(100),
	direccion VARCHAR(100),
	cod_cliente VARCHAR(10),
	tipo_cliente INT
);

-- Modificar columna nombre de la tabla clientes
ALTER TABLE clientes
MODIFY nombre VARCHAR(25) NOT NULL;

-- Modificar columna apellidos de la tabla clientes
ALTER TABLE clientes
MODIFY apellidos VARCHAR(45) NOT NULL;

-- Modificar columna nacionalidad de la tabla clientes
ALTER TABLE clientes
MODIFY nacionalidad VARCHAR(30) DEFAULT 'España';

-- Modificar columna direccion de la tabla clientes
ALTER TABLE clientes
MODIFY direccion VARCHAR(100);

-- Cambiar el nombre de la columna email a correo_electronico
ALTER TABLE clientes
CHANGE email correo_electronico VARCHAR(100);

-- Columna correo_electronico tiene que contener '@'
ALTER TABLE clientes
ADD CONSTRAINT chk_correo
CHECK (correo_electronico LIKE '%@%');

-- Columna tipo_cliente tiene que tener un valor comprendido entre 0, 10
ALTER TABLE clientes
ADD CONSTRAINT chk_tipo_cliente
CHECK (tipo_cliente BETWEEN 0 AND 10);

-- cod_cliente es clave secundaria
ALTER TABLE clientes
ADD CONSTRAINT uq_cod_cliente UNIQUE (cod_cliente);

-- Crear índice en apellidos y nombre
CREATE INDEX IN_clientes_apellidos_nombre ON clientes (apellidos, nombre);

-- Mostrar índice
SHOW INDEX FROM clientes;
