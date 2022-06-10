/*
LOOP
    SECUENCIA DE INSTRUCCIONES
FIN DEL LOOP

while condicion loop
    secuencia de instrucciones;
fin del loop

for contador in valorinicial..valorfinal loop
    secuencia de instrucciones
fin del loop

BUCLES ANIDADOS
loop principal
    1ra secuencia de instrucciones;
    loop anidado
        2da secuencia de instrucciones;
    fin del loop anidado;
fin del loop principal;


*/
set serveroutput on;
DECLARE
    valor number := 10;
BEGIN
    loop
        dbms_output.put_line(valor);
        valor := valor + 10;
        if valor > 50 then
        exit;
        end if;
    end loop;
    dbms_output.put_line('Saliste del bucle');
    dbms_output.put_line( 'Valor final: ' ||valor);
END;
--ó
DECLARE
    valor number := 10;
BEGIN
    loop
        dbms_output.put_line(valor);
        valor := valor + 10;
        exit when valor > 50;
    end loop;
    dbms_output.put_line('Saliste del bucle (Solucion 2)');
    dbms_output.put_line( 'Valor final: ' ||valor);
END;

--WHILE
DECLARE
    valor number(2) := 10;
BEGIN
    while valor < 20 loop
        dbms_output.put_line('El valor es: ' || valor);
        valor := valor + 2;
    end loop;
END;


--TABLA DEL 5 - WHILE
DECLARE
numero number(1) := 5;
cont number(2) := 0;
res number;
BEGIN
    WHILE cont <= 10 loop
        res := numero * cont;
        dbms_output.put_line(numero || ' * ' || cont || ' = ' || res);
        cont := cont + 1;
    end loop;
END;

--FOR
DECLARE
    numero number(2);
BEGIN
    for numero in 10..20 loop
    dbms_output.put_line('Valor del numero: ' || numero);
    end loop;
END;


--FOR IN REVERSE
BEGIN
    for f in reverse 0..5 loop
        dbms_output.put_line('Valor del numero: ' || f);
    end loop;
END;

--TABLA DEL 5
BEGIN
    for i in  0..10 loop
        dbms_output.put_line('5' || ' * ' || i ||' = ' || 5*i);
    end loop;
END;

--BUCLES ANIDADOS
/*
begin
    loop
        bloque de instrucciones;
        loop
            bloque de instrucciones anidados;
        exit when sentencias anidadas finalicen;
        end loop anidado;
    exit when sentencias externas finalicen;
    end loop principal;
end;
*/
DECLARE
multiplicador number(2) := 0;
multiplicando number(1) := 0;
BEGIN
    
END;