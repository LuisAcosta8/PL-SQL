 select * from user_dependencies;

 select * from user_dependencies where name = 'employees';

 select * from user_dependencies where name = 'EMP_DETAILS_VIEW';

 select * from user_dependencies where referenced_name = 'EMPLOYEES';

 select * from user_objects;
 
 select status, count(*) from user_objects
     group by status;
 
 
 create table prueba(
                    campo1 number,
                    campo2 number
                    );
                    
 select * from user_objects where object_name like '%PRUEBA%';
 
 create or replace view v_prueba
 as
 select campo1 from prueba;
 
 select * from user_objects where object_name like '%V_PRUEBA%';
  
 ALTER TABLE PRUEBA MODIFY CAMPO2 VARCHAR2(200);
  
 SELECT * FROM V_PRUEBA;
  
 ALTER TABLE prueba DROP COLUMN CAMPO1;
  
 SELECT * FROM V_PRUEBA;               --> ERROR PORQUE BORRAMOS EL CAMPO DEL QUE DEPENDIA LA VISTA
  
 select * from user_objects where object_name like '%PRUEBA%';            --> INVALID
   
 --HAY QUE REVALIDAR DE NUEVO EL STATUS
 CREATE OR REPLACE PROCEDURE PROC_01
 IS
 BEGIN
       NULL;      --Se crea un error intencionalmente para hacer fallar el procedimiento
 END;
 
 
 select * from user_objects where object_name like '%PROC%';
 
 CREATE OR REPLACE PROCEDURE PROC_02
 IS
 BEGIN
       PROC_01;
 END;
 
 select * from user_objects where object_name like '%PROC%';
 
 alter procedure proc_02 compile;

 