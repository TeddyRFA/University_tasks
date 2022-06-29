/* Создаём таблицу и даем ей название. Также, настраиваем кодировку */
CREATE DATABASE `TED15` COLLATE=`utf8_unicode_ci`; USE `TED15`;
/* Прописываем оператор DROP TABLE, удаляющий одну или несколько таблиц */
DROP TABLE IF EXISTS `Кол-во продуктов`; DROP TABLE IF EXISTS `Продукт`;
DROP TABLE IF EXISTS `Блюдо`;
/* Создаём первую таблицу с помощью оператора “create table”. Как правило, в данном случае следует начинать с независимой таблицы */
CREATE TABLE `Блюдо`(
/* Указываем для рецептов целое непустое значение */
`№ рецепта` INT NOT NULL,
/* Указываем для названии блюд строковое непустое значение */
`Название блюда` VARCHAR(16) NOT NULL,
/* Указываем первичный ключ таблицы */
PRIMARY KEY (`№ рецепта`)
);
CREATE TABLE `Продукт`(
`Номенклатурный № продукта` INT NOT NULL,
`Наименование продукта` VARCHAR(14) NOT NULL,
`Единицы измерения` CHAR(6) NOT NULL, PRIMARY KEY(`Номенклатурный № продукта`)
);
CREATE TABLE `Кол-во продуктов` (
`№ рецепта` INT NOT NULL,
`Номенклатурный № продукта` INT NOT NULL,
`Кол-во` FLOAT NOT NULL,
PRIMARY KEY(`№ рецепта`,`Номенклатурный № продукта`),
/* Cоздаем внешние ключи и связываем таблицы */
CONSTRAINT `FK_кол-во_продукт` FOREIGN KEY (`Номенклатурный № продукта`) REFERENCES `Продукт` (`Номенклатурный № продукта`) ON DELETE NO ACTION ON UPDATE CASCADE,
CONSTRAINT `FK_кол-во_блюдо` FOREIGN KEY (`№ рецепта`) REFERENCES
`Блюдо` (`№ рецепта`) ON DELETE NO ACTION ON UPDATE CASCADE
);
/* Заполняем данными таблицы, используя оператор “insert into” */
INSERT	INTO	`Продукт`(`Номенклатурный	№	продукта`,`Наименование продукта`,`Единицы измерения`) VALUES
(100,'Мидии','кг'),
(101,'Лук','кг'),
(102,'Сыр','граммы'),
(103,'Майонез','кг'),
(105,'Кальмары','кг'),
(106,'Яйцо куриное','шт'),
(107,'Огурец соленый','кг');

INSERT INTO `Кол-во продуктов`(`Кол-во`,`№ рецепта`,`Номенклатурный № продукта`) VALUES
(0.340,103,100),
(0.100,103,101),
(0.080,103,102),
(0.100,103,103),
(1.0,103,106),
(0.300,101,105),
(3.0,101,106),
(0.150,101,107),
(0.100,101,101);
/* Создаем запрос, представляющий исходную таблицу */
SELECT
`Блюдо`.`№ рецепта`,
`Блюдо`.`Название блюда`,
`Продукт`.`Номенклатурный № продукта`,
`Продукт`.`Наименование продукта`,
`Продукт`.`Единицы измерения`,
`Кол-во продуктов`.`Кол-во`
 
FROM
`Кол-во продуктов` INNER JOIN `Продукт`
ON	`Кол-во	продуктов`.`Номенклатурный	№
 
продукта`=`Продукт`.`Номенклатурный № продукта` INNER JOIN `Блюдо`
ON `Кол-во продуктов`.`№ рецепта`=`Блюдо`.`№ рецепта` ORDER BY 1 DESC
;
