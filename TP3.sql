------------------------------------------------------------------------------------
------------------------------Trabajo Práctico Nº3----------------------------------
------------------------------------------------------------------------------------
----Trabajo Práctico Grupal---------------------------------------------------------
------------------------------------------------------------------------------------
----Integrantes:
---<*>Cendra Sebastián Andres
---<*>Gomez Leo Gabriel
---<*>López Otero Rafael Ariel
------------------------------------------------------------------------------------
-------------------------------CREACION DE TABLAS-----------------------------------
------------------------------------------------------------------------------------

CREATE TABLE TALLER (
	id_taller integer CONSTRAINT pk_id_taller PRIMARY KEY,
	nombre varchar(20),
    calle varchar(15),
    calle_nro integer,
    dni_resp integer CONSTRAINT taller_dni_resp NOT NULL,
    UNIQUE(dni_resp)
);


CREATE TABLE CELULA (
	id_celula integer,
	descripcion varchar(10),
    id_taller integer,
	CONSTRAINT pk_id_celula PRIMARY KEY (id_celula),
    CONSTRAINT fk_id_taller FOREIGN KEY (id_taller) REFERENCES TALLER (id_taller)
);


CREATE TABLE MAQUINA (
	id_maquina integer,
	nombre varchar(10),
    tipo varchar(2),
    id_celula integer,
	CONSTRAINT pk_id_maquina PRIMARY KEY (id_maquina),
	CONSTRAINT fk_id_maquina FOREIGN KEY (id_celula) REFERENCES CELULA (id_celula)
);


CREATE TABLE OPERARIO (
	dni integer CONSTRAINT pk_dni PRIMARY KEY,
	nombre varchar(20),
	apellido varchar(20),
    responsable_taller integer CONSTRAINT op_resp_taller NOT NULL    
                                CHECK (responsable_taller in (0,1)), --5.4.1
    salario integer,
	id_taller integer,
    CONSTRAINT fk_id_taller FOREIGN KEY (id_taller) REFERENCES TALLER (id_taller)
    );
ALTER TABLE taller ADD CONSTRAINT fk_dni_taller FOREIGN KEY (dni_resp) REFERENCES operario (dni);

CREATE TABLE OP_ASIGNADO_CEL (
	dni integer,
	id_celula integer,
	fecha_desde date,
	fecha_hasta date,
	CONSTRAINT pk_fecha_desde PRIMARY KEY (fecha_desde),
    CONSTRAINT fk_dni_op FOREIGN KEY (dni) REFERENCES OPERARIO (dni),
    CONSTRAINT fk_id_celula FOREIGN KEY (id_celula) REFERENCES CELULA (id_celula)
);


CREATE TABLE TEL_TALLER (
    id_taller integer,
	nro_tel integer,
	CONSTRAINT pk_nro_tel_taller PRIMARY KEY (nro_tel),
    CONSTRAINT fk_idtaller FOREIGN KEY (id_taller) REFERENCES TALLER (id_taller)
);

------------------------------------------------------------------------------------
------------------------------INSERCIÓN DE DATOS EN TABLAS--------------------------
------------------------------------------------------------------------------------
--+-------------+-----------+-------+------------+
--| id_maquina  |  nombre   | tipo  | id_celula  |
--+-------------+-----------+-------+------------+
--|      1      | maquinaM1 |   T1  |      5     |
--+-------------+-----------+-------+------------+
--|      2      | maquinaM2 |   T1  |      3     |
--+-------------+-----------+-------+------------+
--|      3      | maquinaM3 |   T2  |      4     |
--+-------------+-----------+-------+------------+
INSERT INTO MAQUINA (id_maquina,nombre,tipo) VALUES
(1,'MaquinaM1','T1'),
(2,'MaquinaM2','T1'),
(3,'MaquinaM3','T2');

--+-----------+-------------+-----------+
--| id_celula | descripcion | id_taller |
--+-----------+-------------+-----------+
--|     3     |   celulaC1  |     1     |
--+-----------+-------------+-----------+
--|     4     |   celulaC2  |     3     |
--+-----------+-------------+-----------+
--|     5     |   celulaC3  |     2     |
--+-----------+-------------+-----------+
--|     6     |   celulaC4  |     3     |
--+-----------+-------------+-----------+

