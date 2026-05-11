-- Daniel Pino Gomez
-- Examen UD7

-- 1. Crear usuarios
-- 1.1
SELECT PASSWORD('Est@dio25');
CREATE USER 'estadio'@'localhost' IDENTIFIED BY '*A81BB5AD7CCFE31278F9A97CAC65C691F9BD8C3A';
-- 1.2
SELECT PASSWORD('Gol#2025');
CREATE USER 'marcador'@'localhost' IDENTIFIED BY '*0BF1A53E040922B484BA8E1E8B5E2F1D5E45A706';
-- 1.3
SELECT PASSWORD('Examen#07');
CREATE USER 'danielpino'@'localhost' IDENTIFIED BY '*3BCD355FD0BFDD852324CC735A3C0A653FD0E49C';

-- 2. Asignación de privilegios
-- 2.1
GRANT ALL ON *.* TO 'estadio'@'localhost' WITH GRANT OPTION;
-- 2.2
GRANT ALL ON futbol.* TO 'estadio'@'localhost' WITH GRANT OPTION;
-- 2.3
GRANT ALL ON futbol.equipos TO 'estadio'@'localhost' WITH GRANT OPTION;
GRANT ALL ON futbol.jugadores TO 'estadio'@'localhost' WITH GRANT OPTION;
-- 2.4
GRANT SELECT ON futbol.equipos TO 'marcador'@'localhost';
GRANT SELECT ON futbol.goles TO 'marcador'@'localhost';
GRANT SELECT ON futbol.jugadores TO 'marcador'@'localhost';
GRANT SELECT ON futbol.partidos TO 'marcador'@'localhost';
-- 2.5
GRANT SELECT, UPDATE (nombre, aforo, estadio, ciudad) ON futbol.equipos TO 'marcador'@'localhost';
-- 2.6
GRANT SELECT (id, nombre, fecha_nac), UPDATE (equipo_id) ON futbol.jugadores TO 'marcador'@'localhost';
-- 2.7
GRANT SELECT ON futbol.* TO 'danielpino'@'localhost';

-- 3. Eliminar privilegios
-- 3.1
REVOKE GRANT OPTION ON *.* FROM 'estadio'@'localhost';
-- 3.2
REVOKE GRANTS ON *.* FROM 'estadio'@'localhost';
-- 3.3
REVOKE GRANTS ON futbol.* FROM 'estadio'@'localhost';
-- 3.4
REVOKE INSERT ON futbol.partidos FROM 'marcador'@'localhost';
-- 3.5
REVOKE SELECT (id, nombre, fecha_nac) ON futbol.jugadores FROM 'marcador'@'localhost';
-- 3.6
REVOKE SELECT, UPDATE, DELETE ON futbol.partidos FROM 'danielpino'@'localhost';
REVOKE SELECT, UPDATE, DELETE ON futbol.equipos FROM 'danielpino'@'localhost';
REVOKE SELECT, UPDATE, DELETE ON futbol.jugadores FROM 'danielpino'@'localhost';

-- 4. Renombrar usuarios y cambiar passwords
-- 4.1
RENAME USER 'estadio'@'localhost' TO 'estadio_admin'@'localhost';
-- 4.2
RENAME USER 'marcador'@'localhost' TO 'marcador_ro'@'localhost';
-- 4.3
SELECT PASSWORD('Admin#2026');
SET PASSWORD FOR 'estadio_admin'@'localhost' = PASSWORD ('*267F2A81A523CCB3CB06531A877F953EFA45BEED');
-- 4.4
SELECT PASSWORD('ReadOnly#99');
SET PASSWORD FOR 'marcador_ro'@'localhost' = PASSWORD ('*2EDC91C7CDBE57A118DD34E8A9708DE9AF6BC736');
-- 4.5
DROP USER 'danielpino'@'localhost';

