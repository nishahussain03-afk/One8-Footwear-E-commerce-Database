CREATE TABLE Customer (
    Customer_ID     NUMBER PRIMARY KEY,
    Customer_Name   VARCHAR2(100) NOT NULL,
    Email           VARCHAR2(100) UNIQUE NOT NULL,
    Phone_Number    VARCHAR2(15),
    Password        VARCHAR2(50) NOT NULL,
    Address         VARCHAR2(255)
);

INSERT INTO Customer
VALUES (1, 'Renu Srinivasan', 'renu@gmail.com', '9876543210', 'renu@123', 'Chennai');

INSERT INTO Customer
VALUES (2, 'Arjun Kumar', 'arjun.kumar@gmail.com', '9876501234', 'arjun@123', 'Coimbatore');

INSERT INTO Customer
VALUES (3, 'Priya Kumar', 'priya.kumar@gmail.com', '9876512345', 'priya@123', 'Madurai');

INSERT INTO Customer
VALUES (4, 'Rahul Sharma', 'rahul.sharma@gmail.com', '9876523456', 'rahul@123', 'Salem');

INSERT INTO Customer
VALUES (5, 'Keerthana Mohan', 'keerthana.mohan@gmail.com', '9876534567', 'keerthana@123', 'Trichy');

INSERT INTO Customer
VALUES (6, 'Nandhini Ravi', 'nandhini.ravi@gmail.com', '9876545678', 'nandhini@123', 'Erode');

INSERT INTO Customer
VALUES (7, 'Karthik Prakash', 'karthik.prakash@gmail.com', '9876556789', 'karthik@123', 'Vellore');

INSERT INTO Customer
VALUES (8, 'Swetha Balaji', 'swetha.balaji@gmail.com', '9876567890', 'swetha@123', 'Tirunelveli');

INSERT INTO Customer
VALUES (9, 'Vignesh Ganesh', 'vignesh.ganesh@gmail.com', '9876578901', 'vignesh@123', 'Thanjavur');

INSERT INTO Customer
VALUES (10, 'Meena Krishnan', 'meena.krishnan@gmail.com', '9876589012', 'meena@123', 'Kanchipuram');

SELECT * FROM Customer;

SELECT * FROM Customer
WHERE Customer_ID = 1;

SELECT * FROM Customer
WHERE Email = 'renu@gmail.com';

SELECT * FROM Customer
WHERE Customer_Name = 'Renu Srinivasan';

SELECT * FROM Customer
WHERE Address = 'Chennai';

SELECT Customer_ID, Customer_Name, Email
FROM Customer;

SELECT * FROM Customer
ORDER BY Customer_Name;

SELECT COUNT(*) AS Total_Customers
FROM Customer;

UPDATE Customer
SET Phone_Number = '9123456789'
WHERE Customer_ID = 1;

SELECT * FROM Customer
WHERE Customer_ID = 1;

UPDATE Customer
SET Address = 'Anna Nagar, Chennai'
WHERE Customer_ID = 2;

SELECT * FROM Customer
WHERE Customer_ID = 2;

UPDATE Customer
SET Email = 'priya.new@gmail.com'
WHERE Customer_ID = 3;

SELECT * FROM Customer
WHERE Customer_ID = 3;

DELETE FROM Customer
WHERE Email = 'meena.krishnan@gmail.com';

SELECT * FROM Customer;

COMMIT;