INSERT INTO CELULA (id_celula,descripcion)VALUES
(3,'CelulaC1'),
(4,'CelulaC2'),
(5,'CelulaC3'),
(6,'CelulaC4');

--+-------+-----------+----------+--------------------+---------+-----------+
--|  dni  |   nombre  | apellido | responsable_taller | salario | id_taller |
--+-------+-----------+----------+--------------------+---------+-----------+
--| 35000 |    Juan   |  Cortez  |          0         |  350000 |     3     |
--+-------+-----------+----------+--------------------+---------+-----------+
--| 36000 |  Marcelo  |   Lopez  |          0         |  278500 |     1     |
--+-------+-----------+----------+--------------------+---------+-----------+
--| 40000 |    Alex   |  Valdez  |          0         |  340000 |     2     |
--+-------+-----------+----------+--------------------+---------+-----------+
--| 10000 |   Pedro   |   Rios   |          1         |  458000 |     1     |
--+-------+-----------+----------+--------------------+---------+-----------+
--| 20000 |   Marcos  |  Medina  |          1         |  500000 |     2     |
--+-------+-----------+----------+--------------------+---------+-----------+
--| 30000 | Francisco |  Ramirez |          1         |  512500 |     3     |
--+-------+-----------+----------+--------------------+---------+-----------+
INSERT INTO OPERARIO (dni, nombre, apellido, responsable_taller, salario) VALUES
(35000,'Juan',    'Cortez',   0,350000),
(36000,'Marcelo', 'Lopez',    0,278500),
(40000,'Alex',    'Valdez',   0,350000),
(10000,'Pedro',   'Rios',     1,350000),
(20000,'Marcos',  'Medina',   1,350000),
(30000,'Francisco', 'Ramirez',1,512500);

--+-------+-----------+-------------+-------------+
--|  dni  | id_celula | fecha_desde | fecha_hasta |
--+-------+-----------+-------------+-------------+
--| 35000 |     4     |  01/01/2022 |  31/12/2022 |
--+-------+-----------+-------------+-------------+
--| 35000 |     6     |  01/01/2023 |             |
--+-------+-----------+-------------+-------------+
--| 36000 |     3     |  10/08/2023 |             |
--+-------+-----------+-------------+-------------+
--| 40000 |     5     |  15/12/2022 |             |
--+-------+-----------+-------------+-------------+
INSERT INTO OP_ASIGNADO_CEL VALUES 
(35000,4,'01/01/2022','12/31/2022'),
(35000,6,'01/01/2023',NULL),
(36000,3,'08/10/2023',NULL),
(40000,5,'12/15/2022',NULL);

----+-----------+----------+---------------+-----------+----------+
----| id_taller |  nombre  |     calle     | calle_nro | dni_resp |
----+-----------+----------+---------------+-----------+----------+
----|     1     | tallerT1 |    Av. Sol    |    2358   |   10000  |
----+-----------+----------+---------------+-----------+----------+
----|     2     | tallerT2 | Las Magnolias |    2580   |   20000  |
----+-----------+----------+---------------+-----------+----------+
----|     3     | tallerT3 |  Las Sombras  |    4289   |   30000  |
----+-----------+----------+---------------+-----------+----------+
ALTER TABLE taller ALTER COLUMN dni_resp DROP NOT NULL; --5.6.4
INSERT INTO TALLER (id_taller,nombre,calle,calle_nro) VALUES
(1,'TallerT1','Av. Sol',2358),
(2,'TallerT2','Las Magnolias',2580),
(3,'TallerT3','Las Sombras',4289);

--+-----------+-----------+
--| id_taller |  nro_tel  |
--+-----------+-----------+
--|     1     | 156222333 |
--+-----------+-----------+
--|     1     |  4258693  |
--+-----------+-----------+
--|     2     | 158889995 |
--+-----------+-----------+
--|     3     | 154845484 |
--+-----------+-----------+
INSERT INTO TEL_TALLER (nro_tel)VALUES 
(156222333),
(4258693),
(158889995),
(154845484);

--Una vez cargados todos los campos exceptuando las restricciones
--foraneas, procedemos a cargar todos los campos definidos como fk

UPDATE tel_taller set id_taller = 1 WHERE nro_tel = 156222333;
UPDATE tel_taller set id_taller = 1 WHERE nro_tel = 4258693;
UPDATE tel_taller set id_taller = 2 WHERE nro_tel = 158889995;
UPDATE tel_taller set id_taller = 3 WHERE nro_tel = 154845484;

