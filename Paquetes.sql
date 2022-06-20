/*
- Son un grupo logico de objetos de la base de datos tales como:
-- Registros de datos plsql
-- Variables
-- Estructuras de datos
-- Excepciones
-- Subprogramas
-- Procedimientos
-- Funciones
    Todos estos objetos se relacionan entre si, encapsulados y convertidos en una 
    unidad dentro de la base de datos

-Composición
--Especificacion (Package specification)    --> Interfaz entre paquete y 
                                                aplicaciones que las utilizan
                                                *Declaracion  de variables
                                                *Declaracion  de constantes
                                                *Declaracion  de exepciones
                                                *Declaracion  de cursores
                                                *Declaracion  de procedimientos
                                                *Declaracion  de funciones
--Cuerpo (Package body)                     --> Se implementa la especificacion 
                                                del paquete
                                                *Contiene los detalles de la 
                                                implementacion y las declaraciones 
                                                pero a modo privado(oculto)

*/
 set serveroutput on;
--Package
 create or replace package los_productos as
 procedure caracteristicas(v_codigo productos.codigo%type);
 end los_productos;
--Body
 create or replace package body los_productos as
 procedure caracteristicas(v_codigo productos.codigo%type) is
 v_producto productos.nombre%type;
 v_precio productos.precio%type;
 BEGIN
      select nombre, precio into v_producto, v_precio
      from productos where codigo = v_codigo;
        dbms_output.put_line('Articulo: ' ||  v_producto);
        dbms_output.put_line('Precio: ' ||  v_precio);
      end caracteristicas;
 end los_productos;
 
 BEGIN
    los_productos.caracteristicas(3);
 END;
 
 --Agregando nuevo objeto al paquete
 
 select los_productos.f_precio(6) as precio from dual;
 
select * from productos;