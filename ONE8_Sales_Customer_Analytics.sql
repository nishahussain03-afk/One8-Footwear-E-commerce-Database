-- ONE8 Footwear E-Commerce DBMS
-- Task: Sales and Customer Analytics System
-- MySQL 8.0+
-- WARNING: This standalone sample recreates the tables. Back up existing data first.

CREATE DATABASE IF NOT EXISTS ONE8_Shoes;
USE ONE8_Shoes;

SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS Payments;
DROP TABLE IF EXISTS Order_Details;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Customers;
SET FOREIGN_KEY_CHECKS=1;

CREATE TABLE Customers (
 Customer_ID INT PRIMARY KEY, Customer_Name VARCHAR(100) NOT NULL,
 Email VARCHAR(120) UNIQUE, City VARCHAR(60)
);
CREATE TABLE Products (
 Product_ID INT PRIMARY KEY, Product_Name VARCHAR(120) NOT NULL,
 Category VARCHAR(60), Price DECIMAL(10,2) NOT NULL, Color VARCHAR(40)
);
CREATE TABLE Orders (
 Order_ID INT PRIMARY KEY, Customer_ID INT NOT NULL, Order_Date DATE NOT NULL,
 Order_Status VARCHAR(30) NOT NULL,
 FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
);
CREATE TABLE Order_Details (
 Order_Detail_ID INT PRIMARY KEY, Order_ID INT NOT NULL, Product_ID INT NOT NULL,
 Quantity INT NOT NULL, Unit_Price DECIMAL(10,2) NOT NULL,
 FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID),
 FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID)
);
CREATE TABLE Payments (
 Payment_ID INT PRIMARY KEY, Order_ID INT NOT NULL, Payment_Date DATE,
 Payment_Method VARCHAR(40), Amount DECIMAL(10,2) NOT NULL,
 Payment_Status VARCHAR(30) NOT NULL,
 FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID)
);

INSERT INTO Customers VALUES
(1,'Arun Kumar','arun@example.com','Chennai'),
(2,'Priya Sharma','priya@example.com','Coimbatore'),
(3,'Rahul Das','rahul@example.com','Chennai'),
(4,'Meena Raj','meena@example.com','Madurai'),
(5,'Kavin Raj','kavin@example.com','Salem');

INSERT INTO Products VALUES
(201,'ONE8 Runner Pro','Running Shoes',2999,'Black'),
(202,'ONE8 Court Flex','Sports Shoes',3499,'White'),
(203,'ONE8 Street Classic','Casual Shoes',2499,'Black'),
(204,'ONE8 Urban Lite','Sneakers',2799,'Grey'),
(205,'ONE8 Trail Grip','Walking Shoes',3199,'Blue'),
(206,'ONE8 Formal Edge','Formal Shoes',3999,'Brown');

INSERT INTO Orders VALUES
(1001,1,'2026-10-01','Delivered'),
(1002,2,'2026-10-03','Shipped'),
(1003,1,'2026-10-08','Delivered'),
(1004,3,'2026-10-10','Processing'),
(1005,4,'2026-10-12','Delivered');

INSERT INTO Order_Details VALUES
(1,1001,201,1,2999),(2,1001,203,1,2499),
(3,1002,202,1,3499),(4,1003,204,2,2799),
(5,1004,205,1,3199),(6,1005,206,1,3999);

INSERT INTO Payments VALUES
(5001,1001,'2026-10-01','UPI',5498,'Paid'),
(5002,1002,'2026-10-03','Card',3499,'Paid'),
(5003,1003,'2026-10-08','UPI',5598,'Paid'),
(5004,1004,'2026-10-10','Net Banking',3199,'Pending'),
(5005,1005,'2026-10-12','Card',3999,'Paid');

-- 1. COUNT(), SUM(), AVG(), MIN(), MAX()
SELECT COUNT(*) AS Total_Customers FROM Customers;
SELECT COUNT(*) AS Total_Products FROM Products;
SELECT COUNT(*) AS Total_Orders FROM Orders;

SELECT SUM(Quantity) AS Total_Units_Sold,
       SUM(Quantity * Unit_Price) AS Total_Sales