UPDATE maquina set id_celula = 5 WHERE id_maquina = 1;
UPDATE maquina set id_celula = 3 WHERE id_maquina = 2;
UPDATE maquina set id_celula = 4 WHERE id_maquina = 3;

UPDATE celula set id_taller = 1 WHERE id_celula = 3;
UPDATE celula set id_taller = 3 WHERE id_celula = 4;
UPDATE celula set id_taller = 2 WHERE id_celula = 5;
UPDATE celula set id_taller = 3 WHERE id_celula = 6;

UPDATE operario set id_taller = 3 WHERE dni = 35000;
UPDATE operario set id_taller = 1 WHERE dni = 36000;
UPDATE operario set id_taller = 2 WHERE dni = 40000;
UPDATE operario set id_taller = 1 WHERE dni = 10000;
UPDATE operario set id_taller = 2 WHERE dni = 20000;
UPDATE operario set id_taller = 3 WHERE dni = 30000;

UPDATE taller set dni_resp = 10000 WHERE id_taller = 1;
UPDATE taller set dni_resp = 20000 WHERE id_taller = 2;
UPDATE taller set dni_resp = 30000 WHERE id_taller = 3;

ALTER TABLE taller ALTER COLUMN dni_resp SET NOT NULL; --5.6.3

------------------------------------------------------------------------------------
-----------------------------------EJERCICIO 1--------------------------------------
------------------------------------------------------------------------------------
--Añadir una columna a la tabla TALLER para registrar la CIUDAD 
--en la que se encuentra cada uno (columna tipo VARCHAR(10)). 
--Actualizar con datos la nueva columna de la tabla TALLER, según
--estas dos alternativas: 
---------------------------------------1A-------------------------------------------
--a. Todos los talleres se ubican en la ciudad de Santa Fe.
ALTER TABLE TALLER ADD COLUMN ciudad VARCHAR(10);       --5.6.1
UPDATE TALLER SET ciudad = 'Santa Fe';                  --6.2
---------------------------------------1B-------------------------------------------
--b. Los talleres identificados como 1 y 3 se ubican en la ciudad 
--de Paraná y el 2 en la ciudad de Santa Fe. 
UPDATE TALLER SET ciudad = 'Parana';                    --6.2
UPDATE TALLER SET ciudad = 'Santa Fe' WHERE id_taller = 2;

------------------------------------------------------------------------------------
-----------------------------------EJERCICIO 2--------------------------------------
------------------------------------------------------------------------------------
--Modificar el nombre de la columna TIPO en la tabla MAQUINA, 
--por el nombre TIPO_MAQ. 

ALTER TABLE MAQUINA RENAME COLUMN tipo TO tipo_maq;     --5.6.7

------------------------------------------------------------------------------------
-----------------------------------EJERCICIO 3--------------------------------------
------------------------------------------------------------------------------------
--Añadir una columna CAPACIDAD, de tipo entero, a la tabla MAQUINA.

ALTER TABLE MAQUINA ADD COLUMN CAPACIDAD integer;

--a. Si luego de añadir la columna, ejecutan la sentencia 
--SELECT * FROM maquina; ¿qué valores observan en la columna 
--capacidad? Justificar.

SELECT * FROM "maquina";

--La columna agregada en la tabla maquina no tiene valores iniciales 
--sobre la columna creada, es por eso que los datos quedan definidos 
--con valores "null".


--b. Hubiera sido posible añadir esta columna con la restricción 
--NOT NULL? Justificar. 

--No es posible agregar en esta columna la restricción NOT NULL ya que la
--tabla tiene valores cargados. Solo es posible esta restricción en tablas
--vacias.

------------------------------------------------------------------------------------
-----------------------------------EJERCICIO 4--------------------------------------
------------------------------------------------------------------------------------
--Insertar los siguientes valores para la columna CAPACIDAD de la 
--tabla MAQUINA. 
--+------------+-----------+------+------------+-----------+
--| id_maquina |   nombre  | tipo | id_celula) | capacidad |
--+------------+-----------+------+------------+-----------+
--|      1     | maquinaMl |  Tl  |      5     |    500    |
--+------------+-----------+------+------------+-----------+
--|      2     | maquinaM2 |  Tl  |      3     |    300    |
--+------------+-----------+------+------------+-----------+
--|      3     | maquinaM3 |  T2  |      4     |    100    |
--+------------+-----------+------+------------+-----------+

