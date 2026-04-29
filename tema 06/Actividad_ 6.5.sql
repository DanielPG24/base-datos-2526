-- Actividad 6.5
-- Consultas Básicas de selección

USE futbol;

-- 1 consultas básicas
-- Listado de todos los jugadores
SELECT * FROM jugadores;

-- Listado de todos los equipos
SELECT * FROM equipos;

-- Listado de todos los partidos
SELECT * FROM partidos;

-- Listado de los tres últimos partidos
SELECT * FROM partidos ORDER BY fecha DESC limit 3;

-- 2 Consultas con LIMIT
-- Listado de los 5 goles más tempranos
SELECT 
    *
FROM
    goles
ORDER BY minuto
LIMIT 5;

-- Listado de los goles del 5 al 10
SELECT * FROM goles ORDER BY id LIMIT 5 OFFSET 4;

-- Listado de los tres últimos partidos disputados
SELECT * FROM partidos ORDER BY fecha DESC LIMIT 3;

-- Listado de sólo 1 partido donde intervino el Betis como equipo de fuera
SELECT id FROM equipos WHERE nombre LIKE '%Betis%';

SELECT * FROM partidos WHERE equipo_fuera_id = 5;

-- Listado de 1 partido donde el equipo de fuera no marcó
SELECT * FROM partidos WHERE goles_fuera = 0;

-- Listar 5 goles a partir del gol 4
SELECT * FROM goles ORDER BY id LIMIT 5 OFFSET 4;

-- 3. Consultas listas de columnas
-- Mostrar el id, nombre y id_equipo de todos los jugadores
SELECT id, nombre, equipo_id
FROM jugadores;

-- Mostrar la misma consulta anterior pero asignando los siguientes 
-- alias: Numero, Nombre Jugador y Código Equipo. Usar cláusula AS 12.
SELECT 
id AS Numero,
nombre AS "Nombre Jugador",
equipo_id AS "Código Equipo"
FROM jugadores;

-- Mostrar la misma consulta anterior pero sin usar la cláusula AS. 
-- (No se debe pero para comprobar que dicha cláusula es opcional)
SELECT 
id Numero,
nombre "Nombre Jugador",
equipo_id "Código Equipo"
FROM jugadores;

-- Mostrar la misma consulta anterior pero usando los prefijos del nombre de 
-- la tabla para la especificación de las columnas
SELECT 
jugadores.id,
jugadores.nombre,
jugadores.equipo_id
FROM jugadores;

-- Mostrar la misma consulta anterior pero usando el prefijo del nombre de la base 
-- de datos y del nombre de la tabla, en la especificación de listas de columnas
SELECT 
Futbol.jugadores.id,
Futbol.jugadores.nombre,
Futbol.jugadores.equipo_id
FROM Futbol.jugadores;

-- Realizar una consulta que me permita obtener el siguiente cálculo (32 + (0,33 * 10))/4
SELECT (32 + (0.33 * 10)) / 4;

-- 4 Con predicados (WHERE)
-- Mostrar todos los jugadores del equipo cuyo id es 2 correspondiente al Barcelona
SELECT *
FROM jugadores
WHERE equipo_id = 2;

-- Mostrar el jugador cuyo id es 4
SELECT *
FROM jugadores
WHERE id = 4;

-- Mostrar los tres jugadores más jóvenes del equipo 2
SELECT *
FROM jugadores
WHERE equipo_id = 2
ORDER BY fecha_nac DESC
LIMIT 3;

-- Mostrar los equipos con el estadio de capacidad superior a 10000 espectadores
SELECT *
FROM equipos
WHERE aforo > 10000;

-- Mostrar los equipos con estadios de capacidad superior a 12000 espectadores y su 
-- fundación posterior al año 1970.
SELECT *
FROM equipos
WHERE aforo > 12000
AND fundacion > 1970;

-- Goles marcados por el jugador 1
SELECT *
FROM goles
WHERE jugador_id = 1;

-- Goles marcados por el jugador 1 y jugando como local (ver equipo al que pertenece el jugador 1)
SELECT *
FROM goles
WHERE jugador_id = 1;

-- Comprobar si hay algún jugador que se llama Lamine
SELECT *
FROM jugadores
WHERE nombre LIKE 'Lamine%';

-- Comprobar si algún jugador del equipo 1 se llama Jude
SELECT *
FROM jugadores
WHERE equipo_id = 1
AND nombre LIKE 'Jude%';

-- Obtener todos los partidos ganados en casa por el equipo 3
SELECT *
FROM partidos
WHERE equipo_casa_id = 3
AND goles_casa > goles_fuera;

-- Obtener todos los partidos ganados por el equipo local
SELECT *
FROM partidos
WHERE goles_casa > goles_fuera;

-- Obtener todos los partidos acabados en empate
SELECT *
FROM partidos
WHERE goles_casa = goles_fuera;

-- Obtener todos los partidos ganados por el equipo visitante
SELECT *
FROM partidos
WHERE goles_fuera > goles_casa;

-- Obtener todos los partidos donde se haya ganado por más de 1 gol de diferencia.
SELECT *
FROM partidos
WHERE ABS(goles_casa - goles_fuera) > 1;

-- 5 Operadores IN, BETWEEN, LIKE
-- Seleccionar aquellos jugadores de los siguientes equipos: Real Madrid, Barcelona y Betis
SELECT *
FROM jugadores
WHERE equipo_id IN (1,2,5);

-- Selecciona aquellos equipos con capacidad de estadio entre 40.000 y 80.000 espectadores.
SELECT *
FROM equipos
WHERE aforo BETWEEN 40000 AND 80000;

-- Selecciona aquellos equipos cuyo estadio no tenga menos de 30.000 espectadores de capacidad
SELECT *
FROM equipos
WHERE aforo >= 30000;

-- Selecciona aquellos jugadores nacidos entre el 1995 y 2000
SELECT *
FROM jugadores
WHERE fecha_nac BETWEEN '1995-01-01' AND '2000-12-31';

-- Selecciona aquellos jugadores cuyo nombre empiece por "D"
SELECT *
FROM jugadores
WHERE nombre LIKE 'D%';

-- Selecciona el jugador llamado Alarcón
SELECT *
FROM jugadores
WHERE nombre LIKE '%Alarcón%';

-- 6 Con criterios de ordenación (ORDER BY)
-- Obtener los los jugadores por orden alfabético de forma descendente
SELECT *
FROM jugadores
ORDER BY nombre DESC;

-- Obtener los equipos ordenados por el estadio de mayor a menor aforo
SELECT *
FROM equipos
ORDER BY aforo DESC;

-- Obtener los jugadores ordenados por equipo y luego por nombre
SELECT *
FROM jugadores
ORDER BY equipo_id, nombre;

-- Obtener los jugadores del equipo 1 ordenados por fecha de nacimiento desde el más veterano al mas joven.
SELECT *
FROM jugadores
WHERE equipo_id = 1
ORDER BY fecha_nac ASC;

-- Obtener los jugadores del equipo 2 ordenados por fecha de nacimiento desde el más joven al mas veterano.
SELECT *
FROM jugadores
WHERE equipo_id = 2
ORDER BY fecha_nac DESC;




