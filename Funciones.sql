/*
create or replace function nombre(argumento tipo)
    return tipo
    is 
    begin
    return instrucciones;
end;
*/
set serveroutput on;

create or replace function f_prueba(valor number)
    return number
    is 
    begin
    return valor*2;
end;

select f_prueba(2) as total from dual;      --dual xq no hay tabla de por medio

create or replace function f_costo(valor number)
return varchar
is
costo varchar(20);
begin
costo := '';
if valor <= 500 then
costo := 'Economico';
else costo:='Costoso';
end if;
return costo;
end;

drop function f_prueba;

select titulo, autor, precio, f_costo(precio) from libros;



