/*Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name).
 Поля from, to и label содержат английские названия городов, поле name — русское.
 Выведите список рейсов flights с русскими названиями городов.*/


DROP DATABASE IF EXISTS flights_schedules;
CREATE DATABASE flights_schedules;
USE flights_schedules;

DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
	`id` SERIAL PRIMARY KEY,
  	`from` VARCHAR(50),
  	`to` VARCHAR(50)
);

INSERT INTO flights VALUES
	(1, 'moscow', 'omsk'),
	(2, 'novgorod', 'kazan'),
	(3, 'irkutsk', 'moscow'),
	(4, 'omsk', 'irkutsk'),
	(5, 'moscow', 'kazan');

DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
  	`label` VARCHAR(50),
  	`name` VARCHAR(50)
);

INSERT INTO cities VALUES
	('moscow', 'Москва'),
	('irkutsk', 'Иркутск'),
	('novgorod', 'Новгород'),
	('kazan', 'Казань'),
	('omsk', 'Омск');

SELECT
	id,
	(SELECT name FROM cities WHERE `label` = `from`) AS `from`,
	(SELECT name FROM cities WHERE `label` = `to`) AS `to`
FROM flights;