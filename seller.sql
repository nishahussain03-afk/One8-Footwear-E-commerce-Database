CREATE TABLE Seller (
    seller_id INT PRIMARY KEY,
    seller_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    address VARCHAR(255),
    city VARCHAR(50),
    state VARCHAR(50),
    pincode VARCHAR(10)
);
INSERT INTO Seller
VALUES (101, 'Arun Footwears', 'arun@gmail.com', '9876543210', '12 Anna Nagar', 'Chennai', 'ACTIVE');

INSERT INTO Seller
VALUES (102, 'WalkStyle Traders', 'walkstyle@gmail.com', '9876543211', '25 T Nagar', 'Chennai', 'ACTIVE');

INSERT INTO Seller
VALUES (103, 'StepUp Shoes', 'stepup@gmail.com', '9876543212', '18 Velachery Road', 'Chennai', 'ACTIVE');

INSERT INTO Seller
VALUES (104, 'Comfort Feet', 'comfortfeet@gmail.com', '9876543213', '45 Tambaram Main Road', 'Chennai', 'ACTIVE');

INSERT INTO Seller
VALUES (105, 'Urban Sole', 'urbansole@gmail.com', '9876543214', '30 Mount Road', 'Chennai', 'INACTIVE');

