USE AdventureWorks2022;


-- Domain --> Sales


-- Sales KPIS



--KPI1:Total Sales Revenue

-- Formula:
--   Total Sales Revenue = SUM(TotalDue)
--   (TotalDue represents the final amount of each sales order including tax, freight, and discounts)

-- Business Explanation:
--   Total Sales Revenue shows the overall money generated from all sales orders in a given period.
--   It is the most important financial KPI for any company because it reflects overall performance.
--   Business managers use it to:
--     1. Monitor revenue growth (monthly, quarterly, yearly).
--     2. Compare sales across regions, products, or salespersons.
--     3. Detect trends and evaluate the company’s financial health.

--1.1 Get total sales revenue (all time).

select count(SalesOrderID) as Total_Orders, Sum(TotalDue) as Total_Revenue
from sales.SalesOrderHeader

--1.2 Get sales revenue by year.

Select year(OrderDate) as Year,sum(totaldue) as Total_Revenue
from Sales.SalesOrderHeader
group by YEAR(OrderDate)
order by Total_Revenue desc

--1.3 Get sales revenue by month in 2013.
Select year(OrderDate) as Year,MONTH(OrderDate) as month,sum(totaldue) as Total_Revenue
from Sales.SalesOrderHeader
where year(OrderDate)=2013
group by YEAR(OrderDate),MONTH(OrderDate)
order by month 


--1.4 Get sales revenue by quarter (all years).

Select year(OrderDate) as Year,CONCAT('Q',DATEPART(QUARTER,OrderDate)) As Quarter_Num,sum(totaldue) as Total_Revenue
from Sales.SalesOrderHeader 
group by DATEPART(QUARTER,OrderDate),year(OrderDate)
order by Year,Quarter_Num asc

--1.5 Get top 2 years with highest revenue.

select top 2 YEAR(OrderDate)AS  SALES_YEAR,sum(TotalDue) AS Total_REVENUE
from Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate)
ORDER BY Total_REVENUE DESC

--1.6 Get sales revenue,total orders by quarter for a specific year Range

Select year(OrderDate) As Sales_Year,count(SalesOrderID) Total_Orders,CONCAT('Q',DATEPART(QUARTER,OrderDate)) As Sales_Quarter,SUM(TotalDue) Total_Sales
from Sales.SalesOrderHeader
where YEAR(OrderDate) between 2011 and 2013
group by DATEPART(QUARTER,OrderDate),YEAR(OrderDate)
order by Total_Sales desc


--1.7 Get cumulative revenue over years.
WITH YearlySales AS (
    SELECT YEAR(OrderDate) AS SalesYear,
           SUM(TotalDue) AS TotalRevenue
    FROM Sales.SalesOrderHeader
    GROUP BY YEAR(OrderDate)
)
SELECT SalesYear,
       TotalRevenue,
       SUM(TotalRevenue) OVER (ORDER BY SalesYear) AS CumulativeRevenue
FROM YearlySales
ORDER BY SalesYear asc;

--1.8 Get average revenue per Year.

SELECT YEAR(OrderDate) AS Sales_Year , AVG(TotalDue) AS AvgRevenue
FROM Sales.SalesOrderHeader
group by YEAR(OrderDate)
order by AvgRevenue 

--1.9 Get revenue by region.
select st.Name, Sum(soh.TotalDue) as Total_Revenue
from sales.SalesOrderHeader soh
join Sales.SalesTerritory st
on soh.TerritoryID=st.TerritoryID
group by st.Name
order by Total_Revenue desc

--1.10 Get bottom/top 10 customers by revenue.

select top 10 c.CustomerID ,Sum(TotalDue) as Total_Sales 
from Sales.SalesOrderHeader soh
join Sales.Customer c
on soh.CustomerID=c.CustomerID
group by c.CustomerID
order by Total_Sales 

select top 10 c.CustomerID ,Sum(TotalDue) as Total_Sales 
from Sales.SalesOrderHeader soh
join Sales.Customer c
on soh.CustomerID=c.CustomerID
group by c.CustomerID
order by Total_Sales desc

--1.11 Get average revenue per Quarter for each year.
Select year(OrderDate) as Year,CONCAT('Q',DATEPART(QUARTER,OrderDate)) As Quarter_Num,AVG(totaldue) as Avg_Revenue
from Sales.SalesOrderHeader 
group by DATEPART(QUARTER,OrderDate),year(OrderDate)
order by Year,Quarter_Num asc

