#Task 1
#Create a database to manage hotel room reservations, guest information, room availability, and billing. 
#The database should include tables for guests, rooms, reservations, and payments. 
#Use DDL commands to create the necessary tables with appropriate data types, constraints, and relationships.

CREATE DATABASE hotel_management;
USE hotel_management;

CREATE TABLE guests (
    guest_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(15)
);
CREATE TABLE rooms (
    room_id INT PRIMARY KEY AUTO_INCREMENT,
    room_number VARCHAR(10) NOT NULL,
    room_type VARCHAR(50) NOT NULL,
    capacity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);
CREATE TABLE reservations (
    reservation_id INT PRIMARY KEY AUTO_INCREMENT,
    guest_id INT,
    room_id INT,
    check_in DATE NOT NULL,
    check_out DATE NOT NULL
);
CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    reservation_id INT,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date DATETIME NOT NULL
);

#Task 2
#Develop a database to manage inventory, product details, sales transactions, and supplier information. 
#The database should include tables for products, categories, suppliers, sales, and inventory.
#Use DDL commands to create the necessary tables with appropriate data types, constraints, and relationships.

CREATE DATABASE inventory_management;
USE inventory_management;

CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50) NOT NULL
);
CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_name VARCHAR(50) NOT NULL,
    contact_info VARCHAR(100)
);
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(50) NOT NULL,
    category_id INT,
    supplier_id INT,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(category_id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);
CREATE TABLE sales (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    quantity_sold INT NOT NULL,
    sale_date DATETIME NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
CREATE TABLE inventory (
    inventory_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    quantity INT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
#Task 3
#Create a database to handle menu items, table reservations, customer orders, and staff scheduling. 
#The database should include tables for menu items, orders, reservations, tables, and staff. 
#Use DDL commands to create the necessary tables with appropriate data types, constraints, and relationships.
CREATE DATABASE restaurant_management;
USE restaurant_management;
CREATE TABLE menu_items (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    item_name VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    description VARCHAR(255)
);
CREATE TABLE tables (
    table_id INT PRIMARY KEY AUTO_INCREMENT,
    table_number VARCHAR(10) NOT NULL,
    capacity INT NOT NULL
);
CREATE TABLE staff (
    staff_id INT PRIMARY KEY AUTO_INCREMENT,
    staff_name VARCHAR(50) NOT NULL,
    position VARCHAR(50) NOT NULL,
    schedule DATETIME
);
CREATE TABLE reservations (
    reservation_id INT PRIMARY KEY AUTO_INCREMENT,
    table_id INT,
    customer_name VARCHAR(50) NOT NULL,
    reservation_date DATETIME NOT NULL,
    FOREIGN KEY (table_id) REFERENCES tables(table_id)
);
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    reservation_id INT,
    item_id INT,
    quantity INT NOT NULL,
    order_date DATETIME NOT NULL,
    FOREIGN KEY (reservation_id) REFERENCES reservations(reservation_id),
    FOREIGN KEY (item_id) REFERENCES menu_items(item_id)
);
#Task 4
#Develop a database to manage music tracks, artists, playlists, and user subscriptions. The database should include tables for tracks, artists, albums, playlists, and user accounts. 
#Use DDL commands to create the necessary tables with appropriate data types, constraints, and relationships.
CREATE DATABASE music_management;
USE music_management;
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE
);
CREATE TABLE tracks (
    track_id INT PRIMARY KEY AUTO_INCREMENT,
    track_name VARCHAR(50) NOT NULL,
    artist_name VARCHAR(50) NOT NULL,
    album_name VARCHAR(50),
    duration TIME NOT NULL,
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);





