-- Active: 1744229128545@@127.0.0.1@5432@bookstore_db@public

-- ** Create database and Connect to the database **
-- CREATE DATABASE bookstore_db;
-- \c bookstore_db


------------------------------------
--      **** CREATE table ****
------------------------------------

-- Create books table
CREATE TABLE books (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    author VARCHAR(100) NOT NULL,
    price NUMERIC(10, 2) CHECK (price >= 0),
    stock INT CHECK (stock >= 0) NOT NULL,
    published_year INT CHECK(published_year > 0)
);


-- Create customers table
CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    joined_date DATE DEFAULT CURRENT_DATE
);


-- Create orders table
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(id),
    book_id INT REFERENCES books(id),
    quantity INT CHECK (quantity > 0),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

------------------------------------
-- **** Insert data into table ****
------------------------------------


-- Insert data into books table
INSERT INTO books (title, author, price, stock, published_year) VALUES
    ('The Pragmatic Programmer', 'Andrew Hunt', 40.00, 10, 1999),
    ('Clean Code', 'Robert C. Martin', 35.00, 5, 2008),
    ('You Don''t Know JS', 'Kyle Simpson', 30.00, 8, 2014),
    ('Refactoring', 'Martin Fowler', 50.00, 3, 1999),
    ('Database Design Principles', 'Jane Smith', 20.00, 0, 2018);


-- Insert data into customers table
INSERT INTO customers (name, email, joined_date) VALUES
    ('Alice', 'alice@email.com', '2023-01-10'),
    ('Bob', 'bob@email.com', '2022-05-15'),
    ('Charlie', 'charlie@email.com', '2023-06-20');



-- Insert data into orders table
INSERT INTO orders (customer_id, book_id, quantity, order_date) VALUES
    (1, 2, 1, '2024-03-10'),
    (2, 1, 1, '2024-02-20'),
    (1, 3, 2, '2024-03-05');




------------------------------------
-- **** PostgreSQL Query ****
------------------------------------

-- Query 1: Find books that are out of stock.
SELECT title FROM books
WHERE stock = 0;


-- Query 2: Retrieve the most expensive book in the store.
SELECT * FROM books
ORDER BY price DESC LIMIT 1;


-- Query 3: Find the total number of orders placed by each customer.
SELECT c.name, count(o.id) as total_orders
FROM customers as c
JOIN orders as o ON o.customer_id = c.id
GROUP BY c.name;


-- Query 4: Calculate the total revenue generated from book sales.
SELECT round(sum(o.quantity * b.price),2) as total_revenue
FROM orders as o
JOIN books b ON o.book_id = b.id;


-- Query 5: List all customers who have placed more than one order.
SELECT c.name , count(*) as orders_count 
FROM customers c
JOIN orders o ON o.customer_id = c.id
GROUP BY c.name
HAVING COUNT(o.id) > 1; 


-- Query 6: Find the average price of books in the store.
SELECT round(AVG(price),2) as avg_book_price
FROM books;


-- Query 7: Increase the price of all books published before 2000 by 10%.
UPDATE books
SET price = price * 1.10
WHERE published_year < 2000;


-- Query 8: Delete customers who haven't placed any orders.
DELETE FROM customers
WHERE id NOT IN (SELECT customer_id FROM orders);



-- DROP TABLE books;
-- DROP TABLE customers;
-- DROP TABLE orders;

-- SELECT * FROM books;
-- SELECT * FROM customers;
-- SELECT * FROM orders;