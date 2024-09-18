
/*
 * Company :      FI-UNAM
 * Project :      cargaInicial
 * Author :       
 * CRUZ MALDONADO ARMANDO
 * LÓPEZ REYES ALAM
 * MARTÍNEZ PÉREZ BRIAN ERIK

 *
 * Date Created : Wednesday, May 29, 2024 18:51:29
 * Target DBMS : Microsoft SQL Server 2008
 */
-- Carga inicial para cada tabla, se inicia con usuarios



USE proyectoFinalCine; --O como se haya nombrado
GO
begin tran
INSERT INTO UserManagment.USUARIO (Id_Usuario, Perfil_Usuario, F_Nacimiento, Domicilio, Nombre, A_Paterno, A_Materno, [Gestor_Eventos], [Gestor_Cartelera], [Gestor_Salas], [Programa_Contenido])
VALUES
('User1', 'Administrador General', '1980-01-01', '123 Calle Principal, Ciudad', 'Juan', 'Pérez', 'García', 1, 1, 1, 1),
('User2', 'Gestor de Cines', '1990-02-02', '456 Calle Secundaria, Ciudad', 'Ana', 'López', 'Martínez', 0, 0, 1, 0),
('User3', 'Gestor de Salas', '1985-03-03', '789 Calle Terciaria, Ciudad', 'Luis', 'Torres', 'Hernández', 0, 0, 1, 0),
('User4', 'Gestor de Contenidos', '1992-04-04', '159 Calle Cuarta, Ciudad', 'María', 'Ruiz', 'Díaz', 1, 1, 0, 1),
('User5', 'Coordinador de Eventos', '1983-05-05', '753 Calle Quinta, Ciudad', 'Carlos', 'Navarro', 'Molina', 1, 1, 0, 0),
('User6', 'Asistente de Cartelera', '1995-06-06', '357 Calle Sexta, Ciudad', 'Sofía', 'Mendez', 'Prieto', 0, 1, 0, 0),
('User7', 'Analista de Contenido', '1988-07-07', '951 Calle Séptima, Ciudad', 'Roberto', 'Blanco', 'Casas', 0, 0, 0, 1),
('User8', 'Supervisor de Salas', '1979-08-08', '123 Calle Octava, Ciudad', 'Elena', 'Santos', 'Gómez', 0, 0, 1, 0),
('User9', 'Director Técnico', '1991-09-09', '654 Calle Novena, Ciudad', 'Tomás', 'Reyes', 'Lozano', 1, 0, 0, 1),
('User10', 'Administrador de Sistema', '1986-10-10', '321 Calle Décima, Ciudad', 'Irene', 'García', 'Fernández', 0, 0, 0, 0);
GO

select * from UserManagment.USUARIO
commit tran 

--INSERTANDO 10 CINES
begin tran
-- Insertar detalles de 10 cines en la tabla CINE y sus ingresos
INSERT INTO Administrator.CINE (IDENTIFICADOR_CINE, LOGO_CORPORATIVO, LATITUD, LONGITUD, TELEFONO, DIRECCION, NOMBRE, CODIGO_IDENTIFICACION_FISCAL)
VALUES
(1, 0x, 19.432608, -99.133209, '5555555555', 'Calle Uno 123', 'Cine Plaza', 'CIF001'),
(2, 0x, 19.434334, -99.141266, '5555555556', 'Calle Dos 456', 'Cine Sol', 'CIF002'),
(3, 0x, 19.436778, -99.142450, '5555555557', 'Calle Tres 789', 'Cine Luna', 'CIF003'),
(4, 0x, 19.438556, -99.137845, '5555555558', 'Calle Cuatro 101', 'Cine Estrella', 'CIF004'),
(5, 0x, 19.440789, -99.138916, '5555555559', 'Calle Cinco 202', 'Cine Cometa', 'CIF005'),
(6, 0x, 19.442345, -99.139987, '5555555560', 'Calle Seis 303', 'Cine Eclipse', 'CIF006'),
(7, 0x, 19.444556, -99.140356, '5555555561', 'Calle Siete 404', 'Cine Galaxia', 'CIF007'),
(8, 0x, 19.446778, -99.141425, '5555555562', 'Calle Ocho 505', 'Cine Cosmos', 'CIF008'),
(9, 0x, 19.448999, -99.142494, '5555555563', 'Calle Nueve 606', 'Cine Orion', 'CIF009'),
(10, 0x, 19.451220, -99.143563, '5555555564', 'Calle Diez 707', 'Cine Meteor', 'CIF010');
GO