--1.12 Get Total Orders per region.
select st.Name, count(soh.SalesOrderID) as Total_orders
from sales.SalesOrderHeader soh
join Sales.SalesTerritory st
on soh.TerritoryID=st.TerritoryID
group by st.Name
order by Total_orders desc

--1.13 Get total revenue per product

select p.ProductID,
       p.Name AS ProductName,
       SUM(sod.LineTotal) AS TotalRevenue
from Sales.SalesOrderDetail sod
join Production.Product p
     ON sod.ProductID = p.ProductID
GROUP BY p.ProductID, p.Name
ORDER BY TotalRevenue DESC;


--1.14 Get total revenue per productCategory/SubCategory


SELECT 
    pc.Name AS CategoryName,
    SUM(sod.LineTotal) AS TotalRevenue
FROM Sales.SalesOrderDetail sod
JOIN Production.Product p
    ON sod.ProductID = p.ProductID
JOIN Production.ProductSubcategory psc
    ON p.ProductSubcategoryID = psc.ProductSubcategoryID
JOIN Production.ProductCategory pc
    ON psc.ProductCategoryID = pc.ProductCategoryID
GROUP BY pc.Name
ORDER BY TotalRevenue DESC;



select 
    psc.Name AS SubCategoryName,
    SUM(sod.LineTotal) AS TotalRevenue
from Sales.SalesOrderDetail sod
join Production.Product p
    ON sod.ProductID = p.ProductID
join Production.ProductSubcategory psc
    ON p.ProductSubcategoryID = psc.ProductSubcategoryID
GROUP BY psc.Name
ORDER BY TotalRevenue DESC;


--1.15 Get Top 10 Products by Total Revenue
SELECT TOP 10 p.ProductID,p.Name AS ProductName,SUM(sod.LineTotal) AS TotalRevenue
FROM Sales.SalesOrderDetail sod
JOIN Production.Product p
    ON sod.ProductID = p.ProductID
GROUP BY p.ProductID, p.Name
ORDER BY TotalRevenue DESC;

-- Same Query With Rank_window Function
SELECT top 10 p.ProductID,p.Name AS ProductName,SUM(sod.LineTotal) AS TotalRevenue,
        RANK() OVER (ORDER BY SUM(sod.LineTotal) DESC) AS RankInAll
FROM Sales.SalesOrderDetail sod
JOIN Production.Product p
ON sod.ProductID = p.ProductID
GROUP BY p.ProductID, p.Name


