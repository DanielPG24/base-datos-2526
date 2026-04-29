-- Actividad 6.6
-- Funciones de agregado

USE empresa;

-- 1 ORDER BY, LIMIT, ALL, DISTINCT
-- Obtener los 3 empleados con mayor salario
SELECT 
    *
FROM
    empleados
ORDER BY salario DESC
LIMIT 3;

-- Obtener los 5 empleados con menor salario
SELECT 
    *
FROM
    empleados
ORDER BY salario ASC
LIMIT 5;

-- Obtener los empleados ordenados alfabéticamente
SELECT 
    *
FROM
    empleados
ORDER BY nombre;

-- Obtener los 3 primeros departamentos
SELECT 
    *
FROM
    departamentos
LIMIT 3;

-- Obtener los 3 empleados con mayores salarios del departamento 3
SELECT 
    *
FROM
    empleados
WHERE
    departamento_id = 3
ORDER BY salario DESC
LIMIT 3;

-- 2 Funcion COUNT()
-- Obtener el número total de departamentos
SELECT 
    COUNT(*)
FROM
    departamentos;

-- 	Obtener el número total de beneficiarios de sexo ‘M’ mujer
SELECT 
    COUNT(*)
FROM
    beneficiarios
WHERE
    genero = 'M';

-- Obtener el número total de empleados cuyo salario esté comprendido entre 20000 y 50000.
SELECT 
    COUNT(*)
FROM
    empleados
WHERE
    salario BETWEEN 20000 AND 50000;

-- Obtener el número total de empleados nacidos después del 1970, no inclusive.
SELECT 
    COUNT(*)
FROM
    empleados
WHERE
    fecha_nac > '1970-12-31';

-- Obtener el número total de proyectos asignados al departamento 3.
SELECT 
    COUNT(*)
FROM
    proyectos
WHERE
    departamento_id = 3;

-- Obtener el número de departamentos que están realizando un proyecto.
SELECT 
    COUNT(DISTINCT departamento_id)
FROM
    Proyectos;
    
-- Obtener el número de empleados que están trabajando en algún proyecto.
SELECT 
    COUNT(DISTINCT empleado_id)
FROM
    empleados_proyectos;
    
-- 3 Función SUM()
-- Obtener el total de horas trabajadas en los distintos proyectos.
SELECT 
    SUM(horas)
FROM
    empleados_proyectos;
    
-- Obtener el total de horas trabajadas en el proyecto 2.
SELECT 
    SUM(horas)
FROM
    empleados_proyectos
WHERE
    proyecto_id = 2;
    
-- Obtener la suma total de los salarios de los empleados.
SELECT 
    SUM(salario)
FROM
    Empleados;
    
-- Obtener la suma total de los salarios de los empleados del departamento 5
SELECT 
    SUM(salario)
FROM
    Empleados
WHERE
    departamento_id = 5;
    
-- Obtener la suma total de los salarios de los empleados cuyo número de supervisor es 3
SELECT 
    SUM(salario)
FROM
    Empleados
WHERE
    supervisor_id = 3;
    
-- Obtener el número de empleados y la suma total de sus salarios del departamento 4
SELECT 
    COUNT(*), SUM(salario)
FROM
    Empleados
WHERE
    departamento_id = 4;

-- Función AVG()
-- Obtener la media total de horas trabajadas en los proyectos
SELECT 
    AVG(horas)
FROM
    empleados_proyectos;
    
-- Obtener número total de jornadas trabajadas, suma total y media de horas trabajadas en los proyectos.
SELECT 
    COUNT(*), SUM(horas), AVG(horas)
FROM
    empleados_proyectos;
    
-- Obtener número de empleados, suma total de sus salarios, media de sus salarios de los empleados del departamento 3.
SELECT 
    COUNT(*), SUM(salario), AVG(salario)
FROM
    Empleados
WHERE
    departamento_id = 3;
    
-- Obtener el salario medio de todos los empleados.
SELECT 
    AVG(salario)
FROM
    Empleados;
    
-- Obtener el número total de empleados, salario medio y suma total de salarios de los empleados.
SELECT 
    COUNT(*), AVG(salario), SUM(salario)
FROM
    Empleados;
    
-- Obtener el número de empleados y salario medio de los nacidos entre 1960 y 1980.
SELECT 
    COUNT(*), AVG(salario)
FROM
    Empleados
WHERE
    fecha_nac BETWEEN '1960-01-01' AND '1980-12-31';
    
-- Obtener aquellos empleados cuyo salario este por encima del salario medio.
SELECT 
    *
FROM
    Empleados
WHERE
    salario > (SELECT 
            AVG(salario)
        FROM
            Empleados);
            
-- Obtener aquellos empleados cuyo salario esté por debajo del salario medio de los empleados del departamento 3.
SELECT 
    *
FROM
    Empleados
WHERE
    salario < (SELECT 
            AVG(salario)
        FROM
            Empleados
        WHERE
            departamento_id = 3);
            
-- Obtener el NSS, Nombre, Apellido de los empleados que hayan trabajado en algún proyecto por encima de la media de horas trabajadas.
SELECT 
    e.nss, e.nombre, e.apellidos
FROM
    Empleados e
        JOIN
    empleados_proyectos ep ON e.id = ep.empleado_id
WHERE
    ep.horas > (SELECT 
            AVG(horas)
        FROM
            empleados_proyectos);
            
-- 5 Función MIN() y MAX()
-- Obtener el salario maximo
SELECT 
    MAX(salario)
FROM
    Empleados;

-- Obtener el salario mínimo
SELECT 
    MIN(salario)
FROM
    Empleados;
    
-- Obtener máximo de horas trabajadas en un proyecto
SELECT 
    MAX(horas)
FROM
    empleados_proyectos;

-- Obtener los datos de los empleados con el salario máximo
SELECT 
    *
FROM
    Empleados
WHERE
    salario = (SELECT 
            MAX(salario)
        FROM
            Empleados);

-- Obtener los datos del o de los empleados con el salario mínimo
SELECT 
    *
FROM
    Empleados
WHERE
    salario = (SELECT 
            MIN(salario)
        FROM
            Empleados);
-- Obtener el NSS del empleado con máximo de horas trabajadas en un proyecto.
SELECT 
    e.nss
FROM
    Empleados e
        JOIN
    empleados_proyectos ep ON e.id = ep.empleado_id
WHERE
    ep.horas = (SELECT 
            MAX(horas)
        FROM
            empleados_proyectos);


-- Obtener el NSS, Nombre, Apellidos de los empleados que hayan trabajado en las horas máximas en un proyecto.
SELECT 
    e.nss, e.nombre, e.apellidos
FROM
    Empleados e
        JOIN
    empleados_proyectos ep ON e.id = ep.empleado_id
WHERE
    ep.horas = (SELECT 
            MAX(horas)
        FROM
            empleados_proyectos);

-- Obtener el NSS de los empleados con horas mínimas trabajadas.
SELECT 
    e.nss
FROM
    Empleados e
        JOIN
    empleados_proyectos ep ON e.id = ep.empleado_id
WHERE
    ep.horas = (SELECT 
            MIN(horas)
        FROM
            empleados_proyectos);

-- Obtener el NSS, Nombre, Apellidos de los empleados que han trabajado en los proyectos en tiempo de horas mínimos.
SELECT 
    e.nss, e.nombre, e.apellidos
FROM
    Empleados e
        JOIN
    empleados_proyectos ep ON e.id = ep.empleado_id
WHERE
    ep.horas = (SELECT 
            MIN(horas)
        FROM
            empleados_proyectos);
