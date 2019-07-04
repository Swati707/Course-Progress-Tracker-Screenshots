--Challenge 1: Retrieve Customer Addresses

--1. Retrieve billing addresses
SELECT c.CompanyName, adr.AddressLine1, adr.City, 'Billing' AS AddressType
FROM SalesLT.Customer AS c
JOIN SalesLT.CustomerAddress AS cadr
ON c.CustomerID = cadr.CustomerID
JOIN SalesLT.Address AS adr
ON adr.AddressID = cadr.AddressID
WHERE cadr.AddressType = 'Main Office';

--2. Retrieve shipping addresses
SELECT c.CompanyName, adr.AddressLine1, adr.City, cadr.AddressType AS AddressType
FROM SalesLT.Customer AS c
JOIN SalesLT.CustomerAddress AS cadr
ON c.CustomerID = cadr.CustomerID
JOIN SalesLT.Address AS adr
ON adr.AddressID = cadr.AddressID
WHERE cadr.AddressType <> 'Main Office';

--3. Combine billing and shipping addresses
SELECT c.CompanyName, adr.AddressLine1, adr.City, 'Billing' AS AddressType
FROM SalesLT.Customer AS c
JOIN SalesLT.CustomerAddress AS cadr
ON c.CustomerID = cadr.CustomerID
JOIN SalesLT.Address AS adr
ON adr.AddressID = cadr.AddressID
WHERE cadr.AddressType = 'Main Office'
UNION ALL
SELECT c.CompanyName, adr.AddressLine1, adr.City, cadr.AddressType AS AddressType
FROM SalesLT.Customer AS c
JOIN SalesLT.CustomerAddress AS cadr
ON c.CustomerID = cadr.CustomerID
JOIN SalesLT.Address AS adr
ON adr.AddressID = cadr.AddressID
WHERE cadr.AddressType <> 'Main Office'
ORDER BY c.CompanyName, AddressType;

--Challenge 2: Filter Customer Addresses

--1. Retrieve customers with only a main office address
SELECT c.CompanyName
FROM SalesLT.Customer AS c
JOIN SalesLT.CustomerAddress AS cadr
ON c.CustomerID = cadr.CustomerID
JOIN SalesLT.Address AS adr
ON adr.AddressID = cadr.AddressID
WHERE cadr.AddressType = 'Main Office'
EXCEPT
SELECT c.CompanyName
FROM SalesLT.Customer AS c
JOIN SalesLT.CustomerAddress AS cadr
ON c.CustomerID = cadr.CustomerID
JOIN SalesLT.Address AS adr
ON adr.AddressID = cadr.AddressID
WHERE cadr.AddressType = 'Shipping';

--2. Retrieve only customers with both a main office address and a shipping address
SELECT c.CompanyName
FROM SalesLT.Customer AS c
JOIN SalesLT.CustomerAddress AS cadr
ON c.CustomerID = cadr.CustomerID
JOIN SalesLT.Address AS adr
ON adr.AddressID = cadr.AddressID
WHERE cadr.AddressType = 'Main Office'
INTERSECT
SELECT c.CompanyName
FROM SalesLT.Customer AS c
JOIN SalesLT.CustomerAddress AS cadr
ON c.CustomerID = cadr.CustomerID
JOIN SalesLT.Address AS adr
ON adr.AddressID = cadr.AddressID
WHERE cadr.AddressType = 'Shipping';