-- 5. Transacción con SAVEPOINT - Base de datos empresa
-- 5.1
START TRANSACTION;
-- 5.2
SAVEPOINT antes_subida;
-- 5.3
INSERT INTO empleados (nombre, apellidos, nss, fecha_nac, direccion, salario, id_departamento)
VALUES 
('Carlos', 'Gomez Ruiz', '12345678901', '1990-05-10', '123 Calle A, Madrid, España', 28000, 5),
('Laura', 'Martinez Lopez', '10987654321', '1992-08-15', '456 Calle B, Sevilla, España', 30000, 5);
-- 5.4
SAVEPOINT despues_insercion;
-- 5.5
UPDATE empleados
SET salario = salario * 1.15
WHERE id_departamento = 1;
-- 5.6
UPDATE empleados
SET salario = salario * 1.10
WHERE id_departamento = 5;
-- 5.7
SELECT COUNT(*) INTO @exceso
FROM empleados
WHERE id_departamento = 1 AND salario > 60000;
-- 5.8
COMMIT;

-- 6. Funciones MySQL - Base de datos empresa
-- 6.1
SELECT 
UPPER(CONCAT(nombre, ' ', apellidos)) AS nombre_completo,
LENGTH(CONCAT(nombre, ' ', apellidos)) AS longitud,
LEFT(apellidos, 4) AS codigo
FROM empleados;
-- 6.2
SELECT 
nombre,
apellidos,
FORMAT(salario, 2) AS salario_formateado
FROM empleados
ORDER BY salario DESC;
-- 6.3
SELECT 
nombre,
apellidos,
TIMESTAMPDIFF(YEAR, fecha_nac, NOW()) AS edad
FROM empleados;
-- 6.4
SELECT 
nombre,
apellidos
FROM empleados
WHERE MONTH(fecha_nac) = MONTH(NOW());
-- 6.5
SELECT 
nombre,
apellidos,
DATEDIFF(NOW(), fecha_nac)/365 AS antiguedad
FROM empleados
ORDER BY antiguedad DESC;
-- 6.6
SELECT 
nombre,
apellidos,
SUBSTRING_INDEX(SUBSTRING_INDEX(direccion, ',', 2), ',', -1) AS ciudad
FROM empleados;
-- 6.7
SELECT 
CONCAT(
    RIGHT(nss, 3), '/',
    UPPER(LEFT(nombre, 2)), '_',
    UPPER(LEFT(apellidos, 2))
) AS codigo_empleado
FROM empleados;

-- 7. Bloqueos de tablas - Base de datos futbol
-- 7.1
LOCK TABLE equipos READ;
-- 7.2
SELECT * FROM equipos;
-- 7.3
INSERT INTO equipos VALUES (10, 'Equipo Nuevo', 'Nuevo', 50000, 'otra', 'hakim');
-- Da error porque no se puede insertar mientras esta bloqueada con READ
-- 7.4
UNLOCK TABLES;
-- 7.5
START TRANSACTION;
SELECT * FROM equipos
WHERE id = 1
FOR UPDATE;
-- 7.6
UPDATE equipos
SET aforo = aforo + 5000
WHERE id = 1;
-- 7.7
INSERT INTO partidos (equipo_local, equipo_visitante, fecha, estadio)
VALUES (1, 2, NOW(), 'Santiago Bernabéu');
-- 7.8
COMMIT;


-- 8. Exportar e importar datos
-- 8.1
SELECT id, nombre, apellidos, nss, fecha_nac, direccion, salario
INTO OUTFILE '/var/lib/mysql-files/empleados_houston.csv'
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM empleados
WHERE direccion LIKE '%Houston%';
-- 8.2
mysqldump -u root -p empresa > empresa_backup.sql;
-- 8.3
mysqldump -u root -p empresa empleados proyectos > empresa_empleados_proyectos.sql;
-- 8.4
mysqldump -u root -p --xml empresa > empresa.xml;
-- 8.5
nombre;ini;apellidos;nss;fecha_nac;direccion;salario;supervisor_id;departamento_id
Ana;S;Lopez Garcia;12312312312;1995-06-10;789 Calle C, Valencia, España;27000;1;2
Luis;V;Perez Diaz;32132132132;1988-11-20;101 Calle D, Bilbao, España;32000;2;3
Marta;B;Sanchez Ruiz;45645645645;1993-02-05;202 Calle E, Malaga, España;29000;3ini;4
-- 8.6