--1.16 Get total sales for each month in 2014
SELECT  MONTH(OrderDate) AS Month,SUM(TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = 2014
GROUP BY MONTH(OrderDate)
ORDER BY MONTH(OrderDate)DESC;
/*
-- Top 10 Products by Revenue within each Category
SELECT CategoryName, ProductID, ProductName, TotalRevenue
FROM (
    SELECT 
        pc.Name AS CategoryName,
        p.ProductID,
        p.Name AS ProductName,
        SUM(sod.LineTotal) AS TotalRevenue,
        RANK() OVER (
            PARTITION BY pc.Name 
            ORDER BY SUM(sod.LineTotal) DESC
        ) AS RankInCategory
    FROM Sales.SalesOrderDetail sod
    JOIN Production.Product p
        ON sod.ProductID = p.ProductID
    JOIN Production.ProductSubcategory psc
        ON p.ProductSubcategoryID = psc.ProductSubcategoryID
    JOIN Production.ProductCategory pc
        ON psc.ProductCategoryID = pc.ProductCategoryID
    GROUP BY pc.Name, p.ProductID, p.Name
) ranked
WHERE RankInCategory <= 10
ORDER BY CategoryName, TotalRevenue DESC;
*/



------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------

--KPI2:Customer Lifetime Value (CLV)

-- Formula:
--   CLV = (Average Order Value × Purchase Frequency) × Average Customer Lifespan
--   Average Order Value   = Total Revenue ÷ Number of Orders
--   Purchase Frequency    = Number of Orders ÷ Number of Customers
--   Customer Lifespan     = Time span between first and last order per customer

-- Business Explanation:
--   CLV estimates the total revenue a business can expect from a single customer
--   over the entire duration of their relationship.
--   It is important because:
--     1. It helps companies decide how much they can spend on acquiring new customers.
--     2. It shows the value of retaining existing customers.
--     3. It identifies the most profitable customer segments.

--2.1 Get average order value per customer

select CustomerID,Avg(soh.TotalDue) As AvgorderVal_per_Customer
from sales.SalesOrderHeader soh
group by CustomerID
order by AvgorderVal_per_Customer
--2.2 Get total number of orders per customer
select CustomerID,count(soh.SalesOrderID) As Totalorders_per_Customer
from sales.SalesOrderHeader soh
group by CustomerID
order by Totalorders_per_Customer desc


--2.3 Calculate CLV per customer (AOV × Orders)-- in 2 ways
select soh.CustomerID,
Avg(TotalDue) * count(SalesOrderID) AS CLV_Per_Customer
from Sales.SalesOrderHeader soh
where CustomerID=11185
group by CustomerID
order by CLV_Per_Customer desc

--CTE METHOD


WITH AVGORDERVAL AS (
SELECT CustomerID,
AVG(TotalDue) AS AvgOrderVal_per_Customer
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
),ORDERCOUNT AS (
SELECT CustomerID,
COUNT(SalesOrderID) AS TotalOrders_per_Customer
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
)SELECT A.CustomerID,A.AvgOrderVal_per_Customer,O.TotalOrders_per_Customer,
A.AvgOrderVal_per_Customer * O.TotalOrders_per_Customer AS CLV
FROM AVGORDERVAL A
JOIN ORDERCOUNT O
ON A.CustomerID = O.CustomerID
ORDER BY CLV DESC;

--2.4 Get top 10 customers by CLV

select top 10 soh.CustomerID,
Avg(TotalDue) * count(SalesOrderID) AS CLV_Per_Customer
from Sales.SalesOrderHeader soh
group by CustomerID
order by CLV_Per_Customer desc
--2.5 Compare CLV across different regions

Select st.name as region, Avg(TotalDue) * count(SalesOrderID) AS CLV
from Sales.SalesOrderHeader soh
join Sales.SalesTerritory st
on soh.TerritoryID=st.TerritoryID
group by st.Name
order by CLV desc

--2.6 CLV for customers with more than 15 orders
select CustomerID,Avg(TotalDue) * count(SalesOrderID) AS CLV_Per_Customer
,count(SalesOrderID) as orders
from Sales.SalesOrderHeader
group by CustomerID
having COUNT(SalesOrderID)>15
order by orders desc


--2.7 Find customers whose CLV > average CLV

SELECT CustomerID,
       AVG(TotalDue) * COUNT(SalesOrderID) AS CLV_Per_Customer
FROM Sales.SalesOrderHeader 
GROUP BY CustomerID
HAVING AVG(TotalDue) * COUNT(SalesOrderID) >
(
SELECT AVG(AvgCLV)
FROM (SELECT AVG(TotalDue) * COUNT(SalesOrderID) AS AvgCLV
FROM Sales.SalesOrderHeader 
GROUP BY CustomerID
) AS Sub
)
ORDER BY CLV_Per_Customer DESC;


--2.8 Rank customers by CLV

select soh.CustomerID,
Avg(TotalDue) * count(SalesOrderID) AS CLV_Per_Customer,
dense_RANK() over (order by Avg(TotalDue) * count(SalesOrderID)) as Ranked_Customers_clv
from Sales.SalesOrderHeader soh
group by CustomerID; 




--2.9 Percentage of High vs Low CLV Customers


WITH CustomerCLV AS (
    SELECT CustomerID,
           AVG(TotalDue) * COUNT(SalesOrderID) AS CLV
    FROM Sales.SalesOrderHeader
    GROUP BY CustomerID
),
AverageCLV AS (
    SELECT AVG(CLV) AS OverallAvgCLV
    FROM CustomerCLV
)
SELECT 
CASE 
  WHEN c.CLV > a.OverallAvgCLV THEN 'High Value'
 ELSE 'Low Value'
 END AS CustomerGroup,
    COUNT(*) AS CustomerCount,
    CAST(100.0 * COUNT(*) / SUM(COUNT(*)) OVER() AS DECIMAL(5,2)) AS Percentage
FROM CustomerCLV c
CROSS JOIN AverageCLV a
GROUP BY CASE 
 WHEN c.CLV > a.OverallAvgCLV THEN 'High Value'
 ELSE 'Low Value'
         END;


--2.10 Classify customers into High CLV vs Low CLV groups


SELECT CustomerID,AVG(TotalDue) * COUNT(SalesOrderID) AS CLV,
CASE
WHEN AVG(TotalDue) * COUNT(SalesOrderID) >
(SELECT AVG(AvgCLV)
FROM (SELECT AVG(TotalDue) * COUNT(SalesOrderID) AS AvgCLV
FROM Sales.SalesOrderHeader
GROUP BY CustomerID) y)
 THEN 'High CLV'
 ELSE 'Low CLV'
END AS CLV_Group
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
ORDER BY CLV DESC;


---------------------------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------


--KPI 3: Product Sales Insights
-- Formula:
-- Product Performance = SUM(LineTotal) or SUM(OrderQty) grouped by Product / Category / Time
-- (LineTotal = OrderQty × UnitPrice × (1 - Discount))
-- Discount Impact = SUM(UnitPriceDiscount × UnitPrice × OrderQty)
-- Contribution % = (Product Revenue ÷ Category Revenue) × 100

-- Business Explanation:
-- This KPI focuses on analyzing product-level sales performance and production trends.
-- It helps managers to:
-- 1. Identify best and worst performing products.
-- 2. Detect seasonal demand patterns (quarterly/annual).
-- 3. Measure the effect of discounts on sales.
-- 4. Analyze consistency of sales (stable vs fluctuating products).
-- 5. Compare products inside their categories and subcategories.
-- 6. Track declining products to take corrective action.



--3.1 Get top 10 products by total quantity sold (in units).
Select  top 10 p.Name As ProductName,p.ProductID,sum(sod.OrderQty) As Total_Qty
from Sales.SalesOrderDetail sod
join Production.Product p
on sod.ProductID=p.ProductID
group by p.ProductID,p.Name
order by Total_Qty desc


--3.2 Get top product categories by total quantity sold.
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


--3.3 Get product subcategories with the highest yearly revenue 
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
select top 10 p.Name As product_Name,
SUM(sod.UnitPriceDiscount * sod.UnitPrice * sod.OrderQty)As Total_Discounts
from Sales.SalesOrderDetail sod
join Production.Product p
on sod.ProductID=p.ProductID
group by p.Name
order by Total_Discounts desc


--3.5 Get list of products sold in every year (no missing year).

SELECT 
    p.Name AS ProductName,
    COUNT(DISTINCT YEAR(soh.OrderDate)) AS YearsSold
FROM Sales.SalesOrderDetail sod
JOIN Sales.SalesOrderHeader soh 
    ON sod.SalesOrderID = soh.SalesOrderID
JOIN Production.Product p 
    ON sod.ProductID = p.ProductID
GROUP BY p.Name


SELECT p.Name AS ProductName,
       COUNT(DISTINCT YEAR(soh.OrderDate)) AS YearsSold
FROM Sales.SalesOrderDetail sod
JOIN Sales.SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID
JOIN Production.Product p ON sod.ProductID = p.ProductID
GROUP BY p.Name
HAVING COUNT(DISTINCT YEAR(soh.OrderDate)) = 
       (SELECT COUNT(DISTINCT YEAR(OrderDate)) FROM Sales.SalesOrderHeader);


--3.6 Get top 15 products with highest Q4 (seasonal) revenue.
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
--Contribution % = (Product Revenue ÷ Category Revenue) × 100

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
ORDER BY  ContributionPercent DESC;


--3.8 Get list of products showing declining sales trend year over year.
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



--3.9 Get top 20 products with the highest production cost-to-revenue ratio
--To identify products that cost too much to produce compared to the revenue they generate
SELECT top 20  p.Name AS ProductName,
SUM(p.StandardCost * sod.OrderQty) AS TotalProductionCost,
SUM(sod.LineTotal) AS TotalRevenue,
ROUND(SUM(p.StandardCost * sod.OrderQty) * 100.0 / SUM(sod.LineTotal), 2) AS CostToRevenuePercent
FROM Sales.SalesOrderDetail sod
JOIN Production.Product p 
ON sod.ProductID = p.ProductID
GROUP BY p.Name
ORDER BY CostToRevenuePercent DESC;



--3.10 Products never sold
SELECT p.Name AS ProductName
FROM Production.Product p
LEFT JOIN Sales.SalesOrderDetail sod 
ON p.ProductID = sod.ProductID
WHERE sod.ProductID IS NULL;



--3.11 top 5 products with the most distinct customers
--purpose:Which products attract the widest customer base
SELECT TOP 5  p.Name AS ProductName,COUNT(DISTINCT soh.CustomerID) AS CustomerCount
FROM Sales.SalesOrderDetail sod
JOIN Sales.SalesOrderHeader soh 
ON sod.SalesOrderID = soh.SalesOrderID
JOIN Production.Product p 
ON sod.ProductID = p.ProductID
GROUP BY p.Name
ORDER BY CustomerCount DESC;


--3.12 Get top 5 products with the fastest revenue growth between 2012 and 2013(Self Join)
WITH ProductYearly AS (
    SELECT p.Name AS ProductName,
           YEAR(soh.OrderDate) AS SalesYear,
           SUM(sod.LineTotal) AS TotalRevenue
    FROM Sales.SalesOrderDetail sod
    JOIN Sales.SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID
    JOIN Production.Product p ON sod.ProductID = p.ProductID
    GROUP BY p.Name, YEAR(soh.OrderDate)
)
SELECT TOP 5 p1.ProductName,
       (p2.TotalRevenue - p1.TotalRevenue) * 100.0 / p1.TotalRevenue AS GrowthPercent
FROM ProductYearly p1
JOIN ProductYearly p2 ON p1.ProductName = p2.ProductName AND p2.SalesYear = 2013 AND p1.SalesYear = 2012
ORDER BY GrowthPercent DESC;

------------------------------------------------------------------------
------------------------------------------------------------------------
------------------------------------------------------------------------

--KPI 4:Customer Behavior Analysis

-- Formula:
-- Repeat Purchase Rate = (Customers with >1 order ÷ Total Customers) × 100
-- Average Orders per Customer = COUNT(SalesOrderID) ÷ COUNT(DISTINCT CustomerID)
-- Inactive Customers = Customers with no orders after a given year
-- Customer Share by Territory = (Unique Customers in Territory ÷ Total Customers) × 100

-- Business Explanation:
-- This KPI focuses on understanding how customers interact with the company.
-- It helps managers to:
-- 1. Measure customer loyalty (repeat vs one-time buyers).
-- 2. Detect inactive customers for reactivation campaigns.
-- 3. Understand order frequency and purchasing power.
-- 4. Compare customer base across territories.
-- 5. Segment customers to build targeted marketing strategies.


-- 4.1 Get total count of one-time vs repeat customers
WITH CustomerTypes AS (
SELECT  CustomerID,
CASE WHEN COUNT(*) > 1 THEN 'Repeated Customer' 
  ELSE 'One-Time Customer' 
 END AS Customer_Type
 FROM Sales.SalesOrderHeader
 GROUP BY CustomerID
)
SELECT Customer_Type,COUNT(*) AS Customers_Count
FROM CustomerTypes
GROUP BY Customer_Type;


--4.2 Get percentage of one-time vs repeat customers.
WITH CustomerTypes AS (
SELECT  CustomerID,
CASE WHEN COUNT(*) > 1 THEN 'Repeated Customer' 
  ELSE 'One-Time Customer' 
 END AS Customer_Type
 FROM Sales.SalesOrderHeader
 GROUP BY CustomerID
)
SELECT Customer_Type,COUNT(*) As TYPE_COUNT,
ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER(), 3) AS Percentage 
FROM CustomerTypes
GROUP BY Customer_Type;

