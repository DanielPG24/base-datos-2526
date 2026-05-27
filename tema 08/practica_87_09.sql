USE geslibros;
-- Actividad 1. Función importe_bruto_venta()
DELIMITER $$

CREATE FUNCTION importe_bruto_venta(p_venta_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN

    DECLARE total DECIMAL(10,2);

    SELECT SUM(importe)
    INTO total
    FROM lineasventas
    WHERE venta_id = p_venta_id;

    RETURN IFNULL(total,0);

END $$

-- Actividad 2. Función importe_iva_ventas()
DELIMITER $$

CREATE FUNCTION importe_iva_ventas(p_venta_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN

    DECLARE total_iva DECIMAL(10,2);

    SELECT SUM((importe * iva))
    INTO total_iva
    FROM lineasventas
    WHERE venta_id = p_venta_id;

    RETURN IFNULL(total_iva,0);

END $$

-- Actividad 3. Estudio_stock
DELIMITER $$

CREATE PROCEDURE Estudio_stock()
BEGIN

    SELECT
        'Rotura de STOCK:' AS Aviso,
        id,
        titulo,
        precio_coste,
        stock,
        stock_minimo,
        stock_maximo,
        (stock_maximo - stock) AS stock_necesario
    FROM libros
    WHERE stock <= stock_minimo;

END $$

-- Actividad 4. Verificar_importe_total_venta
DELIMITER $$

CREATE PROCEDURE Verificar_importe_total_venta()
BEGIN

    DECLARE v_id INT;
    DECLARE v_fin INT DEFAULT 0;

    DECLARE v_bruto DECIMAL(10,2);
    DECLARE v_iva DECIMAL(10,2);
    DECLARE v_total DECIMAL(10,2);

    DECLARE cur_ventas CURSOR FOR
        SELECT id
        FROM ventas;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET v_fin = 1;

    OPEN cur_ventas;

    bucle: LOOP

        FETCH cur_ventas INTO v_id;

        IF v_fin = 1 THEN
            LEAVE bucle;
        END IF;

        SET v_bruto = importe_bruto_venta(v_id);
        SET v_iva = importe_iva_ventas(v_id);
        SET v_total = v_bruto + v_iva;

        UPDATE ventas
        SET
            importe_bruto = v_bruto,
            importe_iva = v_iva,
            importe_total = v_total
        WHERE id = v_id;

    END LOOP;

    CLOSE cur_ventas;

END $$

-- Actividad 5. TRIGGER actualizar_stock
DELIMITER $$

CREATE TRIGGER actualizar_stock
AFTER INSERT ON lineasventas
FOR EACH ROW
BEGIN

    UPDATE libros
    SET stock = stock - NEW.cantidad
    WHERE id = NEW.libro_id;

END $$

-- Actividad 6. TRIGGER fuera_de_stock
DELIMITER $$

CREATE TRIGGER fuera_de_stock
BEFORE INSERT ON lineasventas
FOR EACH ROW
BEGIN

    DECLARE v_stock INT;

    SELECT stock
    INTO v_stock
    FROM libros
    WHERE id = NEW.libro_id;

    IF v_stock = 0 THEN

        SET NEW.cantidad = 0;

    ELSEIF NEW.cantidad > v_stock THEN

        SET NEW.cantidad = v_stock;

    END IF;

END $$

-- Actividad 7. EVENT. lineas_ventas
SET GLOBAL event_scheduler = ON;
DELIMITER $$

CREATE EVENT lineas_ventas
ON SCHEDULE
EVERY 1 DAY
STARTS CURRENT_TIMESTAMP
DO
BEGIN

    SELECT *
    FROM lineasventas
    WHERE DATE(fecha) = CURDATE()

    INTO OUTFILE '/var/lib/mysql-files/lineasventasdia.csv'
    FIELDS TERMINATED BY ';'
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n';

END $$

-- Actividad 8. EVENT. rebajas
DELIMITER $$

CREATE EVENT rebajas
ON SCHEDULE
AT '2020-06-01 00:00:00'
DO
BEGIN

    UPDATE libros
    SET precio_venta = precio_venta * 0.90;

END $$