UPDATE MAQUINA 
SET CAPACIDAD = 500
WHERE id_maquina = 1;
UPDATE MAQUINA 
SET CAPACIDAD = 300
WHERE id_maquina = 2;
UPDATE MAQUINA 
SET CAPACIDAD = 100
WHERE id_maquina = 3;

SELECT * FROM "maquina";

------------------------------------------------------------------------------------
-----------------------------------EJERCICIO 5--------------------------------------
------------------------------------------------------------------------------------
--+--------------------+
--|      OPERARIO      |
--+--------------------+
--| DNI (PK)           |
--+--------------------+
--| Nombre             |
--+--------------------+
--| Apellido           | 
--+--------------------+                                    +--------------+
--| Responsable_Taller |                                    | DEPARTAMENTO |
--+--------------------+                                    +--------------+
--| Salario            |                                    | id_dpto (PK) |
--+--------------------+                                    +--------------+
--| Id_taller (FK)     |                                    | Nombre       |
--+--------------------+(0,N)  ________/\__________ (1,1)   +--------------+
--| id_dpto (FK)       |-------<puede tener asignado>-------| Ciudad       |
--+--------------------+       ¯¯¯¯¯¯¯¯\/¯¯¯¯¯¯¯¯¯¯         +--------------+

CREATE TABLE DEPARTAMENTO (
	id_dpto integer PRIMARY KEY,
	nombre varchar(10),
    ciudad varchar(10)
);

ALTER TABLE operario ADD COLUMN id_dpto integer;
ALTER TABLE operario ADD CONSTRAINT fk_id_dpto FOREIGN KEY (id_dpto) REFERENCES departamento (id_dpto);

------------------------------------------------------------------------------------
-----------------------------------EJERCICIO 6--------------------------------------
------------------------------------------------------------------------------------
Insertar los siguientes departamentos en la tabla correspondiente:
--+---------+--------+----------+
--| id_dpto | nombre |  ciudad  |
--+---------+--------+----------+
--|   100   |  dptol | Santa Fe |
--+---------+--------+----------+
--|   203   |  dpto2 |   Paran  |
--+---------+--------+----------+
--|   105   |  dpto3 |  Rosario |
--+---------+--------+----------+
--|   200   |  dpto4 | Santa Fe |
--+---------+--------+----------+

INSERT INTO departamento VALUES
(100, 'dpto1', 'Santa Fe'),
(203, 'dpto2', 'Paraná'),
(105, 'dpto3', 'Rosario'),
(200, 'dpto4', 'Santa Fe');


------------------------------------------------------------------------------------
-----------------------------------EJERCICIO 7--------------------------------------
------------------------------------------------------------------------------------
--Actualizar la tabla OPERARIO asignando a cada uno el departamento donde trabaja:
--+-------+---------+
--|  Dni  | id_dpto |
--+-------+---------+
--| 10000 |   100   |
--+-------+---------+
--| 20000 |   100   |
--+-------+---------+
--| 30000 |   203   |
--+-------+---------+
--| 35000 |   105   |
--+-------+---------+
--| 36000 |   203   |
--+-------+---------+
--| 40000 |   105   |
--+-------+---------+

UPDATE operario set id_dpto = 100 WHERE dni = 10000;
UPDATE operario set id_dpto = 100 WHERE dni = 20000;
UPDATE operario set id_dpto = 203 WHERE dni = 30000;
UPDATE operario set id_dpto = 105 WHERE dni = 35000;
UPDATE operario set id_dpto = 203 WHERE dni = 36000;
UPDATE operario set id_dpto = 105 WHERE dni = 40000;

------------------------------------------------------------------------------------
-----------------------------------EJERCICIO 8--------------------------------------
------------------------------------------------------------------------------------
--Borrar de la tabla MAQUINA la máquina identificada con el id_maquina 2.
DELETE FROM maquina WHERE id_maquina = 2;


------------------------------------------------------------------------------------
-----------------------------------EJERCICIO 9--------------------------------------
------------------------------------------------------------------------------------
--Cambiar el tipo de dato de la columna CAPACIDAD de la tabla MAQUINA:
--a. Al tipo VARCHAR(2). Indicar y describir si surgió algún inconveniente.