-- Insertar registros de ingresos para varios cines
INSERT INTO Administrator.INGRESO (ID_INGRESO, INGRESO_MENSUAL, MES, IDENTIFICADOR_CINE)
VALUES
(1, 100000, '2024-01-01', 1),
(2, 150000, '2024-01-01', 2),
(3, 120000, '2024-01-01', 3),
(4, 130000, '2024-02-01', 1),
(5, 160000, '2024-02-01', 2),
(6, 140000, '2024-02-01', 3),
(7, 110000, '2024-03-01', 1),
(8, 170000, '2024-03-01', 2),
(9, 115000, '2024-03-01', 3),
(10, 125000, '2024-03-01', 4),
(11, 135000, '2024-04-01', 1),
(12, 145000, '2024-04-01', 2),
(13, 155000, '2024-04-01', 3),
(14, 165000, '2024-04-01', 4),
(15, 175000, '2024-04-01', 5);
GO

select * from Administrator.CINE
select * from Administrator.INGRESO


commit tran


BEGIN TRANSACTION;

-- Insertar salas en diferentes cines con variedad de tipos de sala
INSERT INTO Administrator.SALA (ID_SALA, TIPO_SOPORTE, HORA_APERTURA, CAPACIDAD, NOMBRE, TIEMPO_DESCANSO, IDENTIFICADOR_CINE, TIPO_DE_SALA)
VALUES
-- Salas para el cine con IDENTIFICADOR 1
(1, 'Digital', '10:00:00', 100, 'Sala 1', 15, 1, 'Normal'),
(2, '3D', '10:00:00', 150, 'Sala 2', 15, 1, '3D'),
-- Salas para el cine con IDENTIFICADOR 2
(3, 'Digital', '11:00:00', 200, 'Sala 1', 20, 2, '2D'),
(4, '3D', '11:00:00', 120, 'Sala 2', 20, 2, '4D'),
-- Salas para el cine con IDENTIFICADOR 3
(5, 'Digital', '12:00:00', 300, 'Sala 1', 10, 3, 'IMAX'),
(6, '3D', '12:00:00', 180, 'Sala 2', 10, 3, 'VIP'),
-- Resto
(7, 'Digital', '10:30:00', 250, 'Sala 3', 12, 1, 'Junior'),
(8, '3D', '10:30:00', 220, 'Sala 4', 12, 2, 'Normal'),
(9, 'Digital', '09:00:00', 110, 'Sala 3', 15, 3, '2D'),
(10, '3D', '09:00:00', 130, 'Sala 4', 15, 1, '3D');

COMMIT TRANSACTION;



--INSERTANDO LAS 15 PELICULAS Y CONTENIDO EN DIRECTO
begin tran
-- Insertar géneros comunes en la tabla GENERO
INSERT INTO Content.GENERO (ID_GENERO, TIPO_GENERO)
VALUES
(1, 'Drama'),
(2, 'Crimen'),
(3, 'Acción'),
(4, 'Ciencia Ficción'),
(5, 'Romance'),
(6, 'Aventura'),
(7, 'Terror'),
(8, 'Comedia'),
(9, 'Documental'),
(10, 'Musical'),
(11, 'Deportivo');
GO


