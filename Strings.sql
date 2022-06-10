/*

*/

set serveroutput on;
DECLARE
    nombre varchar2(20);
    direccion varchar(30);
    detalles clob;  --Variable de gran almacenamiento
    eleccion char(1);
BEGIN
    nombre := 'Pedro Perez';
    direccion := 'Calle primera #1';
    detalles := 'Este es el detalle de la variable clob que iniciamos 
    en la seccion declarativa, es una variable de gran almacenamiento ';
    eleccion := 'y';
    if eleccion = 'y' then
        dbms_output.put_line(nombre);
        dbms_output.put_line(direccion);
        dbms_output.put_line(detalles);
    end if;
END;

/*
Metodos de los String
*/

DECLARE
    saludo varchar(12) := 'Hola a todos';
BEGIN
    dbms_output.put_line(UPPER(saludo)); --Mayusculas
    dbms_output.put_line(LOWER(saludo));  --Minusculas
    dbms_output.put_line(INITCAP(saludo));   --Primeras letras de todas las palabras a Mayuscula
    dbms_output.put_line(SUBSTR(saludo,1,1)); --Primer caracter dependiendo de la posición (variable,valorinicial, # de caracteres)
    dbms_output.put_line(SUBSTR(saludo,1,4));
    dbms_output.put_line(SUBSTR(saludo,8,5)); --Todos
    dbms_output.put_line(SUBSTR(saludo,6));   --Caracter 6 hasta el final
    dbms_output.put_line(INSTR(saludo,'a')); --Posicion del primer caracter que coincida con el que ingresamos como argumento
end;

DECLARE
    saludo varchar2(30) := '####Hola a todos####';
BEGIN
    dbms_output.put_line(RTRIM(saludo, '#'));    --Renueve los caracteres a la derecha que coincidan con el argumento
    dbms_output.put_line(LTRIM(saludo, '#'));   --Renueve los caracteres a la izquierda que coincidan con el argumento
    dbms_output.put_line(TRIM('#' from saludo));   --Renueve los caracteres que coincidan con el argumento
END;