USE shop;

/* Практическое задание по теме “Оптимизация запросов”*/
 
/* 1. Создайте таблицу logs типа Archive.
Пусть при каждом создании записи в таблицах users, catalogs и products в таблицу logs помещается время и дата создания записи,
название таблицы, идентификатор первичного ключа и содержимое поля name.*/


DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
	created_at DATETIME NOT NULL,
	table_name VARCHAR(255) NOT NULL,
	id_primary_key BIGINT UNSIGNED NOT NULL,
	name VARCHAR(255) NOT NULL)
ENGINE = Archive;


DELIMITER //


DROP TRIGGER IF EXISTS users_logs //
CREATE TRIGGER users_logs AFTER INSERT ON users
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, id_primary_key, name)
	VALUES (NOW(), 'users', NEW.id, NEW.name);
END //


DROP TRIGGER IF EXISTS catalogs_logs //
CREATE TRIGGER catalogs_logs AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, id_primary_key, name)
	VALUES (NOW(), 'catalogs', NEW.id, NEW.name);
END //


DROP TRIGGER IF EXISTS products_logs //
CREATE TRIGGER products_logs AFTER INSERT ON products
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, id_primary_key, name)
	VALUES (NOW(), 'products', NEW.id, NEW.name);
END //

DELIMITER ;

INSERT INTO users (name, birthday_at)
VALUES ('Artem', '1990-10-22');

INSERT INTO catalogs (name)
VALUES ('Процессоры');

INSERT INTO products (name, description, price, catalog_id)
VALUES ('Intel Core i3-8100', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 7890, 1);

SELECT * FROM logs;



/*Практическое задание по теме “NoSQL”*/

/*1. В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов.*/

/*HMSET ip ip1 100 ip2 5 ip3 0 ip4 1 ip5 50
Создадим хеш, где
ip - ключ хеша,
ip1, ip2, ip3, ip4, ip5... - список ip-адресов, которые мы отслеживаем,
они являются ключами пары "ip-адрес - количество посещений" */


/*2. При помощи базы данных Redis решите задачу поиска имени пользователя по электронному адресу и наоборот,
поиск электронного адреса пользователя по его имени.*/

/*Для поиска имени пользователя по электронному адресу создадим хеш name,
 где ключами являются электронные адреса.
 HMSET name anna.ivanova@gmail.com "Anna" petr.kuznetsov@gmail.com "Petr" elena.petrova@gmail.com "Elena"
 
 И наоборот, для поиска электронного адреса пользователя по его имени создадим хеш email,
 где ключами являются имена пользователей.
 HMSET email Anna "anna.ivanova@gmail.com" Petr "petr.kuznetsov@gmail.com" Elena "elena.petrova@gmail.com"  */


/*3. Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB.*/

/*
 {
 	"url": "https//shop.com",
 	"categories": ["Процессоры", "Материнские платы", "Видеокарты"],
 	"products": [
 	{"name": "Intel Core i3-8100",
 	 "description": "Процессор для настольных персональных компьютеров, основанных на платформе Intel.",
 	 "price": 7890,
 	 "catalog": "Процессоры",
 	 "created_at": 2020-06-10 10:22:54,
 	 "updated_at": 2020-06-10 10:22:54},
 	{"name": "ASUS ROG MAXIMUS X HERO",
 	 "description": "Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX",
 	 "price": 19310,
 	 "catalog": "Материнские платы",
 	 "created_at": 2020-06-10 10:22:54,
 	 "updated_at": 2020-06-10 10:22:54},
 	{"name": "Gigabyte H310M S2H",
 	 "description": "Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX",
 	 "price": 4790,
 	 "catalog": "Материнские платы",
 	 "created_at": 2020-06-10 10:22:54,
 	 "updated_at": 2020-06-10 10:22:54}
 	]
 }
 */