--4.3 Get top 10 customers with the highest number of orders.
Select top 10 soh.CustomerID,count(soh.SalesOrderID) as Total_Customer_orders
from sales.SalesOrderHeader soh
group by CustomerID
order by Total_Customer_orders desc


--4.4 Get top 10 customers with the highest average order value.
Select top 10 soh.CustomerID,Avg(soh.TotalDue) as Avg_order_value
from sales.SalesOrderHeader soh
group by CustomerID
order by Avg_order_value desc
 
--4.5 Get total of inactive customers (no orders after 2013).
SELECT count(CustomerID)As #Customers_NoOrders
FROM Sales.Customer
WHERE CustomerID NOT IN (
    SELECT DISTINCT CustomerID
    FROM Sales.SalesOrderHeader
    WHERE YEAR(OrderDate) > 2013
);


--4.6 Get average spending per order per customer

SELECT CustomerID,AVG(TotalDue) AS AverageOrderValue
FROM Sales.SalesOrderHeader
GROUP BY CustomerID;


--4.7 Get total number of unique customers per sales territory.

select st.Name as territory,count(soh.CustomerID) As #Unique_Customers,
sum(soh.TotalDue) As Total_territory_Sales 
from Sales.SalesOrderHeader soh
join Sales.SalesTerritory st
on soh.TerritoryID=st.TerritoryID
group by st.Name
order by Total_territory_Sales desc


