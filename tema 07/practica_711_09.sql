-- practica_711_09
use loteriaprimitiva;

-- 1. CREAR USUARIO

-- Obtener password cifrado
SELECT PASSWORD('1234567');

-- Crear usuario (ejemplo: tunombreapellido)
CREATE USER 'danielpino'@'localhost'
IDENTIFIED BY PASSWORD '*6A7A490FB9DC8C33C2B025A91737077A7E9CC5E5';

-- Sin privilegios (por defecto ya no tiene nada)


-- 2. ASIGNACIÓN PRIVILEGIOS

-- Superadministrador
GRANT ALL PRIVILEGES ON *.* TO 'danielpino'@'localhost' WITH GRANT OPTION;

-- Todos los privilegios en geslibros
GRANT ALL PRIVILEGES ON geslibros.* TO 'danielpino'@'localhost';

-- Todas las tablas específicas
GRANT ALL PRIVILEGES ON geslibros.libros TO 'danielpino'@'localhost';
GRANT ALL PRIVILEGES ON geslibros.editoriales TO 'danielpino'@'localhost';
GRANT ALL PRIVILEGES ON geslibros.clientes TO 'danielpino'@'localhost';

-- Solo SELECT
GRANT SELECT ON geslibros.libros TO 'danielpino'@'localhost';
GRANT SELECT ON geslibros.editoriales TO 'danielpino'@'localhost';
GRANT SELECT ON geslibros.clientes TO 'danielpino'@'localhost';

-- Columnas específicas clientes
GRANT SELECT, UPDATE (nombre, direccion, poblacion, c_postal, telefono, email)
ON geslibros.clientes TO 'danielpino'@'localhost';

-- Columnas específicas libros
GRANT SELECT (id, titulo, precio_venta, fecha_edicion),
UPDATE (precio_venta, titulo)
ON geslibros.libros TO 'danielpino'@'localhost';

-- Todas excepto ventas y lineasventas
GRANT SELECT ON geslibros.* TO 'danielpino'@'localhost';
REVOKE ALL ON geslibros.ventas FROM 'danielpino'@'localhost';
REVOKE ALL ON geslibros.lineasventas FROM 'danielpino'@'localhost';


-- 3. ELIMINAR PRIVILEGIOS

-- Quitar GRANT
REVOKE GRANT OPTION ON *.* FROM 'danielpino'@'localhost';

-- Quitar todo
REVOKE ALL PRIVILEGES ON *.* FROM 'danielpino'@'localhost';

-- Quitar en geslibros
REVOKE ALL PRIVILEGES ON geslibros.* FROM 'danielpino'@'localhost';

-- Quitar UPDATE libros
REVOKE UPDATE ON geslibros.libros FROM 'danielpino'@'localhost';

-- Quitar SELECT columnas
REVOKE SELECT (id, titulo, precio_venta)
ON geslibros.libros FROM 'danielpino'@'localhost';

-- Quitar acceso excepto libros y clientes
REVOKE ALL ON geslibros.* FROM 'danielpino'@'localhost';
GRANT ALL ON geslibros.libros TO 'danielpino'@'localhost';
GRANT ALL ON geslibros.clientes TO 'danielpino'@'localhost';

-- Quitar consulta, update, delete
REVOKE SELECT, UPDATE, DELETE
ON geslibros.libros FROM 'danielpino'@'localhost';
REVOKE SELECT, UPDATE, DELETE
ON geslibros.clientes FROM 'danielpino'@'localhost';
REVOKE SELECT, UPDATE, DELETE
ON geslibros.editoriales FROM 'danielpino'@'localhost';
REVOKE SELECT, UPDATE, DELETE
ON geslibros.autores FROM 'danielpino'@'localhost';


-- 4. CAMBIAR PASSWORD

-- Obtener nuevo cifrado
SELECT PASSWORD('21436587');

