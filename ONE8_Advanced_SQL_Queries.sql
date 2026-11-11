-- ONE8 Footwear E-Commerce DBMS: Advanced SQL Query Implementation
-- MySQL 8.0+ | Sample standalone script
-- WARNING: DROP TABLE removes and recreates these sample tables. Back up data first.
CREATE DATABASE IF NOT EXISTS ONE8_Shoes;
USE ONE8_Shoes;
SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS Order_Details;
DROP TABLE IF EXISTS Payments;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Customers;
SET FOREIGN_KEY_CHECKS=1;

CREATE TABLE Customers(Customer_ID INT PRIMARY KEY, Customer_Name VARCHAR(100) NOT NULL, Email VARCHAR(120), City VARCHAR(60));
CREATE TABLE Products(Product_ID INT PRIMARY KEY, Product_Name VARCHAR(120), Category VARCHAR(60), Price DECIMAL(10,2), Color VARCHAR(40));
CREATE TABLE Orders(Order_ID INT PRIMARY KEY, Customer_ID INT, Order_Date DATE, Order_Status VARCHAR(30), FOREIGN KEY(Customer_ID) REFERENCES Customers(Customer_ID));
CREATE TABLE Order_Details(Order_Detail_ID INT PRIMARY KEY, Order_ID INT, Product_ID INT, Quantity INT, Unit_Price DECIMAL(10,2), FOREIGN KEY(Order_ID) REFERENCES Orders(Order_ID), FOREIGN KEY(Product_ID) REFERENCES Products(Product_ID));
CREATE TABLE Payments(Payment_ID INT PRIMARY KEY, Order_ID INT, Payment_Date DATE, Payment_Method VARCHAR(40), Amount DECIMAL(10,2), Payment_Status VARCHAR(30), FOREIGN KEY(Order_ID) REFERENCES Orders(Order_ID));

INSERT INTO Customers VALUES
(1,'Arun Kumar','arun@example.com','Chennai'),(2,'Priya Sharma','priya@example.com','Coimbatore'),
(3,'Rahul Das','rahul@example.com','Chennai'),(4,'Meena Raj','meena@example.com','Madurai'),
(5,'Kavin Raj','kavin@example.com','Salem'),(6,'Divya S','divya@example.com','Chennai');
INSERT INTO Products VALUES
(201,'ONE8 Runner Pro','Running Shoes',2999,'Black'),(202,'ONE8 Court Flex','Sports Shoes',3499,'White'),
(203,'ONE8 Street Classic','Casual Shoes',2499,'Black'),(204,'ONE8 Urban Lite','Sneakers',2799,'Grey'),
(205,'ONE8 Trail Grip','Walking Shoes',3199,'Blue'),(206,'ONE8 Formal Edge','Formal Shoes',3999,'Brown'),
(207,'ONE8 Sprint Max','Running Shoes',4599,'Red');
INSERT INTO Orders VALUES
(1001,1,'2026-10-01','Delivered'),(1002,2,'2026-10-03','Shipped'),
(1003,1,'2026-10-08','Delivered'),(1004,3,'2026-10-10','Processing'),
(1005,4,'2026-10-12','Delivered'),(1006,2,'2026-10-15','Delivered');
INSERT INTO Order_Details VALUES
(1,1001,201,1,2999),(2,1001,203,1,2499),(3,1002,202,1,3499),
(4,1003,204,2,2799),(5,1004,205,1,3199),(6,1005,206,1,3999),
(7,1006,201,2,2999),(8,1006,202,1,3499);
INSERT INTO Payments VALUES
(5001,1001,'2026-10-01','UPI',5498,'Paid'),(5002,1002,'2026-10-03','Card',3499,'Paid'),
(5003,1003,'2026-10-08','UPI',5598,'Paid'),(5004,1004,'2026-10-10','Net Banking',3199,'Pending'),
(5005,1005,'2026-10-12','Card',3999,'Paid'),(5006,1006,'2026-10-15','UPI',9497,'Paid');

-- 1. Subquery: products above the average product price
SELECT Product_ID,Product_Name,Category,Price FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products) ORDER BY Price DESC;

-- 2. Nested/correlated query: products above their own category average
SELECT p.Product_ID,p.Product_Name,p.Category,p.Price FROM Products p
WHERE p.Price > (SELECT AVG(p2.Price) FROM Products p2 WHERE p2.Category=p.Category)
ORDER BY p.Category,p.Price DESC;

