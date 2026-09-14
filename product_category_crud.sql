CREATE TABLE Category (
    Category_ID     NUMBER PRIMARY KEY,
    Category_Name   VARCHAR2(50) NOT NULL,
    Description     VARCHAR2(255)
);

INSERT INTO Category (Category_ID, Category_Name, Description)
VALUES (1, 'Running', 'Running shoes for daily training and sports');

INSERT INTO Category (Category_ID, Category_Name, Description)
VALUES (2, 'Casual', 'Everyday casual footwear');

INSERT INTO Category (Category_ID, Category_Name, Description)
VALUES (3, 'Formal', 'Formal and office wear shoes');

INSERT INTO Category (Category_ID, Category_Name, Description)
VALUES (4, 'Sneakers', 'Lifestyle and streetwear sneakers');

INSERT INTO Category (Category_ID, Category_Name, Description)
VALUES (5, 'Sports', 'Performance footwear for outdoor sports');

CREATE TABLE Product (
    Product_ID          NUMBER PRIMARY KEY,
    Product_Name        VARCHAR2(100) NOT NULL,
    Brand_ID             NUMBER,
    Category_ID          NUMBER NOT NULL,
    Price                NUMBER(10,2) NOT NULL,
    Size                 VARCHAR2(10),
    Color                VARCHAR2(50),
    Stock                NUMBER NOT NULL,
    CONSTRAINT FK_Product_Category
        FOREIGN KEY (Category_ID)
        REFERENCES Category(Category_ID)
);

INSERT INTO Product
VALUES (101, 'Air Max Runner', 1, 1, 3499.00, '9', 'Black', 40);

INSERT INTO Product
VALUES (102, 'Cloud Stride', 2, 1, 3999.00, '8', 'Blue', 35);

INSERT INTO Product
VALUES (103, 'Urban Casual Slip-On', 3, 2, 1999.00, '9', 'Grey', 50);

INSERT INTO Product
VALUES (104, 'Everyday Canvas', 4, 2, 1499.00, '8', 'White', 45);

INSERT INTO Product
VALUES (105, 'Oxford Classic', 5, 3, 4499.00, '10', 'Black', 20);

INSERT INTO Product
VALUES (106, 'Derby Elite', 6, 3, 4999.00, '9', 'Brown', 18);

INSERT INTO Product
VALUES (107, 'Street Icon Sneaker', 7, 4, 5499.00, '9', 'White', 30);

INSERT INTO Product
VALUES (108, 'Retro Bold', 8, 4, 5999.00, '10', 'Red', 25);

INSERT INTO Product
VALUES (109, 'Trail Blazer Pro', 9, 5, 4299.00, '9', 'Black', 28);

INSERT INTO Product
VALUES (110, 'Court Smash', 10, 5, 3799.00, '8', 'Green', 32);

SELECT * FROM Category;

SELECT * FROM Product;

UPDATE Product
SET Price = 3299.00,
    Stock = 45
WHERE Product_ID = 101;

SELECT * FROM Product
WHERE Product_ID = 101;

UPDATE Product
SET Price = 4199.00
WHERE Product_Name = 'Cloud Stride';

SELECT * FROM Product
WHERE Product_Name = 'Cloud Stride';

DELETE FROM Product
WHERE Product_ID = 110;

SELECT * FROM Product
WHERE Product_ID = 110;

DELETE FROM Product
WHERE Product_Name = 'Trail Blazer Pro';

SELECT * FROM Product
WHERE Product_Name = 'Trail Blazer Pro';

SELECT * FROM Product;

SELECT
    c.Category_Name,
    p.Product_ID,
    p.Product_Name,
    p.Price,
    p.Stock
FROM Category c
JOIN Product p
    ON c.Category_ID = p.Category_ID
ORDER BY c.Category_Name, p.Product_Name;

SELECT
    p.Product_ID,
    p.Product_Name,
    p.Price,
    p.Stock
FROM Product p
JOIN Category c
    ON p.Category_ID = c.Category_ID
WHERE c.Category_Name = 'Sneakers';

SELECT
    c.Category_Name,
    COUNT(p.Product_ID) AS Total_Products
FROM Category c
LEFT JOIN Product p
    ON c.Category_ID = p.Category_ID
GROUP BY c.Category_Name
ORDER BY c.Category_Name;

COMMIT;
