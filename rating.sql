-- ============================================================
-- DBMS SKILL TASK - WEEK 6
-- File 2: rating_management.sql
-- E-Commerce Platform: One8 Shoe Store
-- Description: Rating table creation, score storage, 
--              aggregate analytics, and high-rating filtration.
-- ============================================================

-- Step 1: Create Table for Product Ratings
CREATE DATABASE IF NOT EXISTS one8_ecommerce;
USE one8_ecommerce;

DROP TABLE IF EXISTS product_ratings;

CREATE TABLE product_ratings (
    rating_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    customer_id INT NOT NULL,
    rating_score DECIMAL(2, 1) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_rating_range CHECK (rating_score BETWEEN 1.0 AND 5.0),
    CONSTRAINT unq_customer_product UNIQUE (product_id, customer_id)
);

-- Step 2: Store Customer Ratings (Sample Data for One8 Footwear)
INSERT INTO product_ratings (product_id, customer_id, rating_score) VALUES
    (101, 501, 5.0),
    (101, 502, 4.5),
    (101, 505, 5.0),
    (101, 509, 4.8),
    (102, 503, 3.5),
    (102, 506, 4.0),
    (102, 510, 3.8),
    (103, 504, 5.0),
    (103, 507, 4.8),
    (103, 511, 4.9),
    (104, 508, 2.5),
    (104, 512, 3.0);

-- Step 3: Calculate Average Product Ratings using Aggregate Functions
-- Computes Total Ratings Count, Average Score, Max Score, and Min Score per product
SELECT 
    product_id,
    COUNT(rating_id) AS total_ratings,
    ROUND(AVG(rating_score), 2) AS average_rating,
    MAX(rating_score) AS highest_rating,
    MIN(rating_score) AS lowest_rating
FROM product_ratings
GROUP BY product_id
ORDER BY average_rating DESC;

-- Step 4: Identify Highly Rated Products
-- Uses HAVING clause to filter products with an Average Rating >= 4.5
SELECT 
    product_id,
    COUNT(rating_id) AS total_ratings,
    ROUND(AVG(rating_score), 2) AS avg_rating,
    CASE 
        WHEN AVG(rating_score) >= 4.8 THEN 'Top Seller / Best Choice'
        WHEN AVG(rating_score) >= 4.5 THEN 'Highly Rated'
        ELSE 'Standard Rating'
    END AS rating_category
FROM product_ratings
GROUP BY product_id
HAVING AVG(rating_score) >= 4.5
ORDER BY avg_rating DESC;
