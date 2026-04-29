-- Listado usuarios base de datos
SELECT * FROM mysql.user;

CREATE USER daniel@localhost;

CREATE USER daniel2@localhost IDENTIFIED BY '12345';

CREATE USER pedro@localhost IDENTIFIED BY PASSWORD '*6A7A490FB9DC8C33C2B025A91737077A7E9CC5E5';

DROP USER daniel2@localhost;