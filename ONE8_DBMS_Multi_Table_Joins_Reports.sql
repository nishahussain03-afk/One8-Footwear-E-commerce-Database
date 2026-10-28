-- ONE8 Footwear E-Commerce DBMS: Multi-Table Joins and Reports
-- MySQL 8.0+. WARNING: This sample script drops/recreates these tables.
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
(5004,1004,NULL,'Net Banking',3199,'Pending');
-- Order 1005 has no payment record; customer 5 has no order.

-- 1. Combine customer, order, product and payment data (INNER JOIN)
SELECT c.Customer_Name,o.Order_ID,o.Order_Date,p.Product_Name,od.Quantity,
       od.Unit_Price,od.Quantity*od.Unit_Price AS Item_Total,
       pay.Payment_Method,pay.Amount,pay.Payment_Status
FROM Customers c
INNER JOIN Orders o ON c.Customer_ID=o.Customer_ID
INNER JOIN Order_Details od ON o.Order_ID=od.Order_ID
INNER JOIN Products p ON od.Product_ID=p.Product_ID
INNER JOIN Payments pay ON o.Order_ID=pay.Order_ID
ORDER BY o.Order_ID;

-- 2. INNER JOIN: only orders with matching payment records
SELECT o.Order_ID,c.Customer_Name,o.Order_Date,pay.Amount,pay.Payment_Status
FROM Orders o
INNER JOIN Customers c ON o.Customer_ID=c.Customer_ID
INNER JOIN Payments pay ON o.Order_ID=pay.Order_ID
ORDER BY o.Order_ID;

-- 3. LEFT JOIN: all orders, including orders without payment
SELECT o.Order_ID,c.Customer_Name,o.Order_Date,pay.Payment_Method,
       pay.Amount,pay.Payment_Status
FROM Orders o
INNER JOIN Customers c ON o.Customer_ID=c.Customer_ID
LEFT JOIN Payments pay ON o.Order_ID=pay.Order_ID
ORDER BY o.Order_ID;

-- 4. RIGHT JOIN: all customers, including customers without orders
SELECT c.Customer_ID,c.Customer_Name,o.Order_ID,o.Order_Date
FROM Orders o
RIGHT JOIN Customers c ON o.Customer_ID=c.Customer_ID
ORDER BY c.Customer_ID,o.Order_ID;

-- 5. Complete order details across customer, order, product and payment tables
SELECT o.Order_ID,o.Order_Date,o.Order_Status,c.Customer_Name,c.Email,c.City,
       p.Product_Name,od.Quantity,od.Unit_Price,
       od.Quantity*od.Unit_Price AS Item_Total,
       pay.Payment_Method,pay.Amount AS Payment_Amount,pay.Payment_Status
FROM Orders o
INNER JOIN Customers c ON o.Customer_ID=c.Customer_ID
INNER JOIN Order_Details od ON o.Order_ID=od.Order_ID
INNER JOIN Products p ON od.Product_ID=p.Product_ID
LEFT JOIN Payments pay ON o.Order_ID=pay.Order_ID
ORDER BY o.Order_ID,od.Order_Detail_ID;

-- 6. Customer purchase history (includes customers with no orders)
SELECT c.Customer_ID,c.Customer_Name,o.Order_ID,o.Order_Date,p.Product_Name,
       od.Quantity,od.Unit_Price,od.Quantity*od.Unit_Price AS Item_Total,
       o.Order_Status
FROM Customers c
LEFT JOIN Orders o ON c.Customer_ID=o.Customer_ID
LEFT JOIN Order_Details od ON o.Order_ID=od.Order_ID
LEFT JOIN Products p ON od.Product_ID=p.Product_ID
ORDER BY c.Customer_ID,o.Order_Date,o.Order_ID;

-- 7. Customer-wise total orders and purchase value
SELECT c.Customer_ID,c.Customer_Name,COUNT(DISTINCT o.Order_ID) AS Total_Orders,
       COALESCE(SUM(od.Quantity*od.Unit_Price),0) AS Total_Purchase_Value
FROM Customers c
LEFT JOIN Orders o ON c.Customer_ID=o.Customer_ID
LEFT JOIN Order_Details od ON o.Order_ID=od.Order_ID
GROUP BY c.Customer_ID,c.Customer_Name
ORDER BY Total_Purchase_Value DESC;

-- 8. Product-wise sales report
SELECT p.Product_ID,p.Product_Name,COALESCE(SUM(od.Quantity),0) AS Units_Sold,
       COALESCE(SUM(od.Quantity*od.Unit_Price),0) AS Sales_Value
FROM Products p
LEFT JOIN Order_Details od ON p.Product_ID=od.Product_ID
GROUP BY p.Product_ID,p.Product_Name
ORDER BY Sales_Value DESC;

-- 9. Payment report by method and status
SELECT Payment_Method,Payment_Status,COUNT(*) AS Number_Of_Payments,
       SUM(Amount) AS Total_Amount
FROM Payments
GROUP BY Payment_Method,Payment_Status
ORDER BY Payment_Method,Payment_Status;

-- 10. Find pending payments or orders with no payment record
SELECT o.Order_ID,c.Customer_Name,
       COALESCE(pay.Payment_Status,'No Payment Record') AS Payment_Status,pay.Amount
FROM Orders o
INNER JOIN Customers c ON o.Customer_ID=c.Customer_ID
LEFT JOIN Payments pay ON o.Order_ID=pay.Order_ID
WHERE pay.Payment_Status='Pending' OR pay.Payment_ID IS NULL
ORDER BY o.Order_ID;

-- 11. Multi-table report: customer, order, product, line total, payment status
SELECT c.Customer_Name,o.Order_ID,o.Order_Date,p.Product_Name,od.Quantity,
       od.Quantity*od.Unit_Price AS Line_Total,
       COALESCE(pay.Payment_Status,'No Payment Record') AS Payment_Status
FROM Customers c
INNER JOIN Orders o ON c.Customer_ID=o.Customer_ID
INNER JOIN Order_Details od ON o.Order_ID=od.Order_ID
INNER JOIN Products p ON od.Product_ID=p.Product_ID
LEFT JOIN Payments pay ON o.Order_ID=pay.Order_ID
ORDER BY c.Customer_Name,o.Order_ID;