-- Insertar contenido para 15 películas y contenido en directo
INSERT INTO Content.CONTENIDO 
(IDENTIFICADOR, AÑO, VERSION, FORMATO, TITULO, DISTRIBUIDORA, DIRECTOR, EDAD_RECOMENDADA, PAIS_PRODUCCION, TRAILER, DECRIPCION, WEB_OFICIAL, ES_DIRECTO, DURACION, FECHA_EMISION, CARTEL_ANUNCIADOR, TIPO_CONTENIDO, ID_GENERO)
VALUES
(1, 1994, 'Digital', 'Película', 'The Shawshank Redemption', 'Columbia Pictures', 'Frank Darabont', 16, 'USA', 0x, 'Two imprisoned men bond over a number of years...', 'http://shawshank.com', 0, 142, '1994-10-14', 0x, 'Drama', 1),
(2, 1972, 'Digital', 'Película', 'The Godfather', 'Paramount Pictures', 'Francis Ford Coppola', 18, 'USA', 0x, 'The aging patriarch of an organized crime dynasty transfers control...', 'http://godfather.com', 0, 175, '1972-03-24', 0x, 'Crimen', 2),
(3, 1980, 'Digital', 'Película', 'Star Wars: Episode V - The Empire Strikes Back', '20th Century Fox', 'Irvin Kershner', 12, 'USA', 0x, 'The Rebels scatter after the Empire attacks their base...', 'http://starwars.com', 0, 124, '1980-05-21', 0x, 'Ciencia Ficción', 4),
(4, 1993, 'Digital', 'Película', 'Jurassic Park', 'Universal Pictures', 'Steven Spielberg', 13, 'USA', 0x, 'During a preview tour, a theme park suffers a major power breakdown...', 'http://jurassicpark.com', 0, 127, '1993-06-11', 0x, 'Aventura', 6),
(5, 1999, 'Digital', 'Película', 'The Matrix', 'Warner Bros', 'Lana Wachowski, Lilly Wachowski', 15, 'USA', 0x, 'A computer hacker learns from mysterious rebels about the true nature...', 'http://matrix.com', 0, 136, '1999-03-31', 0x, 'Ciencia Ficción', 4),
(6, 2008, 'Digital', 'Película', 'The Dark Knight', 'Warner Bros', 'Christopher Nolan', 15, 'USA', 0x, 'When the menace known as the Joker wreaks havoc...', 'http://thedarkknight.com', 0, 152, '2008-07-18', 0x, 'Acción', 3),
(7, 2010, 'Digital', 'Película', 'Inception', 'Warner Bros', 'Christopher Nolan', 13, 'USA', 0x, 'A thief who steals corporate secrets through the use of dream-sharing technology...', 'http://inception.com', 0, 148, '2010-07-16', 0x, 'Ciencia Ficción', 4),
(8, 1997, 'Digital', 'Película', 'Titanic', 'Paramount Pictures', 'James Cameron', 12, 'USA', 0x, 'A seventeen-year-old aristocrat falls in love with a kind but poor artist...', 'http://titanic.com', 0, 195, '1997-12-19', 0x, 'Romance', 5),
(9, 1994, 'Digital', 'Película', 'Pulp Fiction', 'Miramax Films', 'Quentin Tarantino', 18, 'USA', 0x, 'The lives of two mob hitmen, a boxer, a gangster and his wife, and a pair of diner bandits...', 'http://pulpfiction.com', 0, 154, '1994-10-14', 0x, 'Crimen', 2),
(10, 2001, 'Digital', 'Película', 'The Lord of the Rings: The Fellowship of the Ring', 'New Line Cinema', 'Peter Jackson', 12, 'New Zealand', 0x, 'A meek Hobbit from the Shire and eight companions set out on a journey...', 'http://lordoftherings.net', 0, 178, '2001-12-19', 0x, 'Aventura', 6),
(11, 2003, 'Digital', 'Película', 'The Lord of the Rings: The Return of the King', 'New Line Cinema', 'Peter Jackson', 12, 'New Zealand', 0x, 'Gandalf and Aragorn lead the World of Men against Saurons army ...', 'http://lordoftherings.net', 0, 201, '2003-12-17', 0x, 'Aventura', 6),
(12, 1997, 'Digital', 'Película', 'Life Is Beautiful', 'Miramax Films', 'Roberto Benigni', 12, 'Italy', 0x, 'When an open-minded Jewish librarian and his son become victims of the Holocaust...', 'http://lifeisbeautiful.com', 0, 116, '1997-12-20', 0x, 'Drama', 1),
(13, 1995, 'Digital', 'Película', 'Se7en', 'New Line Cinema', 'David Fincher', 18, 'USA', 0x, 'Two detectives, a rookie and a veteran, hunt a serial killer who uses the seven deadly sins...', 'http://se7en.com', 0, 127, '1995-09-22', 0x, 'Crimen', 2),
(14, 2000, 'Digital', 'Película', 'Gladiator', 'DreamWorks', 'Ridley Scott', 15, 'USA', 0x, 'A former Roman General sets out to exact vengeance against the corrupt emperor...', 'http://gladiator.com', 0, 155, '2000-05-05', 0x, 'Acción', 3),
(15, 2019, 'Digital', 'Película', 'Parasite', 'CJ Entertainment', 'Bong Joon Ho', 15, 'South Korea', 0x, 'Greed and class discrimination threaten the newly formed symbiotic relationship...', 'http://parasite.com', 0, 132, '2019-05-30', 0x, 'Drama', 1),
(16, 2022, 'Digital', 'Directo', 'Live Concert of Coldplay', 'Live Nation', 'Director N/A', 0, 'UK', 0x, 'Live performance by Coldplay streamed globally.', 'http://livecoldplay.com', 1, 120, '2022-12-01', 0x, 'Concierto', 10),
(17, 2022, 'Digital', 'Directo', 'World Chess Championship', 'Chess.com', 'Director N/A', 0, 'USA', 0x, 'The annual world chess championship featuring top players.', 'http://chess.com', 1, 180, '2022-12-05', 0x, 'Deportivo', 11),
(18, 2022, 'Digital', 'Directo', 'Live Theatre: Hamlet', 'Shakespeare Theatre', 'Director N/A', 12, 'UK', 0x, 'Live performance of Hamlet from the Royal Shakespeare Theatre.', 'http://rsc.com', 1, 150, '2022-12-10', 0x, 'Teatro', 10),
(19, 2022, 'Digital', 'Directo', 'NBA Finals Game 7', 'ESPN', 'Director N/A', 0, 'USA', 0x, 'The final game of the NBA season live.', 'http://nba.com', 1, 120, '2022-06-15', 0x, 'Deportivo', 11),
(20, 2022, 'Digital', 'Directo', 'Met Opera Live: La Traviata', 'Metropolitan Opera', 'Director N/A', 12, 'USA', 0x, 'Live opera performance streamed from the Met.', 'http://metopera.com', 1, 180, '2022-12-20', 0x, 'Ópera', 10);
GO

