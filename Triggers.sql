/*
-Bloque de codigo que se ejecuta automaticamente cada vez que ocurre algun evento dentro de la base de datos, siempre y cuando se desee llevar un registro de modificacion
-Conservar la integridad referencial y la coherencia entre los datos entre distintas tablas
-Registrar los cambios que se efectuan sobre las tablas y la identidad de quien los realizo
-Realizar cualquier accion cuando una tabla es modificada
-Insertar, actualizar o eliminar datos de una tabla asociada en forma automatica

*No son invocados directamente
*Al intentar modificar los datos de una tabla asociada, el trigger se ejecuta automaticamente
*No reciben ni retornan parametros
*No generan resultados de consultas de sql

Clasificacion
*Momento: en que se disparan before o after
*Evento: insert, update o delete, segun se ejecute una de estas sentencias sobre la tabla
*Nivel: Dependiendo si se ejecuta para cada fila afectada en la sentencia (por cada fila) o una unica vez por sentencia independientemente de las filas afectadas (nivel de sentencia)

create or replace trigger nombretrigger
tiempo accion(CRUD)
on libros
begin
    instrucciones
    end nombretrigger;
    
    
*/
drop table Libros;

CREATE TABLE libros(
                codigo number(6),
                titulo varchar2(40),
                autor varchar2(30),
                editorial varchar(20),
                precio number(6)
                );
                
CREATE TABLE control(
                usuario varchar(30),
                fecha date
                );
                
create or replace trigger tr_ingresolibros
before insert
on libros
begin
    insert into control values(user, sysdate);
    end tr_ingresolibros;
    
insert into libros values(100,'Uno','Richard Bach','Planeta',25);
insert into libros values(200,'Dos','Richard Cabh','Mundo',285);
select * from control;
/*
Para ver la hora
-> Herramientas
--> Preferencias
---> Base de datos
----> NLS
Casilla formato de fecha
-> Agregar HH24/12:MI:SS
*/

SELECT * FROM USER_TRIGGERS WHERE TRIGGER_NAME='TR_INGRESOLIBROS';

--TRIGGERS FOR EACH ROW
create table empleados2(
    documento char(8),
    apellido varchar2(30),
    nombre varchar2(30),
    seccion varchar(20),
    sueldo number(8,2)
    );
    
truncate table control;
truncate table empleados2;

create or replace trigger tr_ingresaempleados
before insert
on empleados2
for each row
    begin
        insert into control values(user, sysdate);
    end ingresaempleados;

 insert into empleados2 values('22333444','ACOSTA','Ana','Secretaria',500);
 insert into empleados2 values('22777888','DOMINGUEZ','Daniel','Secretaria',600);
 insert into empleados2 values('22999000','FUENTES','Federico','Sistemas',680);
 insert into empleados2 values('22555666','CASEROS','Carlos','Contaduria',900);
 insert into empleados2 values('23444555','GOMEZ','Gabriela','Sistemas',1200);
 insert into empleados2 values('23666777','JUAREZ','Juan','Contaduria',1000);
 select * from empleados2;
 
 select * from control;


--TRIGGERS BEFORE DELETE
create table alumnos(
    legajo varchar2(4) not null,
    documento varchar2(8) not null,
    nombre varchar2(30) not null,
    curso number(1) not null,
    materia varchar2(15) not null,
    nota_final number(3,2) not null);

insert into alumnos values('A234','23333333','LOPEZ ANA',5,'MATEMATICA',9);
insert into alumnos values('A345','24444444','GARCIA CARLOS',6,'MATEMATICA',8.5);
insert into alumnos values('A457','26666666','PEREZ FABIAN',6,'LENGUA',3.2);
insert into alumnos values('A348','25555555','PEREZ PATRICIA',6,'LENGUA',7.85);
insert into alumnos values('A123','22222222','PEREZ PATRICIA',5,'MATEMATICAS',9);
insert into alumnos values('A124','32222222','GONZALES JOSE',5,'BIOLOGIA',9);
insert into alumnos values('A124','32222222','GONZALES JOSE',5,'MATEMATICAS',8);

