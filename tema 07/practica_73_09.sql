-- 7.3 Revocar privilegios

SELECT * FROM mysql.user;

-- 1. Revocar a juan todos los privilegios a nivel global
REVOKE ALL PRIVILEGES ON *.* FROM juan;

-- 2. Revocar a pedro el privilegio SELECT a nivel global
REVOKE SELECT ON *.* FROM pedro;

-- 3. Revocar a maria privilegios (ALTER, CREATE, UPDATE) sobre geslibros y maratoon
REVOKE ALTER, CREATE, UPDATE ON geslibros.* FROM maria;
REVOKE ALTER, CREATE, UPDATE ON maratoon.* FROM maria;

-- 4. Revocar a roberto el privilegio GRANT OPTION
REVOKE GRANT OPTION ON *.* FROM roberto;

-- 5. Revocar a rocio el privilegio INSERT sobre geslibros
REVOKE INSERT ON geslibros.* FROM rocio;

-- 6. Revocar a carlos privilegios sobre tablas editoriales y clientes + UPDATE
REVOKE ALL PRIVILEGES ON geslibros.editoriales FROM carlos;
REVOKE ALL PRIVILEGES ON geslibros.clientes FROM carlos;
REVOKE UPDATE ON geslibros.* FROM carlos;

-- 7. Revocar a anamari acceso a columnas de libros (SELECT)
REVOKE SELECT (titulo, ean, isbn, precio_venta) ON geslibros.libros FROM anamari;

-- 8. Revocar a anamari acceso a columnas de clientes (SELECT)
REVOKE SELECT (nombre, telefono, email) ON geslibros.clientes FROM anamari;

