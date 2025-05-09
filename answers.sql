-- Test change
SELECT * FROM ProductDetail;

-- Question 1: Achieving 1NF
SELECT 
    OrderID,
    CustomerName,
    TRIM(value) AS Product
FROM 
    ProductDetail,
    LATERAL STRING_SPLIT(Products, ',');

-- Question 2: Achieving 2NF

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

CREATE TABLE OrderLine (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

INSERT INTO OrderLine (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;
