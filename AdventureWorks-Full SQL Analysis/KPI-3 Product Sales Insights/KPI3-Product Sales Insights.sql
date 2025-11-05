USE AdventureWorks2022;

--3.1 Get top 10 products by total quantity sold (in units).
--Purpose: Finds the most sold products by quantity to identify bestsellers.
Select  top 10 p.Name As ProductName,p.ProductID,sum(sod.OrderQty) As Total_Qty
from Sales.SalesOrderDetail sod
join Production.Product p
on sod.ProductID=p.ProductID
group by p.ProductID,p.Name
order by Total_Qty desc

--3.2 Get top product categories by total quantity sold.
--Purpose: Highlights the most successful product categories based on units sold.
Select pc.Name as CategoryName , sum(sod.OrderQty) As Total_Qty
from Sales.SalesOrderDetail sod
join Production.Product p
on sod.ProductID=p.ProductID
join Production.ProductSubcategory psc
on p.ProductSubcategoryID=psc.ProductSubcategoryID
join Production.ProductCategory pc
on psc.ProductCategoryID=pc.ProductCategoryID
group by pc.Name
order by Total_Qty desc

--3.3 Get product subcategories with the highest yearly revenue.
--Purpose: Evaluates which product subcategories generate the most annual income.
Select   YEAR(OrderDate) As Sale_year,psc.Name as sub_category_name,round(sum(LineTotal),2) as Total_Sales
from Sales.SalesOrderHeader soh
join Sales.SalesOrderDetail sod
on soh.SalesOrderID=sod.SalesOrderID
join Production.Product p
on sod.ProductID=p.ProductID
join Production.ProductSubcategory psc
on p.ProductSubcategoryID=psc.ProductSubcategoryID
group by YEAR(OrderDate),psc.Name
order by Sale_year 

--3.4 Get top 10 products with the highest total discount value applied.
--Purpose: Shows products where discounts had the largest financial impact.
select top 10 p.Name As product_Name,
SUM(sod.UnitPriceDiscount * sod.UnitPrice * sod.OrderQty)As Total_Discounts
from Sales.SalesOrderDetail sod
join Production.Product p
on sod.ProductID=p.ProductID
group by p.Name
order by Total_Discounts desc

--3.5 Get list of products sold in every year (no missing year).
--Purpose: Identifies consistently selling products that appear in all years.
SELECT p.Name AS ProductName,
       COUNT(DISTINCT YEAR(soh.OrderDate)) AS YearsSold
FROM Sales.SalesOrderDetail sod
JOIN Sales.SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID
JOIN Production.Product p ON sod.ProductID = p.ProductID
GROUP BY p.Name
HAVING COUNT(DISTINCT YEAR(soh.OrderDate)) = 
       (SELECT COUNT(DISTINCT YEAR(OrderDate)) FROM Sales.SalesOrderHeader);

--3.6 Get top 15 products with highest Q4 (seasonal) revenue.
--Purpose: Measures which products perform best in the last quarter of each year.
select top 15 p.Name As Product_Name,DATEPART(QUARTER,soh.OrderDate) As Quarter
,Sum(TotalDue) As Total_Revenue
from Sales.SalesOrderHeader soh
join Sales.SalesOrderDetail sod
on soh.SalesOrderID=sod.SalesOrderID
join Production.Product p
on sod.ProductID=p.ProductID
where DATEPART(QUARTER,soh.OrderDate)=4
group by p.Name,DATEPART(QUARTER,soh.OrderDate)
order by Total_Revenue DESC

--3.7 Get each product’s percentage contribution to its category revenue.
--Purpose: Calculates how much each product contributes to its category’s total sales.
select pc.Name as Category,p.Name as ProductName,
sum(sod.LineTotal)as ProductRevenue, 
ROUND(SUM(sod.LineTotal) * 100.0 /SUM(SUM(sod.LineTotal)) OVER (PARTITION BY pc.Name),2) 
AS ContributionPercent 
from Sales.SalesOrderDetail sod
join Production.Product p
on sod.ProductID=p.ProductID
join Production.ProductSubcategory psc
on p.ProductSubcategoryID=psc.ProductSubcategoryID
join Production.ProductCategory pc
on psc.ProductCategoryID=pc.ProductCategoryID
GROUP BY pc.Name, p.Name
ORDER BY Category, ContributionPercent DESC;

--3.8 Get list of products showing declining sales trend year over year.
--Purpose: Detects products whose revenue is decreasing compared to the previous year.
with productrevenue as(
select p.name as productname,year(soh.orderdate) as salesyear,sum(sod.linetotal) as totalrevenue
from sales.salesorderdetail sod
join sales.salesorderheader soh 
on sod.salesorderid=soh.salesorderid
join production.product p 
on sod.productid=p.productid 
group by p.name,year(soh.orderdate)
),withprev as(
select productname,salesyear,totalrevenue,
lag(totalrevenue) over(partition by productname order by salesyear) as prevyearrevenue
from productrevenue)
select * from withprev
where totalrevenue<prevyearrevenue 
order by productname,salesyear;

--3.9 Get top 20 products with the highest production cost-to-revenue ratio.
--Purpose: Identifies products that are costly to produce relative to the revenue they generate.
SELECT top 20  p.Name AS ProductName,
SUM(p.StandardCost * sod.OrderQty) AS TotalProductionCost,
SUM(sod.LineTotal) AS TotalRevenue,
ROUND(SUM(p.StandardCost * sod.OrderQty) * 100.0 / SUM(sod.LineTotal), 2) AS CostToRevenuePercent
FROM Sales.SalesOrderDetail sod
JOIN Production.Product p 
ON sod.ProductID = p.ProductID
GROUP BY p.Name
ORDER BY CostToRevenuePercent DESC;

--3.10 Products never sold.
--Purpose: Lists products that exist in inventory but have never been included in any sale.
SELECT p.Name AS ProductName
FROM Production.Product p
LEFT JOIN Sales.SalesOrderDetail sod 
ON p.ProductID = sod.ProductID
WHERE sod.ProductID IS NULL;

--3.11 Top 5 products with the most distinct customers.
--Purpose: Determines which products attract the widest range of unique customers.
SELECT TOP 5  p.Name AS ProductName,COUNT(DISTINCT soh.CustomerID) AS CustomerCount
FROM Sales.SalesOrderDetail sod
JOIN Sales.SalesOrderHeader soh 
ON sod.SalesOrderID = soh.SalesOrderID
JOIN Production.Product p 
ON sod.ProductID = p.ProductID
GROUP BY p.Name
ORDER BY CustomerCount DESC;
