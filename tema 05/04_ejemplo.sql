-- ejemplo_04
-- resricción DEFAULT

USE test;

DROP TABLE IF EXISTS pedidos;
CREATE TABLE IF NOT EXISTS pedidos(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    fecha_pedido DATE DEFAULT CURRENT_TIMESTAMP,
    importe DECIMAL(10,2) DEFAULT 0.00,
    forma_pago VARCHAR(20) DEFAULT 'Contado'
);


INSERT INTO pedidos VALUES
(null, '2025-12-12', 234.56, 'Transferencia'),
(null, default, default, default);

-- Auditar las tablas
-- Almacenar la fecha hora de creación un registro
-- Almacenar la fecha hora de actualización de un registro

DROP TABLE IF EXISTS cuentas;
CREATE TABLE IF  NOT EXISTS cuentas(
	id INT AUTO_INCREMENT PRIMARY KEY,
    IBAN CHAR(22) UNIQUE,
    titular VARCHAR(50),
    saldo DECIMAL(10,2) DEFAULT(0.00),
    create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO cuentas VALUES
(null, '12345678932145697777', 'Pedro Reina Moscoso', default, default, default);

UPDATE cuentas SET
	saldo = '12000',
    update_at = now()
    
    