select * from alumnos;
select * from control;

create or replace trigger borradoalumnos
before delete
for each row                        
on alumnos
    begin  
    insert into control values(user, sysdate);
end borradoalumnos;    

select * from alumnos;

delete from alumnos where curso = 5;        --Registro por cada fila sino tuviera each row hace un solo registro en la tabla control
select * from alumnos;
select * from control;

truncate table alumnos;
truncate table control;
drop trigger boradoalumnos;
drop table empleados2;

--TRIGGERS BEFORE UPDATE

select * from empleados2;

create or replace trigger tr_actualiza
before update
on empleados2
for each row
    begin
    insert into control values(user, sysdate);
    end tr_actualiza;
    
select * from control;

update empleados2 set sueldo = sueldo+sueldo*0.1
    where seccion = 'Secretaria';


--TRIGGER MULTIPLES EVENTOS
create table control_empleados(
                            usuario varchar(20),
                            fecha date,
                            accion varchar(20)
                            );
                            
create or replace trigger tr_multiple
before insert or update or delete
on empleados2
    begin
        if inserting then
            insert into control_empleados values (user, sysdate, 'Ingreso');
        end if;
        if deleting then
            insert into control_empleados values (user, sysdate, 'Borro');
        end if;
        if updating then
            insert into control_empleados values (user, sysdate, 'Actualizo');
            end if;
end tr_multiple;

select * from empleados2;

insert into empleados2 values (22334455, 'Gonzales', 'José', 'Gerencia', 3000);
update empleados2 set sueldo = 2000 where documento = 23444555;
delete from empleados2 where documento = 23444555;
select * from empleados2;
alter table empleados2 drop column genero;
select * from empleados2;
select * from control_empleados;


--TRIGGERS :NEW :OLD
drop table libros;
drop table ofertas;

 create table libros(
  codigo number(6),
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar(20),
  precio number(6,2)
 );
 
 create table ofertas(
  codigo number(6),
  precio number(6,2),
  usuario varchar2(20),
  fecha date
 );
 
 insert into libros values(100,'Uno','Richard Bach','Planeta',25);
 insert into libros values(103,'El aleph','Borges','Emece',28);
 insert into libros values(105,'Matematica estas ahi','Paenza','Nuevo siglo',12);
 insert into libros values(120,'Aprenda PHP','Molina Mario','Nuevo siglo',55);
 insert into libros values(145,'Alicia en el pais de las maravillas','Carroll','Planeta',35);
 
 select * from libros;
 select * from ofertas;
 
 create or replace trigger tr_ingresalibros2
 before insert
 on libros
 for each row
    begin
    if(:new.precio<=30) then
        insert into ofertas values(:new.codigo, :new.precio, user, sysdate);
    end if;
end tr_ingresalibros;

select * from ofertas;
insert into libros values(155, 'El gato con botas', 'Gaskin', 'Planeta', 28);
select * from ofertas;
insert into libros values(155, 'Padre rico padre pobre', 'Kiyosaki', 'Techpress', 35);
select * from ofertas;
select * from libros;

create or replace trigger tr_actualizalibros
 before update of precio
 on libros
 for each row
    begin
    if(:old.precio<=30) and (:new.precio>30) then
        delete from ofertas where codigo=:old.codigo;
    end if;
    if(:old.precio > 30) and (:new.precio <= 30) then
        insert into ofertas values(:new.codigo, :new.precio, user, sysdate);
        end if;
end tr_actualizalibros;        

select * from libros;
update libros set precio = 25 where codigo = 120;
update libros set precio = 60 where codigo = 120;
select * from ofertas;

