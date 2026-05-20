
USE bancos;

DELIMITER $$
DROP TRIGGER IF EXISTS bonificacion_apertura $$
CREATE TRIGGER bonificacion_apertura AFTER INSERT ON cuentas
FOR EACH ROW
BEGIN

    INSERT INTO movimientos(
        cuenta_id,
        fechahora,
        concepto,
        tipo,
        cantidad
    )
    VALUES(
        NEW.id,
        NOW(),
        'Bonificación de Apertura Cuenta',
        'I',
        20.00
    );

    -- Actualizar saldo de la cuenta
    UPDATE cuentas
    SET saldo = saldo + 20
    WHERE id = NEW.id;

END $$

INSERT INTO cuentas
VALUES (4,'ES1234567890123456789012',1,NOW(),0);

DELIMITER $$
DROP TRIGGER IF EXISTS validar_movimiento $$
CREATE TRIGGER validar_movimiento
BEFORE INSERT ON movimientos
FOR EACH ROW
BEGIN

    DECLARE v_saldo DECIMAL(10,2);

    -- Obtener saldo actual
    SELECT saldo
    INTO v_saldo
    FROM cuentas
    WHERE id = NEW.cuenta_id;

    -- INGRESO
    IF NEW.tipo = 'I' THEN

        UPDATE cuentas
        SET saldo = saldo + NEW.cantidad
        WHERE id = NEW.cuenta_id;

    END IF;

    -- REINTEGRO
    IF NEW.tipo = 'R' THEN

        -- Si intenta retirar más saldo del disponible
        IF ABS(NEW.cantidad) > v_saldo THEN

            SET NEW.cantidad = 0;

        ELSE

            UPDATE cuentas
            SET saldo = saldo + NEW.cantidad
            WHERE id = NEW.cuenta_id;

        END IF;

    END IF;

END $$

-- Ingreso
INSERT INTO movimientos
VALUES (NULL,1,NOW(),'Ingreso Cajero','I',100);

--Reintegro valido
INSERT INTO movimientos
VALUES (NULL,1,NOW(),'Retirada Cajero','R',-50);

-- Reintegro sin saldo suficiente
INSERT INTO movimientos
VALUES (NULL,1,NOW(),'Retirada Grande','R',-5000);