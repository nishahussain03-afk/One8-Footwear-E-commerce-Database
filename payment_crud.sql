CREATE TABLE Orders (
    Order_ID        NUMBER PRIMARY KEY,
    Customer_ID     NUMBER NOT NULL,
    Order_Date      DATE,
    Total_Amount    NUMBER(10,2),
    Order_Status    VARCHAR2(20)
);

INSERT INTO Orders VALUES (201, 1, TO_DATE('05-01-2026','DD-MM-YYYY'), 3299.00, 'Delivered');
INSERT INTO Orders VALUES (202, 2, TO_DATE('06-01-2026','DD-MM-YYYY'), 4199.00, 'Delivered');
INSERT INTO Orders VALUES (203, 3, TO_DATE('08-01-2026','DD-MM-YYYY'), 1999.00, 'Shipped');
INSERT INTO Orders VALUES (204, 4, TO_DATE('09-01-2026','DD-MM-YYYY'), 1499.00, 'Delivered');
INSERT INTO Orders VALUES (205, 5, TO_DATE('10-01-2026','DD-MM-YYYY'), 4499.00, 'Pending');
INSERT INTO Orders VALUES (206, 6, TO_DATE('11-01-2026','DD-MM-YYYY'), 4999.00, 'Delivered');
INSERT INTO Orders VALUES (207, 7, TO_DATE('12-01-2026','DD-MM-YYYY'), 5499.00, 'Cancelled');
INSERT INTO Orders VALUES (208, 8, TO_DATE('13-01-2026','DD-MM-YYYY'), 5999.00, 'Shipped');

CREATE TABLE Payment (
    Payment_ID       NUMBER PRIMARY KEY,
    Order_ID         NUMBER NOT NULL,
    Payment_Mode     VARCHAR2(30) NOT NULL,
    Payment_Date     DATE NOT NULL,
    Amount           NUMBER(10,2) NOT NULL,
    Payment_Status   VARCHAR2(20) DEFAULT 'Pending' NOT NULL,
    CONSTRAINT FK_Payment_Order
        FOREIGN KEY (Order_ID)
        REFERENCES Orders(Order_ID),
    CONSTRAINT CHK_Payment_Status
        CHECK (Payment_Status IN ('Success', 'Failed', 'Pending'))
);

INSERT INTO Payment VALUES (301, 201, 'UPI', TO_DATE('05-01-2026','DD-MM-YYYY'), 3299.00, 'Success');
INSERT INTO Payment VALUES (302, 202, 'Credit Card', TO_DATE('06-01-2026','DD-MM-YYYY'), 4199.00, 'Success');
INSERT INTO Payment VALUES (303, 203, 'Net Banking', TO_DATE('08-01-2026','DD-MM-YYYY'), 1999.00, 'Success');
INSERT INTO Payment VALUES (304, 204, 'Debit Card', TO_DATE('09-01-2026','DD-MM-YYYY'), 1499.00, 'Failed');
INSERT INTO Payment VALUES (305, 205, 'UPI', TO_DATE('10-01-2026','DD-MM-YYYY'), 4499.00, 'Pending');
INSERT INTO Payment VALUES (306, 206, 'Credit Card', TO_DATE('11-01-2026','DD-MM-YYYY'), 4999.00, 'Success');
INSERT INTO Payment VALUES (307, 207, 'Cash on Delivery', TO_DATE('12-01-2026','DD-MM-YYYY'), 5499.00, 'Failed');
INSERT INTO Payment VALUES (308, 208, 'UPI', TO_DATE('13-01-2026','DD-MM-YYYY'), 5999.00, 'Success');

SELECT * FROM Payment;

-- Manage successful and failed transactions
SELECT * FROM Payment
WHERE Payment_Status = 'Success';

SELECT * FROM Payment
WHERE Payment_Status = 'Failed';

-- Retry a failed payment and mark it successful
UPDATE Payment
SET Payment_Status = 'Success',
    Payment_Date   = TO_DATE('14-01-2026','DD-MM-YYYY')
WHERE Payment_ID = 304;

-- Resolve a pending payment
UPDATE Payment
SET Payment_Status = 'Success'
WHERE Payment_ID = 305;

SELECT * FROM Payment
WHERE Payment_ID IN (304, 305);

-- Analyze payment methods used by customers
SELECT
    Payment_Mode,
    COUNT(*) AS Total_Transactions,
    SUM(Amount) AS Total_Amount
FROM Payment
GROUP BY Payment_Mode
ORDER BY Total_Transactions DESC;

-- Payment status summary
SELECT
    Payment_Status,
    COUNT(*) AS Total_Transactions
FROM Payment
GROUP BY Payment_Status
ORDER BY Payment_Status;

-- Payment transaction report (Customer + Order + Payment)
SELECT
    c.Customer_Name,
    o.Order_ID,
    p.Payment_Mode,
    p.Payment_Date,
    p.Amount,
    p.Payment_Status
FROM Payment p
JOIN Orders o
    ON p.Order_ID = o.Order_ID
JOIN Customer c
    ON o.Customer_ID = c.Customer_ID
ORDER BY p.Payment_Date;

COMMIT;
