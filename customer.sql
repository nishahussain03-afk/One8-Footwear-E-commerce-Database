-- ===========================================
-- ONE8 Footwear E-Commerce Database
-- CUSTOMER TABLE
-- ===========================================

-- Create Customer Table

CREATE TABLE Customer (
    Customer_ID     NUMBER(5) PRIMARY KEY,
    Customer_Name   VARCHAR2(50) NOT NULL,
    Email           VARCHAR2(50) UNIQUE,
    Phone_Number    NUMBER(10) UNIQUE,
    Address         VARCHAR2(50),
    Password        VARCHAR2(20)
);

-- ===========================================
-- Insert Records
-- ===========================================

INSERT INTO Customer VALUES (101, 'Aarav Mehta', 'aarav.mehta@gmail.com', 9876500101, 'Chennai, Tamil Nadu', 'aarav@123');

INSERT INTO Customer VALUES (102, 'Diya Sharma', 'diya.sharma@gmail.com', 9876500102, 'Mumbai, Maharashtra', 'diya@456');

INSERT INTO Customer VALUES (103, 'Kabir Nair', 'kabir.nair@gmail.com', 9876500103, 'Bengaluru, Karnataka', 'kabir@789');

INSERT INTO Customer VALUES (104, 'Ishita Rao', 'ishita.rao@gmail.com', 9876500104, 'Hyderabad, Telangana', 'ishita@321');

INSERT INTO Customer VALUES (105, 'Rohan Verma', 'rohan.verma@gmail.com', 9876500105, 'Delhi', 'rohan@654');

INSERT INTO Customer VALUES (106, 'Ananya Iyer', 'ananya.iyer@gmail.com', 9876500106, 'Kochi, Kerala', 'ananya@987');

INSERT INTO Customer VALUES (107, 'Vivaan Kapoor', 'vivaan.kapoor@gmail.com', 9876500107, 'Pune, Maharashtra', 'vivaan@159');

INSERT INTO Customer VALUES (108, 'Sara Fernandes', 'sara.fernandes@gmail.com', 9876500108, 'Goa', 'sara@753');

INSERT INTO Customer VALUES (109, 'Aditya Reddy', 'aditya.reddy@gmail.com', 9876500109, 'Coimbatore, Tamil Nadu', 'aditya@246');

INSERT INTO Customer VALUES (110, 'Meera Pillai', 'meera.pillai@gmail.com', 9876500110, 'Trivandrum, Kerala', 'meera@864');

COMMIT;

-- ===========================================
-- Display Records
-- ===========================================

SELECT * FROM Customer;

-- ===========================================
-- Update Record
-- ===========================================

UPDATE Customer
SET Address = 'Bandra, Mumbai, Maharashtra',
    Password = 'rohan@999'
WHERE Customer_ID = 105;

COMMIT;

-- ===========================================
-- Display Updated Records
-- ===========================================

SELECT * FROM Customer;

-- ===========================================
-- Delete Record
-- ===========================================

DELETE FROM Customer
WHERE Customer_ID = 110;

COMMIT;

-- ===========================================
-- Display Final Records
-- ===========================================

SELECT * FROM Customer;
