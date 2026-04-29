-- ejemplo 6
-- SELECT

USE maratoon;

-- 1. Mostrar todos las columnas y registros de la tabla corredores
SELECT * FROM corredores;

-- Ejemplo 02 - Espcificación de una lista de columnas 
-- Muestra de la tabla corredor sólo las columnas especificadas en la lista 
SELECT id, Apellidos, Nombre, Edad FROM corredores; 

-- EJEMPLO 03 
SELECT id, Apellidos, Nombre, categoría_id FROM corredores; 

 -- Ejemplo 04 - Cláusula AS  -- Especificación de columnas con asignación de alias a algunas columnas 
SELECT  
Id  AS `Código`, Apellidos, Nombre, club_id AS Club 
FROM 
corredores; 

-- Ejemplo 05 - Renombrar columnas sin AS -- Veamos a continuación que la cláusula AS no es obligatoria 
SELECT  
id `Código`, Apellidos, Nombre, club_id Club 
FROM 
corredores;

-- Ejemplo 06 - Prefijos -- En este ejemplo vemos que el prefijo nombre de tabla es obligatorio sólo  -- para el campo Nombre, ya que dicha columna se repite en ambas tablas 
SELECT  
corredores.id, 
corredores.Nombre, 
corredores.Apellidos, 
carreras.Nombre, 
carreras.Ciudad 
FROM 
corredores, 
carreras;

-- Ejemplo 07 - Prefijos con alias en las tablas 
SELECT  
co.id, co.Nombre, co.Apellidos, ca.Nombre, ca.Ciudad 
FROM 
corredores AS co, 
carreras AS ca;

-- Ejemplo 08 - Expresiones en la lista de columnas 
SELECT 
id, 
CONCAT(Apellidos, ‘, ‘, Nombre) AS Nombre, 
YEAR(FechaNacimiento) AS 'Año Nacimiento', 
Edad 
FROM 
corredores;

-- Ejemplo 09 - solo los corredores de ubrique
SELECT * FROM corredores WHERE ciudad = 'Ubrique';

SELECT * FROM corredores WHERE ciudad NOT IN ('Villamartin', 'Arcos') ORDER BY edad ASC;

SELECT * FROM Corredores  WHERE Nombre REGEXP '^A';

SELECT * FROM Corredores WHERE Nombre REGEXP 'a$';

SELECT * FROM Corredores WHERE Nombre REGEXP '^P|J';

SELECT * FROM Corredores WHERE Nombre REGEXP 'an.';

SELECT * FROM Corredores WHERE Nombre REGEXP 'ua*'; 

SELECT * FROM Corredores WHERE Nombre REGEXP 'jo+'; 

SELECT * FROM Corredores WHERE Nombre REGEXP '(ua|fa)'; 

SELECT * FROM Corredores WHERE Nombre REGEXP '^(Ju|Ev)'; 

SELECT * FROM Corredores WHERE Nombre REGEXP 'j{2,3}'; 

SELECT * FROM Corredor WHERE Nombre  REGEXP '[dv]'; 

SELECT * FROM Corredores WHERE Nombre  NOT REGEXP '[ap]';  