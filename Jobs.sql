 /*
 Procesos de negocio que realizan tareas automaticas, analizan y procesan 
 grandes cantidades de datos en la base
 
 DBMS_SCHEDULER_JOB
 -Programador de tareas
 
 */
 
 create table log_actividades(
                               id_log int not null,
                               fecha date
                                );
                                
 BEGIN
    sys.dbms_scheduler.create_job(
    job_name => 'job_uno',
    job_type => 'PLSQL_BLOCK',
    job_action =>   'DECLARE
                        v_conteo number := 0;
                    BEGIN
                        select count(*) into v_conteo
                        from log_actividades;
                        insert into log_actividades values (v_conteo + 1, sysdate);
                        commit;
                        end;',
    start_date => systimestamp,
    repeat_interval => 'freq = secondly; interval = 5',
    end_date => null,
    enabled => False,
    comments => 'log de actividades');
    end;
    
select * from log_actividades;
  