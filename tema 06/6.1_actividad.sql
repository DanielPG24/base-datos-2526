-- Actividad: 6.1
-- Tema: Lenguaje SQL - DDL
-- Módulo: Base de Datos
-- Curso: 25/26
-- Nombre: Daniel Pino

-- Descripción: mina de datos de la bbd futbol
USE FUTBOL;

-- Tabla equipos
INSERT INTO equipos VALUES
(6, 'Rayo Vallecano', 'Estadio de Vallecas', 50721, 1900, 'Madrid'),
(7, 'Real Sociedad', 'Anoeta', 61721, 1807, ''),
(8, 'Elche FC', 'Martínez Valero', 43521, 1876, ''),
(9, 'RCD Espanyol', 'RCDE Stadium', 60721, 1927, 'Barcelona'),
(10, 'Villareal FC', 'Estadio de la Cerámica', 54721, 1897, 'Valencia');

-- Tabla jugadores	
INSERT INTO jugadores VALUES
(16, 'Toni Kroos', '1990-01-04', 1),
(17, 'João Félix', '1999-11-10', 2),
(18, 'Koke Resurrección', '1992-01-08', 3),
(19, 'Sergio Ramos', '1986-03-30', 4),
(20, 'Ayoze Pérez', '1993-07-29', 5),
(21, 'Eduardo Camavinga', '2002-11-10', 1),
(22, 'Ferran Torres', '2000-02-29', 2),
(23, 'Samuel Lino', '1999-12-23', 3),
(24, 'Lucas Ocampos', '1994-07-11', 4),
(25, 'William Carvalho', '1992-04-07', 5);

-- Tabla partidos
INSERT INTO partidos VALUES
(7, 2, 1, '2024-04-20 21:00:00', 1, 2, 'Clásico muy disputado decidido en el tramo final'),
(8, 4, 5, '2024-04-21 18:30:00', 0, 1, 'Partido muy táctico con pocas ocasiones'),
(9, 3, 2, '2024-04-27 20:00:00', 2, 0, 'Gran actuación del Atlético en casa'),
(10, 1, 4, '2024-05-03 21:00:00', 3, 0, 'Dominio absoluto del Real Madrid'),
(11, 5, 2, '2024-05-10 18:30:00', 2, 2, 'Empate con goles en los minutos finales'),
(12, 1, 5, '2024-05-18 21:00:00', 2, 0, 'Partido sólido del Real Madrid'),
(13, 2, 3, '2024-05-19 18:30:00', 1, 1, 'Empate muy disputado en el Camp Nou'),
(14, 4, 1, '2024-05-25 21:00:00', 0, 2, 'El Madrid gana con oficio fuera de casa'),
(15, 5, 3, '2024-05-26 18:30:00', 1, 0, 'Victoria mínima del Betis'),
(16, 3, 4, '2024-06-01 20:00:00', 2, 1, 'Remontada del Atlético en el Metropolitano');

-- Tabla goles
INSERT INTO goles VALUES
-- Partido 7: FC Barcelona 1 - 2 Real Madrid
(NULL, 7, 35, 'Lewandowski adelanta al Barça con un remate en el área', 4),
(NULL, 7, 60, 'Vinícius empata tras una contra rápida', 1),
(NULL, 7, 88, 'Bellingham marca el gol de la victoria con un disparo lejano', 2),

-- Partido 8: Sevilla FC 0 - 1 Real Betis
(NULL, 8, 72, 'Ayoze Pérez marca tras una jugada colectiva', 20),

-- Partido 9: Atlético de Madrid 2 - 0 FC Barcelona
(NULL, 9, 25, 'Griezmann abre el marcador con un tiro cruzado', 7),
(NULL, 9, 67, 'Morata amplía la ventaja de cabeza', 8),

-- Partido 10: Real Madrid 3 - 0 Sevilla FC
(NULL, 10, 15, 'Rodrygo marca tras una gran jugada individual', 3),
(NULL, 10, 40, 'Vinícius anota el segundo con un disparo potente', 1),
(NULL, 10, 78, 'Toni Kroos cierra el marcador con un tiro desde fuera del área', 16),

-- Partido 11: Real Betis 2 - 2 FC Barcelona
(NULL, 11, 20, 'Isco marca desde el punto de penalti', 13),
(NULL, 11, 45, 'Pedri empata con un disparo ajustado', 5),
(NULL, 11, 70, 'Borja Iglesias adelanta al Betis tras un centro lateral', 14),
(NULL, 11, 90, 'João Félix empata en el último minuto', 17),

(NULL, 12, 30, 'Camavinga marca con un disparo desde fuera del área', 21),
(NULL, 13, 55, 'Ferran Torres empata el partido con un tiro cruzado', 22),
(NULL, 14, 70, 'Vinícius sentencia tras una gran jugada individual', 1),
(NULL, 15, 65, 'William Carvalho marca con un potente disparo lejano', 25),
(NULL, 16, 85, 'Griezmann anota el gol de la victoria en el tramo final', 7);
