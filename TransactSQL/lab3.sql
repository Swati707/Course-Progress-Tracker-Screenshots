--Challenge 1: Generate Invoice Reports

--1. Retrieve customer orders
SELECT c.CompanyName, soh.SalesOrderID, soh.TotalDue
FROM SalesLT.Customer AS c
JOIN SalesLT.SalesOrderHeader as soh
ON c.CustomerID = soh.CustomerID;

--2. Retrieve customer orders with addresses
SELECT c.CompanyName, soh.SalesOrderID, soh.TotalDue, adr.AddressLine1 + ' ' + ISNULL(adr.AddressLine2, '') AS FullStreetAddress,
	adr.City, adr.StateProvince, adr.PostalCode, adr.CountryRegion
FROM SalesLT.Address AS adr
JOIN SalesLT.CustomerAddress AS cadr
ON adr.AddressID = cadr.AddressID
JOIN SalesLT.Customer AS c
ON cadr.CustomerID = c.CustomerID
JOIN SalesLT.SalesOrderHeader AS soh
ON c.CustomerID = soh.CustomerID
WHERE cadr.AddressType LIKE 'Main%';

-- Challenge 2: Retrieve Sales Data

--1. Retrieve a list of all customers and their orders
SELECT c.FirstName + ' ' + c.LastName AS Contact, c.CompanyName AS Company, soh.SalesOrderID, soh.TotalDue
FROM SalesLT.Customer AS c
LEFT JOIN SalesLT.SalesOrderHeader AS soh
ON c.CustomerID = soh.CustomerID
ORDER BY soh.TotalDue DESC;

--2. Retrieve a list of customers with no address
SELECT c.CustomerID, c.CompanyName, c.FirstName + ' ' + c.LastName AS Contact, c.Phone
FROM SalesLT.Customer AS c
LEFT OUTER JOIN SalesLT.CustomerAddress AS cadr
ON c.CustomerID = cadr.CustomerID
WHERE cadr.AddressID IS NULL;

--3. Retrieve a list of customers and products without orders
SELECT c.CustomerID, p.ProductID
FROM SalesLT.Customer AS c
FULL JOIN SalesLT.SalesOrderHeader AS soh
ON c.CustomerID = soh.CustomerID
FULL JOIN SalesLT.SalesOrderDetail AS sod
ON soh.SalesOrderID = sod.SalesOrderID
FULL JOIN SalesLT.Product AS p
ON p.ProductID = sod.ProductID
WHERE p.ProductID IS NULL OR c.CustomerID IS NULL;