-- Actividad 5.2
-- Tema 5: Lenguaje SQL - DQL
-- Daniel Pino

-- 1
-- Crear la base de datos ajedrez, usar siempre la cláusula IF NOT EXISTS.
--  Indicar el juego de caracteres y la colección establecida por defecto.
CREATE DATABASE IF NOT EXISTS ajedrez
CHARACTER SET utb8mb4 COLLATE utb8mb4_general_ci;

-- 2
-- Modificar la base de datos ajedrez para establecer el juego de caracteres
-- inglés internacional así como la colección correspondiente.
ALTER DATABASE ajedrez
CHARACTER SET hp8 COLLATE hp8_english_ci;

-- 3
-- Eliminar la base de datos ajedrez.
DROP DATABASE IF EXISTS ajedrez;

-- 4
-- Crear la base de datos futbol, usar el 
-- juego de caracteres utf16 y la colección utf16_general_ci.
CREATE DATABASE IF NOT EXISTS futbol
CHARACTER SET utf16 COLLATE utf16_general_ci;

-- 5
-- Modificar la base de datos futbol para cambiar al juego de caracteres 
-- UTF8MB4 y la colección 'utf8mb4_general_ci'.
ALTER DATABASE futbol
CHARACTER SET UTF8MB4 COLLATE utf8mb4_general_ci;

-- 6
-- Eliminar definitivamente la base de datos futbol.
DROP DATABASE IF EXISTS futbol;