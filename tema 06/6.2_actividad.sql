USE futbol;

-- Cambiar nombre del equipo
UPDATE equipos 
SET 
    nombre = 'Girona Futbol Club'
WHERE
    nombre = 'Girona FC';
    
-- Actualizar ciudad de un equipo
UPDATE equipos 
SET 
    ciudad = 'Vila-real'
WHERE
    nombre = 'Villarreal CF';
    
-- Incremento aforo estadio
UPDATE equipos 
SET 
    aforo = aforo + 1000
WHERE
    aforo > 50000;
    
-- Cambiar equipo de jugador
UPDATE jugadores 
SET 
    equipo_id = 7
WHERE
    nombre = 'Hugo Duro';
    
-- Corregir fecha de nacimiento
UPDATE jugadores 
SET 
    fecha_nac = '2001-06-05'
WHERE
    nombre = 'Takefusa Kubo';
    
-- Ajustar goles partido
UPDATE partidos 
SET 
    goles_casa = 2,
    goles_fuera = 1
WHERE
    id = 7 LIMIT 1;
    
-- Actualizar observaciones ultimos 3 partidos
UPDATE partidos 
SET 
    observaciones = concat_ws(' ', observaciones, ' (actualizado)')
ORDER BY fecha DESC LIMIT 3;

-- Cambiar minutos de goles por penalti
UPDATE goles 
SET 
    minuto = minuto + 1
WHERE
    descripcion LIKE '%penalti%';
    
-- Asignar goles partidos a jugador(solo local)
UPDATE goles 
SET 
    jugador_id = 18
WHERE
    id = 37 LIMIT 1;
    
-- Incrementar minutos goles Iñaki Williams
SELECT 
    *
FROM
    goles
WHERE
    id = 20;

UPDATE goles 
SET 
    minuto = minuto + 1
WHERE
    jugador_id = 20 ORDER BY id ASC LIMIT 2;
            
-- Modificar estadio de un equipo
UPDATE equipos 
SET 
    estadio = 'Reale Arena Nuevo'
WHERE
    nombre = 'Real Sociedad';
    
-- Mover jugadores de Girona a Athletic
UPDATE jugadores 
SET 
    equipo_id = 8
WHERE
    equipo_id = (SELECT 
            equipo_id
        FROM
            equipos
        WHERE
            nombre = 'Girona Futbol Club');
            
-- Incrementar goles como local de Valencia
UPDATE partidos 
SET 
    goles_casa = goles_casa + 1
WHERE
    equipo_casa_id = (SELECT 
            equipo_id
        FROM
            equipos
        WHERE
            nombre = 'Valencia CF');
            
-- Correguir minutos de goles antiguos
UPDATE goles 
SET 
    minuto = minuto - 2
WHERE
    minuto > 80;
    
-- Renombrar jugador
UPDATE jugadores 
SET 
    nombre = 'José Gayà'
WHERE
    id = 16;











