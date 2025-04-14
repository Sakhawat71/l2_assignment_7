-- Active: 1744229128545@@127.0.0.1@5432@bookstore_db

-- Create database and Connect to the database
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
('Clean Code', 'Robert C. Martin', 35.00, 15, 2008),
('Introduction to Algorithms', 'Thomas H. Cormen', 80.00, 5, 2009),
('Design Patterns', 'Erich Gamma', 50.00, 7, 1994),
('Refactoring', 'Martin Fowler', 45.00, 12, 1999);


-- Insert data into customers table
INSERT INTO customers (name, email) VALUES
('Alice Johnson', 'alice@example.com'),
('Bob Smith', 'bob@example.com'),
('Charlie Brown', 'charlie@example.com');



-- Insert data into orders table
INSERT INTO orders (customer_id, book_id, quantity, order_date) VALUES
    (1, 2, 1, '2024-03-10'),
    (2, 1, 1, '2024-02-20'),
    (1, 3, 2, '2024-03-05');










-- DROP TABLE orders;

SELECT * FROM books;

SELECT * FROM customers;

SELECT * FROM orders;