-- Insertar registros en la tabla PELICULA
INSERT INTO Content.PELICULA (IDENTIFICADOR, IMDB)
VALUES
(1, 'tt0111161'),
(2, 'tt0068646'),
(3, 'tt0080684'),
(4, 'tt0107290'),
(5, 'tt0133093'),
(6, 'tt0468569'),
(7, 'tt1375666'),
(8, 'tt0120338'),
(9, 'tt0110912'),
(10, 'tt0120737'),
(11, 'tt0167260'),
(12, 'tt0118799'),
(13, 'tt0114369'),
(14, 'tt0172495'),
(15, 'tt6751668');
GO

-- Insertar idiomas para las películas
INSERT INTO Content.IDIOMA (ID_IDIOMA, IDIOMA, IDENTIFICADOR)
VALUES
(1, 'Inglés', 1),
(2, 'Inglés', 2),
(3, 'Inglés', 3),
(4, 'Inglés', 4),
(5, 'Inglés', 5),
(6, 'Inglés', 6),
(7, 'Inglés', 7),
(8, 'Inglés', 8),
(9, 'Inglés', 9),
(10, 'Inglés', 10),
(11, 'Inglés', 11),
(12, 'Inglés', 12),
(13, 'Inglés', 13),
(14, 'Inglés', 14),
(15, 'Inglés', 15);
GO

-- AHORA para el contenido en directo
-- Insertar registros en la tabla DIRECTO
INSERT INTO Content.DIRECTO (IDENTIFICADOR, TIPO_DIRECTO)
VALUES
(16, 'Concierto'),
(17, 'Deporte'),
(18, 'Teatro'),
(19, 'Deporte'),
(20, 'Ópera');
GO

