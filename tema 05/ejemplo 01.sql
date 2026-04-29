-- Juego caracteres mysql
SHOW CHARACTER SET;

-- Muestro las colecciones disponibles
SHOW COLLATION;

-- Crear una base de datos ejemplos
CREATE DATABASE ejemplo;

-- Crear la base de datos sólo si no existe
CREATE DATABASE IF NOT EXISTS ejemplo;

-- Crear la base de datos Banco Multilingüe con UTF8
CREATE DATABASE IF NOT EXISTS banco
CHARACTER SET UTF8 COLLATE utf8_general_ci;

-- Crear la base de datos Banco Multilingüe con UTF8
CREATE DATABASE IF NOT EXISTS banco
CHARACTER SET UTF8 COLLATE utf8_spanish_ci;

-- Crear la base de datos Banco Multilingüe con UTF8
CREATE DATABASE IF NOT EXISTS banco
CHARACTER SET utf8mb4 COLLATE utf8_spanish_ci;

-- Crear la base de datos geslibros español multilingüe con juego de caracteres utf8mb4
-- Opciones por defecto
CREATE DATABASE IF NOT EXISTS geslibros
CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;