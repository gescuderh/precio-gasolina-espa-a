-- Paso previo: importamos csv en Excel y sustituimos los "." de fuel_price por "," para que SQL comprenda que es un valor decimal.

-- Creamos la database donde vamos alojar el archivo csv que vamos a importar
CREATE DATABASE gasolineras;

-- Seleccionamos la tabla ya creada
USE gasolineras;

-- Cargamos el archivo csv. Hacemos click en la db, new task e importamos flat file.

-- Mostramos el contenido de la tabla creada
SELECT * FROM lista_gasolineras;

-- Eliminamos las columnas que no vamos a utilizar
ALTER TABLE lista_gasolineras DROP COLUMN website;
ALTER TABLE lista_gasolineras DROP COLUMN url;
ALTER TABLE lista_gasolineras DROP COLUMN latitude;
ALTER TABLE lista_gasolineras DROP COLUMN longitude;
ALTER TABLE lista_gasolineras DROP COLUMN country;
ALTER TABLE lista_gasolineras DROP COLUMN road_margin;

-- Eliminamos las filas que no nos interesan (aquellas cuyas estaciones no son abiertas al p�blico sales_type = R y sales_type = A)
DELETE FROM lista_gasolineras
WHERE sales_type IN ('A','R');

-- Eliminamos las filas que no nos interesan (aquellas cuyo precio fuel_price sea menor a 700 ya que son datos de precio no v�lidos)
DELETE FROM lista_gasolineras
WHERE fuel_price < 700;

-- RESPUESTA A LAS PREGUNTAS
-- �Cu�l es la provincia con m�s gasolineras?
SELECT TOP 1 province, count(company) as cantidad_gasolineras
FROM lista_gasolineras
GROUP BY province
ORDER BY cantidad_gasolineras DESC;

-- �C�al es la provincia con menos gasolineras?
SELECT TOP 1 province, count(company) as cantidad_gasolineras
FROM lista_gasolineras
GROUP BY province
ORDER BY cantidad_gasolineras ASC;

-- Lista de provincias con su n�mero de gasolineras (Ordenar de mayor a menor n�mero de gasolineras)
SELECT province, count(company) as cantidad_gasolineras
FROM lista_gasolineras
GROUP BY province
ORDER BY cantidad_gasolineras DESC;

-- �Qu� compa��a tiene m�s gasolineras?
SELECT TOP 1 company, count(company) as cantidad
FROM lista_gasolineras
GROUP BY company
ORDER BY cantidad DESC;

-- �D�nde se encuentra la gasolinera con el precio m�s alto de gasolina 95? 
SELECT TOP 1 province, city, address, fuel_price as precio
FROM lista_gasolineras
WHERE fuel_type = 'SP95'
ORDER BY fuel_price DESC;

-- �D�nde se encuentra la gasolinera con el precio m�s bajo de gasolina 95?
SELECT TOP 1 province, city, address, fuel_price as precio
FROM lista_gasolineras
WHERE fuel_type = 'SP95'
ORDER BY fuel_price ASC;

-- Dame un listado de los diferentes tipos de combustibles que se comercializan.
SELECT DISTINCT fuel_type
FROM lista_gasolineras;


-- �Cu�ntos tipos de combustible se comercializan al p�blico?
SELECT count(DISTINCT fuel_type) as cantidad_combustibles
FROM lista_gasolineras;

-- �Cu�l es el tipo de combustible que menos se comercializa en las gasolineras?
SELECT TOP 1 fuel_type, count(*) as cantidad
FROM lista_gasolineras
GROUP BY fuel_type
ORDER BY cantidad ASC;

-- �N�mero de gasolineras por tipo de combustible? (Ordenar de mayor a menor cantidad de gasolineras)
SELECT DISTINCT fuel_type, count(*) as cantidad_gasolineras
FROM lista_gasolineras
GROUP BY fuel_type
ORDER BY cantidad_gasolineras DESC;

-- �Cu�ntas gasolineras est�n abiertas 24h?
SELECT count(*) as gasolineras_24h
FROM lista_gasolineras
WHERE schedule LIKE '%24H%';

-- �Cu�l es el precio medio por tipo de combustible? (Ordenar de mayor a menor precio promedio)
SELECT fuel_type, ROUND(avg(fuel_price),0) as precio_promedio
FROM lista_gasolineras
GROUP BY fuel_type
ORDER BY precio_promedio DESC;