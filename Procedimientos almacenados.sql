/*
-A nivel de esquema
-Dentro de un paquete
-Dentro de un bloque PL/SQL

create or replace prodecure nombre
as
begin
    set de instrucciones
end nombre

*/
set serveroutput on;
create or replace procedure saludo
as
begin
    dbms_output.put_line('Hola a todos');
end saludo;

    BEGIN
        saludo;
    END;
    
    
    EXECUTE saludo;
    
CREATE TABLE Libros (ID_libro integer, 
                    Titulo varchar2(25), 
                    Autor varchar2(25), 
                    Precio decimal(5,2));

INSERT INTO Libros
VALUES
(1,'El quijote','Miguel de Cervantes', 454.5);
INSERT INTO Libros
VALUES
(2,'Cien años de soledad','Gabriel G. Marquez',545.4);
INSERT INTO Libros
VALUES
(3,'El alquimista','Paulo Coehlo',636.3);
select * from Libros


/*PROCEDIMIENTO*/
CREATE OR REPLACE PROCEDURE aumenta_precio
AS 
    BEGIN
        update Libros set Precio = Precio + (Precio*.01);
END aumenta_precio;


SELECT Titulo, Precio from Libros;

EXECUTE aumenta_precio;

SELECT Titulo, Precio from Libros;

SELECT * FROM user_objects where object_type='PROCEDURE';   --Buscar los procedimientos almacenados

SELECT * FROM user_procedures where object_name like 'SALUDO';  --Buscar un procedimiento en especifico

DROP PROCEDURE saludo;

--PARAMETROS DE ENTRADA
create table empleados(
  documento char(8),
  nombre varchar2(20),
  apellido varchar2(20),
  sueldo number(6,2),
  fechaingreso date
 );
 insert into empleados values('22222222','Juan','Perez',300,to_date('10/10/1980','dd/mm/yyyy'));
 insert into empleados values('22333333','Luis','Lopez',300,to_date('12/05/1998','dd/mm/yyyy'));
 insert into empleados values('22444444','Marta','Perez',500,to_date('25/08/1990','dd/mm/yyyy'));
 insert into empleados values('22555555','Susana','Garcia',400,to_date('05/05/2000','dd/mm/yyyy'));
 insert into empleados values('22666666','Jose Maria','Morales',400,to_date('24/10/2005','dd/mm/yyyy'));
 
 select * from empleados
  
  create or replace procedure aumenta_sueldo(anio in number, porcentaje in number)
  as
    begin
        update empleados set sueldo = sueldo+(sueldo*porcentaje/100)
        where (extract(year from current_date)-extract(year from fechaingreso))> anio;
        end aumenta_sueldo;

execute aumenta_sueldo(28,20);

select * from empleados;


create or replace procedure ingreso_empleado(docu in char, nom in varchar2, ape in varchar)
as
begin
    insert into empleados values(docu, nom, ape, null, null);
    end ingreso_empleado;
    
execute ingreso_empleado('333222', 'Emilio', 'Perez');

select * from empleados;


/*VARIABLES*/
create table tabla1( 
   titulo varchar2(40),
   precio number(6,2)
  );
  
create or replace procedure autorlibro(atitulo in varchar2)
 as
   v_autor varchar2(20);
 begin
  select autor into v_autor from libros where titulo=atitulo;
  insert into tabla1
   select titulo,precio
   from libros
   where autor=v_autor;
 end autorlibro;
 
 execute autorlibro('El quijote');
 execute autorlibro('El alquimista');

select * from tabla1;


