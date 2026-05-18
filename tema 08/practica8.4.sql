USE bancos;

DELIMITER $$

CREATE PROCEDURE actualizar_saldo()
BEGIN

    -- Variables
    DECLARE v_id INT;
    DECLARE v_iban CHAR(24);
    DECLARE v_saldo_actual DECIMAL(10,2);
    DECLARE v_saldo_calculado DECIMAL(10,2);
    DECLARE v_diferencia DECIMAL(10,2);

    -- Variable control fin cursor
    DECLARE fin INT DEFAULT 0;

    -- Cursor con todas las cuentas
    DECLARE cursor_cuentas CURSOR FOR
        SELECT id, iban, saldo
        FROM cuentas;

    -- Handler fin cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET fin = 1;

    -- Abrir cursor
    OPEN cursor_cuentas;

    bucle: LOOP

        -- Leer registro
        FETCH cursor_cuentas
        INTO v_id, v_iban, v_saldo_actual;

        -- Comprobar fin
        IF fin = 1 THEN
            LEAVE bucle;
        END IF;

        -- Obtener saldo calculado
        SET v_saldo_calculado = saldo_cuentas(v_id);

        -- Comparar saldos
        IF v_saldo_actual <> v_saldo_calculado THEN

            -- Calcular diferencia
            SET v_diferencia = v_saldo_calculado - v_saldo_actual;

            -- Mostrar descuadre
            SELECT
                v_id AS id_cuenta,
                v_iban AS iban,
                v_saldo_actual AS saldo_actual,
                v_saldo_calculado AS saldo_calculado,
                v_diferencia AS diferencia;

            -- Actualizar saldo
            UPDATE cuentas
            SET saldo = v_saldo_calculado
            WHERE id = v_id;

        END IF;

    END LOOP;

    -- Cerrar cursor
    CLOSE cursor_cuentas;

END $$

CALL actualizar_saldo();
