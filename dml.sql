
/*
 * Company :      FI-UNAM
 * Project :      dml.sql
 * Author :       
 * CRUZ MALDONADO ARMANDO
 * LÓPEZ REYES ALAM
 * MARTÍNEZ PÉREZ BRIAN ERIK
 * Target DBMS : Microsoft SQL Server 2008
 */

/*
Conjunto de instrucciones para elaborar vistas, triggers, storeProcedures y funciones
*/

USE proyectoFinalCine;
GO

/*Explicacion primer vista
  En esta primera vista tenemos una visualizacion de todos los usuarios, que cargos ocupan y sus datos personales
  Esto con el fin de administrar usuarios y ver los roles que cumplen*/
CREATE VIEW UserManagment.vUsuariosPerfiles AS
SELECT 
    Id_Usuario, 
    Perfil_Usuario, 
    Nombre, 
    A_Paterno, 
    A_Materno, 
    Domicilio,
    F_Nacimiento
FROM 
    UserManagment.USUARIO;

select * from UserManagment.vUsuariosPerfiles
go
/*Explicacion segunda vista
  Esta es una relacion de los cines con la cantidad de ingresos que reciben este manejo es importante
  Porque nos permite administrar financieramente cuanto es el ingreso mensual ademas de entender el rendimiento
  que ofrece cada cine*/
CREATE VIEW Administrator.vIngresosCine AS
SELECT 
    c.IDENTIFICADOR_CINE AS Cine_ID,
    c.NOMBRE AS Cine_Nombre,
    i.MES,
    i.INGRESO_MENSUAL
FROM 
    Administrator.CINE c
JOIN 
    Administrator.INGRESO i ON c.IDENTIFICADOR_CINE = i.IDENTIFICADOR_CINE;

Select * from Administrator.vIngresosCine
go 

/*Explicacion tercer vista
  En este ejemplo es una relacion de 3 tablas donde tendremos los eventos programados, en que sala son mostrados y el contenido
  de dichas salas, partimos de la idea de corroborar que la informacion mostrada sea correcta para las 3 relaciones, nos permite
  una mejor forma de obtener informacion sobre eventos*/

CREATE VIEW Content.vProgramacionEventos AS
SELECT 
    e.IDENTIFICADOR_EVENTO AS Evento_ID,
    e.QUIEN_PROGRAMA AS Programador,
    e.FECHA_HORA_INICIO,
    e.ID_SALA,
    s.NOMBRE AS Sala_Nombre,
    c.TITULO AS Contenido_Titulo,
    c.TIPO_CONTENIDO
FROM 
    Content.EVENTO e
JOIN 
    Administrator.SALA s ON e.ID_SALA = s.ID_SALA
JOIN 
    Content.CONTENIDO c ON e.CONTENIDO_PROGRAMADO = c.IDENTIFICADOR;

Select * from Content.vProgramacionEventos

/*Explicacion cuarta vista
  Para este ejemplo trabajamos solo la vista de los eventos programados esto es importante para tener una vision general
  de los eventos que se encuentran disponibles.*/

CREATE VIEW Content.vEventosProgramados AS
SELECT 
    IDENTIFICADOR_EVENTO AS Evento_ID,
    ID_SALA,
    FECHA_HORA_INICIO,
    CONTENIDO_PROGRAMADO AS Contenido_ID
FROM 
    Content.EVENTO;

select * from Content.vEventosProgramados


-- TRIGGERS

