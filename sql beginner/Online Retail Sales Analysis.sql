-- Online Retail Sales Analysis-- 
drop database retail_project;

-- Step 1: Create a Database-- 
-- Create a database for the retail project.-- 

create database retail_project;
use retail_project;

-- Step 2: Create Customers Table-- 
-- Create a table to store customer information.-- 

create table customers( customer_id INT Primary Key Auto_Increment,
					   customer_name  VARCHAR(100) NOT NULL,
					   email VARCHAR(50) unique,
					   city VARCHAR(50),
                       signup_date DATE
                       );

select * from customers;

-- Step 3: Create Products Table-- 
-- Create a table for product details.-- 

create table Products(
					  product_id int PRIMARY KEY auto_increment,
					  product_name varchar(50) not null,
					  category varchar(50),
					  price DECIMAL(10,2) not null
					  );

select * from Products;

-- Step 4: Create Orders Table-- 
-- Create a table to store orders.-- 

create table Orders (order_id int PRIMARY KEY auto_increment, 
					customer_id int NOT null,
                    Foreign Key (customer_id) references customers (customer_id ) ,
					order_date DATE NOT NULL,
					total_amount decimal(10,2) 
					);

select * from  Orders;

-- Step 5: Create Order_Items Table--
-- Create a table for products inside each order. -- 

Create Table Order_Items (
							order_item_id INT primary key auto_increment,
							order_id INT,
                            Foreign Key (order_id) references Orders (order_id ) ,
							product_id INT,
							Foreign Key (product_id) references Products(product_id),
							quantity int NOT NULL,
							price DECIMAL(10,2) NOT NULL 
);
   
-- Step 6: Insert Sample Data  -- 
-- Insert 10 – 50 records into each table.-- 
  
INSERT INTO customers (customer_name,email,city,signup_date) VALUES
('Rahul Sharma','rahul@gmail.com','Delhi','2023-01-10'),
('Anita Verma','anita@gmail.com','Mumbai','2023-02-15'),
('Rohit Singh','rohit@gmail.com','Pune','2023-03-05'),
('Priya Patel','priya@gmail.com','Ahmedabad','2023-01-22'),
('Amit Kumar','amit@gmail.com','Bhopal','2023-04-01'),
('Sneha Joshi','sneha@gmail.com','Indore','2023-02-18'),
('Vikas Gupta','vikas@gmail.com','Jaipur','2023-03-12'),
('Neha Agarwal','neha@gmail.com','Kolkata','2023-05-09'),
('Arjun Mehta','arjun@gmail.com','Chandigarh','2023-06-11'),
('Kiran Rao','kiran@gmail.com','Hyderabad','2023-07-19');


INSERT INTO products (product_name,category,price) VALUES
('Laptop','Electronics',55000),
('Mouse','Electronics',500),
('Keyboard','Electronics',1500),
('Headphones','Electronics',2500),
('T-Shirt','Clothing',700),
('Jeans','Clothing',1200),
('Shoes','Footwear',3000),
('Watch','Accessories',4000),
('Backpack','Accessories',1800),
('Mobile Phone','Electronics',25000);


INSERT INTO orders (customer_id,order_date,total_amount) VALUES
(1,'2024-01-10',56000),
(2,'2024-01-12',1500),
(3,'2024-01-15',2500),
(4,'2024-01-18',700),
(5,'2024-01-20',3000),
(6,'2024-01-22',4000),
(7,'2024-01-25',1800),
(8,'2024-01-28',25000),
(9,'2024-02-01',55000),
(10,'2024-02-03',1200),
(1,'2024-02-05',3000),
(2,'2024-02-07',700),
(3,'2024-02-10',2500),
(4,'2024-02-12',4000),
(5,'2024-02-15',1800);


INSERT INTO order_items (order_id,product_id,quantity,price) VALUES
(1,1,1,55000),
(1,2,2,500),
(2,3,1,1500),
(3,4,1,2500),
(4,5,1,700),
(5,7,1,3000),
(6,8,1,4000),
(7,9,1,1800),
(8,10,1,25000),
(9,1,1,55000),
(10,6,1,1200),
(11,7,1,3000),
(12,5,1,700),
(13,4,1,2500),
(14,8,1,4000),
(15,9,1,1800),

(2,2,1,500),
(3,3,1,1500),
(4,4,1,2500),
(5,5,2,700),
(6,6,1,1200),
(7,7,1,3000),
(8,8,1,4000),
(9,9,1,1800),
(10,10,1,25000),

(11,2,2,500),
(12,3,1,1500),
(13,4,1,2500),
(14,5,1,700),
(15,6,1,1200),

(1,3,1,1500),
(2,4,1,2500),
(3,5,2,700),
(4,6,1,1200),
(5,8,1,4000),
(6,9,1,1800),
(7,10,1,25000),
(8,1,1,55000),
(9,2,2,500),

(10,3,1,1500),
(11,4,1,2500),
(12,6,1,1200),
(13,7,1,3000),
(14,9,1,1800),
(15,10,1,25000),
(1,5,2,700),
(2,6,1,1200),
(3,7,1,3000),
(4,8,1,4000),
(5,9,1,1800);

	

select * from customers;
select * from order_items ;
select * from Products;
select * from  Orders;

-- Step 7: First Analysis Query-- 
-- Show all orders with the customer name.-- 


select * from Orders inner join customers
on Orders.customer_id = customers.customer_id;

select 
	c.customer_name,
    O.order_id
from  Orders O
inner join customers c
on O.customer_id = c.customer_id;

-- Step 8: Sales by Product-- 
-- Find total quantity sold for each product.-- 

-- SELECT  product_id, SUM(quantity) AS TotalSales
-- FROM order_items
-- GROUP BY  product_id; it is okk but some thing is missing 
SELECT
p.product_name,
SUM(oi.quantity)
FROM order_items oi
JOIN Products p
ON oi.product_id = p.product_id
GROUP BY p.product_name;

-- select sum(quantity) as total from  order_items group by  product_id ;it is wrong --

-- Step 9: Top Customers-- 
-- Find customers who spent the most money.-- 
select
c.customer_name,
SUM(ta.total_amount) as total_spent 
FROM orders ta
JOIN customers c
ON ta.customer_id = c.customer_id
GROUP BY c.customer_name
order by total_spent desc ;

-- Step 10: Best Selling Product --
-- Find the product with the highest total quantity sold.-- 

SELECT
p.product_name,
SUM(oi.quantity) as total_quantity
FROM order_items oi
JOIN Products p
ON oi.product_id = p.product_id
GROUP BY p.product_name
order by total_quantity desc limit 1;

