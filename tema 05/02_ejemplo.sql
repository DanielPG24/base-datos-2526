-- ejemplo 2
-- Creación de tabla

-- 1
-- Seleccionar base de datos activa
USE geslibros;

-- 2
-- Crear la tabla libros
-- id, titulo, precio, autor, editorial, paginas

DROP TABLE IF EXISTS libros;
CREATE TABLE IF NOT EXISTS libros (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(40),
    autor VARCHAR(50),
    editorial VARCHAR(20),
    paginas SMALLINT UNSIGNED,
    fecha_edicion DATE,
    precios DECIMAL(10,2)
);

-- 3
-- Insertar un libro
INSERT INTO libros VALUES (
	null,
    'La Historia Interminable',
    'Mikel Ende',
    'Somosagua',
    340,
    '2025/12/12',
    37.80
);