
/*Практическое задание по теме “Транзакции, переменные, представления”*/


/* 1. В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных.
Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.*/

START TRANSACTION;
INSERT INTO sample.users (id, name, birthday_at, created_at, updated_at)
SELECT id, name, birthday_at, created_at, updated_at FROM shop_new.users WHERE id = 1;
DELETE FROM shop_new.users WHERE id = 1;
COMMIT;


/* 2. Создайте представление, которое выводит название name товарной позиции из таблицы products и
соответствующее название каталога name из таблицы catalogs.*/

USE shop;
CREATE OR REPLACE VIEW products_catalogs
AS SELECT products.name AS product_name, catalogs.name AS catalog_name FROM products, catalogs
WHERE (products.catalog_id = catalogs.id);

SELECT * FROM prod;



/*Практическое задание по теме “Хранимые процедуры и функции, триггеры"*/


/* 1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток.
С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро",
с 12:00 до 18:00 функция должна возвращать фразу "Добрый день",
с 18:00 до 00:00 — "Добрый вечер",
с 00:00 до 6:00 — "Доброй ночи".*/

DELIMITER // ;

DROP FUNCTION IF EXISTS hello //
CREATE FUNCTION hello()
RETURNS TEXT DETERMINISTIC 
BEGIN
	IF (CURTIME() BETWEEN '06:00:00' AND '11:59:59') THEN
		RETURN "Доброе утро";
	ELSEIF (CURTIME() BETWEEN '12:00:00' AND '17:59:59') THEN
		RETURN "Добрый день";
	ELSEIF (CURTIME() BETWEEN '18:00:00' AND '23:59:59') THEN 
		RETURN "Добрый вечер";
	ELSE
		RETURN "Доброй ночи";
	END IF;
END //

SELECT hello() //


/* 2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием.
 Допустимо присутствие обоих полей или одно из них.
 Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема.
 Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены.
 При попытке присвоить полям NULL-значение необходимо отменить операцию.*/

USE shop//

DROP TRIGGER IF EXISTS check_table_products_update //
CREATE TRIGGER check_table_products_update BEFORE UPDATE ON products
FOR EACH ROW 
BEGIN 
	IF NEW.name IS NULL AND NEW.description IS NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'UPDATE canceled';
	END IF;
END//

UPDATE products SET name = NULL, description = NULL WHERE id = 4 //

DROP TRIGGER IF EXISTS check_table_products_insert //
CREATE TRIGGER check_table_products_insert BEFORE INSERT ON products
FOR EACH ROW 
BEGIN 
	IF NEW.name IS NULL AND NEW.description IS NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INSERT canceled';
	END IF;
END//

INSERT products SET name = NULL, description = NULL //
