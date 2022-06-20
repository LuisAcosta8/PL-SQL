/*
create or replace function nombrefuncion(variables)
return varchar2
is 
    #variables segun el caso
    begin
        #Declaracion de variables
        case variable
            when valorvariable then instruccion;
            when valorvariable then instruccion;
            when valorvariable then instruccion;
            when valorvariable then instruccion;
            when valorvariable then instruccion;
            when valorvariable then instruccion;
            when valorvariable then instruccion;
            else instruccion;
        end case;
            return #salida;
end;
*/

create or replace function f_diasemana(numero int)
return varchar2
is 
    dia varchar2(25);
    begin
        dia:='';
        case numero
            when 1 then dia:='Lunes';
            when 2 then dia:='Martes';
            when 3 then dia:='Miercoles';
            when 4 then dia:='Jueves';
            when 5 then dia:='Viernes';
            when 6 then dia:='Sabado';
            when 7 then dia:='Domingo';
            else dia := 'No es un numero correcto';
        end case;
            return dia;
end;
drop function f_diasemana;

select f_diasemana(3) as "Día de la semana" from dual;      --Debe ser doble comilla

select f_diasemana(9) as "Día de la semana" from dual;

create or replace function f_trimestre(fecha date)
return varchar2
is 
    mes varchar2(20);
    trimestre number;
    begin
        mes := extract(month from fecha);
        trimestre := 0;
        case mes
           when 1 then trimestre :=1;
           when 2 then trimestre :=1;
           when 3 then trimestre :=1;
           when 4 then trimestre :=2;
           when 5 then trimestre :=2;
           when 6 then trimestre :=2;
           when 7 then trimestre :=3;
           when 8 then trimestre :=3;
           when 9 then trimestre :=3;
           else trimestre := 4;
        end case;
            return trimestre;
end;

select f_trimestre(to_date('11/11/2011', 'dd/mm/yyyy')) as Trimestre from dual;
select f_trimestre(to_date('11/01/2011', 'dd/mm/yyyy')) as Trimestre from dual;
select f_trimestre(to_date('11/06/2011', 'dd/mm/yyyy')) as Trimestre from dual;
select f_trimestre(to_date('11/8/2011', 'dd/mm/yyyy')) as Trimestre from dual;