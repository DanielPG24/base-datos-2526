# 1 Crear la base de datos fmatemáticas
DROP DATABASE IF EXISTS fmatematicas;
CREATE DATABASE IF NOT EXISTS fmatematicas;

USE fmatematicas;

# 2 Crear la tabla angulos los valores con máxima precisión
-- id
-- grados
-- radianes
-- seno
-- coseno
-- tangente
CREATE TABLE IF NOT EXISTS angulos(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    grados SMALLINT UNSIGNED,
    radianes DOUBLE(31,30),
    seno DOUBLE(31,30),
    coseno DOUBLE(31,30),
    tangente DOUBLE(31,30)
);

# 3 Insertar en la tabla angulos los valores de 5 ángulos (0 a 360)
-- actualizar solo la columna grados.
INSERT INTO angulos (grados) VALUES
(0),
(45),
(90),
(135),
(180),
(225),
(270),
(315),
(360);

# 4 Actualizar la columna radiantes a partir de la columna grados
-- añadida 
UPDATE angulos SET radianes = radians(grados);

# 5 
-- columna radianes actualizada en el apartado anterior
UPDATE angulos SET seno = sin(radianes), coseno = cos(radianes), tangente = tan(radianes);
