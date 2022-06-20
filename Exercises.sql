-- Show 'Hello world' on screen
set serveroutput on;
BEGIN
    dbms_output.put_line('Hello world');
END;


-- Declare a numeric variable and show if it is greater than 10 or not.
DECLARE
    a number(3):= 1;
BEGIN
    if (a > 10) then
        dbms_output.put_line(a || ' Is greater than 10');
    elsif (a < 10) then
        dbms_output.put_line(a || ' Is less than 10');
    else 
        dbms_output.put_line(a || ' Is equal to 10');
    end if;
END;


-- Declare a numeric variable and ask for its value and display it.
accept x number prompt 'Enter a number: '
DECLARE
    a number;
BEGIN
    a := &x;
    dbms_output.put_line(a);
END;


-- Show the numbers from 1 to 100 with a while.
DECLARE
    a number(3):= 1;
BEGIN
    while a <= 100 loop
        dbms_output.put_line(a);
        a := a + 1;
    end loop;
END;


--Show the numbers from 1 to 100 with a for.
DECLARE
    n number(3);
BEGIN
    for n in 1..100 loop
        dbms_output.put_line(n);
    end loop;
END;


-- Show the numbers from 1 to 100 with a loop.
DECLARE
    a number(3):=1;
BEGIN
    loop 
        dbms_output.put_line(a);
        a := a + 1;
        exit when a = 101;
    end loop;
END;



