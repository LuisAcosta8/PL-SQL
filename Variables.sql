/*
Variable
Tipos de variables
*Fechas y horas
*Strings
*Registros
*Colección de datos

set serveroutput on --Habilita la salida de mensajes del script

*/
set serveroutput on 
DECLARE
identificador integer := 50;    --integer = Entero
nombre varchar2(25) := 'Luis Acosta';   --varchar2 = vacia los espacios que no se ocupen y reduce el tamaño de la variable
apodo char(10) := 'Luisillo';   --char = Deja los espacios en blanco aunque no se ocupen
sueldo number(5) := 30000;  --number = numero debes especificar el nmero de caracteres que puede tener la variable
comision decimal(4,2) := 50.20; --decimal(totaldedigitos,numerodedecimales)
fecha_actual date := (sysdate); --date = fecha  --sysdate Devuelve la fecha del sistema
fecha date:=to_Date('2019/07/09', 'yyyy/mm/dd');    
saludo varchar2(50) default 'Buenos dias a todos';  --default = Da un valor por default a una variable

BEGIN
DBMS_OUTPUT.PUT_LINE('El valor de la variable identificador es: ' || identificador);   --|| Concatenador
DBMS_OUTPUT.PUT_LINE(nombre);
DBMS_OUTPUT.PUT_LINE(apodo);
DBMS_OUTPUT.PUT_LINE(sueldo);
DBMS_OUTPUT.PUT_LINE(comision);
DBMS_OUTPUT.PUT_LINE(fecha_actual);
DBMS_OUTPUT.PUT_LINE(fecha);
DBMS_OUTPUT.PUT_LINE(saludo);

END;