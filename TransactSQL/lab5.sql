--Challenge 1:

--1. Retrieve the name and approximate weight of each product
SELECT ProductID, UPPER(Name), ROUND(Weight, 0) AS ApproxWeight  
FROM SalesLT.Product;

--2. Retrieve the year and month in which products were first sold
SELECT ProductID, UPPER(Name), 
	ROUND(Weight, 0) AS ApproxWeight,
	YEAR(SellStartDate) AS SellStartYear, 
	DATENAME(mm, SellStartDate) AS SellStartMonth
FROM SalesLT.Product;

--3. Extract product types from product numbers
SELECT ProductID, UPPER(Name), 
	ROUND(Weight, 0) AS ApproxWeight,
	YEAR(SellStartDate) AS SellStartYear, 
	DATENAME(mm, SellStartDate) AS SellStartMonth,
	LEFT(ProductNumber, 2) AS ProductType
FROM SalesLT.Product;

--4. Retrieve only products with a numeric size
SELECT ProductID, UPPER(Name), 
	ROUND(Weight, 0) AS ApproxWeight,
	YEAR(SellStartDate) AS SellStartYear, 
	DATENAME(mm, SellStartDate) AS SellStartMonth,
	LEFT(ProductNumber, 2) AS ProductType, Size
FROM SalesLT.Product
WHERE ISNUMERIC(Size) = 1;

--Challenge 2:

--1. Retrieve companies ranked by sales totals
SELECT c.CompanyName, soh.TotalDue,
	RANK() OVER(ORDER BY soh.TotalDue DESC) AS RankByTotalDue
FROM SalesLT.Customer AS c
JOIN SalesLT.SalesOrderHeader AS soh
ON c.CustomerID = soh.CustomerID
ORDER BY RankByTotalDue;

--Challenge 3:

--1. Retrieve total sales by product
SELECT p.Name, SUM(sod.LineTotal) AS TotalRevenue
FROM SalesLT.Product AS p
JOIN SalesLT.SalesOrderDetail AS sod
ON p.ProductID = sod.ProductID
GROUP BY p.Name
ORDER BY TotalRevenue DESC;

--2. Filter the product sales list to include only products that cost over $1,000
SELECT p.Name, SUM(sod.LineTotal) AS TotalRevenue
FROM SalesLT.Product AS p
JOIN SalesLT.SalesOrderDetail AS sod
ON p.ProductID = sod.ProductID
WHERE p.ListPrice > 1000
GROUP BY p.Name
ORDER BY TotalRevenue DESC;

--3. Filter the product sales groups to include only total sales over $20,000
SELECT p.Name, SUM(sod.LineTotal) AS TotalRevenue
FROM SalesLT.Product AS p
JOIN SalesLT.SalesOrderDetail AS sod
ON p.ProductID = sod.ProductID
WHERE p.ListPrice > 1000
GROUP BY p.Name
HAVING SUM(sod.LineTotal) > 20000
ORDER BY TotalRevenue DESC;