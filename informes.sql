/*
 * Company :      FI-UNAM
 * Project :      informes.sql
 * Author :       
 * CRUZ MALDONADO ARMANDO
 * LÓPEZ REYES ALAM
 * MARTÍNEZ PÉREZ BRIAN ERIK
 * Target DBMS : Microsoft SQL Server 2008
 */

/*
d. Elaborar un script para las estadísticas, cuyo nombre debe ser informes.sql (son consultas)

Elaborar 3 o más consultas. Se debe emplear el uso de joins (diferentes tipos de JOINs), funciones
de agregación, algebra relacional y subconsultas
*/

USE proyectoFinalCine;
GO


/*
a) Un informe del monto de entradas por día por cada contenido en cartelera. 
Para ello el área contable asigna un folio consecutivo del 1 al n por cada día que está 
en cartelera un contenido (fecha, monto deentradas vendida). 
Este informe se puede obtener también por cine
*/
select C.*, I.Ingreso_Mensual_Mayor from Administrator.CINE as C
left join ( select IDENTIFICADOR_CINE, max(INGRESO_MENSUAL) as 'Ingreso_Mensual_Mayor' from Administrator.INGRESO
			group by IDENTIFICADOR_CINE ) as I 
on C.IDENTIFICADOR_CINE = I.IDENTIFICADOR_CINE

-- b) Top ten de las películas más vistas en un periodo de tiempo, incluyendo la cantidad monto.
select top 10 
    C.TITULO as Pelicula,
    sum(V.Vista_Total) as Total_Vistas
from 
    Content.VISTA  as V
inner join 
    Content.EVENTO as E on V.IDENTIFICADOR_EVENTO = E.IDENTIFICADOR_EVENTO
inner join 
    Content.EXHIBE as X on E.ID_SALA = X.ID_SALA and E.CONTENIDO_PROGRAMADO = X.IDENTIFICADOR
inner join 
    Content.CONTENIDO as C on X.IDENTIFICADOR = C.IDENTIFICADOR
inner join 
    Content.PELICULA as P on C.IDENTIFICADOR = P.IDENTIFICADOR
where 
    V.Fecha between '2023-01-01' and '2023-06-02'
group by 
    C.TITULO
order by 
    Total_Vistas desc;

--c) Ingresos por cine (todos los cines, nombre y dirección) en una fecha o rango de fechas

select C.NOMBRE, C.DIRECCION, I.INGRESO_MENSUAL, i.MES  from Administrator.CINE as C
inner join Administrator.INGRESO as I
on C.IDENTIFICADOR_CINE = I.IDENTIFICADOR_CINE
where I.MES between '2024-01-01' and '2024-03-01' -- RANGO DE FECHAS VARIABLE


--d) Listado de géneros, numero de vistas ordenados de mayor a menor

select G.TIPO_GENERO, C.Numero_Genero from Content.GENERO as G
inner join (select ID_GENERO, count(ID_GENERO) as 'Numero_Genero' from Content.CONTENIDO -- encontrar los generos dentros de los contenidos 
			group by ID_GENERO) as C 
on G.ID_GENERO = C.ID_GENERO
order by Numero_Genero desc


--e) Listado de los usuarios del sistema, nombre completo, fecha de nacimiento y domicilio
--π_(NOMBRE + A_PATERNO + A_MATERNO, F_Nacimiento, Domicilio)(USUARIO)

select NOMBRE + ' ' + A_PATERNO + ' ' + A_MATERNO as 'Nombre Completo', F_Nacimiento, Domicilio 
from UserManagment.USUARIO

/*
f) Inventario de los cines: nombre, dirección, sala, número de asientos, 
tipo de sala (normal, 2d, 3d, 4d, IMAX, vip, junior)
*/
--π_CINE.NOMBRE, CINE.DIRECCION, SALA.NOMBRE, SALA.CAPACIDAD, SALA.TIPO_DE_SAL (CINE ⨝(CINE.IDENTIFICADOR_CINE = SALA.IDENTIFICADOR_CINE) SALA) 

select C.NOMBRE as 'Nombre Cine', C.DIRECCION, S.NOMBRE as 'Nombre Sala', S.CAPACIDAD as 'número de asientos', S.TIPO_DE_SALA from Administrator.CINE as C
inner join Administrator.SALA as S
on C.IDENTIFICADOR_CINE = S.IDENTIFICADOR_CINE






