USE bancos;

SET GLOBAL event_scheduler = ON;

-- Actividad 1
DELIMITER $$

CREATE EVENT movimientos_semanales
ON SCHEDULE
EVERY 1 WEEK
STARTS '2026-05-25 00:00:00'
DO
BEGIN

    SELECT *
    FROM movimientos
    INTO OUTFILE '/var/lib/mysql-files/moviweek.csv'
    FIELDS TERMINATED BY ';'
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n';

END $$

-- Actividad 2
DELIMITER $$

CREATE EVENT verificacion_saldo_diario
ON SCHEDULE
EVERY 1 DAY
STARTS TIMESTAMP(CURRENT_DATE + INTERVAL 1 DAY)
DO
BEGIN

    CALL actualizar_saldo();

END $$

-- Actividad 3
DELIMITER $$

CREATE EVENT verificacion_cliente_mensual
ON SCHEDULE
EVERY 1 MONTH
STARTS TIMESTAMP(CURRENT_DATE + INTERVAL 1 MONTH)
DO
BEGIN

    SELECT
        c.id AS id_cliente,
        c.nombre,
        c.apellidos,
        c.email,
        cu.iban,
        cu.saldo
    FROM clientes c
    INNER JOIN cuentas cu
        ON c.id = cu.cliente_id
    WHERE cu.saldo < 0

    INTO OUTFILE '/var/lib/mysql-files/clientesenrojo.csv'
    FIELDS TERMINATED BY ';'
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n';

END $$

