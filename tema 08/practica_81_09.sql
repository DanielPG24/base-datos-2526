USE bancos;


-- Ejercicio 1 - procedimiento clientes
-- Crear un procedimiento que devuelva una lista de todos los clientes de una determinada ciudad. 

DELIMITER $$
DROP PROCEDURE IF EXISTS clientes_por_ciudad $$
CREATE PROCEDURE clientes_por_ciudad(IN ciudad VARCHAR(20))
BEGIN
    SELECT * FROM clientes WHERE ciudad = p_ciudad;
END $$

CALL clientes_por_ciudad('Ubrique');

-- Crear un procedimiento que devuelva todos los movimientos de una determinada cuenta. 

DELIMITER $$
DROP PROCEDURE IF EXISTS movimientos_cuentas $$
CREATE PROCEDURE bancos.movimientos_cuentas(IN p_cuenta_id INT UNSIGNED)
BEGIN
SELECT * FROM movimientos WHERE cuenta_id = p_cuenta_id ORDER BY fechahora DESC;
END $$


CALL movimientos_cuentas(1);

-- Crear un procedimiento que devuelva las cuentas de un determinado cliente

DELIMITER $$
DROP PROCEDURE IF EXISTS clientes_cuentas $$
CREATE PROCEDURE clientes_cuentas(IN p_cliente_id INT UNSIGNED)
BEGIN
SELECT * FROM cuentas WHERE cliente_id = p_cliente_id;
END $$

CALL clientes_cuentas(1);

-- Se desea crear un procedimiento llamado SaldosBajos sobre la base de datos bancos, que
-- me devuelva un listado de aquellas cuentas que tienen un saldo inferior o igual a 200 €

DELIMITER $$
DROP PROCEDURE IF EXISTS SaldosBajos $$
CREATE PROCEDURE SaldosBajos()
BEGIN
    SELECT 
        c.id AS "ID Cuenta",
        c.iban AS "IBAN",
        cl.nombre AS "Nombre",
        cl.apellidos AS "Apellidos",
        cl.dni AS "DNI",
        c.saldo AS "Saldo Actual"
    FROM cuentas c
    INNER JOIN clientes cl 
        ON c.cliente_id = cl.id
    WHERE c.saldo <= 200;
END $$

CALL SaldosBajos(); 

-- Realizar un procedimiento pl/sql que devuelva el saldo total por cliente ordenado alfabéticamente.
-- Hay que tener en cuenta que un cliente puede tener varias cuentas, deberá acumular el saldo de todas sus cuentas.

DELIMITER $$
DROP PROCEDURE IF EXISTS saldo_total $$
CREATE PROCEDURE saldo_total()
BEGIN
    SELECT 
        cl.id AS "ID Cliente",
        cl.nombre AS "Nombre",
        cl.apellidos AS "Apellidos",
        cl.dni AS "DNI",
        cl.ciudad AS "Ciudad",
        SUM(c.saldo) AS "Saldo Total"
    FROM clientes cl
    INNER JOIN cuentas c
        ON cl.id = c.cliente_id
    GROUP BY 
        cl.id,
        cl.nombre,
        cl.apellidos,
        cl.dni,
        cl.ciudad
    ORDER BY cl.nombre ASC;
END $$

CALL saldo_total();