-- Insertar registros en la tabla CULTURAL
INSERT INTO Content.CULTURAL (IDENTIFICADOR, NOMBRE_COMPOSITOR, LUGAR_EMISION)
VALUES
(16, 'Coldplay', 'London, UK'),
(18, 'William Shakespeare', 'Stratford-upon-Avon, UK'),
(20, 'Giuseppe Verdi', 'New York, USA');
GO

-- Insertar registros en la tabla DEPORTIVO
INSERT INTO Content.DEPORTIVO (IDENTIFICADOR, LUGAR_ORIGEN, DEPORTE_EXHIBIDO)
VALUES
(17, 'Las Vegas, USA', 'Chess'),
(19, 'Los Angeles, USA', 'Basketball');
GO

-- Insertar registros en la tabla INTERPRETE
INSERT INTO Content.INTERPRETE (ID_INTERPRETE, NOMBRE_INTERPRETE, IDENTIFICADOR)
VALUES
(1, 'Chris Martin', 16),
(2, 'Benedict Cumberbatch', 18),
(3, 'Diana Damrau', 20);
GO


select * from Content.CONTENIDO
select * from Content.IDIOMA
select * from Content.PELICULA
select * from Content.DIRECTO
select * from Content.CULTURAL
select * from Content.DEPORTIVO
select * from Content.INTERPRETE



commit tran


-- Asociar salas con contenidos para las funciones
INSERT INTO Content.EXHIBE (ID_SALA, IDENTIFICADOR)
VALUES
(1, 1),  -- Sala 1 exhibe "The Shawshank Redemption"
(2, 2),  -- Sala 2 exhibe "The Godfather"
(3, 3),  -- Sala 3 exhibe "Star Wars: Episode V - The Empire Strikes Back"
(4, 4),  -- Sala 4 exhibe "Jurassic Park"
(5, 5),  -- Sala 5 exhibe "The Matrix"
(6, 6),  -- Sala 6 exhibe "The Dark Knight"
(7, 7),  -- Sala 7 exhibe "Inception"
(8, 8),  -- Sala 8 exhibe "Titanic"
(9, 9),  -- Sala 9 exhibe "Pulp Fiction"
(10, 10), -- Eventos DIRECTOS
(1, 16),
(2, 17),
(3, 18),
(4, 19),
(5, 20);
GO


-- Insertar eventos en la tabla Content.EVENTO con diferentes usuarios programando
begin tran

INSERT INTO Content.EVENTO (IDENTIFICADOR_EVENTO, QUIEN_PROGRAMA, CONTENIDO_PROGRAMADO, FECHA_HORA_INICIO, ID_SALA, IDENTIFICADOR_EXHIBE, VALIDADO)
VALUES
(1, 'User1', 16, '2023-01-01T10:00:00', 1, 16,1),
(2, 'User2', 17, '2023-01-01T12:00:00', 2, 17,1),
(3, 'User3', 18, '2023-01-01T14:00:00', 3, 18,1),
(4, 'User4', 19, '2023-01-01T16:00:00', 4, 19,1),
(5, 'User5', 20, '2023-01-01T18:00:00', 5, 20,1),
(6, 'User1', 16, '2023-01-02T10:00:00', 1, 16,1),
(7, 'User2', 17, '2023-01-02T12:00:00', 2, 17,1),
(8, 'User3', 18, '2023-01-02T14:00:00', 3, 18,1),
(9, 'User4', 19, '2023-01-02T16:00:00', 4, 19,1),
(10, 'User5', 20, '2023-01-02T18:00:00', 5, 20,1),
-- Continuar para los próximos días
(11, 'User1', 16, '2023-01-03T10:00:00', 1, 16,1),
(12, 'User2', 17, '2023-01-03T12:00:00', 2, 17,1),
(13, 'User3', 18, '2023-01-03T14:00:00', 3, 18,1),
(14, 'User4', 19, '2023-01-03T16:00:00', 4, 19,1),
(15, 'User5', 20, '2023-01-03T18:00:00', 5, 20,1),
(16, 'User1', 16, '2023-01-04T10:00:00', 1, 16,1),
(17, 'User2', 17, '2023-01-04T12:00:00', 2, 17,1),
(18, 'User3', 18, '2023-01-04T14:00:00', 3, 18,1),
(19, 'User4', 19, '2023-01-04T16:00:00', 4, 19,1),
(20, 'User5', 20, '2023-01-04T18:00:00', 5, 20,1),
(21, 'User1', 1, '2023-06-01T10:00:00', 1, 1, 1),
(22, 'User2', 2, '2023-06-01T12:00:00', 2, 2, 1),
(23, 'User3', 3, '2023-06-01T14:00:00', 3, 3, 1),
(24, 'User4', 4, '2023-06-01T16:00:00', 4, 4, 1),
(25, 'User5', 5, '2023-06-01T18:00:00', 5, 5, 1),
(26, 'User1', 6, '2023-06-02T10:00:00', 6, 6, 1),
(27, 'User2', 7, '2023-06-02T12:00:00', 7, 7, 1),
(28, 'User3', 8, '2023-06-02T14:00:00', 8, 8, 1),
(29, 'User4', 9, '2023-06-02T16:00:00', 9, 9, 1),
(30, 'User5', 10, '2023-06-02T18:00:00', 10, 10, 1);
GO
commit tran

