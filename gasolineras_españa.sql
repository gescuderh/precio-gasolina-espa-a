-- Creamos la database donde vamos alojar el archivo csv que vamos a importar
CREATE DATABASE gasolineras;

-- Seleccionamos la tabla ya creada
USE gasolineras;

-- Cargamos el archivo csv.

-- Mostramos el contenido de la tabla creada
SELECT * FROM lista_gasolineras;

-- Eliminamos las columnas que no vamos a utilizar
ALTER TABLE lista_gasolineras DROP COLUMN website;
ALTER TABLE lista_gasolineras DROP COLUMN url;
ALTER TABLE lista_gasolineras DROP COLUMN latitude;
ALTER TABLE lista_gasolineras DROP COLUMN longitude;
ALTER TABLE lista_gasolineras DROP COLUMN country;
ALTER TABLE lista_gasolineras DROP COLUMN road_margin;

-- Eliminamos las filas que no nos interesan (aquellas cuyas estaciones no son abiertas al público sales_type = R y sales_type = A)
DELETE FROM lista_gasolineras
WHERE sales_type IN ('A','R');

-- Eliminamos las filas que no nos interesan (aquellas cuyo precio fuel_price sea menor a 700 ya que son datos de precio no válidos)
DELETE FROM lista_gasolineras
WHERE fuel_price < 700;

-- RESPUESTA A LAS PREGUNTAS
-- ¿Cuál es la provincia con más gasolineras?
SELECT TOP 1 province, count(company) as cantidad_gasolineras
FROM lista_gasolineras
GROUP BY province
ORDER BY cantidad_gasolineras DESC;

-- ¿Cúal es la provincia con menos gasolineras?
SELECT TOP 1 province, count(company) as cantidad_gasolineras
FROM lista_gasolineras
GROUP BY province
ORDER BY cantidad_gasolineras ASC;

-- Lista de provincias con su número de gasolineras (Ordenar de mayor a menor número de gasolineras)
SELECT province, count(company) as cantidad_gasolineras
FROM lista_gasolineras
GROUP BY province
ORDER BY cantidad_gasolineras DESC;

-- ¿Qué compañía tiene más gasolineras?
SELECT TOP 1 company, count(company) as cantidad
FROM lista_gasolineras
GROUP BY company
ORDER BY cantidad DESC;

-- ¿Dónde se encuentra la gasolinera con el precio más alto de gasolina 95? 
SELECT TOP 1 province, city, address, fuel_price as precio
FROM lista_gasolineras
WHERE fuel_type = 'SP95'
ORDER BY fuel_price DESC;

-- ¿Dónde se encuentra la gasolinera con el precio más bajo de gasolina 95?
SELECT TOP 1 province, city, address, fuel_price as precio
FROM lista_gasolineras
WHERE fuel_type = 'SP95'
ORDER BY fuel_price ASC;

-- Dame un listado de los diferentes tipos de combustibles que se comercializan.
SELECT DISTINCT fuel_type
FROM lista_gasolineras;

-- ¿Cuántos tipos de combustible se comercializan al público?
SELECT count(DISTINCT fuel_type) as cantidad_combustibles
FROM lista_gasolineras;

-- ¿Cuál es el tipo de combustible que menos se comercializa en las gasolineras?
SELECT TOP 1 fuel_type, count(*) as cantidad
FROM lista_gasolineras
GROUP BY fuel_type
ORDER BY cantidad ASC;

-- ¿Número de gasolineras por tipo de combustible? (Ordenar de mayor a menor cantidad de gasolineras)
SELECT DISTINCT fuel_type, count(*) as cantidad_gasolineras
FROM lista_gasolineras
GROUP BY fuel_type
ORDER BY cantidad_gasolineras DESC;

-- ¿Cuántas gasolineras están abiertas 24h?
SELECT count(*) as gasolineras_24h
FROM lista_gasolineras
WHERE schedule LIKE '%24H%';

-- ¿Cuál es el precio medio por tipo de combustible? (Ordenar de mayor a menor precio promedio)
SELECT fuel_type, ROUND(avg(fuel_price),0) as precio_promedio
FROM lista_gasolineras
GROUP BY fuel_type
ORDER BY precio_promedio DESC;