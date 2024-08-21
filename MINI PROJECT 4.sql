-- Create the database
CREATE DATABASE global_store_db;
USE global_store_db;

-- Create the products table
CREATE TABLE PRODUCTS (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10,2),
    quantity INT
);


-- Create the orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    product_id INT,
    quantity_ordered INT,
    order_date DATE
);


-- Alter the products table to add the category column
ALTER TABLE PRODUCTS ADD COLUMN category VARCHAR(50) AFTER price;

-- Rename products table to inventory
ALTER TABLE products RENAME TO inventory;

-- Insert records into the inventory table
INSERT INTO inventory (product_id, name, price, quantity, category) VALUES
(101, 'Product 1', 10.00, 20, 'Category A'),
(102, 'Product 2', 15.50, 15, 'Category B'),
(103, 'Product 3', 20.25, 30, 'Category A'),
(104, 'Product 4', 8.75, 10, 'Category C'),
(105, 'Product 5', 12.00, 25, 'Category B'),
(106, 'Product 6', 18.50, 5, 'Category A'),
(107, 'Product 7', 22.75, 0, 'Category C'),
(108, 'Product 8', 30.00, 8, 'Category B'),
(109, 'Product 9', 11.50, 12, 'Category A'),
(110, 'Product 10', 25.00, 3, 'Category C');

SELECT * FROM INVENTORY;

-- Insert records into the orders table
INSERT INTO orders (order_id, product_id, quantity_ordered, order_date) VALUES
(1, 102, 5, '2024-05-20'),
(2, 110, 2, '2024-05-21'),
(3, 105, 15, '2024-05-22'),
(4, 108, 3, '2024-05-23'),
(5, 102, 10, '2024-05-24');

SELECT * FROM ORDERS;

-- Update inventory table
UPDATE INVENTORY INNER JOIN ORDERS ON INVENTORY.PRODUCT_ID = ORDERS.PRODUCT_ID
SET INVENTORY.QUANTITY = INVENTORY.QUANTITY - ORDERS.QUANTITY_ORDERED;

SELECT * FROM INVENTORY;

-- Display distinct categories from the inventory table
SELECT DISTINCT category FROM inventory;

-- Select the top 5 products by their prices in descending order from the inventory table
SELECT * FROM inventory ORDER BY price DESC LIMIT 5;

-- Display the names of products with a quantity greater than 10 from the inventory table
SELECT name FROM inventory WHERE quantity > 10;

-- Use the SUM() function to calculate the total price of all products in the inventory table
SELECT SUM(price * quantity) AS total_price FROM inventory;

-- Group products by their categories and display the count of products in each category
SELECT category, COUNT(*) AS product_count FROM inventory GROUP BY category;


-- Write a query to identify products that are currently out of stock (i.e., quantity is zero). Display the product details including the product name and price.
SELECT name, price FROM inventory WHERE quantity = 0;

-- Create a view named expensive_products that displays the details of products with a price above the average price of all products
CREATE VIEW expensive_products AS
SELECT * FROM inventory WHERE price > (SELECT AVG(price) FROM inventory);
SELECT * FROM EXPENSIVE_PRODUCTS;

-- Write a join query to display the names of products along with the corresponding order quantities from the inventory and orders tables
SELECT INVENTORY.NAME AS product_name, ORDERS.quantity_ordered AS order_quantity
FROM inventory INNER JOIN orders  ON INVENTORY.product_id = ORDERS.product_id;

