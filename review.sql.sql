-- ============================================================
-- DBMS SKILL TASK - WEEK 6
-- File 1: review_management.sql
-- E-Commerce Platform: One8 Shoe Store
-- Description: Review table creation, feedback storage, 
--              and detailed retrieval queries.
-- ============================================================

-- Step 1: Create Database and Table for Product Reviews
CREATE DATABASE IF NOT EXISTS one8_ecommerce;
USE one8_ecommerce;

DROP TABLE IF EXISTS product_reviews;

CREATE TABLE product_reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    customer_id INT NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    review_title VARCHAR(150) NOT NULL,
    review_text TEXT NOT NULL,
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_verified_purchase BOOLEAN DEFAULT TRUE
);

-- Step 2: Store Customer Feedback (Sample Data for One8 Footwear Models)
INSERT INTO product_reviews 
    (product_id, customer_id, customer_name, review_title, review_text, is_verified_purchase) 
VALUES
    (101, 501, 'Arjun Kumar', 'Exceptional Court Grip!', 'The One8 Fuse 2.0 shoes have incredible traction on the court and fit true to size. Highly recommended for intense workouts.', TRUE),
    (101, 502, 'Priya Sharma', 'Super Comfortable & Lightweight', 'Lightweight and sleek design. Perfect for daily running sessions and urban casual wear.', TRUE),
    (102, 503, 'Rohan Verma', 'Stylish, but stiff initially', 'The One8 Drift Cat looks incredibly stylish in matte black, but takes a couple of days to break in properly.', TRUE),
    (103, 504, 'Ananya Roy', 'Top Notch Material Quality', 'Premium leather material with superb stitching. Feels comfortable even during 10+ hour shifts.', TRUE),
    (101, 505, 'Siddharth Nair', 'Loved the Ankle Support', 'Soft foam sole and strong ankle reinforcement. Great choice for long distance runs.', TRUE),
    (104, 506, 'Meera Reddy', 'Decent performance for price', 'Good budget shoe from One8 line, but the cushion padding could be improved for running.', TRUE);

-- Step 3: Retrieve Product Review Details

-- Query A: Retrieve all customer feedback specifically for 'One8 Fuse 2.0' (Product ID 101)
SELECT 
    review_id,
    customer_name,
    review_title,
    review_text,
    DATE_FORMAT(review_date, '%Y-%m-%d') AS review_date,
    IF(is_verified_purchase, 'Verified', 'Unverified') AS purchase_status
FROM product_reviews
WHERE product_id = 101
ORDER BY review_date DESC;

-- Query B: Search reviews containing specific keywords (e.g., 'comfortable' or 'cushioning')
SELECT 
    product_id,
    customer_name,
    review_title,
    review_text
FROM product_reviews
WHERE review_text LIKE '%comfortable%' OR review_text LIKE '%cushion%'
ORDER BY product_id;

-- Query C: Global audit log of all customer reviews across the platform
SELECT 
    r.review_id,
    r.product_id,
    r.customer_name,
    r.review_title,
    r.review_text,
    r.review_date
FROM product_reviews r
ORDER BY r.product_id ASC, r.review_date DESC;