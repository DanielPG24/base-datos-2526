-- Actividad 6.4
--  4.1.1 Insertamos la venta
SELECT * FROM geslibros.lineasventas;

INSERT INTO ventas (id, cliente_id, fecha, importe_bruto, importe_iva, importe_total) VALUES (11, 6, now(), 289.50, 60.50, 350.30);

-- 4.1.2 Insertamos las lineas_ventas de esa factura
INSERT INTO lineasventas (venta_id, numero_linea, libro_id, iva, cantidad, precio, importe) VALUES
(11, 1, 11, 0.21, 5, 30, 150),
(11, 2, 12, 0.21, 10, 13, 130),
(11, 3, 15, 0.21, 1, 9.50, 9.50);

-- 4.2.1 Actualizar la dirección del cliente
-- id = 5
UPDATE clientes 
SET 
    direccion = 'Polígono Ansu Fati, Calle Messi, Nave 20'
WHERE
    nif = '231242346';
    
-- 4.2.2 Añadir premio autor
SELECT id FROM autores WHERE nombre = 'Oscar Wilde';

UPDATE autores 
SET 
    premios = CONCAT_WS(',', premios, 'Planeta')
WHERE
    nombre = 'Oscar Wilde';
    
-- 4.2.3 Reducir precio de venta al 10%
UPDATE libros 
SET 
    precio_venta = precio_venta * 0.90;

-- 4.2.4 Incrementar precio un 10% libros de Alfaguara y Anaya
SELECT id FROM editoriales WHERE nombre = 'Alfaguara';
SELECT id FROM editoriales WHERE nombre = 'Anaya';

UPDATE libros 
SET 
    precio_coste = precio_coste * 1.10
WHERE
    editorial_id IN (5 , 6);
            
-- 	4.2.5 Descontar 2€ a libros editados antes de 2000
UPDATE libros 
SET 
    precio_venta = precio_venta - 2
WHERE
    YEAR(fecha_edicion) < 2000;
    
-- 4.3.1 Eliminar libros de Alfaguara
SELECT id FROM editoriales WHERE nombre = 'Alfaguara';

DELETE FROM libros 
WHERE
    editorial_id = 5;
        
-- 4.3.2 Eliminar editorial Alfaguara
DELETE FROM editoriales 
WHERE
    id = 5;