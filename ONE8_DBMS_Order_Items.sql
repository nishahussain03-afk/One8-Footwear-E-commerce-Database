CREATE DATABASE IF NOT EXISTS ONE8_Shoes;
USE ONE8_Shoes;

DROP TABLE IF EXISTS Order_Items;

CREATE TABLE Order_Items (
    Order_Item_ID INT PRIMARY KEY,
    Order_ID INT NOT NULL,
    Product_ID INT NOT NULL,
    Quantity INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID)
);

INSERT INTO Order_Items
(Order_Item_ID, Order_ID, Product_ID, Quantity, Price)
VALUES
(1, 101, 201, 1, 2499.00),
(2, 102, 202, 2, 1749.00),
(3, 103, 203, 1, 1999.00),
(4, 104, 204, 2, 2299.00),
(5, 105, 205, 1, 2999.00),
(6, 101, 202, 1, 1749.00),
(7, 102, 205, 1, 2999.00),
(8, 104, 201, 1, 2499.00);

UPDATE Order_Items
SET Quantity = 2
WHERE Order_Item_ID = 1;

SELECT * FROM Order_Items;

SELECT
    oi.Order_Item_ID,
    oi.Order_ID,
    oi.Product_ID,
    oi.Quantity,
    oi.Price,
    (oi.Quantity * oi.Price) AS Item_Total
FROM Order_Items oi
ORDER BY oi.Order_ID;

SELECT
    oi.Order_ID,
    o.Customer_ID,
    o.Order_Date,
    oi.Product_ID,
    oi.Quantity,
    oi.Price,
    (oi.Quantity * oi.Price) AS Item_Total
FROM Order_Items oi
JOIN Orders o
ON oi.Order_ID = o.Order_ID
ORDER BY oi.Order_ID;

SELECT
    Product_ID,
    SUM(Quantity) AS Total_Quantity_Ordered
FROM Order_Items
GROUP BY Product_ID
ORDER BY Total_Quantity_Ordered DESC;

SELECT
    Order_ID,
    SUM(Quantity * Price) AS Order_Item_Total
FROM Order_Items
GROUP BY Order_ID
ORDER BY Order_ID;
