CREATE TABLE Inventory (
    inventory_id INT PRIMARY KEY,
    seller_id INT,
    product_id INT,
    quantity INT NOT NULL,
    reorder_level INT,
    stock_status VARCHAR(20),
    last_updated DATE,
    FOREIGN KEY (seller_id) REFERENCES Seller(seller_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);
INSERT INTO Inventory
VALUES (1, 101, 201, 25, 5, 'AVAILABLE', SYSDATE);

INSERT INTO Inventory
VALUES (2, 102, 202, 0, 5, 'UNAVAILABLE', SYSDATE);

INSERT INTO Inventory
VALUES (3, 103, 203, 15, 5, 'AVAILABLE', SYSDATE);

INSERT INTO Inventory
VALUES (4, 104, 204, 3, 5, 'AVAILABLE', SYSDATE);

INSERT INTO Inventory
VALUES (5, 105, 205, 0, 5, 'UNAVAILABLE', SYSDATE);
