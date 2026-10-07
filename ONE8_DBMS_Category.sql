CREATE DATABASE IF NOT EXISTS ONE8_Shoes;
USE ONE8_Shoes;

DROP TABLE IF EXISTS Category;

CREATE TABLE Category (
    Category_ID INT PRIMARY KEY,
    Category_Name VARCHAR(100) NOT NULL,
    Description VARCHAR(255)
);

INSERT INTO Category
(Category_ID, Category_Name, Description)
VALUES
(1, 'Running Shoes', 'Shoes designed for running and jogging'),
(2, 'Sports Shoes', 'Shoes suitable for sports and physical activities'),
(3, 'Casual Shoes', 'Comfortable shoes for everyday use'),
(4, 'Formal Shoes', 'Shoes suitable for formal occasions'),
(5, 'Sneakers', 'Stylish footwear for casual and daily wear'),
(6, 'Sandals', 'Open footwear for casual use'),
(7, 'Boots', 'Durable footwear covering the foot and ankle'),
(8, 'Walking Shoes', 'Comfortable shoes designed for walking');

SELECT * FROM Category;

SELECT
    Category_ID,
    Category_Name,
    Description
FROM Category
ORDER BY Category_Name;

SELECT
    Category_ID,
    Category_Name
FROM Category
WHERE Category_Name LIKE '%Shoes%';

UPDATE Category
SET Description = 'Comfortable and lightweight shoes for daily walking'
WHERE Category_ID = 8;

SELECT * FROM Category
WHERE Category_ID = 8;

SELECT
    COUNT(*) AS Total_Categories
FROM Category;

SELECT
    Category_ID,
    Category_Name,
    Description
FROM Category
WHERE Category_Name LIKE 'S%';
