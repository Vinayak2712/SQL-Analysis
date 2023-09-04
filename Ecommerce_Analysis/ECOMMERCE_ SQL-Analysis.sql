--  SELECT * FROM COMMAND
USE ecom;

-- DATA CLEANING  
-- FINDING NULL VALUES AND FIXING IT WITH APPRORIATE METHOD 

SELECT * FROM comments WHERE creationTime IS NULL OR grade IS NULL OR content IS NULL;

-- DROPPING THE NULL VALUES 

DELETE FROM comments WHERE content IS NULL;
SELECT * FROM comments;

-- Filling Null Values with approriate Knowledge 
SELECT * FROM product WHERE brand IS NULL;

-- As we clearly known that the brand name is  Microsoft we can fill the null value 
UPDATE product SET brand = 'Microsoft' WHERE brand IS NULL;

SELECT * FROM product;


-- query the address, starttime and endtime of the servicepoints in the same city as userid 5   

SELECT streetaddr,startTime,endTime 
	FROM servicepoint 
	WHERE city IN (SELECT city FROM address WHERE userid = 5);
    
    
-- query the information of  Costliest laptop

SELECT brand, name, modelNumber,Type,price FROM product 
WHERE type = 'laptop' ORDER BY Price DESC LIMIT 1;


-- query the total quantity of products from store with storeid 8 in the shopping cart

SELECT product.sid, product.brand,product.name, product.type, product.price, save_to_shopping_cart.quantity
FROM save_to_shopping_cart JOIN product ON save_to_shopping_cart.pid = product.pid
WHERE save_to_shopping_cart.pid IN (SELECT pid FROM product WHERE sid = 8);




-- query the name and address of orders delivered on 2017-02-17
	SELECT name, streetaddr, city FROM  address 
    WHERE addrid IN (SELECT addrid FROM deliver_to WHERE TimeDelivered = '2017-02-17');
    
    
    
-- ------------------------------------------- --

-- Data Modification

-- Insert the user id of sellers whose name starts with A into buyer
INSERT IGNORE INTO buyer(userid)
SELECT userid FROM users WHERE name LIKE 'A%';

SELECT userid FROM users WHERE name LIKE 'A%';


-- Update the payment state of orders to unpaid which created after year 2017 and with total amount greater than 50.

UPDATE orders 
SET paymentState = 'unpaid' 
WHERE creationTime > '2017-01-01' AND totalAmount > 50;

SELECT * FROM orders WHERE creationTime > '2017-01-01';


-- Update the name and contact phone number of address where the provice is Quebec and city is montreal.
SELECT * FROM address WHERE province = 'Quebec' AND city = 'Montreal';

UPDATE address 
SET contactPhoneNumber = '9448540545', name = 'Vinayak'
WHERE province = 'Quebec' AND city = 'Montreal';

SELECT * FROM address WHERE province = 'Quebec' AND city = 'Montreal';




-- Delete the store which opened before year 2017
SELECT * FROM save_to_shopping_cart;

DELETE FROM save_to_shopping_cart 
WHERE addtime < '2017-01-01';




-- Views 
USE ecommerce;
-- Create view of all products whose price above average price.
CREATE VIEW ExpensiveProduct AS 
SELECT * FROM product WHERE price > (SELECT AVG(price) FROM product);

SELECT * FROM ExpensiveProduct;


UPDATE ExpensiveProduct
SET price = 1
WHERE name = 'GoPro HERO5';

SELECT * FROM ExpensiveProduct;





-- Update the view

UPDATE ExpensiveProduct 
 SET price = 20000 WHERE brand = 'GoPro';


-- Create view of all products sales in 2016.
CREATE VIEW products_sales_2016
AS SELECT * FROM product WHERE pid IN (SELECT pid FROM orderitem 
WHERE  creationTime BETWEEN '2016-01-01' AND '2016-12-30');

SELECT* FROM products_sales_2016;






    
    
    
    
    



