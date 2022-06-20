 /*
 Permiten almacenar distintos valores de registros con distintos tipos de datos 
 en una sola variable
 */
 set serveroutput on;
 
 drop table productos;

 create table productos (
 codigo int not null primary key,
 nombre varchar2(100) not null,
 precio number(6,2) not null,
 codigo_fabricante int not null);

 insert into productos values(1, 'Disco duro SATA· 1TB', 86.99, 5);
 insert into productos values(2 , 'Memoria RAM DDR4 8GB', 120, 6);
 insert into productos values(3, 'DISCO SSD 1 TB', 150.99, 4);
 insert into productos values(4, 'GEFORCE GTX 1050Ti', 185, 7);
 insert into productos values(5, 'GEFORCE GTX 1080TI', 755, 6);
 insert into productos values(6, 'Monitor 24 LED Full HD', 202, 1);
 insert into productos values(7, 'Monitor 27 LED Full HD', 245.99, 1);
 insert into productos values(8, 'Portátil Yoga 520', 559, 2);
 insert into productos values(9, 'Portátil Ideapd 320', 444, 2);
 insert into productos values(10, 'Impresora HP Deskjet 3720', 59.99, 3);
 insert into productos values(11, 'Impresora HP Laserjet Pro M26nw', 180, 3);

 --VARIABLE COMPUESTA BASADA EN UNA TABLA
 DECLARE
    reg_productos productos%rowtype;
 
 BEGIN
    select * into reg_productos from productos
    where codigo = 3;
        dbms_output.put_line('Caracteristica del producto');
        dbms_output.put_line('Codigo de producto:'  ||  reg_productos.codigo);
        dbms_output.put_line('Articulo: ' ||  reg_productos.nombre);
        dbms_output.put_line('Precio:'  ||  reg_productos.precio);
        dbms_output.put_line('Serial: ' ||  reg_productos.codigo_fabricante);
            
 END;
 
 --VARIABLE COMPUESTA BASADA EN CURSORES
 DECLARE
 cursor cu_productos is
 select * from productos;
 
 var_productos cu_productos%rowtype;
 
 BEGIN
    open cu_productos;
    loop
    fetch cu_productos into var_productos;
    exit when cu_productos%notfound;
    dbms_output.put_line(var_productos.codigo || ' ' || var_productos.nombre  ||  ' Precio: '  ||  var_productos.precio);
    end loop;

 END;
 
 
 
 select * from productos;