-- Actividad 6.7
-- Subconsultas

USE empresa;

-- 1. Mostrar nombre y apellidos de los empleados que trabajan en el mismo departamento que John Smith.
SELECT 
    nombre, apellidos
FROM
    empleados
WHERE
    departamento_id = (SELECT 
            departamento_id
        FROM
            empleados
        WHERE
            nombre = 'John' AND apellidos = 'Smith');
            
-- 2. Mostrar nombre y apellidos de los empleados mayores que Franklin Wong.
SELECT 
    nombre, apellidos
FROM
    empleados
WHERE
    fecha_nac < (SELECT 
            fecha_nac
        FROM
            empleados
        WHERE
            nombre = 'Franklin'
                AND apellidos = 'Wong');
                
-- 3. Mostrar nombre, apellidos y salario de los empleados cuyo salario es mayor que el salario medio de la empresa.
SELECT 
    nombre, apellidos, salario
FROM
    empleados
WHERE
    salario > (SELECT 
            AVG(salario)
        FROM
            empleados);
            
-- 4. Mostrar los empleados que trabajan en el departamento Investigación.
SELECT 
    nombre, apellidos
FROM
    empleados
WHERE
    departamento_id = (SELECT 
            id
        FROM
            departamentos
        WHERE
            nombre = 'Investigación');
            
-- 5. Mostrar descripción y localización de los proyectos del departamento Administración.
SELECT 
    descripcion, localizacion
FROM
    proyectos
WHERE
    departamento_id = (SELECT 
            id
        FROM
            departamentos
        WHERE
            nombre = 'Administración');
            
-- 6. Mostrar los empleados que participan en proyectos.
SELECT 
    nombre, apellidos
FROM
    empleados
WHERE
    id IN (SELECT 
            empleado_id
        FROM
            empleados_proyectos);
            
-- 7. Mostrar empleados que no están asignados a proyectos.
SELECT 
    nombre, apellidos
FROM
    empleados
WHERE
    id NOT IN (SELECT 
            empleado_id
        FROM
            empleados_proyectos);
            
-- 8. Mostrar empleados que tienen beneficiarios registrados.
SELECT 
    nombre, apellidos
FROM
    empleados
WHERE
    id IN (SELECT 
            empleado_id
        FROM
            beneficiarios);
            
-- 9. Mostrar empleados cuyo salario es el máximo de la empresa.
SELECT 
    nombre, apellidos, salario
FROM
    empleados
WHERE
    salario = (SELECT 
            MAX(salario)
        FROM
            empleados);
            
-- 10. Mostrar nombre, apellidos y salario de los empleados cuyo salario sea mayor que el salario de al menos un empleado del departamento 1.
SELECT 
    nombre, apellidos, salario
FROM
    empleados
WHERE
    salario > ANY (SELECT 
            salario
        FROM
            empleados
        WHERE
            departamento_id = 1);
            
-- 11. Mostrar nombre, apellidos y salario de los empleados que ganan más que todos los empleados del departamento 2.  (obtener las dos versiones con y sin ALL).
SELECT 
    nombre, apellidos, salario
FROM
    empleados
WHERE
    salario > ALL (SELECT 
            salario
        FROM
            empleados
        WHERE
            departamento_id = 2);
            
-- 12. Mostrar los empleados cuyo número de horas en un proyecto sea mayor que alguna asignación registrada en la tabla empleados_proyectos.
SELECT 
    nombre, apellidos
FROM
    empleados
WHERE
    id IN (SELECT 
            empleado_id
        FROM
            empleados_proyectos
        WHERE
            horas > ANY (SELECT 
                    horas
                FROM
                    empleados_proyectos));










