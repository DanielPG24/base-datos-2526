-- Actividad: 5.15
-- Tema: Lenguaje SQL - DDL
-- Módulo: Base de Datos
-- Curso: 25/26
-- Nombre: Daniel Pino

-- Creación de la base de datos
DROP DATABASE IF EXISTS libros_almacen;
CREATE DATABASE IF NOT EXISTS libros_almacen;

-- Usar base de datos empleados_taller
USE libros_almacen;

-- Crear la tabla libros
DROP TABLE IF EXISTS libros;
CREATE TABLE IF NOT EXISTS libros(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(45) NOT NULL,
    autor VARCHAR(25),
    precio DECIMAL(10,2)
);

-- Crear la tabla educacion
DROP TABLE IF EXISTS educacion;
CREATE TABLE IF NOT EXISTS educacion(
	id_libro INT UNSIGNED NOT NULL,
    curso VARCHAR(50),
    asignatura VARCHAR(50),
    FOREIGN KEY (id_libro) REFERENCES libros(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Crear la tabla lectura
DROP TABLE IF EXISTS lectura;
CREATE TABLE IF NOT EXISTS lectura(
	id_libro INT PRIMARY KEY,
    tipo VARCHAR(50),
    genero VARCHAR(50),
);

-- Crear la tabla provincias
DROP TABLE IF EXISTS provincias;
CREATE TABLE IF NOT EXISTS provincias(
	id INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    id_almacen INT
);

-- Crear la tabla poblaciones
DROP TABLE IF EXISTS poblaciones;
CREATE TABLE IF NOT EXISTS poblaciones(
	id INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    habitantes INT,
    id_provincia INT NOT NULL,
    FOREIGN KEY (id_provincia) REFERENCES provincias(id) ON DELETE NO ACTION ON UPDATE CASCADE
);

-- Crear la tabla socios
DROP TABLE IF EXISTS socios;
CREATE TABLE IF NOT EXISTS socios(
	id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    codsocio VARCHAR(20) UNIQUE,
    telefono VARCHAR(20),
    dni VARCHAR(15) UNIQUE,
    id_poblacion INT,
    id_socio_avalista INT,
    FOREIGN KEY (id_poblacion) REFERENCES poblaciones(id) ON DELETE NO ACTION ON UPDATE CASCADE,
    FOREIGN KEY (id_socio_avalista) REFERENCES socios(id) ON DELETE NO ACTION ON UPDATE CASCADE
);

-- Crear la tabla pedidos
DROP TABLE IF EXISTS pedidos;
CREATE TABLE IF NOT EXISTS pedidos(
	id INT PRIMARY KEY,
    fecha DATE NOT NULL,
    envio VARCHAR(50),
    id_socio INT NOT NULL,
    FOREIGN KEY (id_socio) REFERENCES socios(id) ON DELETE NO ACTION ON UPDATE CASCADE
);

-- Crear la tabla almacenas
DROP TABLE IF EXISTS almacenas;
CREATE TABLE IF NOT EXISTS almacenas(
	id INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    fecha DATE,
    id_provincia INT NOT NULL,
    FOREIGN KEY (id_provincia) REFERENCES provincias(id) ON DELETE NO ACTION ON UPDATE CASCADE
);

-- Crear la tabla libros_pedidos
DROP TABLE IF EXISTS libros_pedidos;
CREATE TABLE IF NOT EXISTS libros_pedidos(
	id_pedido INT,
    id_libro INT,
    unidades INT NOT NULL,
    precio DECIMAL(8,2) NOT NULL,
    PRIMARY KEY (id_pedido, id_libro),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id) ON DELETE NO ACTION ON UPDATE CASCADE,
    FOREIGN KEY (id_libro) REFERENCES libros(id) ON DELETE NO ACTION ON UPDATE CASCADE
);

-- Crear la tabla almacenes_libros
DROP TABLE IF EXISTS almacenes_libros;
CREATE TABLE IF NOT EXISTS almacenes_libros(
	id_almacen INT,
    id_libro INT,
    stock INT NOT NULL,
    PRIMARY KEY (id_almacen, id_libro),
    FOREIGN KEY (id_almacen) REFERENCES almacenes(id) ON DELETE NO ACTION ON UPDATE CASCADE,
    FOREIGN KEY (id_libro) REFERENCES libros(id) ON DELETE NO ACTION ON UPDATE CASCADE
);

-- Tabla empleados restricciones FOREIGN KEY
ALTER TABLE lectura
ADD CONSTRAINT FK_id_libro_lectura FOREIGN KEY(id_libro) REFERENCES libros(id)
ON DELETE CASCADE ON UPDATE CASCADE
