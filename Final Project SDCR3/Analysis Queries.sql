use final_projsdcr3;

---------------------------------------------------------
-- 1. sales trends by category & country
---------------------------------------------------------
select d.year, p.categoryname, c.country, sum(isnull(f.totalamount,0)) as totalsales
from dim_date_star d
 join fact_sales f on f.datekey = d.datekey
 join dim_product_star p on f.p_id = p.p_id
 join dim_customer_star c on f.cus_id = c.cus_id
group by d.year, p.categoryname, c.country
order by d.year, totalsales desc;

select d.year, 
       coalesce(p.categoryname,'no category') as categoryname,
       coalesce(c.country,'no country') as country,
       sum(isnull(f.totalamount,0)) as totalsales
from dim_date_star d
left join fact_sales f on f.datekey = d.datekey
left join dim_product_star p on f.p_id = p.p_id
left join dim_customer_star c on f.cus_id = c.cus_id
group by d.year, coalesce(p.categoryname,'no category'), coalesce(c.country,'no country')
order by d.year, totalsales desc;


---------------------------------------------------------
-- 2. top 10 customers by sales
---------------------------------------------------------
select top 10 c.cus_id, c.name, sum(f.totalamount) as totalsales
from fact_sales f
join dim_customer_star c on f.cus_id = c.cus_id
group by c.cus_id, c.name
order by totalsales desc;

---------------------------------------------------------
-- 3. top 10 products by sales volume
---------------------------------------------------------
select top 10 p.p_id, p.productname, sum(f.quantity) as totalquantity
from fact_sales f
join dim_product_star p on f.p_id = p.p_id
group by p.p_id, p.productname
order by totalquantity desc;

---------------------------------------------------------
-- 4. monthly seasonality
---------------------------------------------------------
select d.year, d.month, sum(f.totalamount) as monthlysales
from dim_date_star d
 join fact_sales f on f.datekey = d.datekey
group by d.year, d.month
order by d.year, d.month asc;








select d.year, d.month, sum(isnull(f.totalamount,0)) as monthlysales
from dim_date_star d
left join fact_sales f on f.datekey = d.datekey
group by d.year, d.month
order by d.year, d.month asc;

---------------------------------------------------------
-- 5. profitability by product
---------------------------------------------------------
select top 7 p.productname, 
       sum((p.price - p.cost) * f.quantity) as totalprofit
from fact_sales f
join dim_product_star p on f.p_id = p.p_id
group by p.productname
order by totalprofit desc;





---------------------------------------------------------
-- 6. customer demographics analysis
---------------------------------------------------------
select c.gender, 
       avg(c.age) as avgage,
       sum(f.totalamount) as totalsales
from fact_sales f
join dim_customer_star c on f.cus_id = c.cus_id
group by c.gender;

select c.gender, 
       avg(c.age) as avgage,
       sum(f.totalamount) as totalsales,
       sum(f.totalamount) * 100.0 / sum(sum(f.totalamount)) over() as salespct
from fact_sales f
join dim_customer_star c on f.cus_id = c.cus_id
group by c.gender
order by salespct desc;

---------------------------------------------------------
-- 7. average purchase per customer
---------------------------------------------------------
select c.cus_id, c.name, 
       round(sum(f.totalamount) * 1.0 / count(distinct f.invoiceno), 3) as avgtransactionvalue
from fact_sales f
join dim_customer_star c on f.cus_id = c.cus_id
group by c.cus_id, c.name
order by avgtransactionvalue desc;

---------------------------------------------------------
-- 8. customer segmentation by region
---------------------------------------------------------
select c.region, sum(f.totalamount) as totalsales
from fact_sales f
join dim_customer_star c on f.cus_id = c.cus_id
group by c.region
order by totalsales desc;

---------------------------------------------------------
-- 9. category contribution to total sales
---------------------------------------------------------
select p.categoryname,
       sum(f.totalamount) as categorysales,
       round(sum(f.totalamount) * 100.0 / sum(sum(f.totalamount)) over (), 3) as contributionpct
from fact_sales f
join dim_product_star p on f.p_id = p.p_id
group by p.categoryname
order by contributionpct desc;

---------------------------------------------------------
-- 10. sub-category performance
---------------------------------------------------------
select p.subcategoryname, p.categoryname, sum(f.totalamount) as totalsales
from fact_sales f
join dim_product_star p on f.p_id = p.p_id
group by p.subcategoryname, p.categoryname
order by totalsales desc;

---------------------------------------------------------
-- 11. year-over-year sales growth
---------------------------------------------------------
select d.year,
       sum(f.totalamount) as totalsales,
       lag(sum(f.totalamount)) over (order by d.year) as prevyearsales,
       (sum(f.totalamount) - lag(sum(f.totalamount)) over (order by d.year)) * 100.0 /
        nullif(lag(sum(f.totalamount)) over (order by d.year),0) as yoygrowthpct
from fact_sales f
join dim_date_star d on f.datekey = d.datekey
group by d.year
order by d.year;

---------------------------------------------------------
-- 12. quarterly performance by region
---------------------------------------------------------
select d.year, d.quarter, c.region, sum(f.totalamount) as totalsales
from fact_sales f
join dim_customer_star c on f.cus_id = c.cus_id
join dim_date_star d on f.datekey = d.datekey
group by d.year, d.quarter, c.region
order by d.year, d.quarter, totalsales desc;

---------------------------------------------------------
-- 13. daily sales patterns
---------------------------------------------------------
select d.day as dayofmonth,
       avg(f.totalamount) as avgdailysales
from fact_sales f
join dim_date_star d on f.datekey = d.datekey
group by d.day
order by d.day;

---------------------------------------------------------
-- 14. customer lifetime value (clv)
---------------------------------------------------------
select c.cus_id, c.name, sum(f.totalamount) as clv
from fact_sales f
join dim_customer_star c on f.cus_id = c.cus_id
group by c.cus_id, c.name
order by clv desc;

---------------------------------------------------------
-- 15. sales per country
---------------------------------------------------------
select c.country, round(sum(f.totalamount),3) as totalsales
from fact_sales f
join dim_customer_star c on f.cus_id = c.cus_id
group by c.country
order by totalsales desc;