FROM Order_Details;

SELECT AVG(Price) AS Average_Product_Price,
       MIN(Price) AS Minimum_Product_Price,
       MAX(Price) AS Maximum_Product_Price
FROM Products;

SELECT MIN(Order_Total) AS Minimum_Order_Value,
       MAX(Order_Total) AS Maximum_Order_Value,
       AVG(Order_Total) AS Average_Order_Value
FROM (
 SELECT Order_ID, SUM(Quantity * Unit_Price) AS Order_Total
 FROM Order_Details GROUP BY Order_ID
) AS Order_Summary;

-- 2. Total sales reports
SELECT COUNT(DISTINCT Order_ID) AS Number_Of_Orders,
       SUM(Quantity) AS Units_Sold,
       SUM(Quantity * Unit_Price) AS Total_Sales
FROM Order_Details;

SELECT YEAR(o.Order_Date) AS Sales_Year,
       MONTH(o.Order_Date) AS Sales_Month,
       COUNT(DISTINCT o.Order_ID) AS Number_Of_Orders,
       SUM(od.Quantity * od.Unit_Price) AS Monthly_Sales
FROM Orders o JOIN Order_Details od ON o.Order_ID=od.Order_ID
GROUP BY YEAR(o.Order_Date), MONTH(o.Order_Date)
ORDER BY Sales_Year, Sales_Month;

SELECT o.Order_ID, o.Order_Date,
       SUM(od.Quantity * od.Unit_Price) AS Order_Total
FROM Orders o JOIN Order_Details od ON o.Order_ID=od.Order_ID
GROUP BY o.Order_ID,o.Order_Date ORDER BY o.Order_Date;

-- 3. Top customers by purchase amount
SELECT c.Customer_ID,c.Customer_Name,
       COUNT(DISTINCT o.Order_ID) AS Total_Orders,
       SUM(od.Quantity * od.Unit_Price) AS Total_Purchase_Amount
FROM Customers c
JOIN Orders o ON c.Customer_ID=o.Customer_ID
JOIN Order_Details od ON o.Order_ID=od.Order_ID
GROUP BY c.Customer_ID,c.Customer_Name
ORDER BY Total_Purchase_Amount DESC LIMIT 5;

-- 4. Best-selling products
SELECT p.Product_ID,p.Product_Name,p.Category,
       SUM(od.Quantity) AS Total_Quantity_Sold,
       SUM(od.Quantity * od.Unit_Price) AS Total_Revenue
FROM Products p JOIN Order_Details od ON p.Product_ID=od.Product_ID
GROUP BY p.Product_ID,p.Product_Name,p.Category
ORDER BY Total_Quantity_Sold DESC,Total_Revenue DESC;

-- 5. Category-wise sales analysis
SELECT p.Category,
       COUNT(DISTINCT od.Order_ID) AS Orders_Containing_Category,
       SUM(od.Quantity) AS Total_Units_Sold,
       SUM(od.Quantity * od.Unit_Price) AS Category_Sales,
       AVG(od.Unit_Price) AS Average_Selling_Price
FROM Products p JOIN Order_Details od ON p.Product_ID=od.Product_ID
GROUP BY p.Category ORDER BY Category_Sales DESC;

-- Category sales percentage
SELECT Category,Category_Sales,
       ROUND(Category_Sales*100.0/
       (SELECT SUM(Quantity*Unit_Price) FROM Order_Details),2) AS Sales_Percentage
FROM (
 SELECT p.Category,SUM(od.Quantity*od.Unit_Price) AS Category_Sales
 FROM Products p JOIN Order_Details od ON p.Product_ID=od.Product_ID
 GROUP BY p.Category
) AS Category_Summary
ORDER BY Category_Sales DESC;

-- Extra: city-wise sales report
SELECT c.City,COUNT(DISTINCT o.Order_ID) AS Total_Orders,
       SUM(od.Quantity*od.Unit_Price) AS City_Sales
FROM Customers c JOIN Orders o ON c.Customer_ID=o.Customer_ID
JOIN Order_Details od ON o.Order_ID=od.Order_ID
GROUP BY c.City ORDER BY City_Sales DESC;
