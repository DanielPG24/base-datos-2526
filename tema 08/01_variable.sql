SET @numero_1 = 1;
SET @numero_2 = 2;
SELECT @numero_1 + @numero_2;
use maratoon;
set @ciudad = 'Ubrique';

-- corredores de villamartin
SELECT * FROM corredores WHERE ciudad = @ciudad;