-- Cambiar password
ALTER USER 'danielpino'@'localhost'
IDENTIFIED BY PASSWORD '*1DEB27DD74919473A2C69FDFA8E46B08E9F16547';

-- 5. TRANSACCIÓN LOTERÍA

START TRANSACTION;

INSERT INTO sorteos
VALUES (
NULL,
NOW(),
FLOOR(1 + RAND()*49),
FLOOR(1 + RAND()*49),
FLOOR(1 + RAND()*49),
FLOOR(1 + RAND()*49),
FLOOR(1 + RAND()*49),
FLOOR(1 + RAND()*49),
FLOOR(1 + RAND()*49),
FLOOR(RAND()*10)
);

INSERT INTO sorteos
VALUES (
NULL,
NOW(),
FLOOR(1 + RAND()*49),
FLOOR(1 + RAND()*49),
FLOOR(1 + RAND()*49),
FLOOR(1 + RAND()*49),
FLOOR(1 + RAND()*49),
FLOOR(1 + RAND()*49),
FLOOR(1 + RAND()*49),
FLOOR(RAND()*10)
);

COMMIT;

-- 6. BASE DE DATOS MARATOON

-- Añadir columnas
ALTER TABLE maratoon.corredores
ADD apellido1 VARCHAR(40),
ADD apellido2 VARCHAR(40),
ADD codigo CHAR(11);

-- Separar apellidos
UPDATE maratoon.corredores
SET 
apellido1 = SUBSTRING_INDEX(apellidos, ' ', 1),
apellido2 = SUBSTRING_INDEX(apellidos, ' ', -1);

-- Generar código
UPDATE maratoon.corredores
SET codigo = CONCAT(
YEAR(fechaNacimiento),
'/',
UPPER(LEFT(nombre,2)),
UPPER(LEFT(apellido1,2)),
UPPER(LEFT(apellido2,2))
);

-- Actualizar edad
UPDATE maratoon.corredores
SET edad = TIMESTAMPDIFF(YEAR, fechaNacimiento, NOW());

-- Actualizar categoría
UPDATE maratoon.corredores
SET categoria_id =
CASE
    WHEN edad < 12 THEN 1
    WHEN edad < 15 THEN 2
    WHEN edad < 18 THEN 3
    WHEN edad < 30 THEN 4
    WHEN edad < 40 THEN 5
    WHEN edad < 50 THEN 6
    WHEN edad < 60 THEN 7
    ELSE 8
END;

-- Transacción con bloqueo
START TRANSACTION;

LOCK TABLE maratoon.categorias WRITE;

UPDATE maratoon.corredores
SET edad = TIMESTAMPDIFF(YEAR, fechaNacimiento, NOW());

UPDATE maratoon.corredores
SET categoria_id =
CASE
    WHEN edad < 12 THEN 1
    WHEN edad < 15 THEN 2
    WHEN edad < 18 THEN 3
    WHEN edad < 30 THEN 4
    WHEN edad < 40 THEN 5
    WHEN edad < 50 THEN 6
    WHEN edad < 60 THEN 7
    ELSE 8
END;

UNLOCK TABLES;

COMMIT;

-- 7. EXPORTAR / IMPORTAR

-- Exportar CSV clientes Ubrique
SELECT *
INTO OUTFILE 'clientesUbrique.csv'
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM geslibros.clientes
WHERE poblacion = 'Ubrique';

-- Exportar XML autores
SELECT *
FROM geslibros.autores
INTO OUTFILE 'autores.xml';

-- Backup BD

mysqldump -u root -p geslibros > backup.sql;

-- Crear libros.csv (ejemplo manual)
-- id;titulo;precio_venta;fechaedicion
-- NULL;Libro1;10.5;2020-01-01
-- NULL;Libro2;12.0;2021-02-02
-- NULL;Libro3;15.0;2022-03-03
-- NULL;Libro4;20.0;2023-04-04

-- Importar CSV
LOAD DATA INFILE 'libros.csv'
INTO TABLE geslibros.libros
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
