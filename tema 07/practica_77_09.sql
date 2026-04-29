USE empresa;

-- 1. Añadir segundo apellido (ejemplo: Pérez)
UPDATE empleados
SET apellidos = CONCAT(apellidos, ' Pérez')
WHERE id = 1;

UPDATE empleados
SET apellidos = CONCAT(apellidos, ' García')
WHERE id = 2;

UPDATE empleados
SET apellidos = CONCAT(apellidos, ' López')
WHERE id = 3;

UPDATE empleados
SET apellidos = CONCAT(apellidos, ' Martínez')
WHERE id = 4;

UPDATE empleados
SET apellidos = CONCAT(apellidos, ' Sánchez')
WHERE id = 5;

UPDATE empleados
SET apellidos = CONCAT(apellidos, ' Rodríguez')
WHERE id = 6;

UPDATE empleados
SET apellidos = CONCAT(apellidos, ' Fernández')
WHERE id = 7;

UPDATE empleados
SET apellidos = CONCAT(apellidos, ' Gómez')
WHERE id = 8;

UPDATE empleados
SET apellidos = CONCAT(apellidos, ' Díaz')
WHERE id = 9;

UPDATE empleados
SET apellidos = CONCAT(apellidos, ' Álvarez')
WHERE id = 10;

UPDATE empleados
SET apellidos = CONCAT(apellidos, ' Moreno')
WHERE id = 11;


-- 2. Consulta: apellidos primero
SELECT 
    id,
    nss,
    CONCAT(apellidos, ', ', nombre) AS nombre
FROM empleados;


-- 3. Consulta: separar apellido1 y apellido2
SELECT 
    id,
    nss,
    nombre,
    SUBSTRING_INDEX(apellidos, ' ', 1) AS apellido1,
    SUBSTRING_INDEX(apellidos, ' ', -1) AS apellido2
FROM empleados;


-- 4. Consulta: dirección en orden invertido
SELECT 
    id,
    nombre,
    apellidos,
    nss,
    SUBSTRING_INDEX(direccion, ',', -1) AS estado,
    SUBSTRING_INDEX(SUBSTRING_INDEX(direccion, ',', -2), ',', 1) AS provincia,
    SUBSTRING_INDEX(SUBSTRING_INDEX(direccion, ',', -3), ',', 1) AS ciudad,
    SUBSTRING_INDEX(direccion, ',', 1) AS codigo_postal
FROM empleados;


-- 5. Generar código de empleado
SELECT 
    id,
    apellidos,
    nombre,
    nss,
    CONCAT(
        RIGHT(nss, 3),
        '/',
        UPPER(LEFT(nombre, 2)),
        UPPER(LEFT(SUBSTRING_INDEX(apellidos, ' ', 1), 2)),
        UPPER(LEFT(SUBSTRING_INDEX(apellidos, ' ', -1), 2))
    ) AS codigo_generado
FROM empleados;
