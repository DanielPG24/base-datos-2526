USE geslibros;

-- 1. Transacción: Actualizaciones de precios
START TRANSACTION;

-- 1. Libros de tema Novela → -10%
UPDATE libros l
JOIN libros_temas lt ON l.id = lt.libro_id
JOIN temas t ON lt.tema_id = t.id
SET l.precio_venta = l.precio_venta * 0.90
WHERE t.tema = 'Novela';

-- 2. Editorial Anaya → +6%
UPDATE libros l
JOIN editoriales e ON l.editorial_id = e.id
SET l.precio_venta = l.precio_venta * 1.06
WHERE e.nombre = 'Anaya';

-- 3. Resto editoriales → -4.5%
UPDATE libros l
JOIN editoriales e ON l.editorial_id = e.id
SET l.precio_venta = l.precio_venta * 0.955
WHERE e.nombre <> 'Anaya';

-- Comprobación
SELECT id, titulo, precio_venta FROM libros;


-- 2. Deshacer la transacción
ROLLBACK;

-- Comprobar que todo vuelve al estado original
SELECT id, titulo, precio_venta FROM libros;


-- 3. Nueva transacción (INSERTS)
START TRANSACTION;

-- Añadir dos libros
INSERT INTO libros (isbn, titulo, autor_id, editorial_id, precio_coste, precio_venta, stock)
VALUES 
('1111111111111', 'Libro Nuevo 1', 1, 1, 10, 15, 5),
('2222222222222', 'Libro Nuevo 2', 2, 2, 12, 18, 10);

-- Añadir una venta
INSERT INTO ventas (cliente_id, fecha, importe_bruto, importe_iva, importe_total)
VALUES (1, CURDATE(), 100, 21, 121);

-- Obtener ID de la venta
SET @idVenta = LAST_INSERT_ID();

-- Añadir 3 líneas de detalle
INSERT INTO lineasventas (venta_id, numero_linea, libro_id, iva, cantidad, precio, importe)
VALUES 
(@idVenta, 1, 1, 0.21, 2, 15, 30),
(@idVenta, 2, 2, 0.21, 1, 18, 18),
(@idVenta, 3, 3, 0.21, 3, 20, 60);


-- 4. Confirmar la transacción
COMMIT;

-- Comprobación
SELECT * FROM libros ORDER BY id DESC LIMIT 2;
SELECT * FROM ventas ORDER BY id DESC LIMIT 1;
SELECT * FROM lineasventas WHERE venta_id = @idVenta;



-- 5. Transacción con SAVEPOINT
START TRANSACTION;

-- Insertar dos libros
INSERT INTO libros (isbn, titulo, autor_id, editorial_id, precio_coste, precio_venta, stock)
VALUES 
('3333333333333', 'Libro Savepoint 1', 1, 1, 10, 15, 5),
('4444444444444', 'Libro Savepoint 2', 2, 2, 12, 18, 10);

-- Insertar dos clientes
INSERT INTO clientes (nombre, direccion, poblacion, c_postal, provincia_id, nif)
VALUES 
('Cliente Test 1', 'Calle A', 'Madrid', '28001', 28, '11111111A'),
('Cliente Test 2', 'Calle B', 'Madrid', '28002', 28, '22222222B');

-- SAVEPOINT A
SAVEPOINT a;

-- Incrementar precios un 10%
UPDATE libros
SET precio_venta = precio_venta * 1.10;

-- SAVEPOINT B
SAVEPOINT b;

-- Eliminar libros no vendidos
DELETE FROM libros
WHERE id NOT IN (
    SELECT DISTINCT libro_id FROM lineasventas
);

-- Deshacer hasta SAVEPOINT A
ROLLBACK TO a;

-- Comprobación
SELECT id, titulo, precio_venta FROM libros;
SELECT * FROM clientes ORDER BY id DESC LIMIT 2;

-- Finalizar (opcional confirmar lo restante)
COMMIT;
	