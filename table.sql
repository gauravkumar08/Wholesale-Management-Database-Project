CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(255),
    Category VARCHAR(255),
    Quantity INT,
    CostPrice DECIMAL(10, 2),
    SellingPrice DECIMAL(10, 2)
);

CREATE TABLE Buyers (
    BuyerID INT PRIMARY KEY,
    BuyerName VARCHAR(255),
    ContactNumber VARCHAR(15),
    Email VARCHAR(255),
    Address TEXT
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    BuyerID INT,
    ProductID INT,
    Quantity INT,
    OrderDate DATE,
    Status ENUM('Pending', 'Shipped', 'Delivered'),
    FOREIGN KEY (BuyerID) REFERENCES Buyers(BuyerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(255),
    ContactNumber VARCHAR(15),
    Email VARCHAR(255),
    Address TEXT
);

CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    OrderID INT,
    Amount DECIMAL(10, 2),
    PaymentDate DATE,
    Status ENUM('Paid', 'Pending'),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);


CREATE TABLE MonthlyProfits (
    MonthYear DATE PRIMARY KEY,
    TotalSales DECIMAL(10, 2),
    TotalExpenses DECIMAL(10, 2),
    Profit DECIMAL(10, 2)
);
