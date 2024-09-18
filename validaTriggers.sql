/*
 * Company :      FI-UNAM
 * Project :      validaTriggers.sql
 * Author :       
 * CRUZ MALDONADO ARMANDO
 * LÓPEZ REYES ALAM
 * MARTÍNEZ PÉREZ BRIAN ERIK
 * Target DBMS : Microsoft SQL Server 2008
 */

/*
Se presentan pruebas para validar los triggers
*/


USE proyectoFinalCine;
GO


-- PRUEBAS TRIGGER 1

BEGIN TRANSACTION;
-- Intenta insertar un evento que no interfiera con otros eventos programados.
INSERT INTO Content.EVENTO (IDENTIFICADOR_EVENTO, QUIEN_PROGRAMA, CONTENIDO_PROGRAMADO, FECHA_HORA_INICIO, ID_SALA, IDENTIFICADOR_EXHIBE, VALIDADO)
VALUES (31, 'User1', 17, '2023-01-01 10:00:00.0000000', 1, 16, 1);
ROLLBACK TRANSACTION;


BEGIN TRANSACTION;
-- Intenta insertar un evento que no interfiera con otros eventos programados.
INSERT INTO Content.EVENTO (IDENTIFICADOR_EVENTO, QUIEN_PROGRAMA, CONTENIDO_PROGRAMADO, FECHA_HORA_INICIO, ID_SALA, IDENTIFICADOR_EXHIBE)
VALUES (31, 'User3', 19, '2023-01-01 14:00:00.0000000', 3, 18);
ROLLBACK TRANSACTION;

select * from Content.EVENTO
select * from Content.EXHIBE



--PRUEBAS RN2
BEGIN TRANSACTION;
-- Intenta actualizar un evento que está marcado como publicado.
UPDATE Content.EVENTO
SET FECHA_HORA_INICIO = '2024-05-01 19:00:00'
WHERE IDENTIFICADOR_EVENTO = 1;  -- (`validado = 1`).
ROLLBACK TRANSACTION;

BEGIN TRANSACTION;
-- Intenta eliminar un evento que está marcado como publicado.
DELETE FROM Content.EVENTO WHERE IDENTIFICADOR_EVENTO = 1;  -- validado
ROLLBACK TRANSACTION;




--PRUEBAS 3
INSERT INTO Content.EVENTO (IDENTIFICADOR_EVENTO, QUIEN_PROGRAMA, CONTENIDO_PROGRAMADO, FECHA_HORA_INICIO, ID_SALA, IDENTIFICADOR_EXHIBE, VALIDADO)
VALUES (32, 'User1', 17, '2024-07-01T10:00:00', 1, 16,0);
select * from content.evento

BEGIN TRANSACTION;
-- Intenta actualizar un evento que está marcado como publicado y cuya fecha ha pasado.
UPDATE Content.EVENTO
SET FECHA_HORA_INICIO = '2023-10-01T10:00:00'
WHERE IDENTIFICADOR_EVENTO = 32;  -- Evento pasado salta trigger, si no es pasado ni validado se actualiza
ROLLBACK TRANSACTION;

BEGIN TRANSACTION;
-- Intenta eliminar un evento que está marcado como publicado y cuya fecha ha pasado.
DELETE FROM Content.EVENTO WHERE IDENTIFICADOR_EVENTO = 31;  -- Asegúrate de que este evento está validado y su fecha es anterior a hoy.
ROLLBACK TRANSACTION;



