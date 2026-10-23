CREATE DATABASE IF NOT EXISTS ONE8_Shoes;
USE ONE8_Shoes;

DROP TABLE IF EXISTS Order_Details;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Category;

CREATE TABLE Category (
  Category_ID INT PRIMARY KEY,
  Category_Name VARCHAR(100) NOT NULL,
  Description VARCHAR(255)
);

CREATE TABLE Products (
  Product_ID INT PRIMARY KEY,
  Product_Name VARCHAR(120) NOT NULL,
  Brand VARCHAR(80) NOT NULL,
  Category_ID INT NOT NULL,
  Price DECIMAL(10,2) NOT NULL,
  Size VARCHAR(10),
  Color VARCHAR(40),
  Stock INT NOT NULL DEFAULT 0,
  FOREIGN KEY (Category_ID) REFERENCES Category(Category_ID)
);

CREATE TABLE Customers (
  Customer_ID INT PRIMARY KEY,
  Customer_Name VARCHAR(100) NOT NULL,
  Email VARCHAR(120),
  City VARCHAR(80)
);

CREATE TABLE Orders (
  Order_ID INT PRIMARY KEY,
  Customer_ID INT NOT NULL,
  Order_Date DATE NOT NULL,
  Total_Amount DECIMAL(10,2) NOT NULL,
  Order_Status VARCHAR(30) NOT NULL,
  FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
);

CREATE TABLE Order_Details (
  Order_Detail_ID INT PRIMARY KEY,
  Order_ID INT NOT NULL,
  Product_ID INT NOT NULL,
  Quantity INT NOT NULL,
  Price DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID),
  FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID)
);

INSERT INTO Category VALUES
(1,'Running Shoes','Shoes for running and jogging'),
(2,'Sports Shoes','Shoes for sports activities'),
(3,'Casual Shoes','Footwear for everyday use'),
(4,'Formal Shoes','Footwear for formal occasions'),
(5,'Sneakers','Stylish casual footwear');

INSERT INTO Products VALUES
(201,'ONE8 Runner','ONE8',1,2499.00,'8','Black',25),
(202,'ONE8 Sport Pro','ONE8',2,3499.00,'9','White',18),
(203,'ONE8 Daily Comfort','ONE8',3,1999.00,'7','Blue',30),
(204,'ONE8 Classic Formal','ONE8',4,4599.00,'10','Brown',12),
(205,'ONE8 Street Sneaker','ONE8',5,2999.00,'8','Black',22),
(206,'ONE8 Flex Runner','ONE8',1,2799.00,'9','Grey',15),
(207,'ONE8 Court Shoe','ONE8',2,3299.00,'8','Red',10),
(208,'ONE8 Casual Lite','ONE8',3,1799.00,'6','White',35);

INSERT INTO Customers VALUES
(101,'Customer One','customer1@example.com','Chennai'),
(102,'Customer Two','customer2@example.com','Coimbatore'),
(103,'Customer Three','customer3@example.com','Madurai'),
(104,'Customer Four','customer4@example.com','Chennai'),
(105,'Customer Five','customer5@example.com','Salem');

INSERT INTO Orders VALUES
(301,101,'2026-10-01',2499.00,'Delivered'),
(302,102,'2026-10-03',3499.00,'Shipped'),
(303,101,'2026-10-06',5998.00,'Confirmed'),
(304,103,'2026-10-08',1999.00,'Delivered'),
(305,104,'2026-10-10',4599.00,'Pending'),
(306,105,'2026-10-12',2999.00,'Confirmed');

INSERT INTO Order_Details VALUES
(1,301,201,1,2499.00),
(2,302,202,1,3499.00),
(3,303,205,2,2999.00),
(4,304,203,1,1999.00),
(5,305,204,1,4599.00),
(6,306,205,1,2999.00);

-- 1. Basic SQL Queries
SELECT * FROM Products;

SELECT Product_ID, Product_Name, Price, Stock
FROM Products;

-- 1.2 WHERE: products in category 1
SELECT Product_ID, Product_Name
FROM Products
WHERE Category_ID = 1;

-- 1.3 ORDER BY: price descending
SELECT Product_ID, Product_Name, Price
FROM Products
ORDER BY Price DESC;

-- 1.4 DISTINCT: unique colors
SELECT DISTINCT Color
FROM Products;

-- 2. Search products by price
SELECT Product_ID, Product_Name, Price
FROM Products
WHERE Price BETWEEN 2000 AND 3500
ORDER BY Price;

-- 3. Retrieve customer information
SELECT * FROM Customers;

-- 4. Filtering with AND, OR, NOT
SELECT Product_ID, Product_Name, Price, Stock
FROM Products
WHERE Price < 3500 AND Stock > 15;

SELECT Product_ID, Product_Name, Category_ID
FROM Products
WHERE Category_ID = 1 OR Category_ID = 2;

SELECT Product_ID, Product_Name, Color
FROM Products
WHERE NOT Color = 'Black';

-- 5.1 Product price report
SELECT Product_ID, Product_Name, Price
FROM Products
ORDER BY Price DESC;

-- 5.2 Customer order report
SELECT o.Order_ID, c.Customer_ID, c.Customer_Name,
       o.Order_Date, o.Total_Amount, o.Order_Status
FROM Orders o
JOIN Customers c ON c.Customer_ID = o.Customer_ID
ORDER BY o.Order_Date;

-- 5.3 Product order report
SELECT p.Product_ID, p.Product_Name,
       SUM(od.Quantity) AS Total_Quantity_Ordered,
       SUM(od.Quantity * od.Price) AS Total_Sales
FROM Products p
JOIN Order_Details od ON od.Product_ID = p.Product_ID
GROUP BY p.Product_ID, p.Product_Name
ORDER BY Total_Sales DESC;

-- 5.4 Customer-wise total orders
SELECT c.Customer_ID, c.Customer_Name,
       COUNT(o.Order_ID) AS Total_Orders
FROM Customers c
LEFT JOIN Orders o ON o.Customer_ID = c.Customer_ID
GROUP BY c.Customer_ID, c.Customer_Name
ORDER BY Total_Orders DESC;

-- 5.5 Customer-wise total purchase amount
SELECT c.Customer_ID, c.Customer_Name,
       COALESCE(SUM(o.Total_Amount), 0) AS Total_Purchase_Amount
FROM Customers c
LEFT JOIN Orders o ON o.Customer_ID = c.Customer_ID
GROUP BY c.Customer_ID, c.Customer_Name
ORDER BY Total_Purchase_Amount DESC;
