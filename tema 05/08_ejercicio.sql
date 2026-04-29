-- ejercicio_08
-- crear tablas

USE test;

CREATE TABLE IF NOT EXISTS departamentos(
	id INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    cod_departamento CHAR(3) NOT NULL,
    CONSTRAINT pk_departamentos PRIMARY KEY (id),
    CONSTRAINT uq_cod_departamento UNIQUE (cod_departamento)
);

CREATE TABLE IF NOT EXISTS profesor(
	id INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    fecha_ingreso DATE NOT NULL,
    especialidad VARCHAR(50) NOT NULL,
    nrp VARCHAR(20) NOT NULL,
    departamento_id INT NOT NULL,
    CONSTRAINT pk_profesor PRIMARY KEY (id),
    CONSTRAINT uq_profesor_email UNIQUE (email),
    CONSTRAINT uq_profesor_nrp UNIQUE (nrp),
    CONSTRAINT fk_profesor_departamento 
        FOREIGN KEY (departamento_id)
        REFERENCES departamentos(id)
);

CREATE TABLE IF NOT EXISTS asignatura(
	id INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    nivel CHAR(4) NOT NULL,
    cod_asignatura CHAR(7) NOT NULL,
    horas INT NOT NULL,
    departamento_id INT NOT NULL,
    CONSTRAINT pk_asignatura PRIMARY KEY (id),
    CONSTRAINT uq_cod_asignatura UNIQUE (cod_asignatura),
    CONSTRAINT fk_asignatura_departamento
        FOREIGN KEY (departamento_id)
        REFERENCES departamentos(id)
);

CREATE TABLE IF NOT EXISTS horario(
	 id INT NOT NULL,
    profesor_id INT NOT NULL,
    dia INT NOT NULL,
    tramo INT NOT NULL,
    turno INT NOT NULL,
    asignatura_id INT NOT NULL,
    horas INT NOT NULL,
    CONSTRAINT pk_horario PRIMARY KEY (id),
    CONSTRAINT fk_horario_profesor
        FOREIGN KEY (profesor_id)
        REFERENCES profesor(id),
    CONSTRAINT fk_horario_asignatura
        FOREIGN KEY (asignatura_id)
        REFERENCES asignatura(id)
);