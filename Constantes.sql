declare
    mensaje constant varchar2(30) := 'Buenos dias a todos';
    numero constant number(6) := 30000;
    
begin
    mensaje :='Adios a todos'   --El mensaje inicial no cambia; la ejecucion dara error
    dbms_output.put_line(mensaje);
    dbms_output.put_line(numero);

end;