--TRIGGERS WHEN / IF
drop table empleados;

 create table empleados(
  documento char(8),
  apellido varchar2(20),
  nombre varchar2(20),
  seccion varchar2(30),
  sueldo number(8,2)
 );
   drop table control;
 create table control(
  usuario varchar2(30),
  fecha date,
  documento char(8),
  antiguosueldo number(8,2),
  nuevosueldo number(8,2)
 ); 
 insert into empleados values('22333444','ACOSTA','Ana','Secretaria',500);
 insert into empleados values('22555666','CASEROS','Carlos','Contaduria',900);
 insert into empleados values('22777888','DOMINGUEZ','Daniel','Secretaria',560);
 insert into empleados values('22999000','FUENTES','Federico','Sistemas',680);
 insert into empleados values('23444555','GOMEZ','Gabriela','Sistemas',1200);
 insert into empleados values('23666777','JUAREZ','Juan','Contaduria',1000);
 
 select * from empleados;
 select * from control;
 
 create or replace trigger tr_aumentasueldo
 before update of sueldo
 on empleados
 for each row when (new.sueldo > old.sueldo)
    begin
        insert into control values (user, sysdate, :old.documento, :old.sueldo, :new.sueldo);
end tr_aumentasueldo;

select * from empleados;

update empleados set sueldo = 600 where documento = 22333444;

select * from control;
select * from empleados;


create or replace trigger tr_actualizadatos
before insert 
on empleados
for each row
    begin
    :new.apellido := upper(:new.apellido);
    if (:new.sueldo is null) then
        :new.sueldo := 0;
    end if;
end tr_actualizadatos;


select * from empleados;
insert into empleados values(2566777,'Lopez','Luisa','Secretaria',null);
select * from empleados;


--TRIGGERS UNABLE / DISSABLE
--Con el trigger de aumentasueldo
 select * from empleados;
 select trigger_name, triggering_event, table_name, status
    from user_triggers
        where table_name = 'EMPLEADOS';                         --Para checar el estatus del trigger
        
 alter trigger tr_aumentasueldo disable;
 alter trigger tr_aumentasueldo enable;
 select * from empleados;
 
 update empleados set sueldo = 1200 where documento = 22333444;
 select * from control;
 
 --TRIGGERS RAISE_APPLICATION_ERROR
 ---ora-2000
 
 drop table empleados;
 drop table control;

 create table empleados(
  documento char(8),
  apellido varchar2(30),
  nombre varchar2(30),
  domicilio varchar2(30),
  seccion varchar2(20),
  sueldo number(8,2)
 );

 create table control(
  usuario varchar2(30),
  fecha date,
  operacion varchar2(30)
 );

 insert into empleados values('22222222','Acosta','Ana','Avellaneda 11','Secretaria',1800);
 insert into empleados values('23333333','Bustos','Betina','Bulnes 22','Gerencia',5000);
 insert into empleados values('24444444','Caseres','Carlos','Colon 333','Contaduria',3000);

select * from empleados;


 create or replace trigger tr_control_empleados
 before insert or update or delete
 on empleados
 for each row
 BEGIN
    if (:new.sueldo > 5000) then
        raise_application_error(-20000, 'Sueldo no puede superar los $5000.00');
    end if;
        insert into control values (user, sysdate, 'Inserción');
    if (:old.seccion = 'Gerencia') then
        raise_application_error(-20000, 'No se puede eliminar un puesto de gerencia');
    end if;
        insert into control values(user, sysdate, 'Borrado');
    if updating('documento') then
        raise_application_error(-20000, 'No se puede actualizar numero de documentos');
    end if;
 END tr_control_empleados;
 
 select * from empleados;
 
 insert into empleados values(56985555,'Suarez','Manuel','Calle 3ra No. 54','informatica',9000);
 delete from empleados where seccion = 'gerencia'; 
 update empleados set documento = '11111111'
    where documento = '2222222';
 
 
 select * from control;