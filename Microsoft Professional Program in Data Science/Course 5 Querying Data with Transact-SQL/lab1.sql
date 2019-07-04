--Challenge 1: Retrieve Customer Data

--1. Retrieve customer details
SELECT * from SalesLt.Customer;

--2. Retrieve customer name data
SELECT Title, FirstName, ISNULL(middlename, '') MiddleName, LastName, ISNULL(Suffix, '') as Suffix
FROM SalesLT.Customer;

--3. Retrieve customer names and phone numbers
SELECT SalesPerson, ISNULL(Title, '') + ' ' + FirstName AS CustomerName, Phone
FROM SalesLT.Customer;

--Challenge 2: Retrieve Customer and Sales Data

--1. Retrieve a list of customer companies
SELECT STR(CustomerID) + ': ' + CompanyName
FROM SalesLT.Customer;

--2. Retrieve a list of sales order revisions
SELECT SalesOrderNumber + '(' + LTRIM(STR(RevisionNumber)) + ')', CONVERT(varchar, OrderDate, 102)
FROM SalesLT.SalesOrderHeader;

--Challenge 3: Retrieve Customer Contact Details

--1. Retrieve customer contact names with middle names if known
SELECT FirstName + 
CASE
	WHEN MiddleName IS NULL THEN ' '
	ELSE ' ' + MiddleName + ' '
END
+ LastName As Name
FROM SalesLT.Customer;

--2. Retrieve primary contact details
SELECT CustomerID, COALESCE(EmailAddress, Phone) AS PrimaryContact
FROM SalesLT.Customer;

--3. Retrieve shipping status
SELECT SalesOrderID, 
CASE
	WHEN ShipDate IS NOT NULL THEN 'Shipped'
	ELSE 'Awaiting Shipment'
END AS ShippingStatus
FROM SalesLT.SalesOrderHeader;