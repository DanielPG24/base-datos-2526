-- practica_78_09
-- funciones fecha hora

USE maratoon;

-- 1. AÑADIR 3 CORREDORES
INSERT INTO corredores (nombre, apellidos, ciudad ,fechaNacimiento, sexo, club_id)
VALUES 
('Juan', 'García López', 'Villaluenga', '2005-03-15', 'H', 5),
('María', 'Fernández Ruiz', 'Villaluenga', '1998-07-22', 'M', 5),
('Carlos', 'Sánchez Pérez', 'Grazalema', '1985-11-10', 'H', 5);


-- 2. ACTUALIZAR EDAD
UPDATE corredores
SET edad = TIMESTAMPDIFF(YEAR, fechaNacimiento, NOW());


-- 3. ACTUALIZAR CATEGORIA
UPDATE corredores
SET categoria_id = 
CASE 
    WHEN edad < 12 THEN 1 -- infantil
    WHEN edad < 15 THEN 2 -- junior
    WHEN edad < 18 THEN 3 -- juvenil
    WHEN edad < 30 THEN 4 -- senior A
    WHEN edad < 40 THEN 5 -- senior B
    WHEN edad < 50 THEN 6 -- veterano A
    WHEN edad < 60 THEN 7 -- veterano B
    ELSE 8 -- veterano C
END;


-- 4. MOSTRAR CORREDORES
SELECT 
    c.id,
    c.nombre,
    c.apellidos,
    c.fechaNacimiento,
    c.edad,
    cat.nombre_corto AS categoria,
    cl.nombre_corto AS club
FROM corredores c
JOIN categorias cat ON c.categoria_id = cat.id
JOIN clubs cl ON c.club_id = cl.id;


-- CORREDORES QUE CUMPLEN EL MES QUE VIENE
SELECT 
    c.id,
    c.nombre,
    c.apellidos,
    c.fechaNacimiento,
    c.edad,
    cat.nombre_corto AS categoria,
    cl.nombre_corto AS club
FROM corredores c
JOIN categorias cat ON c.categoria_id = cat.id
JOIN clubes cl ON c.club_id = cl.id
WHERE MONTH(c.fechaNacimiento) = MONTH(DATE_ADD(NOW(), INTERVAL 1 MONTH));


-- CORREDORES QUE CUMPLEN LA SEMANA QUE VIENE
SELECT 
    c.id,
    c.nombre,
    c.apellidos,
    c.fechaNacimiento,
    c.edad,
    cat.nombre_corto AS categoria,
    cl.nombre_corto AS club
FROM corredores c
JOIN categorias cat ON c.categoria_id = cat.id
JOIN clubes cl ON c.club_id = cl.id
WHERE WEEK(c.fechaNacimiento) = WEEK(DATE_ADD(NOW(), INTERVAL 1 WEEK));


-- NACIDOS EN EL 2º CUATRIMESTRE
SELECT 
    c.id,
    c.nombre,
    c.apellidos,
    c.fechaNacimiento,
    c.edad,
    cat.nombre_corto AS categoria,
    cl.nombre_corto AS club
FROM corredores c
JOIN categorias cat ON c.categoria_id = cat.id
JOIN clubes cl ON c.club_id = cl.id
WHERE MONTH(c.fechaNacimiento) BETWEEN 5 AND 8;


-- 5. INSERTAR REGISTROS MARATÓN DE SEVILLA
INSERT INTO registros VALUES 
(NULL, 2, 2, '2019-12-02 09:00:00', '2019-12-02 11:20:00', NULL),
(NULL, 2, 3, '2019-12-02 09:00:00', '2019-12-02 11:35:00', NULL),
(NULL, 2, 4, '2019-12-02 09:00:00', '2019-12-02 11:50:00', NULL),
(NULL, 2, 5, '2019-12-02 09:00:00', '2019-12-02 12:05:00', NULL),
(NULL, 2, 6, '2019-12-02 09:00:00', '2019-12-02 12:20:00', NULL);


-- 6. ACTUALIZAR TIEMPO INVERTIDO
UPDATE registros
SET tiempoInvertido = TIMEDIFF(llegada, salida)
WHERE maraton_id = 2;


-- 7. CLASIFICACIÓN
SELECT 
    c.id,
    c.nombre,
    c.apellidos,
    cl.nombre AS club,
    cat.nombre AS categoria,
    r.tiempoInvertido
FROM registros r
JOIN corredores c ON r.corredor_id = c.id
JOIN clubes cl ON c.club_id = cl.id
JOIN categorias cat ON c.categoria_id = cat.id
WHERE r.maraton_id = 2
ORDER BY r.tiempoInvertido ASC;


-- CLASIFICACIÓN + SEGUNDOS
SELECT 
    c.id,
    c.nombre,
    c.apellidos,
    cl.nombre AS club,
    cat.nombre AS categoria,
    r.tiempoInvertido,
    TIME_TO_SEC(r.tiempoInvertido) AS segundos
FROM registros r
JOIN corredores c ON r.corredor_id = c.id
JOIN clubes cl ON c.club_id = cl.id
JOIN categorias cat ON c.categoria_id = cat.id
WHERE r.maraton_id = 2
ORDER BY r.tiempoInvertido ASC;


-- DIFERENCIA CON RECORD MUNDIAL (2:01:39)
SELECT 
    c.id,
    c.nombre,
    c.apellidos,
    cl.nombre AS club,
    cat.nombre AS categoria,
    r.tiempoInvertido,
    TIMEDIFF(r.tiempoInvertido, '02:01:39') AS diferencia_record
FROM registros r
JOIN corredores c ON r.corredor_id = c.id
JOIN clubes cl ON c.club_id = cl.id
JOIN categorias cat ON c.categoria_id = cat.id
WHERE r.maraton_id = 2
ORDER BY r.tiempoInvertido ASC;


-- CLASIFICACIÓN SOLO CATEGORÍA SNA
SELECT 
    c.id,
    c.nombre,
    c.apellidos,
    cl.nombre AS club,
    cat.nombre AS categoria,
    r.tiempoInvertido
FROM registros r
JOIN corredores c ON r.corredor_id = c.id
JOIN clubes cl ON c.club_id = cl.id
JOIN categorias cat ON c.categoria_id = cat.id
WHERE r.maraton_id = 2
AND cat.nombre_corto = 'SNA'
ORDER BY r.tiempoInvertido ASC;
