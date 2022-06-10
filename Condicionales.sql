/*
Condicionales: Estructuras de tomas de decisiones, requieren 
de condiciones para ser evaluadas o probadas por el programa, 
junto con una declaracion o declaraciones que se ejecutaran si se 
determina que la condicion es verdadera, opcionalmente otras sentencas 
de ejecutaran si la condicion resulta falsa.
1 condicion:

if condicion then
else
end if;

varias condiciones:


*/
/*
DECLARE
    a number(2):=10;
    b number(2):=20;


BEGIN
    if a > b then
    dbms_output.put_line(a || ' es mayor que ' || b);
    else
    dbms_output.put_line(b || ' es mayor que ' || a);
    end if;

END;
  */
DECLARE
numero NUMBER(3):= 100;

BEGIN
    if (numero = 10) then
        dbms_output.put_line('El valor del numero es 10');
    elsif (numero = 20) then
        dbms_output.put_line('El valor es 20');
    elsif (numero = 30) then
        dbms_output.put_line('El valor es 30');
    else
        dbms_output.put_line('Ninguno de los valores encontrado');
    end if;
        dbms_output.put_line('El valor exacto de la variable es ' || numero);
    

END;
    