--4.8 Get yearly count of new customers (first purchase year).

SELECT FirstPurchaseYear,COUNT(*) AS NewCustomers
FROM (SELECT CustomerID,YEAR(MIN(OrderDate)) AS FirstPurchaseYear
    FROM Sales.SalesOrderHeader
    GROUP BY CustomerID
) AS FirstOrders
GROUP BY FirstPurchaseYear
ORDER BY FirstPurchaseYear;





------------------------------------------------------------------------
------------------------------------------------------------------------
------------------------------------------------------------------------


--KPI5: Order Fulfillment & Delivery Performance


-- 5.1 Get average delivery time (days between OrderDate and ShipDate).
SELECT AVG(DATEDIFF(DAY, OrderDate, ShipDate)) AS AvgDeliveryDays
FROM Sales.SalesOrderHeader
WHERE ShipDate IS NOT NULL;


-- 5.2 Get percentage of on-time vs delayed deliveries (exdays = 5 days).
SELECT CASE 
        WHEN DATEDIFF(DAY, OrderDate, ShipDate) <= 5 THEN 'On-Time'
        ELSE 'Delayed' 
END AS DeliveryStatus,
COUNT(*) AS OrdersCount,
ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER(), 2) AS Percentage
FROM Sales.SalesOrderHeader
WHERE ShipDate IS NOT NULL
GROUP BY CASE 
 WHEN DATEDIFF(DAY, OrderDate, ShipDate) <= 5 THEN 'On-Time'
 ELSE 'Delayed' 
  END;

