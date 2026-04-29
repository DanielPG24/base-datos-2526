-- ejemplo
-- SELECT

-- Muestra todos los registros de la tabla, con todas las columnas de la tabla
-- Lista de columnas: *
SELECT * FROM libros;

-- Especificamos lista de columnas
SELECT id, titulo, autor_id, editorial_id, precio_venta FROM libros;

-- Especificamos lista de columnas con otro orden
SELECT 
    id,
    titulo,
    precio_venta,
    autor_id,
    editorial_id,
    precio_coste
FROM
    libros;

-- Lista de columnas con expresión
-- Beneficio que obtengo de cada libro: precio_venta - precio_coste
-- Coloca el alías beneficios en esta última columna
SELECT 
    id,
    titulo,
    autor_id,
    editorial_id,
    precio_coste,
    precio_venta,
    precio_venta - precio_coste as beneficio
FROM
    libros;
    
-- Lista de columnas con expresión
-- Beneficio que obtengo de cada libro: precio_venta - precio_coste
-- Coloca el alías beneficios en esta última columna
SELECT 
    id,
    titulo,
    autor_id,
    editorial_id,
    precio_coste,
    precio_venta,
    precio_venta - precio_coste beneficio
FROM
    libros;

-- Columnas: nombre de la base de datos, nombre de la tabla
-- Tablas: nombre de la base de datos
SELECT 
    libros.id,
    libros.titulo,
    libros.autor_id,
    libros.editorial_id,
    libros.precio_coste,
    libros.precio_venta,
    libros.precio_venta - libros.precio_coste beneficio
FROM
    geslibros.libros;
    
--
use mara;

-- Clausula FROM las tablas a partir de la cual extraigo los datos
SELECT 
    libros.id,
    libros.titulo,
    libros.autor_id,
    autores.id as id_autor,
    autores.nombre as autor,
    libros.id as id_libro,
    libros.precio_venta
FROM
    libros,
    autores;