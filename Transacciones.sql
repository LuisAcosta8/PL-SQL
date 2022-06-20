/*
 Unidad atomica de trabajo que puede constar de una o mas sentencias SQL 
 relacionadas entre si, se les dice atomicas xq las modificaciones de la BD 
 provocadas por estas sentencias pueden confirmarse colectivamente, es decir, 
 hacerce permanentes o deshacerce dese la BD.
*/


 drop table clientes;
 create table clientes(
 id_cliente int not null,
 nombre varchar2(30),
 edad numeric(2),
 direccion varchar(60),
 salario number(6,2));


 insert into clientes values (1,'Ramon Rodriguez',32,'Calle primera numero 001',2000.00); 
 insert into clientes values (2,'Jose Tomas',25,'Calle segunda numero 002',1500.00); 
 insert into clientes values (3,'Ana Jimenez',23,'Calle tercera numero 003',2000.00); 
 insert into clientes values (4,'Emilio Contreras',25,'Calle cuarta numero 004',6500.00); 
 insert into clientes values (6,'Pedro Sandoval',22,'Calle quinta numero 005',4500.00); 
 
 select * from clientes;
 
 --Rollback: Los cambios que se hagan en una tabla se puedan deshacer con tan solo ejecutar el comando
 
 rollback;
 select * from clientes;
 
 insert into clientes values (1,'Ramon Rodriguez',32,'Calle primera numero 001',2000.00); 
 insert into clientes values (2,'Jose Tomas',25,'Calle segunda numero 002',1500.00); 
 insert into clientes values (3,'Ana Jimenez',23,'Calle tercera numero 003',2000.00); 
 insert into clientes values (4,'Emilio Contreras',25,'Calle cuarta numero 004',6500.00); 
 insert into clientes values (6,'Pedro Sandoval',22,'Calle quinta numero 005',4500.00);
 
 
 --Los cambios que generamos se hacen permanentemente
 commit;        
 
 insert into  clientes values (7,'Esther Sanchez',27,'Calle sexta numero 006',5500.00 ); 
 insert into  clientes values (8,'Antonio Peralta',21,'Calle septima numero 007',4500.00 ); 
 
 savepoint punto1;          --Puntop de control de transaccion
 
 update clientes set salario = salario + 100;
 
 
 rollback to punto1;            --Regresa a la version del punto guardado
 
 select * from clientes;