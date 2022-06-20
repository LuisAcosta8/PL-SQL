/*
Crusor: Puntero que se utiliza para manejar sentencias select y esta formado por 
un conjunto de registros que son devueltos por dicha instruccion, desde un punto 
de vista interno se puede decir que los cursores son segmentos de memoria utilizados 
para realizar operaciones con los registros que se devuelven tras ejecutar una 
sentencia select

*Cursores implicitos
-Definidos por el sistema
--Devuelve un solo registro

*Cursores explicitos
-Definidos por el usuario
--Devuelve varios registros
--Tambien se pueden utilizar en consultas que devuelven un solo registro

*Atributos
* %ISOPEN   --> Devuelve True si el cursor esta abierto
* %FOUND    --> Devuelve True si el registro fue procesado satisfactoriamente
* %NOTFOUND --> Devuelve True si el registro no pudo ser procesado. Normalmente
                esto ocurre cuando ya se han procesado todos los registros 
                devueltos por el cursor
* %ROWCOUNT --> Devuelve el numero de registros que han sido procesados hasta 
                ese momento
*/

drop table empleados;

 create table empleados(
  documento char(8),
  apellido varchar2(30),
  nombre varchar2(30),
  domicilio varchar2(30),
  seccion varchar2(20),
  sueldo number(8,2)
 );
 insert into empleados values('22222222','Acosta','Ana','Avellaneda 11','Secretaria',1800);
 insert into empleados values('23333333','Bustos','Betina','Bulnes 22','Gerencia',5000);
 insert into empleados values('24444444','Caseres','Carlos','Colon 333','Contabilidad',3000);
 insert into empleados values('32323255','Gonzales','Miguel','Calle 4ta No.90','Contabilidad',8000);
 insert into empleados values('56565555','Suarez','Tomas','Atarazana 78','Cobros',1500);
 
 select * from empleados;
 
 --IMPLICITOS
 set serveroutput on;
 DECLARE
    filas number(2);
 BEGIN
    update empleados set sueldo = sueldo + 500 where sueldo >= 1000;
    if sql%notfound then 
        dbms_output.put_line('No hay empleados disponibles');
    elsif sql%found then
        filas := sql%rowcount;
        dbms_output.put_line(filas || ' filas han sido actualizadas');
    end if;
 END;
 
  select * from empleados;
  
  /*
 --EXPLICITOS
   --DECLARE    --> Se define el nombre del cursor y la consulta que se va a ejecutar
   ---OPEN      --> Se ejecuta la sentencia select que esta asociada y el resultado 
                    se guarda en una zona de memoria donde existen las llamadas 
                    tablas temporales de oracle, las cuales se van retornando cada 
                    una de las filas segun se va pidiendo desde la consulta
   ----FETCH    --> Se recuperan cada una de las filas de la consulta ejecutada dentro 
                    del cursor, una vez que el cursor esta abierto se podra hacer la 
                    peticion de cada fila
   -----EMPTY?  --> Evaluacion de la consulta extraida, se determina si los registros 
                    consultados cumplen con las funciones de los atributos de no ser 
                    asi el sistema regresa a fetch para volver a revisar la consulta
                    extraer los datos y regresar a la evaluacion. Si los datos cumplen 
                    con la consulta configurada en el cursor se salta al siguiente paso
   ------CLOSE  --> Cerrar el cursor
   */
   
   
 set serveroutput on;
   
 DECLARE
    v_docu empleados.documento%type;
    v_nom empleados.nombre%type;
    v_ape empleados.apellido%type;
    v_sueldo empleados.sueldo%type;

    cursor c_cursor2 is
        select documento, nombre, apellido, sueldo
        from empleados
        where documento = 22222222;

 BEGIN        
    open c_cursor2;
    fetch c_cursor2 into v_docu, v_nom, v_ape, v_sueldo;
    close c_cursor2;
    
    dbms_output.put_line('Documento: ' || v_docu);
    dbms_output.put_line('Nombre: ' || v_nom);
    dbms_output.put_line('Apellido: ' || v_ape);
    dbms_output.put_line('Sueldo: ' || v_sueldo);
    
    
 END;
   select * from empleados;
   
--CURSOR SELECT
 set serveroutput on;
 --chr(9)  tabulador
 --chr(10) salto de linea
 --chr(13) retorno de carro
 DECLARE
    v_empleados empleados%rowtype;
    
    
 BEGIN
    for v_empleados in (select * from empleados) loop
    dbms_output.put_line(v_empleados.nombre || chr(9) || v_empleados.sueldo);
    end loop;
    
 END;
 
 
 --CURSOR UPDATE

 BEGIN
    update empleados set sueldo = 10000
    where documento = '23338333';
    if sql%notfound then
        dbms_output.put_line('No existe registro para modificar');
    end if;
 END;
 
 select * from empleados;
 
 --CURSOR CON PARAMETROS
 drop table productos;

create table productos(
id_producto int not null,
nombre_producto VARCHAR2(25),
precio NUMBER(6,2),
descripcion VARCHAR2(50));

insert into productos values(1,'Abrazadera',560,'Abrazadera de media pulgada');
insert into productos values(2,'Destornillador',120,'destornillador cabeza plana');
insert into productos values(3,'Martillo',300,'Martillo con ganzua'); 
insert into productos values(4,'Llave inglesa',200,'Llave inglesa de plomeria');
insert into productos values(5,'Pasadores RTR',935,'Tuerca exagonal de Almenada');
insert into productos values(6,'Tornillo exagonal',90,'Tornillo exagonal de baja o tuerca');
 
 select * from productos;
 set serveroutput on;
 
 DECLARE
    v_nom productos.nombre_producto%type;
    v_pre productos.precio%type;
    
    cursor c_productos (idprod productos.id_producto%type)
    is
    select nombre_producto, precio from productos
    where id_producto = idprod;
    
    
 BEGIN
    open c_productos(1);
    loop
    fetch c_productos into v_nom, v_pre;
    exit when c_productos%notfound;
        dbms_output.put_line('Articulo: ' || v_nom || ' Precio: ' || v_pre);
    end loop;
    close c_productos;
 END;
 
 --REF_CURSORS
 /*
 -Variable que podria apuntar o hacer referencia hacia un resultado de un cursor normal
 */
 
 select * from empleados;
 
 --create or replace function f_datosempleados(v_documento in number) -- UN REGISTRO
 create or replace function f_datosempleados(v_documento in number,
                                             v_documento2 in number)  --MÁS DE UN REGISTRO 
 return SYS_REFCURSOR
 is 
    v_ref SYS_REFCURSOR;
    
 BEGIN
    open v_ref for select * from empleados
    --where documento = v_documento;                                    --UN REGISTRO
    where documento in (v_documento, v_documento2);                     --MÁS DE UN REGISTRO
    return v_ref;
 END;
 select * from empleados;

 select f_datosempleados(22222222, 24444444) from dual;

--Como no es buena forma de presentar los datos se tiene q crear una variable
 var rc1 refcursor
 exec :rc1 := f_datosempleados(22222222, 24444444);
 print rc1;