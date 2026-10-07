CREATE DATABASE IF NOT EXISTS ONE8_Shoes;
USE ONE8_Shoes;

DROP TABLE IF EXISTS Order_Details;
DROP TABLE IF EXISTS Orders;

CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY,
    Customer_ID INT NOT NULL,
    Order_Date DATE NOT NULL,
    Total_Amount DECIMAL(10,2) NOT NULL,
    Order_Status VARCHAR(30) NOT NULL
);

CREATE TABLE Order_Details (
    Order_Detail_ID INT PRIMARY KEY,
    Order_ID INT NOT NULL,
    Product_ID INT NOT NULL,
    Quantity INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID)
);

INSERT INTO Orders
(Order_ID, Customer_ID, Order_Date, Total_Amount, Order_Status)
VALUES
(101, 101, '2026-10-01', 2499.00, 'Confirmed'),
(102, 102, '2026-10-02', 3498.00, 'Shipped'),
(103, 103, '2026-10-03', 1999.00, 'Delivered'),
(104, 104, '2026-10-04', 4598.00, 'Confirmed'),
(105, 105, '2026-10-05', 2999.00, 'Pending');

INSERT INTO Order_Details
(Order_Detail_ID, Order_ID, Product_ID, Quantity, Price)
VALUES
(1, 101, 201, 1, 2499.00),
(2, 102, 202, 2, 1749.00),
(3, 103, 203, 1, 1999.00),
(4, 104, 204, 2, 2299.00),
(5, 105, 205, 1, 2999.00);

UPDATE Orders
SET Order_Status = 'Shipped'
WHERE Order_ID = 101;

UPDATE Order_Details
SET Quantity = 2
WHERE Order_Detail_ID = 1;

SELECT * FROM Orders;

SELECT * FROM Order_Details;

SELECT
    o.Order_ID,
    o.Customer_ID,
    o.Order_Date,
    od.Product_ID,
    od.Quantity,
    od.Price,
    o.Total_Amount,
    o.Order_Status
FROM Orders o
JOIN Order_Details od
ON o.Order_ID = od.Order_ID
ORDER BY o.Order_ID;

SELECT
    Customer_ID,
    Order_ID,
    Order_Date,
    Total_Amount,
    Order_Status
FROM Orders
ORDER BY Customer_ID, Order_Date;

SELECT
    o.Customer_ID,
    o.Order_ID,
    o.Order_Date,
    SUM(od.Quantity * od.Price) AS Calculated_Total
FROM Orders o
JOIN Order_Details od
ON o.Order_ID = od.Order_ID
GROUP BY o.Customer_ID, o.Order_ID, o.Order_Date
ORDER BY o.Customer_ID;

SELECT
    Customer_ID,
    COUNT(Order_ID) AS Total_Orders,
    SUM(Total_Amount) AS Total_Spending
FROM Orders
GROUP BY Customer_ID
ORDER BY Total_Spending DESC;