/*
  SELECT 
    SalesOrderID,
    CustomerID,
    OrderDate,
    ShipDate,
    DATEDIFF(DAY, OrderDate, ShipDate) AS DeliveryDays,
    CASE 
        WHEN DATEDIFF(DAY, OrderDate, ShipDate) <= 5 THEN 'On-Time'
        ELSE 'Delayed' 
    END AS DeliveryStatus
FROM Sales.SalesOrderHeader
WHERE ShipDate IS NOT NULL
ORDER BY DeliveryDays;
*/

-- 5.3 Get top 10 orders with the longest delivery time.
SELECT TOP 10 SalesOrderID,CustomerID,DATEDIFF(DAY, OrderDate, ShipDate) AS DeliveryDays
FROM Sales.SalesOrderHeader
WHERE ShipDate IS NOT NULL
ORDER BY DeliveryDays DESC;


-- 5.4 Get average delivery time per sales territory.
SELECT st.Name AS TerritoryName,
ROUND(AVG(DATEDIFF(DAY, OrderDate, ShipDate)), 2) AS AvgDeliveryDays
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesTerritory st ON soh.TerritoryID = st.TerritoryID
WHERE ShipDate IS NOT NULL
GROUP BY st.Name
ORDER BY AvgDeliveryDays;


-- 5.5 Get top 10 customers with the most delayed deliveries (>7 days).
SELECT TOP 10 
    CustomerID,
    COUNT(*) AS DelayedOrders
FROM Sales.SalesOrderHeader
WHERE ShipDate IS NOT NULL
  AND DATEDIFF(DAY, OrderDate, ShipDate) > 7
GROUP BY CustomerID
ORDER BY DelayedOrders DESC;

-- 5.6 Get count of delayed deliveries per quarter.
SELECT 
    YEAR(OrderDate) AS SalesYear,
    CONCAT('Q', DATEPART(QUARTER, OrderDate)) AS Quarter,
    COUNT(*) AS DelayedOrders
FROM Sales.SalesOrderHeader
WHERE ShipDate IS NOT NULL
  AND DATEDIFF(DAY, OrderDate, ShipDate) > 5
GROUP BY YEAR(OrderDate), DATEPART(QUARTER, OrderDate)
ORDER BY SalesYear, Quarter;

-- 5.7 Get top 10 salespersons with the highest number of delayed deliveries.
SELECT TOP 10 sp.BusinessEntityID AS SalesPersonID,COUNT(*) AS DelayedOrders
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesPerson sp ON soh.SalesPersonID = sp.BusinessEntityID
WHERE ShipDate IS NOT NULL
  AND DATEDIFF(DAY, OrderDate, ShipDate) > 5
GROUP BY sp.BusinessEntityID
ORDER BY DelayedOrders DESC;
