-- practica_710_solucion
-- observacion: los comandos estan en modo comentado puesto que se ejecutan en la consola
-- 1 accede usuario root a modo consola
mysql -h localhost -u root

-- 2 comandos sql
show databases;
use geslibros;
show tables;
select host, user, passsword, from mysql.user;
show grants for root@localhost;
show grants for current_user();

-- 3 crear usuarios
Create USER lopez@localhost identified by '1234567';
GRANT CREATE, ALTER, UPDATE ON maratoon.corredores TO lopez@localhost;

-- 4 cambiar password
ALTER USER 'lopez'@'localhost' IDENTIFIED BY '654321';

-- 5 transacciones
USE geslibros;
START TRANSACTION;
UPDATE libros SET precio = precio * 1.10;
SELECT * FROM libros;
ROLLBACK;

-- 6 bloqueo de tablas
LOCK TABLES libros READ;
SELECT * FROM autores;
UNLOCK TABLES;
SELECT * FROM autores;

-- 7 operaciones
START TRANSACTION;
SELECT * FROM clientes WHERE provincia_id = '11'LOCK IN SHARE MODE;
SELECT * FROM clientes WHERE provincia_id <> '11';
COMMIT;

-- 8 operaciones maratoon
USE maratoon;
UPDATE corredores SET edirecciondad = edad + 1;
SELECT id, apellidos, nombre, edad, club, categoria FROM corredores;

-- 9 csv
SELECT * FROM corredores WHERE ciudad = 'Villamartin'INTO OUTFILE '/tmp/corredores_villamartin.csv'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n';

-- 10 salir de consola
EXIT;

-- 11 copia seguridad
mysqldump -u root -p maratoon > maratoon.sql

-- 12 copia seguridad de todas las tablas
mysqldump -u root -p --all-databases > alldatabases.sql

-- 13 exportar base de datos en xml
mysqldump -u root -p --xml empresa > empresa.xml