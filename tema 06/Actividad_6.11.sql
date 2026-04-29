-- Actividad 6.11
-- GROUP BY - HAVING

USE empresa;

-- 1. Numero de empleados en cada departamento
-- columnas: id, departamento, num_empleados
SELECT 
    departamento_id, COUNT(*) num_empleados
FROM
    empleados
        INNER JOIN
    departamentos ON empleados.departamento_id = departamentos.id
GROUP BY departamentos_id;

-- 2. Obtener el número de empleados que hay en cada departamento cuyo sueldo esté por encima de los 30000 anuales. Mismas columnas que el ejercicio anterior. 
SELECT 
    departamento_id,
    departamentos.nombre departamento,
    COUNT(*) num_empleados
FROM
    empleados
        LEFT JOIN
    departamentos ON empleados.departamento_id = departamentos.id
WHERE
    salario > 30000
GROUP BY empleados.departamento_id;

-- 3. Obtener el número total de empleados que hay en cada departamento cuyo salario esté comprendido entre 20000 y 50000. Mismas columnas que el ejercicio anterior. 
SELECT 
    departamento_id,
    departamentos.nombre departamento,
    COUNT(*) num_empleados
FROM
    empleados
        LEFT JOIN
    departamentos ON empleados.departamento_id = departamentos.id
WHERE
    salario BETWEEN 20000 AND 50000
GROUP BY empleados.departamento_id;

-- 4. Obtener el número de empleados que nacieron en cada año. Mostrar las columnas con el alias Año y Nempleados.
SELECT 
    YEAR(fecha_nac) AS Año, COUNT(*) AS Nempleados
FROM
    empleados
GROUP BY YEAR(fecha_nac);

-- 5. Sobre la tabla Empleados_proyectos, obtener la suma total de horas trabajadas en cada proyecto. Mostrar id, Proyecto y HorasAcumuladas. 
SELECT 
    p.id,
    p.descripcion AS Proyecto,
    SUM(ep.horas) AS HorasAcumuladas
FROM
    proyectos p
        JOIN
    empleados_proyectos ep ON p.id = ep.proyecto_id
GROUP BY p.id , p.descripcion;

