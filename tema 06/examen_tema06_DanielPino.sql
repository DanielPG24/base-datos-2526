USE geslibros;

-- 1. Insertar un nuevo libro en la base de datos
INSERT INTO Libros (id, isbn, ean, titulo, autor_id, editorial_id, precio_coste, precio_venta, stock, stock_min, stock_max, fecha_edicion) VALUES
(20, 9788408096528, 9788888199587, "El Retrato de Dorian Gray", 2, 4, 18.00, 24.00, 12, 5, 25, 2015-03-15);

-- 2. Insertar los registros necesarios en la tabla libros_temas para 
-- asociar el libro insertado anteriormente con las temáticas de Novela y Ciencia.
INSERT INTO libros_temas (libro_id, tema_id) VALUES
(20, 3),
(20, 9);

-- 3. Insertar un nuevo registro en la tabla ventas y sus correspondientes líneas de venta
INSERT INTO ventas (id, cliente_id, fecha, importe_bruto, importe_iva, importe_total) VALUES 
(11, 1, 2014-05-10, 108.00, 22.68, 130.68);

INSERT INTO lineasventas (id, venta_id, numero_linea, libro_id, iva, cantidad, precio, importe) VALUES
(38, 11, 1, 20, 0.21, 2, 48.00, 96.00),
(39, 11, 2, 13, 0.21, 1, 12.00, 12.00);

-- 4. Crear 2 líneas de venta con al menos 2 libros diferentes y que 
-- se pueda emparejar con la venta anterior
INSERT INTO lineasventas (id, venta_id, numero_linea, libro_id, iva, cantidad, precio, importe) VALUES
(40, 11, 3, 14, 0.21, 1, 12.30, 12.30),
(41, 11, 4, 17, 0.21, 1, 12.00, 12.00);


-- 5. Actualizar el precio de venta de todos los libros de la editorial Planeta incrementándolo en un 15%.
UPDATE libros 
SET 
    precio_venta = precio_venta * 1.15
WHERE
    editorial_id = 4;


-- 6. Reducir el stock de todos los libros cuyo stock actual sea superior a 15 unidades en un 20%.
UPDATE libros 
SET 
    stock = stock * 0.8
WHERE
    stock > 15;

-- 7. Eliminar de la base de datos todos los libros de temática Viajes.
DELETE l FROM libros l
        JOIN
    libros_temas lt ON l.id = lt.libro_id 
WHERE
    lt.tema_id = 4;

-- 8. Mostrar aquellos clientes cuya dirección de email pertenezca al dominio "gmail.com" 
-- y que estén ubicados en la provincia de Guadalajara.
SELECT 
    c.id,
    c.nombre,
    c.direccion,
    c.c_postal,
    c.nif,
    c.telefono,
    c.email
FROM
    clientes c
        JOIN
    provincias p ON c.provincia_id = p.id
WHERE
    c.email LIKE '%@gmail.com'
        AND p.provincia = 'Guadalajara'
ORDER BY c.nombre;

-- 9. Mostrar las 5 ventas con menor importe total realizadas en el año 2013.
SELECT 
    v.id,
    c.nombre,
    v.fecha,
    v.importe_bruto,
    v.importe_iva,
    v.importe_total
FROM
    ventas v
        JOIN
    clientes c ON v.cliente_id = c.id
WHERE
    fecha = YEAR(v.fecha) = 2013
ORDER BY v.importe_total ASC
LIMIT 5;

-- 10. Mostrar los libros publicados en el año 2014 cuyo stock sea inferior a 20 unidades.
SELECT 
    l.id,
    l.titulo,
    a.nombre AS autor,
    e.nombre AS editorial,
    l.stock,
    l.precio_coste,
    l.precio_venta
FROM
    libros l
        JOIN
    autores a ON l.autor_id = a.id
        JOIN
    editoriales e ON l.editorial_id = e.id
WHERE
    l.stock < 20
        AND YEAR(l.fecha_edicion) = 2014
ORDER BY l.titulo;

-- 11. Mostrar los libros de temática Novela cuyo precio de venta sea superior a 20 €.
SELECT 
    l.id,
    l.titulo,
    a.nombre AS autor,
    e.nombre AS editorial,
    t.tema,
    l.precio_coste,
    l.precio_venta
FROM
    libros l
        JOIN
    autores a ON l.autor_id = a.id
        JOIN
    editoriales e ON l.editorial_id = e.id
        JOIN
    libros_temas lt ON l.id = lt.libro_id
        JOIN
    temas t ON lt.tema_id = t.id
WHERE
    t.tema = 'Novela'
        AND l.precio_venta > 20
ORDER BY l.titulo;

-- 12. Mostrar los libros cuyo precio de venta sea superior al precio medio de todos los libros de la base de datos.
SELECT 
    l.id,
    l.titulo,
    a.nombre AS autor,
    e.nombre AS editorial,
    l.precio_venta
FROM
    libros l
        JOIN
    autores a ON l.autor_id = a.id
        JOIN
    editoriales e ON l.editorial_id = e.id
WHERE
    l.precio_venta > (SELECT 
            AVG(precio_venta)
        FROM
            libros)
ORDER BY l.precio_venta DESC;

-- 13. Mostrar el número de ventas realizadas y el importe total facturado por cada cliente.
SELECT 
    c.id,
    c.nombre,
    COUNT(v.id) AS numero_ventas,
    SUM(v.importe_total) AS importe_total
FROM
    clientes c
        JOIN
    ventas v ON c.id = v.cliente_id
GROUP BY c.id , c.nombre
ORDER BY numero_ventas DESC;

-- 14. Mostrar estadísticas de ventas para cada libro: número de unidades vendidas, importe total vendido y precio medio de venta.
SELECT 
    l.id,
    l.titulo,
    SUM(lv.cantidad) AS unidades_vendidas,
    SUM(lv.importe) AS importe_total,
    AVG(lv.precio) AS precio_medio
FROM
    libros l
        JOIN
    lineasventas lv ON l.id = lv.libro_id
GROUP BY l.id , l.titulo
ORDER BY importe_total DESC;



