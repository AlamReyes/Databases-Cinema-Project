/*
 * Company :      FI-UNAM
 * Project :      DCL
 * Author :       
 * CRUZ MALDONADO ARMANDO
 * LÓPEZ REYES ALAM
 * MARTÍNEZ PÉREZ BRIAN ERIK

 *
 * Date Created : Wednesday, May 29, 2024 18:51:29
 * Target DBMS : Microsoft SQL Server 2008
 */
 USE proyectoFinalCine; --O como se haya nombrado
GO

-- Crear usuarios de ejemplo
CREATE LOGIN User1 WITH PASSWORD = 'Password1!';
CREATE LOGIN User2 WITH PASSWORD = 'Password2!';
CREATE LOGIN User3 WITH PASSWORD = 'Password3!';
CREATE LOGIN User4 WITH PASSWORD = 'Password4!';
CREATE LOGIN User5 WITH PASSWORD = 'Password5!';
CREATE LOGIN User6 WITH PASSWORD = 'Password6!';
CREATE LOGIN User7 WITH PASSWORD = 'Password7!';
CREATE LOGIN User8 WITH PASSWORD = 'Password8!';
CREATE LOGIN User9 WITH PASSWORD = 'Password9!';
CREATE LOGIN User10 WITH PASSWORD = 'Password10!';
GO

-- Crear usuarios en la base de datos y vincular logins
CREATE USER User1 FOR LOGIN User1;
CREATE USER User2 FOR LOGIN User2;
CREATE USER User3 FOR LOGIN User3;
CREATE USER User4 FOR LOGIN User4;
CREATE USER User5 FOR LOGIN User5;
CREATE USER User6 FOR LOGIN User6;
CREATE USER User7 FOR LOGIN User7;
CREATE USER User8 FOR LOGIN User8;
CREATE USER User9 FOR LOGIN User9;
CREATE USER User10 FOR LOGIN User10;
GO

-- Asignar roles y permisos específicos
-- Suponemos que algunos usuarios pueden hacer todo, mientras otros tienen restricciones específicas

-- Usuario 1 tiene acceso a todo
EXEC sp_addrolemember 'db_owner', 'User1';

-- Usuarios para gestión de cines y salas
EXEC sp_addrolemember 'db_datawriter', 'User2';
EXEC sp_addrolemember 'db_datareader', 'User2';

EXEC sp_addrolemember 'db_datawriter', 'User3';
EXEC sp_addrolemember 'db_datareader', 'User3';

-- Usuarios para gestión de contenido y eventos
EXEC sp_addrolemember 'db_datawriter', 'User4';
EXEC sp_addrolemember 'db_datareader', 'User4';

EXEC sp_addrolemember 'db_datawriter', 'User5';
EXEC sp_addrolemember 'db_datareader', 'User5';

-- Usuarios con permisos específicos para consultas
GRANT SELECT ON Administrator.CINE TO User6;
GRANT SELECT ON Administrator.SALA TO User6;

GRANT SELECT ON Content.CONTENIDO TO User7;
GRANT SELECT ON Content.EVENTO TO User7;

-- Permiso para actualizar y modificar contenido y eventos
GRANT UPDATE, INSERT ON Content.CONTENIDO TO User8;
GRANT UPDATE, INSERT ON Content.EVENTO TO User8;

-- Permiso para gestionar usuarios y roles
GRANT ALTER ANY USER TO User9;
GRANT ALTER ANY ROLE TO User9;

-- Usuario 10 es solo para consultas en general
GRANT SELECT ON SCHEMA::Administrator TO User10;
GRANT SELECT ON SCHEMA::Content TO User10;
GO
