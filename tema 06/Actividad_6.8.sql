-- Actividad 6.8
-- Consultas multitablas

-- Activamos la base de datos futbol
USE futbol;

-- Realiza un producto cartesiano entre las tablas jugadores y equipos.
SELECT 
    *
FROM
    jugadores,
    equipos;

-- Realiza un producto cartesiano entre las tablas jugadores y goles.
SELECT 
    *
FROM
    jugadores,
    goles;

-- Realiza un producto cartesiano entre las tablas jugadores y equipos eliminando los registros espurios (where).
SELECT 
    *
FROM
    jugadores,
    equipos
WHERE
    jugadores.equipo_id = equipos.id;

-- Realiza un producto cartesiano entre las tablas jugadores y goles eliminando los registros espurios (where).
SELECT 
    *
FROM
    goles,
    jugadores
WHERE
    goles.jugador_id = jugadores.id;

-- Realiza INNER JOIN correcto entre las tablas jugadores y equipos, devolver todas las columnas de jugadores y de equipos.
 SELECT 
    *
FROM
    jugadores
        INNER JOIN
    equipos ON jugadores.equipo_id = equipos.id;
    
-- Realiza INNER JOIN correcto entre las tablas jugadores y equipos, devolver las columnas id, nombre, edad y equipo
SELECT 
    id,
    nombre,
    TIMESTAMPDIFF(YEAR,
        jugadores.fecha_nac,
        CURDATE()) edad
FROM
    futbol.jugadores;
    
-- Realizar INNER JOIN correcto entre las tablas jugadores y goles.
SELECT 
    *
FROM
    jugadores
        INNER JOIN
    goles ON jugadores.id = goles.jugador_id;
    
-- Realiza INNER JOIN correcto entre las tablas jugadores y goles, devolver las columnas id, nombre, minuto, descripción.
SELECT 
    jugadores.id,
    jugadores.nombre,
    goles.minuto,
    goles.descripcion
FROM
    jugadores
        INNER JOIN
    goles ON jugadores.id = goles.jugador_id;

-- Realizar INNER JOIN correcto entre las tablas jugadores, equipos y goles.
SELECT 
    *
FROM
    jugadores
        INNER JOIN
    equipos ON jugadores.equipo_id = equipos.id
        INNER JOIN
    goles ON jugadores.id = goles.jugador_id;
    
-- Realiza INNER JOIN correcto entre las tablas jugadores y goles, devolver las columnas id, nombre, equipo, minuto, descripción.
SELECT 
    jugadores.id,
    jugadores.nombre,
    equipos.nombre AS equipo,
    goles.minuto,
    goles.descripcion
FROM
    jugadores
        INNER JOIN
    equipos ON jugadores.equipo_id = equipos.id
        INNER JOIN
    goles ON jugadores.id = goles.jugador_id;
    
-- Realizar INNER JOIN correcto entre las tablas jugadores, equipos, goles y partidos. Todas las columnas.
SELECT 
    *
FROM
    jugadores
        INNER JOIN
    equipos ON jugadores.equipo_id = equipos.id
        INNER JOIN
    goles ON jugadores.id = goles.jugador_id
        INNER JOIN
    partidos ON goles.id_partido = partidos.id;
    
-- Realiza INNER JOIN correcto entre las tablas jugadores y goles, devolver las columnas id, nombre, equipo, minuto, descripción, observaciones.
SELECT 
    jugadores.id,
    jugadores.nombre,
    jugadores.equipo_id,
    goles.minuto,
    goles.descripcion
FROM
    jugadores
        INNER JOIN
    equipos ON jugadores.equipo_id = equipos.id
        INNER JOIN
    goles ON jugadores.id = goles.jugador_id
        INNER JOIN
    partidos ON goles.id_partido = id_partido;




