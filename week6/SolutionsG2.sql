-- Task 1
CREATE DATABASE hospital;
CREATE USER 'doctor'@'%' IDENTIFIED BY 'medic123';
GRANT SELECT, INSERT, DELETE ON hospital.* TO 'doctor'@'%';
SHOW GRANTS FOR 'doctor'@'%';
REVOKE DELETE ON hospital.* FROM 'doctor'@'%';
SHOW GRANTS FOR 'doctor'@'%';


-- Task 2
CREATE DATABASE bookstore;
USE bookstore;

CREATE TABLE books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    author_id INT,
    genre_id INT,
    isbn VARCHAR(13) UNIQUE,
    price DECIMAL(10, 2) CHECK (price >= 0 AND price <= 1000),
    publication_date DATE,
    FOREIGN KEY (author_id) REFERENCES authors(author_id),
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
);

CREATE TABLE authors (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50) NOT NULL,
    UNIQUE (first_name, last_name)
);

CREATE TABLE genres (
    genre_id INT PRIMARY KEY AUTO_INCREMENT,
    genre_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15)
);

CREATE TABLE sales (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT,
    customer_id INT,
    sale_date DATE NOT NULL,
    quantity INT CHECK (quantity > 0),
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);



-- Task 3
CREATE INDEX idx_isbn ON books(isbn);
CREATE INDEX idx_author_last_name ON authors(last_name);
CREATE INDEX idx_genre_name ON genres(genre_name);
CREATE INDEX idx_customer_email ON customers(email);

