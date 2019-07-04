--Challenge 1: Creating scripts to insert sales orders

--1. Write code to insert an order header
DECLARE @OrderDate datetime = GETDATE();
DECLARE @DueDate datetime = DATEADD(dd, 7, GETDATE());
DECLARE @CustomerID int = 1;
DECLARE @OrderID int;

SET @OrderID = NEXT VALUE FOR SalesLT.SalesOrderNumber;

INSERT INTO SalesLT.SalesOrderHeader (SalesOrderID, OrderDate, DueDate, CustomerID, ShipMethod)
VALUES
(@OrderID, @OrderDate, @DueDate, @CustomerID, 'CARGO TRANSPORT 5');

PRINT @OrderID;

SELECT SalesOrderID, OrderDate, DueDate, CustomerID, ShipMethod
FROM SalesLT.SalesOrderHeader;

--2. Write code to insert an order detail
DECLARE @SalesOrderID int = 4
DECLARE @ProductID int = 760;
DECLARE @Quantity int = 1;
DECLARE @UnitPrice money = 782.99;

SET @SalesOrderID = 0; -- test with the order ID generated for the sales order header inserted above

IF EXISTS (SELECT * FROM SalesLT.SalesOrderHeader WHERE SalesOrderID = @SalesOrderID)
	BEGIN
		INSERT INTO SalesLT.SalesOrderDetail (SalesOrderID, OrderQty, ProductID, UnitPrice)
		VALUES
		(@SalesOrderID, @Quantity, @ProductID, @UnitPrice)
	END
ELSE
	BEGIN
		PRINT 'The order does not exist'
	END

SELECT * FROM SalesLT.SalesOrderDetail;

--Challenge 2: Updating Bike Prices

--1. Write a WHILE loop to update bike prices


