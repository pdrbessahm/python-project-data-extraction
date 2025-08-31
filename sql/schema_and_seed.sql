SET FOREIGN_KEY_CHECKS=0;
TRUNCATE TABLE payments;
TRUNCATE TABLE order_items;
TRUNCATE TABLE orders;
TRUNCATE TABLE customers;
TRUNCATE TABLE products;
SET FOREIGN_KEY_CHECKS=1;

CREATE TABLE IF NOT EXISTS products (
	id INT AUTO_INCREMENT,
	products_name VARCHAR(120) NOT NULL,
	category VARCHAR(50) NOT NULL,
	price DECIMAL(10,2) NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS customers (
	id INT AUTO_INCREMENT,
    customers_name VARCHAR(120) NOT NULL,
    email VARCHAR(120),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS orders (
	id INT AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

CREATE TABLE IF NOT EXISTS order_items (
	id INT AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
	unit_price DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (product_id) REFERENCES products(id),
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

CREATE TABLE IF NOT EXISTS payments (
	id INT AUTO_INCREMENT,
    order_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    paid_at DATETIME NOT NULL,
    method VARCHAR(30),
    PRIMARY KEY (id),
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

INSERT INTO products (products_name, category, price) VALUES 
('Basic Tee', 'Apparel', 19.90),('Hoodie', 'Apparel', 69.00),
('Mug', 'Home', 12.00),('Keyboard', 'Electronics', 99.00);

INSERT INTO customers (customers_name, email) VALUES 
('Ana', 'ana@example.com'), ('Pedro', 'pedro@example.com'), ('Noug', 'noug@example.com');

INSERT INTO orders (customer_id, order_date) VALUES 
(1, CURDATE() - INTERVAL 10 DAY),
(2, CURDATE() - INTERVAL 25 DAY),
(3, CURDATE() - INTERVAL 40 DAY); -- outside 30d window

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 2, 19.90),
(1, 3, 1, 12.00),
(2, 4, 1, 99.00),
(3, 2, 1, 69.00);

INSERT INTO payments (order_id, amount, paid_at, method) VALUES 
(1, 51.80, NOW() - INTERVAL 9 DAY, 'card'),
(2, 99.00, NOW() - INTERVAL 24 DAY, 'pix'),
(3, 69.00, NOW() - INTERVAL 39 DAY, 'card');

