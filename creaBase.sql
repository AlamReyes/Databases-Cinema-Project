/*
 * Company :      FI-UNAM
 * Project :      CrearTablas
 * Author :       
 * CRUZ MALDONADO ARMANDO
 * LÓPEZ REYES ALAM
 * MARTÍNEZ PÉREZ BRIAN ERIK

 *
 * Date Created : Saturday, April 20, 2024 18:51:29
 * Target DBMS : Microsoft SQL Server 2008
 */


 -- Crear la base de datos proyectoCine
CREATE DATABASE proyectoFinalCine;
GO

-- Seleccionar la base de datos para operaciones subsecuentes
USE proyectoFinalCine;
GO

-- Crear schemas
CREATE SCHEMA Administrator
GO
CREATE SCHEMA Content
GO
CREATE SCHEMA UserManagment
GO

/* 
 * TABLE: CINE 
 */




CREATE TABLE Administrator.CINE(
    IDENTIFICADOR_CINE                int            NOT NULL,
    LOGO_CORPORATIVO                varbinary(max) NOT NULL,
    LATITUD                         decimal        NOT NULL,
    LONGITUD                        float          NOT NULL,
    TELEFONO                        varchar(10)        NOT NULL,
    DIRECCION                       varchar(30)    NOT NULL,
    NOMBRE                          varchar(20)    NOT NULL,
    CODIGO_IDENTIFICACION_FISCAL    varchar(20)    NOT NULL,
    CONSTRAINT CINE_PK PRIMARY KEY NONCLUSTERED (IDENTIFICADOR_CINE),
	CONSTRAINT CHK_TELEFONO CHECK (TELEFONO LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
)
go

-- Alter
--identificador a idCine



/* 
 * TABLE: CONTENIDO 
 */

CREATE TABLE Content.CONTENIDO(
    IDENTIFICADOR        int             NOT NULL,
    AÑO                  int             NOT NULL,
    VERSION              varchar(20)     NOT NULL,
    FORMATO              varchar(20)     NOT NULL,
    TITULO               varchar(50)     NOT NULL,
    DISTRIBUIDORA        varchar(50)     NOT NULL,
    DIRECTOR             varchar(50)     NOT NULL,
    EDAD_RECOMENDADA     int             NOT NULL,
    PAIS_PRODUCCION      varchar(20)     NOT NULL,
    TRAILER              varbinary(max)  NOT NULL,
    DECRIPCION           varchar(150)    NOT NULL,
    WEB_OFICIAL          varchar(255)     NOT NULL,
    ES_DIRECTO           bit             NOT NULL,
    DURACION             int             NOT NULL,
    FECHA_EMISION        date            NOT NULL,
    CARTEL_ANUNCIADOR    image           NOT NULL,
    TIPO_CONTENIDO       varchar(20)     NOT NULL,
    ID_GENERO            int             NOT NULL,
    CONSTRAINT CONTENIDO_PK PRIMARY KEY NONCLUSTERED (IDENTIFICADOR),
	CONSTRAINT CHK_VERSION CHECK (VERSION IN ('Digital', '3D')),
	CONSTRAINT CHK_DURACION CHECK (DURACION > 0),
	CONSTRAINT CHK_DURACION_RANGO CHECK (DURACION BETWEEN 1 AND 480)
)
go


/* 
 * TABLE: CULTURAL 
 */

CREATE TABLE Content.CULTURAL(
    IDENTIFICADOR        int            NOT NULL,
    NOMBRE_COMPOSITOR    varchar(50)    NOT NULL,
    LUGAR_EMISION        varchar(30)    NOT NULL,
    CONSTRAINT CULTURAL_PK PRIMARY KEY NONCLUSTERED (IDENTIFICADOR)
)
go

/* 
 * TABLE: DEPORTIVO 
 */

CREATE TABLE Content.DEPORTIVO(
    IDENTIFICADOR       int            NOT NULL,
    LUGAR_ORIGEN        varchar(30)    NOT NULL,
    DEPORTE_EXHIBIDO    varchar(30)    NOT NULL,
    CONSTRAINT DEPORTIVO_PK PRIMARY KEY NONCLUSTERED (IDENTIFICADOR)
)
go




/* 
 * TABLE: DIRECTO 
 */

CREATE TABLE Content.DIRECTO(
    IDENTIFICADOR    int            NOT NULL,
    TIPO_DIRECTO     varchar(20)    NOT NULL,
    CONSTRAINT DIRECTO_PK PRIMARY KEY NONCLUSTERED (IDENTIFICADOR)
)
go



/* 
 * TABLE: EVENTO 
 */

CREATE TABLE Content.EVENTO(
    IDENTIFICADOR_EVENTO           int            NOT NULL,
    QUIEN_PROGRAMA          varchar(50)    NOT NULL,
    CONTENIDO_PROGRAMADO    int			   NOT NULL,
    FECHA_HORA_INICIO     datetime2(7)	   NOT NULL,
    ID_SALA                 int            NOT NULL,
    IDENTIFICADOR_EXHIBE     int           NOT NULL,
	VALIDADO                BIT            NOT NULL DEFAULT 0,
    CONSTRAINT EVENTO_PK PRIMARY KEY NONCLUSTERED (IDENTIFICADOR_EVENTO)
)
go





/* 
 * TABLE: EXHIBE 
 */

CREATE TABLE Content.EXHIBE(
    ID_SALA          int    NOT NULL,
    IDENTIFICADOR    int    NOT NULL,
    CONSTRAINT EXHIBE_PK PRIMARY KEY NONCLUSTERED (ID_SALA, IDENTIFICADOR)
)
go

/* 
 * TABLE: GENERO 
 */

CREATE TABLE Content.GENERO(
    ID_GENERO      int            NOT NULL,
    TIPO_GENERO    varchar(20)    NOT NULL,
    CONSTRAINT GENERO_PK PRIMARY KEY NONCLUSTERED (ID_GENERO)
)
go



/* 
 * TABLE: IDIOMA 
 */

CREATE TABLE Content.IDIOMA(
    ID_IDIOMA        int            NOT NULL,
    IDIOMA           varchar(40)    NOT NULL,
    IDENTIFICADOR    int            NOT NULL,
    CONSTRAINT IDIOMA_PK PRIMARY KEY NONCLUSTERED (ID_IDIOMA)
)
go


/* 
 * TABLE: INGRESO 
 */

CREATE TABLE Administrator.INGRESO(
    ID_INGRESO         int     NOT NULL,
    INGRESO_MENSUAL    int     NOT NULL,
    MES                date    NOT NULL,
    IDENTIFICADOR_CINE      int     NOT NULL,
    CONSTRAINT INGRESO_PK PRIMARY KEY NONCLUSTERED (ID_INGRESO)
)
go


/* 
 * TABLE: INTERPRETE 
 */

CREATE TABLE Content.INTERPRETE(
    ID_INTERPRETE        int            NOT NULL,
    NOMBRE_INTERPRETE    varchar(50)    NOT NULL,
    IDENTIFICADOR        int            NOT NULL,
    CONSTRAINT INTERPRETE_PK PRIMARY KEY NONCLUSTERED (ID_INTERPRETE)
)
go



/* 
 * TABLE: PELICULA 
 */

CREATE TABLE Content.PELICULA(
    IDENTIFICADOR    int            NOT NULL,
    IMDB             varchar(10)    NOT NULL,
    CONSTRAINT PELICULA_PK PRIMARY KEY NONCLUSTERED (IDENTIFICADOR)
)
go



/* 
 * TABLE: SALA 
 */

CREATE TABLE Administrator.SALA(
    ID_SALA            int            NOT NULL,
    TIPO_SOPORTE       varchar(15)    NOT NULL,
    HORA_APERTURA      time(7)        NOT NULL,
    CAPACIDAD          int            NOT NULL,
    NOMBRE             varchar(50)    NOT NULL,
    TIEMPO_DESCANSO    int            NOT NULL,
    IDENTIFICADOR_CINE      int            NOT NULL,
	TIPO_DE_SALA       varchar(15)    NOT NULL DEFAULT 'Normal',
    CONSTRAINT SALA_PK PRIMARY KEY NONCLUSTERED (ID_SALA),
    CONSTRAINT CHK_TIPO_SOPORTE CHECK (TIPO_SOPORTE IN ('Digital', '3D')),
	CONSTRAINT CHK_CAPACIDAD CHECK (CAPACIDAD BETWEEN 10 AND 1000),
	CONSTRAINT CHK_TIEMPO_DESCANSO CHECK (TIEMPO_DESCANSO BETWEEN 5 AND 30),
	CONSTRAINT CHK_TIPO_DE_SALA CHECK (TIPO_DE_SALA IN ('Normal', '2D', '3D', '4D', 'IMAX', 'VIP', 'Junior'))
)
go




/* 
 * TABLE: USUARIO 
 */

CREATE TABLE UserManagment.USUARIO(
    Id_Usuario           varchar(10)    NOT NULL,
    Perfil_Usuario               varchar(50)    NOT NULL,
    F_Nacimiento                 date		    NOT NULL,
    Domicilio                    varchar(255)    NOT NULL,
    Nombre                       varchar(20)    NOT NULL,
    A_Paterno                    varchar(10)    NOT NULL,
    A_Materno                    varchar(10)    NOT NULL,
    [Gestor_Eventos]       bit            NOT NULL,
    [Gestor_Cartelera]     bit            NOT NULL,
    [Gestor_Salas]        bit            NOT NULL,
    [Programa_Contenido]  bit            NOT NULL,
    CONSTRAINT USUARIO_PK PRIMARY KEY NONCLUSTERED (Id_Usuario),
	CONSTRAINT CHK_Nombre_NoVacio CHECK (Nombre <> '')
)
go

/* 
 * TABLE: VISTA 
 */

CREATE TABLE Content.VISTA(
    id_Vista         int            NOT NULL,
    Vista_Total      int            NOT NULL,
    Fecha            date           NOT NULL,
    IDENTIFICADOR_EVENTO    int            NOT NULL,
    CONSTRAINT VISTA_PK PRIMARY KEY NONCLUSTERED (id_Vista)
)
go


/* 
 * TABLE: CONTENIDO 
 */

ALTER TABLE Content.CONTENIDO ADD CONSTRAINT CONTENIDO_GENERO_FK 
    FOREIGN KEY (ID_GENERO)
    REFERENCES Content.GENERO(ID_GENERO)
go


/* 
 * TABLE: CULTURAL 
 */

ALTER TABLE Content.CULTURAL ADD CONSTRAINT CULTURAL_DIRECTO_FK 
    FOREIGN KEY (IDENTIFICADOR)
    REFERENCES Content.DIRECTO(IDENTIFICADOR)
go


/* 
 * TABLE: DEPORTIVO 
 */

ALTER TABLE Content.DEPORTIVO ADD CONSTRAINT DEPORTIVO_DIRECTO_FK 
    FOREIGN KEY (IDENTIFICADOR)
    REFERENCES Content.DIRECTO(IDENTIFICADOR)
go


/* 
 * TABLE: DIRECTO 
 */

ALTER TABLE Content.DIRECTO ADD CONSTRAINT DIRECTO_CONTENIDO_FK 
    FOREIGN KEY (IDENTIFICADOR)
    REFERENCES Content.CONTENIDO(IDENTIFICADOR)
go


/* 
 * TABLE: EVENTO 
 */


ALTER TABLE Content.EVENTO ADD CONSTRAINT EVENTO_EXHIBE_FK
    FOREIGN KEY (ID_SALA, IDENTIFICADOR_EXHIBE)
    REFERENCES Content.EXHIBE(ID_SALA, IDENTIFICADOR);



/* 
 * TABLE: EXHIBE 
 */

ALTER TABLE Content.EXHIBE ADD CONSTRAINT EXHIBE_SALA_FK
    FOREIGN KEY (ID_SALA)
    REFERENCES Administrator.SALA(ID_SALA)
go

ALTER TABLE Content.EXHIBE ADD CONSTRAINT EXHIBE_CONTENIDO_FK 
    FOREIGN KEY (IDENTIFICADOR)
    REFERENCES Content.CONTENIDO(IDENTIFICADOR)
go


/* 
 * TABLE: IDIOMA 
 */

ALTER TABLE Content.IDIOMA ADD CONSTRAINT IDIOMA_PELICULA_FK 
    FOREIGN KEY (IDENTIFICADOR)
    REFERENCES Content.PELICULA(IDENTIFICADOR)
go


/* 
 * TABLE: INGRESO 
 */

ALTER TABLE Administrator.INGRESO ADD CONSTRAINT INGRESO_CINE_FK 
    FOREIGN KEY (IDENTIFICADOR_CINE)
    REFERENCES Administrator.CINE(IDENTIFICADOR_CINE)
go


/* 
 * TABLE: INTERPRETE 
 */

ALTER TABLE Content.INTERPRETE ADD CONSTRAINT INTERPRETE_CULTURAL_FK 
    FOREIGN KEY (IDENTIFICADOR)
    REFERENCES Content.CULTURAL(IDENTIFICADOR)
go


/* 
 * TABLE: PELICULA 
 */

ALTER TABLE Content.PELICULA ADD CONSTRAINT PELICULA_CONTENIDO_FK 
    FOREIGN KEY (IDENTIFICADOR)
    REFERENCES Content.CONTENIDO(IDENTIFICADOR)
go


/* 
 * TABLE: SALA 
 */

ALTER TABLE Administrator.SALA ADD CONSTRAINT SALA_CINE_FK 
    FOREIGN KEY (IDENTIFICADOR_CINE)
    REFERENCES Administrator.CINE(IDENTIFICADOR_CINE)
go


/* 
 * TABLE: VISTA 
 */

ALTER TABLE Content.VISTA ADD CONSTRAINT VISTA_EVENTO_FK 
    FOREIGN KEY (IDENTIFICADOR_EVENTO)
    REFERENCES Content.EVENTO(IDENTIFICADOR_EVENTO)
go


-- INDICES
/*
Este índice es apropiado como non-clustered por varias razones:
- La tabla probablemente tiene un índice clustered en la columna IDENTIFICADOR, que es la clave primaria.
- Un índice non-clustered en AÑO y DISTRIBUIDORA mejorará el rendimiento de consultas que filtran o realizan 
  búsquedas por estos atributos sin alterar el orden físico de almacenamiento de toda la tabla.
*/
CREATE INDEX IDX_CONTENIDO_ANO_DISTRIBUIDORA ON Content.CONTENIDO(AÑO, DISTRIBUIDORA);
/*
Este índice podría ser tanto clustered como non-clustered dependiendo de los usos específicos, pero aquí se recomienda non-clustered:
- Si el índice primario ya es clustered en IDENTIFICADOR_EVENTO, entonces un índice non-clustered en FECHA_HORA_INICIO
  es ideal para soportar consultas por fecha sin reordenar toda la tabla.
- Un índice non-clustered proporciona acceso rápido a las fechas de los eventos para operaciones de búsqueda y filtrado,
  que son comunes en la gestión de eventos.
- Mantener este índice como non-clustered nos permitirá múltiples índices secundarios eficientes junto al índice primario clustered.
*/
CREATE INDEX IDX_EVENTO_FECHA_HORA_INICIO ON Content.EVENTO(FECHA_HORA_INICIO);
/*
Este índice es un buen candidato para ser clustered por las siguientes razones:
- Un índice clustered en MES e IDENTIFICADOR_CINE reorganiza físicamente los datos en la tabla
  según estos atributos, lo que es óptimo para operaciones de agregación y reportes mensuales de ingresos por cine.
- Este ordenamiento facilita operaciones como sumas, promedios y otras agregaciones en rangos de fechas y cines específicos,
  haciendo las consultas más rápidas y eficientes en comparación con un índice non-clustered.
*/
CREATE INDEX IDX_INGRESO_MES_CINE ON Administrator.INGRESO(MES, IDENTIFICADOR_CINE);