/* TRIGGER 1
RN1:Para la misma sala no pueden programarse dos eventos en la misma franja horaria.
Insertar en evento: Comprobar que no exista un Evento programado en la sala
indicada en la misma franja horaria, incluyendo el tiempo de
descanso indicado para la sala en cuestión.
*/
CREATE TRIGGER trg_CheckEventoSolape
ON Content.EVENTO
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @newIdSala INT, @newFechaHoraInicio DATETIME2, @newDuracion INT, @newFechaHoraFin DATETIME2, @eventoId INT;

    -- Extrae los datos del evento insertado o actualizado junto con la duración del contenido asociado.
    SELECT @newIdSala = i.ID_SALA, @newFechaHoraInicio = i.FECHA_HORA_INICIO, @newDuracion = c.DURACION, @eventoId = i.IDENTIFICADOR_EVENTO
    FROM inserted i
    JOIN Content.CONTENIDO c ON i.CONTENIDO_PROGRAMADO = c.IDENTIFICADOR;

    -- Calcula el tiempo de finalización del evento, teniendo en cuenta la duración del contenido.
    SET @newFechaHoraFin = DATEADD(MINUTE, @newDuracion, @newFechaHoraInicio);

    -- Verifica si hay algún evento existente que se solape con el nuevo evento.
    IF EXISTS (
        SELECT 1
        FROM Content.EVENTO e
        JOIN Administrator.SALA s ON e.ID_SALA = s.ID_SALA
        WHERE e.ID_SALA = @newIdSala
        AND e.IDENTIFICADOR_EVENTO <> @eventoId -- Excluye el evento actual en caso de actualización para evitar auto-conflictos.
        AND (
            (@newFechaHoraInicio BETWEEN e.FECHA_HORA_INICIO AND DATEADD(MINUTE, @newDuracion + s.TIEMPO_DESCANSO, e.FECHA_HORA_INICIO))
            OR
            (@newFechaHoraFin BETWEEN e.FECHA_HORA_INICIO AND DATEADD(MINUTE, @newDuracion + s.TIEMPO_DESCANSO, e.FECHA_HORA_INICIO))
            OR
            (e.FECHA_HORA_INICIO BETWEEN @newFechaHoraInicio AND @newFechaHoraFin)
        )
    )
    BEGIN
        -- Si se detecta un solapamiento, se lanza un error y se revierte la transacción.
        RAISERROR('No se puede programar el evento porque se solapa con otro evento en la misma sala.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

/*TRIGGER 2 Y 3

RN2:Un evento no puede ser ni modificado ni borrado una vez dicho evento haya sido publicado en la cartelería.

Modificar atributos en evento: Comprobar si el campo validado de Evento no está activado
para el evento en cuestión.

Borrar en evento Comprobar si el campo validado de Evento no está activado
para el evento en cuestión.

RN3 No se puede ni borrar ni modificar un evento antiguo
Modificar en evento: Comprobar si la fecha del Evento es anterior a la fecha actual
Borrar en evento: Comprobar si la fecha del Evento es anterior a la fecha actual

*/
CREATE  TRIGGER trg_EventoModificacionesBorrado
ON Content.EVENTO
INSTEAD OF UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- Comprobar si algún evento que se intenta actualizar o eliminar está validado
    IF EXISTS (
        SELECT 1 FROM deleted
        WHERE EXISTS (
            SELECT 1 FROM Content.EVENTO WHERE IDENTIFICADOR_EVENTO = deleted.IDENTIFICADOR_EVENTO AND VALIDADO = 1
        )
    )
    BEGIN
        RAISERROR('No se puede modificar o eliminar un evento que ha sido publicado en la cartelera.', 16, 1);
        RETURN;
    END

    -- Comprobar si se intenta modificar o eliminar eventos cuya fecha de inicio es anterior a la fecha actual
    IF EXISTS (
        SELECT 1 FROM deleted
        WHERE FECHA_HORA_INICIO < CAST(GETDATE() AS DATE)
    )
    BEGIN
        RAISERROR('No se puede modificar o eliminar eventos cuya fecha ha pasado.', 16, 1);
        RETURN;
    END

    -- Si no hay eventos validados o pasados en el conjunto borrado, procede a eliminar
    DELETE FROM Content.EVENTO
    WHERE IDENTIFICADOR_EVENTO IN (SELECT IDENTIFICADOR_EVENTO FROM deleted);

    -- Para los eventos actualizados que no están validados y no son pasados, realiza la actualización
    IF EXISTS (SELECT 1 FROM inserted)
    BEGIN
        UPDATE e
        SET
            QUIEN_PROGRAMA = i.QUIEN_PROGRAMA,
            CONTENIDO_PROGRAMADO = i.CONTENIDO_PROGRAMADO,
            FECHA_HORA_INICIO = i.FECHA_HORA_INICIO,
            ID_SALA = i.ID_SALA
        FROM Content.EVENTO e
        INNER JOIN inserted i ON e.IDENTIFICADOR_EVENTO = i.IDENTIFICADOR_EVENTO
        WHERE e.FECHA_HORA_INICIO >= CAST(GETDATE() AS DATE)
          AND NOT EXISTS (
              SELECT 1 FROM Content.EVENTO WHERE IDENTIFICADOR_EVENTO = i.IDENTIFICADOR_EVENTO AND VALIDADO = 1
          );
    END
END;
GO



-- FUNCIONES
USE proyectoFinalCine; --O como se haya nombrado
GO
CREATE FUNCTION dbo.VistasPorAnio()
RETURNS TABLE
AS
RETURN (
    SELECT 
        YEAR(Fecha) AS Anio, 
        SUM(Vista_Total) AS TotalVistas
    FROM 
        Content.VISTA
    GROUP BY 
        YEAR(Fecha)
);


CREATE FUNCTION dbo.GananciasPorCine()
RETURNS TABLE
AS
RETURN (
    SELECT 
        IDENTIFICADOR_CINE AS CineID,
        SUM(INGRESO_MENSUAL) AS Total
    FROM 
        Administrator.INGRESO
    GROUP BY 
        IDENTIFICADOR_CINE
);


-- Obtener el total de vistas por año
SELECT * FROM dbo.VistasPorAnio();

-- Obtener ingresos por un cine específico
SELECT * FROM dbo.GananciasPorCine();


--STORE PROCEDURES
-- 1. Monto de Entradas por Día por Contenido en Cartelera

USE proyectoFinalCine;
GO

CREATE PROCEDURE pusuMontoEntradasPorDiaPorContenido
AS
BEGIN
    SELECT C.*, I.Ingreso_Mensual_Mayor 
    FROM Administrator.CINE AS C
    LEFT JOIN ( SELECT IDENTIFICADOR_CINE, MAX(INGRESO_MENSUAL) AS Ingreso_Mensual_Mayor 
                FROM Administrator.INGRESO
                GROUP BY IDENTIFICADOR_CINE 
              ) AS I ON C.IDENTIFICADOR_CINE = I.IDENTIFICADOR_CINE
END
GO
-- 2. Top Diez de las Películas Más Vistas
CREATE PROCEDURE pusuTopDiezPeliculasMasVistas
    @FechaInicio DATE,
    @FechaFin DATE
AS
BEGIN
    SELECT TOP 10 
        C.TITULO AS Pelicula,
        SUM(V.Vista_Total) AS Total_Vistas
    FROM Content.VISTA AS V
    INNER JOIN Content.EVENTO AS E ON V.IDENTIFICADOR_EVENTO = E.IDENTIFICADOR_EVENTO
    INNER JOIN Content.EXHIBE AS X ON E.ID_SALA = X.ID_SALA AND E.CONTENIDO_PROGRAMADO = X.IDENTIFICADOR
    INNER JOIN Content.CONTENIDO AS C ON X.IDENTIFICADOR = C.IDENTIFICADOR
    INNER JOIN Content.PELICULA AS P ON C.IDENTIFICADOR = P.IDENTIFICADOR
    WHERE V.Fecha BETWEEN @FechaInicio AND @FechaFin
    GROUP BY C.TITULO
    ORDER BY Total_Vistas DESC;
END
GO
--3. Ingresos por Cine en un Rango de Fechas
CREATE PROCEDURE pusuIngresosPorCine
    @FechaInicio DATE,
    @FechaFin DATE
AS
BEGIN
    SELECT C.NOMBRE, C.DIRECCION, I.INGRESO_MENSUAL, I.MES  
    FROM Administrator.CINE AS C
    INNER JOIN Administrator.INGRESO AS I ON C.IDENTIFICADOR_CINE = I.IDENTIFICADOR_CINE
    WHERE I.MES BETWEEN @FechaInicio AND @FechaFin
END
GO
--4. Listado de Géneros por Número de Vistas
CREATE PROCEDURE pusuListadoGenerosPorNumeroDeVistas
AS
BEGIN
    SELECT G.TIPO_GENERO, C.Numero_Genero 
    FROM Content.GENERO AS G
    INNER JOIN ( SELECT ID_GENERO, COUNT(ID_GENERO) AS Numero_Genero 
                 FROM Content.CONTENIDO 
                 GROUP BY ID_GENERO
               ) AS C ON G.ID_GENERO = C.ID_GENERO
    ORDER BY C.Numero_Genero DESC
END
GO
-- 5. Listado de Usuarios del Sistema
CREATE PROCEDURE pusuListadoUsuariosSistema
AS
BEGIN
    SELECT NOMBRE + ' ' + A_PATERNO + ' ' + A_MATERNO AS NombreCompleto, F_Nacimiento, Domicilio 
    FROM UserManagment.USUARIO
END
GO
--6. Inventario de los Cines
CREATE PROCEDURE pusuInventarioCines
AS
BEGIN
    SELECT C.NOMBRE AS NombreCine, C.DIRECCION, S.NOMBRE AS NombreSala, S.CAPACIDAD, S.TIPO_DE_SALA 
    FROM Administrator.CINE AS C
    INNER JOIN Administrator.SALA AS S ON C.IDENTIFICADOR_CINE = S.IDENTIFICADOR_CINE
END
GO


--PRUEBAS

EXEC pusuMontoEntradasPorDiaPorContenido;

-- requiere dos parámetros de fecha (inicio y fin del periodo a consultar)
EXEC pusuTopDiezPeliculasMasVistas @FechaInicio = '2023-01-01', @FechaFin = '2023-06-02';
--requiere fechas de inicio y fin
EXEC pusuIngresosPorCine @FechaInicio = '2024-01-01', @FechaFin = '2024-03-01';
EXEC pusuListadoGenerosPorNumeroDeVistas;
EXEC pusuListadoUsuariosSistema;
EXEC pusuInventarioCines;
