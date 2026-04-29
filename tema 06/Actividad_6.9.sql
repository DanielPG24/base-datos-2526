-- Actividad 6.9
-- Consultas Multitablas Avanzadas

USE empresa;

-- 1.
SELECT 
    e.id,
    e.nombre,
    e.apellidos,
    e.salario,
    e.departamento_id,
    d.nombre AS nombre_departamento
FROM
    empleados e
        INNER JOIN
    departamentos d ON e.departamento_id = d.id
ORDER BY e.id;

-- 2.
SELECT 
    d.id,
    d.nombre,
    d.localizacion,
    d.componentes,
    d.jefe_departamento_id,
    e.apellidos,
    e.nombre
FROM
    departamentos d
        INNER JOIN
    empleados e ON d.jefe_departamento_id = e.id
ORDER BY d.nombre;

-- 3.
SELECT 
    e.id,
    e.nombre,
    e.apellidos,
    e.nss,
    e.salario,
    s.nombre AS supervisor_nombre,
    s.apellidos AS supervisor_apellidos
FROM
    empleados e
        INNER JOIN
    empleados s ON e.supervisor_id = s.id
ORDER BY e.id;

-- 4.
SELECT 
    b.id,
    b.nombre,
    b.genero,
    b.parentesco,
    b.fecha_nac,
    b.empleado_id,
    e.nombre AS empleado_nombre,
    e.apellidos AS empleado_apellidos
FROM
    beneficiarios b
        INNER JOIN
    empleados e ON b.empleado_id = e.id;
    
-- 5.
SELECT 
    p.id,
    p.descripcion,
    p.num_proyecto,
    p.localizacion,
    p.fecha_inicio,
    p.fecha_fin,
    p.departamento_id,
    d.nombre AS departamento
FROM
    proyectos p
        INNER JOIN
    departamentos d ON p.departamento_id = d.id;
    
-- 6.
SELECT 
    p.id,
    p.descripcion,
    p.num_proyecto,
    p.localizacion,
    p.fecha_inicio,
    p.fecha_fin,
    p.departamento_id,
    d.nombre AS departamento,
    e.nombre AS jefe_nombre,
    e.apellidos AS jefe_apellidos
FROM
    proyectos p
        INNER JOIN
    departamentos d ON p.departamento_id = d.id
        INNER JOIN
    empleados e ON d.jefe_departamento_id = e.id;
    
-- 7.
SELECT 
    ep.empleado_id,
    ep.proyecto_id,
    ep.horas,
    e.nombre,
    e.apellidos,
    p.descripcion
FROM
    empleados_proyectos ep
        INNER JOIN
    empleados e ON ep.empleado_id = e.id
        INNER JOIN
    proyectos p ON ep.proyecto_id = p.id
ORDER BY e.apellidos , e.nombre;






