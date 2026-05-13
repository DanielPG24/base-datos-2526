USE maratoon;

-- Actividad 1. Id de Categoría
-- Crear una función Categoria() para la base de datos maratoon que devuelva el id de una categoría a partir de la edad de un corredor.
-- El intervalo de edad de cada categoría está registrado en la columna descripción de la tabla categorias
DELIMITER $$
DROP FUNCTION IF EXISTS Categoria $$
CREATE FUNCTION Categoria(p_edad INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_categoria INT;

    IF p_edad < 12 THEN
        SET v_categoria = 1;

    ELSEIF p_edad BETWEEN 12 AND 14 THEN
        SET v_categoria = 2;

    ELSEIF p_edad BETWEEN 15 AND 17 THEN
        SET v_categoria = 3;

    ELSEIF p_edad BETWEEN 18 AND 29 THEN
        SET v_categoria = 4;

    ELSEIF p_edad BETWEEN 30 AND 39 THEN
        SET v_categoria = 5;

    ELSEIF p_edad BETWEEN 40 AND 49 THEN
        SET v_categoria = 6;

    ELSEIF p_edad BETWEEN 50 AND 59 THEN
        SET v_categoria = 7;

    ELSE
        SET v_categoria = 8;
    END IF;

    RETURN v_categoria;
END $$

SELECT Categoria();

-- Actividad 2. Procedimiento ActualizarCategoria
-- Crear el procedimiento ActualizarCategoria para la base de datos maratoon que actualice la columna categoria_id de todos los corredores.
-- En dicho procedimiento hay que utilizar obligatoriamente la función categoria() del apartado anterior.
DELIMITER $$

CREATE PROCEDURE ActualizarCategoria()
BEGIN

    UPDATE Corredores
    SET categoria_id = Categoria(Edad);

END $$

CALL ActualizarCategoria();

-- Actividad 3. Procedmiento ProximoCumpleaños
-- Crear la función NumerosPrimos para la base de datos test que dado un valor numérico entero, devuelva la suma de todos los números primos que hay desde el 1 hasta ese valor.
-- Por ejemplo si introduzco el 7 los números primos desde el 1 al 7 serían 1, 2, 3, 5, 7 la suma de estos números es 18, valor que tendría que devolver la función.

DELIMITER $$

CREATE PROCEDURE ProximosCumpleaños()
BEGIN

    SELECT 
        id,
        Nombre,
        Apellidos,
        Ciudad,
        FechaNacimiento,
        Edad
    FROM Corredores
    WHERE WEEK(DATE_ADD(FechaNacimiento, 
          INTERVAL YEAR(CURDATE()) - YEAR(FechaNacimiento) YEAR))
          = WEEK(DATE_ADD(CURDATE(), INTERVAL 1 WEEK));

END $$

CALL ProximosCumpleaños();

-- Actividad 4. Función Números Primos
-- Crear la función NumerosPrimos para la base de datos test que dado un valor numérico entero, devuelva la suma de todos los números primos que hay desde el 1 hasta ese valor.
-- Por ejemplo si introduzco el 7 los números primos desde el 1 al 7 serían 1, 2, 3, 5, 7 la suma de estos números es 18, valor que tendría que devolver la función.
DELIMITER $$

CREATE FUNCTION NumerosPrimos(p_num INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE j INT;
    DECLARE primo BOOLEAN;
    DECLARE suma INT DEFAULT 0;

    WHILE i <= p_num DO

        SET primo = TRUE;
        SET j = 2;

        IF i = 1 THEN
            SET suma = suma + 1;

        ELSE
            WHILE j < i DO

                IF i MOD j = 0 THEN
                    SET primo = FALSE;
                END IF;

                SET j = j + 1;

            END WHILE;

            IF primo = TRUE THEN
                SET suma = suma + i;
            END IF;

        END IF;

        SET i = i + 1;

    END WHILE;

    RETURN suma;
END $$

SELECT NumerosPrimos();

-- Actividad 5. Factorial
-- Crear la función factorial sobre la base de datos test que dado un valor entero como parámetro devuelva el valor del factorial.
-- Por ejemplo si introduzco el 5 el factorial sería 1*2*3*4*5 = 120

DELIMITER $$

CREATE FUNCTION factorial(p_num INT)
RETURNS BIGINT
DETERMINISTIC
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE resultado BIGINT DEFAULT 1;

    WHILE i <= p_num DO

        SET resultado = resultado * i;

        SET i = i + 1;

    END WHILE;

    RETURN resultado;
END $$

SELECT factorial();