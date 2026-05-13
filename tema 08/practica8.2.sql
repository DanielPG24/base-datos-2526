USE bancos;

-- Actividad 1. saldo_total
DELIMITER $$
DROP FUNCTION IF EXISTS saldo_total $$
CREATE FUNCTION saldo_total()
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);

    SELECT SUM(saldo)
    INTO total
    FROM cuentas;

    RETURN total;
END $$

SELECT saldo_total();

-- Actividad 2. mejor_cliente
DELIMITER $$
DROP FUNCTION IF EXISTS mejor_cliente $$
CREATE FUNCTION mejor_cliente()
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE id_mejor INT;

    SELECT cliente_id
    INTO id_mejor
    FROM cuentas
    ORDER BY saldo DESC
    LIMIT 1;

    RETURN id_mejor;
END $$

SELECT mejor_cliente();

-- Actividad 3. Función saldo_cuentas

DELIMITER $$
DROP FUNCTION IF EXISTS saldo_cuentas $$
CREATE FUNCTION saldo_cuentas(p_cuenta_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);

    SELECT SUM(cantidad)
    INTO total
    FROM movimientos
    WHERE cuenta_id = p_cuenta_id;

    RETURN IFNULL(total,0);
END $$

SELECT saldo_cuentas(3);

-- Actividad 4. Procedimiento verificar_saldo

DELIMITER $$
DROP PROCEDURE IF EXISTS verificar_saldo $$
CREATE PROCEDURE verificar_saldo(IN p_cuenta_id INT)
BEGIN
    DECLARE saldo_tabla DECIMAL(10,2);
    DECLARE saldo_verificado DECIMAL(10,2);

    SELECT saldo
    INTO saldo_tabla
    FROM cuentas
    WHERE id = p_cuenta_id;

    SET saldo_verificado = saldo_cuentas(p_cuenta_id);

    IF saldo_tabla <> saldo_verificado THEN

        SELECT *
        FROM cuentas
        WHERE id = p_cuenta_id;

    END IF;

END $$

CALL verificar_saldo(3);

-- Actividad 5. Procedimiento auditar_saldo

DELIMITER $$
DROP PROCEDURE IF EXISTS auditar_saldo $$
CREATE PROCEDURE auditar_saldo(IN p_cuenta_id INT)
BEGIN
    DECLARE saldo_tabla DECIMAL(10,2);
    DECLARE saldo_verificado DECIMAL(10,2);

    SELECT saldo
    INTO saldo_tabla
    FROM cuentas
    WHERE id = p_cuenta_id;

    SET saldo_verificado = saldo_cuentas(p_cuenta_id);

    IF saldo_tabla <> saldo_verificado THEN

        UPDATE cuentas
        SET saldo = saldo_verificado
        WHERE id = p_cuenta_id;

    END IF;

END $$

CALL auditar_saldo(3);