-- 3. Customers whose purchase total is above the average customer purchase
SELECT c.Customer_ID,c.Customer_Name,SUM(od.Quantity*od.Unit_Price) AS Purchase_Total
FROM Customers c JOIN Orders o ON c.Customer_ID=o.Customer_ID
JOIN Order_Details od ON o.Order_ID=od.Order_ID
GROUP BY c.Customer_ID,c.Customer_Name
HAVING SUM(od.Quantity*od.Unit_Price) > (
 SELECT AVG(Customer_Total) FROM (
  SELECT SUM(d.Quantity*d.Unit_Price) AS Customer_Total
  FROM Orders x JOIN Order_Details d ON x.Order_ID=d.Order_ID GROUP BY x.Customer_ID
 ) AS Customer_Averages
) ORDER BY Purchase_Total DESC;

-- 4. Customer(s) with maximum total purchase amount; includes ties
SELECT c.Customer_ID,c.Customer_Name,SUM(d.Quantity*d.Unit_Price) AS Maximum_Purchase
FROM Customers c JOIN Orders o ON c.Customer_ID=o.Customer_ID
JOIN Order_Details d ON o.Order_ID=d.Order_ID
GROUP BY c.Customer_ID,c.Customer_Name
HAVING SUM(d.Quantity*d.Unit_Price) = (
 SELECT MAX(Customer_Total) FROM (
  SELECT SUM(d2.Quantity*d2.Unit_Price) AS Customer_Total
  FROM Orders o2 JOIN Order_Details d2 ON o2.Order_ID=d2.Order_ID GROUP BY o2.Customer_ID
 ) AS Customer_Totals
);

-- 5. Complex query: products never purchased
SELECT p.Product_ID,p.Product_Name,p.Category,p.Price FROM Products p
WHERE NOT EXISTS (SELECT 1 FROM Order_Details d WHERE d.Product_ID=p.Product_ID);

-- 6. Complex nested query: customers who purchased every Running Shoes product
SELECT c.Customer_ID,c.Customer_Name FROM Customers c
WHERE NOT EXISTS (
 SELECT 1 FROM Products p WHERE p.Category='Running Shoes'
 AND NOT EXISTS (
  SELECT 1 FROM Orders o JOIN Order_Details d ON o.Order_ID=d.Order_ID
  WHERE o.Customer_ID=c.Customer_ID AND d.Product_ID=p.Product_ID
 )
);

-- 7. Products selling above average quantity per product (including zero-sales products)
SELECT p.Product_ID,p.Product_Name,COALESCE(SUM(d.Quantity),0) AS Units_Sold
FROM Products p LEFT JOIN Order_Details d ON p.Product_ID=d.Product_ID
GROUP BY p.Product_ID,p.Product_Name
HAVING COALESCE(SUM(d.Quantity),0) > (
 SELECT AVG(Product_Quantity) FROM (
  SELECT p2.Product_ID,COALESCE(SUM(d2.Quantity),0) AS Product_Quantity
  FROM Products p2 LEFT JOIN Order_Details d2 ON p2.Product_ID=d2.Product_ID
  GROUP BY p2.Product_ID
 ) AS Product_Averages
) ORDER BY Units_Sold DESC;

-- 8. Advanced customer report: total order value and number of orders
SELECT c.Customer_ID,c.Customer_Name,COUNT(DISTINCT o.Order_ID) AS Total_Orders,
       SUM(d.Quantity*d.Unit_Price) AS Total_Purchase
FROM Customers c JOIN Orders o ON c.Customer_ID=o.Customer_ID
JOIN Order_Details d ON o.Order_ID=d.Order_ID
GROUP BY c.Customer_ID,c.Customer_Name ORDER BY Total_Purchase DESC;

-- 9. Category sales above average category sales
SELECT Category,Category_Sales FROM (
 SELECT p.Category,SUM(d.Quantity*d.Unit_Price) AS Category_Sales
 FROM Products p JOIN Order_Details d ON p.Product_ID=d.Product_ID GROUP BY p.Category
) AS Category_Report
WHERE Category_Sales > (
 SELECT AVG(Category_Total) FROM (
  SELECT SUM(d2.Quantity*d2.Unit_Price) AS Category_Total
  FROM Products p2 JOIN Order_Details d2 ON p2.Product_ID=d2.Product_ID
  GROUP BY p2.Category
 ) AS Category_Averages
) ORDER BY Category_Sales DESC;

-- 10. Orders whose total value is greater than average order value
SELECT o.Order_ID,c.Customer_Name,o.Order_Date,SUM(d.Quantity*d.Unit_Price) AS Order_Total
FROM Orders o JOIN Customers c ON o.Customer_ID=c.Customer_ID
JOIN Order_Details d ON o.Order_ID=d.Order_ID
GROUP BY o.Order_ID,c.Customer_Name,o.Order_Date
HAVING SUM(d.Quantity*d.Unit_Price) > (
 SELECT AVG(Order_Total) FROM (
  SELECT SUM(Quantity*Unit_Price) AS Order_Total
  FROM Order_Details GROUP BY Order_ID
 ) AS Average_Order_Values
) ORDER BY Order_Total DESC;