--Para registrar 20 fechas de entradas con su monto, insertamos datos directamente.


-- Registrar vistas para los eventos
begin tran
INSERT INTO Content.VISTA (id_Vista, Vista_Total, Fecha, IDENTIFICADOR_EVENTO)
VALUES
(1, 5000, '2023-01-01', 1),
(2, 4500, '2023-01-01', 2),
(3, 4700, '2023-01-01', 3),
(4, 4800, '2023-01-01', 4),
(5, 5000, '2023-01-01', 5),
(6, 5200, '2023-01-02', 6),
(7, 5300, '2023-01-02', 7),
(8, 5400, '2023-01-02', 8),
(9, 5500, '2023-01-02', 9),
(10, 5600, '2023-01-02', 10),
(11, 5700, '2023-01-03', 11),
(12, 5800, '2023-01-03', 12),
(13, 5900, '2023-01-03', 13),
(14, 6000, '2023-01-03', 14),
(15, 6100, '2023-01-03', 15),
(16, 6200, '2023-01-04', 16),
(17, 6300, '2023-01-04', 17),
(18, 6400, '2023-01-04', 18),
(19, 6500, '2023-01-04', 19),
(20, 6600, '2023-01-04', 20),
(21, 5100, '2023-06-01', 21),
(22, 5200, '2023-06-01', 22),
(23, 5300, '2023-06-01', 23),
(24, 5400, '2023-06-01', 24),
(25, 5500, '2023-06-01', 25),
(26, 5600, '2023-06-02', 26),
(27, 5700, '2023-06-02', 27),
(28, 5800, '2023-06-02', 28),
(29, 5900, '2023-06-02', 29),
(30, 6000, '2023-06-02', 30);
GO
commit tran



--el resultado de un select a cada tabla de la base de datos, incluyendo un count() a cada una de las tablas.
select * from Administrator.CINE
select count(*) from Administrator.CINE


select * from Administrator.INGRESO
select count(*) from Administrator.INGRESO


select * from Administrator.SALA
select count(*) from Administrator.SALA


select * from Content.CONTENIDO
select count(*) from Content.CONTENIDO


select * from Content.CULTURAL
select count(*) from Content.CULTURAL


select * from Content.DEPORTIVO
select count(*) from Content.DEPORTIVO


select * from Content.DIRECTO
select count(*) from Content.DIRECTO


select * from Content.EVENTO
select count(*) from Content.EVENTO


select * from Content.EXHIBE
select count(*) from Content.EXHIBE


select * from Content.GENERO
select count(*) from Content.GENERO


select * from Content.IDIOMA
select count(*) from Content.IDIOMA



select * from Content.INTERPRETE
select count(*) from Content.INTERPRETE


select * from Content.PELICULA
select count(*) from Content.PELICULA


select * from Content.VISTA
select count(*) from Content.VISTA


select * from UserManagment.USUARIO 
select count(*) from UserManagment.USUARIO