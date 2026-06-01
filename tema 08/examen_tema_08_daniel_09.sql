-- Examen Tema 08 
-- Daniel Pino

USE bancos;

-- Ejercicio 1
DELIMITER $$
DROP FUNCTION IF EXISTS resumen_cliente;
CREATE FUNCTION IF NOT EXISTS resumen_cliente(p_cliente_id INT UNSIGNED) RETURNS INT
BEGIN
    DECLARE v_total_cuentas INT;

    SELECT COUNT(*)
    INTO v_total_cuentas
    FROM cuentas
    WHERE cliente_id = p_cliente_id;

    RETURN v_total_cuentas;
END$$

-- Ejercicio 2
USE bancos;

DELIMITER $$

CREATE FUNCTION saldo_medio_ciudad_2(p_ciudad VARCHAR(50)) RETURNS DECIMAL(10,2)
BEGIN
    DECLARE v_media_saldo DECIMAL(10,2);

    SELECT IFNULL(AVG(cu.saldo),0.00)
    INTO v_media_saldo
    FROM cuentas cu
    INNER JOIN clientes cl
        ON cu.cliente_id = cl.id
    WHERE cl.ciudad = p_ciudad;

    RETURN v_media_saldo;
END$$

-- Ejercicio 3
USE bancos;

DELIMITER $$

CREATE PROCEDURE clientes_saldo_negativo()
BEGIN

    SELECT
        cl.id,
        cl.nombre,
        cl.apellidos,
        cl.email,
        cu.iban,
        cu.saldo
    FROM clientes cl
    INNER JOIN cuentas cu
        ON cl.id = cu.cliente_id
    WHERE cu.saldo < 0;

END$$

-- Ejercicio 4
USE bancos;

DELIMITER $$

DROP PROCEDURE IF EXISTS aplicar_interes;
CREATE PROCEDURE IF NOT EXISTS aplicar_interes(IN p_porcentaje DECIMAL(5,2))
BEGIN

    DECLARE v_id INT UNSIGNED;
    DECLARE v_saldo DECIMAL(10,2);
    DECLARE v_importe DECIMAL(10,2);

    DECLARE fin INT DEFAULT 0;

    DECLARE c_cuentas CURSOR FOR SELECT id, saldo FROM cuentas WHERE saldo > 0;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET fin = 1;

    OPEN c_cuentas;

    bucle: LOOP

        FETCH c_cuentas INTO v_id, v_saldo;

        IF fin = 1 THEN
            LEAVE bucle;
        END IF;

        SET v_importe = v_saldo * (p_porcentaje / 100);

        INSERT INTO movimientos(cuenta_id, fechahora, concepto, tipo, cantidad)
        VALUES(v_id, NOW(), 'Abono de intereses', 'I', v_importe);

        UPDATE cuentas
        SET saldo = saldo + v_importe
        WHERE id = v_id;

    END LOOP;

    CLOSE c_cuentas;

END$$

-- Ejercicio 5
USE geslibros;

DELIMITER $$

DROP TRIGGER IF EXISTS actualizar_stock_venta;
CREATE TRIGGER IF NOT EXISTS actualizar_stock_venta
AFTER INSERT ON lineasventas
FOR EACH ROW
BEGIN

    UPDATE libros
    SET stock = stock - NEW.cantidad
    WHERE id = NEW.libro_id;

END$$

-- Ejercicio 6
USE geslibros;

DELIMITER $$

DROP TRIGGER IF EXISTS control_precio_libro;
CREATE TRIGGER IF NOT EXISTS control_precio_libro
BEFORE UPDATE ON libros
FOR EACH ROW
BEGIN

    IF NEW.precio_venta <= NEW.precio_coste THEN

        SET NEW.precio_venta =
            ROUND(NEW.precio_coste * 1.10, 2);

    END IF;

END$$

-- Ejercicio 7
USE geslibros;

DELIMITER $$

DROP PROCEDURE IF EXISTS verificar_importes_ventas;
CREATE PROCEDURE IF NOT EXISTS verificar_importes_ventas()


END$$
-- Ejercicio 8
USE bancos;

DELIMITER $$

DROP EVENT IF EXISTS exportar_movimientos_diarios;
CREATE EVENT IF NOT EXISTS exportar_movimientos_diarios

END$$