
-- 1. Создайте таблицу "users" с полями "id", "name", "email" и "password".
-- Поле "id" должно быть уникальным и являться первичным ключом таблицы.

CREATE TABLE users (
    id bigserial PRIMARY KEY,
    name varchar (50),
    email varchar (50),
    password varchar (50)
);



-- 2. Напишите SQL-запрос для добавления нового пользователя в таблицу "users".
-- Новый пользователь должен иметь имя "John", email "john@example.com" и
-- пароль "mypassword" и еще 5 юзеров по выбору.

INSERT INTO users (name, email, password) VALUES ('John', 'john@example.com', 'mypassword');
INSERT INTO users (name, email, password) VALUES ('Sarah', 'sarah@example.com', 'herpassword');
INSERT INTO users (name, email, password) VALUES ('Bob', 'bob@example.com', 'hispasswor');
INSERT INTO users (name, email, password) VALUES ('Laura', 'laura@example.com', 'coolpassword');
INSERT INTO users (name, email, password) VALUES ('Antonio', 'antonio@example.com', 'secret');
INSERT INTO users (name, email, password) VALUES ('Ira', 'ira@example.com', 'nopass');



-- 3. Напишите SQL-запрос для изменения имени пользователя с id=1 на "Jane"

UPDATE users SET name='Jane' WHERE id=1;



-- 4. Напишите SQL-запрос для удаления пользователя с email "john@example.com"

DELETE FROM users WHERE email='john@example.com';



-- 5. Создайте таблицу "orders" с полями "id", "user_id", "product_name" и "price".
-- Поле "id" должно быть уникальным и являться первичным ключом таблицы.
-- Поле "user_id" должно быть внешним ключом, связывающим таблицы "users" и "orders".

CREATE TABLE orders (
    id bigserial,
    user_id int,
    product_name varchar(50),
    price double precision,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);


INSERT INTO orders (user_id, product_name, price) VALUES (2,'banana', 200.50);
INSERT INTO orders (user_id, product_name, price) VALUES (3, 'apple', 45.20);
INSERT INTO orders (user_id, product_name, price) VALUES (4, 'pineapple', 711.24);
INSERT INTO orders (user_id, product_name, price) VALUES (2, 'coconut', 349.99);



-- 6. Напишите SQL-запрос для выборки всех заказов,
-- сделанных пользователем с именем "Jane".

SELECT * FROM orders WHERE user_id = (SELECT id FROM users WHERE name='Sarah');



-- 7. ***Напишите SQL-запрос для выборки всех пользователей,
-- которые сделали заказ на товары с ценой больше 100 долларов

SELECT DISTINCT users.id, users.name FROM users
    INNER JOIN
    orders ON users.id = orders.user_id
    WHERE orders.price > 100.00;



-- 8. ***Напишите SQL-запрос для выборки суммарной стоимости всех заказов
-- для каждого пользователя. Результаты должны быть отсортированы
-- по убыванию суммарной стоимости.

SELECT DISTINCT users.id, users.name,
                (SELECT SUM (price)
                     FROM orders
                     WHERE user_id = users.id) AS sum
            FROM users
    INNER JOIN
    orders ON users.id = orders.user_id ORDER BY sum DESC;



-- 9. ***Напишите SQL-запрос для выборки количества заказов
-- для каждого пользователя. Результаты должны быть отсортированы
-- по возрастанию количества заказов.

SELECT DISTINCT users.id, users.name,
                (SELECT COUNT (orders.id)
                 FROM orders
                 WHERE orders.user_id = users.id) AS count
            FROM users
    ORDER BY count;


-- TRUNCATE TABLE USERS;
-- ALTER SEQUENCE users_id_seq RESTART WITH 1;
-- DROP TABLE orders;
-- SELECT * FROM users;
-- SELECT * FROM orders;
