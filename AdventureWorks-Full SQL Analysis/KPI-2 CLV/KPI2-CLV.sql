USE AdventureWorks2022;

--2.1 Get average order value per customer.
--Purpose: Calculates the average amount each customer spends per order.
select CustomerID,Avg(soh.TotalDue) As AvgorderVal_per_Customer
from sales.SalesOrderHeader soh
group by CustomerID
order by AvgorderVal_per_Customer

--2.2 Get total number of orders per customer.
--Purpose: Shows how many total orders each customer has made.
select CustomerID,count(soh.SalesOrderID) As Totalorders_per_Customer
from sales.SalesOrderHeader soh
group by CustomerID
order by Totalorders_per_Customer desc

--2.3 Calculate CLV per customer (AOV × Orders).
--Purpose: Estimates total value each customer brings based on spending and frequency.
select soh.CustomerID,
Avg(TotalDue) * count(SalesOrderID) AS CLV_Per_Customer
from Sales.SalesOrderHeader soh
where CustomerID=11185
group by CustomerID
order by CLV_Per_Customer desc

--2.4 Get top 10 customers by CLV.
--Purpose: Identifies the 10 most valuable customers by total lifetime revenue.
select top 10 soh.CustomerID,
Avg(TotalDue) * count(SalesOrderID) AS CLV_Per_Customer
from Sales.SalesOrderHeader soh
group by CustomerID
order by CLV_Per_Customer desc

--2.5 Compare CLV across different regions.
--Purpose: Evaluates customer value differences between geographic territories.
Select st.name as region, Avg(TotalDue) * count(SalesOrderID) AS CLV
from Sales.SalesOrderHeader soh
join Sales.SalesTerritory st
on soh.TerritoryID=st.TerritoryID
group by st.Name
order by CLV desc

--2.6 CLV for customers with more than 15 orders.
--Purpose: Finds high-engagement customers who frequently purchase and their total value.
select CustomerID,Avg(TotalDue) * count(SalesOrderID) AS CLV_Per_Customer
,count(SalesOrderID) as orders
from Sales.SalesOrderHeader
group by CustomerID
having COUNT(SalesOrderID)>15
order by orders desc

--2.7 Find customers whose CLV > average CLV.
--Purpose: Identifies customers performing above the average lifetime value benchmark.
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

--2.8 Rank customers by CLV.
--Purpose: Assigns ranking to customers based on their total lifetime value.
select soh.CustomerID,
Avg(TotalDue) * count(SalesOrderID) AS CLV_Per_Customer,
dense_RANK() over (order by Avg(TotalDue) * count(SalesOrderID)) as Ranked_Customers_clv
from Sales.SalesOrderHeader soh
group by CustomerID; 

--2.9 Percentage of High vs Low CLV Customers.
--Purpose: Segments customers into high and low value groups and calculates their percentages.
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

--2.10 Classify customers into High CLV vs Low CLV groups.
--Purpose: Labels each customer as high or low value based on comparison with average CLV.
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