ALTER TABLE maquina ALTER COLUMN capacidad TYPE varchar(2);--5.6.6

--No se puede realizar la modificación ya que los datos almacenados en ese
--campo son mayores a 2 caracteres. El error que arroja el motor es el siguiente:
--"ERROR: value too long for type character varying(2)".

--b. Al tipo VARCHAR(5)
ALTER TABLE maquina ALTER COLUMN capacidad TYPE varchar(5);--5.6.6

--En este caso el motor si nos deja realizar la modificación ya que la cadena
--mas grande en este campo es de 3 caracteres.


------------------------------------------------------------------------------------
-----------------------------------EJERCICIO 10-------------------------------------
------------------------------------------------------------------------------------
--Actualizar la tabla OPERARIO, dado que el operario Ríos deja de ser responsable 
--del taller identificado con id_taller = 1. Frente a esta situación, el taller 1 
--podría quedar sin responsable? Justificar.

UPDATE operario set responsable_taller = 0 WHERE dni = 10000;

--El taller 1 puede quedar sin responsable, ya que las restricciones generadas en la
--base de datos lo permiten. No hay claves a las cuales apunte.

------------------------------------------------------------------------------------
-----------------------------------EJERCICIO 11-------------------------------------
------------------------------------------------------------------------------------
--Actualizar la tabla TALLER, asignando al operario identificado con dni = 30000 como
--responsable del taller con id_taller = 1. Qué respuesta ha recibido ante 
--esta actualización? Justificar.

UPDATE taller set dni_resp = 30000 WHERE id_taller = 1;

--NO se puede realizar la modificación planteada en este ejercicio, ya que hay una
--restricción de valor unico en el campo dni_resp, definido en la creación de la tabla 
--No puede en esa columna existir dos valores duplicados, en este caso dos dni repetidos
--Habria que cambiar el responsable en el taller T3 y ahi si se podría realizar la accion
--solicitada.

------------------------------------------------------------------------------------
-----------------------------------EJERCICIO 12-------------------------------------
------------------------------------------------------------------------------------
--Asignar al operario Juan Cortez como responsable del taller identificado con id_taller = 1

UPDATE operario set responsable_taller = 1 WHERE dni = 35000;
UPDATE operario set id_taller = 1 WHERE dni = 35000;
UPDATE taller set dni_resp = 35000 WHERE id_taller = 1;

------------------------------------------------------------------------------------
-----------------------------------EJERCICIO 13-------------------------------------
------------------------------------------------------------------------------------
--Considerar que en la tabla CELULA, la clave foránea que referencia al id_taller ha sido creada
--sin la opción “cascade”.
--a. Borrar de la tabla TALLER el taller identificado como 3, observar y justificar los resultados.

DELETE FROM taller WHERE id_taller = 3;

--No se puede borrar de la tabla taller el taller 3, ya que viola la restricción de la clave foranea
--que apunta a la tabla celula. 

--b. A continuación, modificar la definición de la tabla CELULA, incorporando la restricción
--“cascade” para la clave foránea que referencia a id_taller.

ALTER TABLE celula DROP CONSTRAINT fk_id_taller;
ALTER TABLE celula ADD CONSTRAINT fk_id_taller_cascade
 FOREIGN KEY (id_taller)
 REFERENCES taller(id_taller)
 ON UPDATE CASCADE
ON DELETE CASCADE;

--c. Borrar el taller identificado como 3, observar y justificar los resultados.

DELETE FROM taller WHERE id_taller = 3; 

--No se puede eliminar en cascada porque sigue violando restricciones de identidad
--referencial entre OPERARIO y sus relaciones.

------------------------------------------------------------------------------------
-----------------------------------EJERCICIO 14-------------------------------------
------------------------------------------------------------------------------------
--Cambiar el nombre de la tabla MAQUINA por el nuevo nombre MAQ_CELULA.

ALTER TABLE maquina RENAME TO maq_celula;

------------------------------------------------------------------------------------
-----------------------------------EJERCICIO 15-------------------------------------
------------------------------------------------------------------------------------
--Actualizar el SALARIO de los operarios en un 5%

UPDATE operario SET salario = salario * 1.05;
