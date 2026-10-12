

--What is the total revenue/profit?

SELECT SUM(SOD.LineTotal - (SOD.OrderQty * PP.StandardCost)) AS TotalProfit  
FROM Sales.SalesOrderDetail SOD 
JOIN Production.Product PP ON SOD.ProductID = PP.ProductID;



--What is the average of the discounts on a single item?

SELECT PP.Name, AVG(SOD.UnitPriceDiscount) AS AverageDiscount
FROM Sales.SalesOrderDetail SOD 
JOIN Production.Product PP ON SOD.ProductID = PP.ProductID
GROUP BY PP.Name;



--What is the quantity of items purchased?

SELECT SUM(OrderQty) AS TotalOrdered
FROM SALES.SalesOrderDetail;



--How much is the margin (sale price less cost)?

SELECT SUM(SOD.LineTotal - (SOD.OrderQty * PP.StandardCost)) AS TotalMargin 
FROM Sales.SalesOrderDetail SOD 
JOIN Production.Product PP ON SOD.ProductID = PP.ProductID;



--What is the average margin (sale price less cost)?

SELECT AVG(SOD.LineTotal - (SOD.OrderQty * PP.StandardCost)) AS AverageMargin
FROM Sales.SalesOrderDetail SOD 
JOIN Production.Product PP ON SOD.ProductID = PP.ProductID;



--What are the monthly and quarterly rankings for the year according to the margin (sale less cost)?

SELECT 
    YEAR(SOH.OrderDate) AS An,
    MONTH(SOH.OrderDate) AS Luna,
    SUM(SOD.LineTotal - (SOD.OrderQty * PP.StandardCost)) AS MonthlyMargin,
    SUM(SOD.OrderQty) AS MonthlyOrdered,
    SUM(SOD.LineTotal) AS MonthlyRevenue,
    SUM(SOD.UnitPriceDiscount * SOD.UnitPrice * SOD.OrderQty) AS MonthlyDiscount,
    SUM(SOD.OrderQty) as TotalOrdered,
    PS.NAME AS Subcategorie,
    PC.NAME as Categorie
FROM Sales.SalesOrderDetail SOD
JOIN Sales.SalesOrderHeader SOH 
    ON SOD.SalesOrderID = SOH.SalesOrderID
JOIN Production.Product PP 
    ON PP.ProductID = SOD.ProductID
JOIN Production.ProductSubcategory PS 
    ON PP.ProductSubcategoryID = PS.ProductSubcategoryID
JOIN Production.ProductCategory PC 
    ON PS.ProductCategoryID = PC.ProductCategoryID
GROUP BY 
    YEAR(SOH.OrderDate),
    MONTH(SOH.OrderDate),
        PS.NAME,
        PC.NAME 




