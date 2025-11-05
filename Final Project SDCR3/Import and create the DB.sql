create database sdcr3_final_proj;

use sdcr3_final_proj;
select * from Fact_Sales;
select count(CustomerID) from Dim_Customer;
/*
-- data loading and validation:
-- foreign keys
-- 1. fact_sales → dim_date
alter table dbo.fact_sales
add constraint fk_factsales_date
foreign key (invoicedate) references dbo.dim_date(date);

-- 2. fact_sales → dim_product
alter table dbo.fact_sales
add constraint fk_factsales_product
foreign key (productid) references dbo.dim_product(productid);

-- 3. fact_sales → dim_customer
alter table dbo.fact_sales
add constraint fk_factsales_customer
foreign key (customerid) references dbo.dim_customer(customerid);

-- 4. dim_product → dim_subcategory
alter table dbo.dim_product
add constraint fk_product_subcategory
foreign key (subcategoryid) references dbo.dim_subcategory(subcategoryid);

-- 5. dim_subcategory → dim_category
alter table dbo.dim_subcategory
add constraint fk_subcategory_category
foreign key (categoryid) references dbo.dim_category(categoryid);

-- 6. dim_customer → dim_location
alter table dbo.dim_customer
add constraint fk_customer_location
foreign key (locationid) references dbo.dim_location(locationid);

-- 7. dim_location → dim_country
alter table dbo.dim_location
add constraint fk_location_country
foreign key (countryid) references dbo.dim_country(countryid);
*/
-- product dimension (product + subcategory + category)
select 
    p.productid,
    p.productname,
    p.price,
    p.cost,
    sc.subcategoryname,
    c.categoryname
into dbo.dim_product_star
from dbo.dim_product p
join dbo.dim_subcategory sc on p.subcategoryid = sc.subcategoryid
join dbo.dim_category c on sc.categoryid = c.categoryid;

-- customer dimension (customer + location + country)
select 
    cu.customerid,
    cu.name,
    cu.gender,
    cu.age,
    cu.registrationdate,
    l.city,
    l.state,
    co.country,
    co.region
into dbo.dim_customer_star
from dbo.dim_customer cu
join dbo.dim_location l on cu.locationid = l.locationid
join dbo.dim_country co on l.countryid = co.countryid;

alter table dbo.dim_product_star add constraint pk_dim_product_star primary key (productid);
alter table dbo.dim_customer_star add constraint pk_dim_customer_star primary key (customerid);

-- ================================================================
-- data cleaning & transformation checks
-- ================================================================

-- 1. check for null values
select count(*) as missingdates from fact_sales where invoicedate is null;
select count(*) as missingcustomers from fact_sales where customerid is null;
select count(*) as missingproducts from fact_sales where productid is null;
select count(*) as missingamounts from fact_sales where totalamount is null;

select count(*) as nullcustomers from dim_customer where customerid is null or name is null;
select count(*) as nullproducts from dim_product where productid is null or productname is null;
select count(*) as nullsubcategory from dim_subcategory where subcategoryid is null or subcategoryname is null;
select count(*) as nulllocation from dim_location where locationid is null or city is null;
select count(*) as nulldates from dim_date where date is null;
select count(*) as nullcountries from dim_country where countryid is null or country is null or region is null;
select count(*) as nullcustomerstar from dim_customer_star where customerid is null or name is null;
select count(*) as nullproductstar from dim_product_star where productid is null or productname is null;

-- 2. check for duplicates
select invoiceno, count(*) as duplicatecount from fact_sales group by invoiceno having count(*) > 1;
select customerid, count(*) as duplicatecount from dim_customer group by customerid having count(*) > 1;
select productid, count(*) as duplicatecount from dim_product group by productid having count(*) > 1;
select subcategoryid, count(*) as duplicatecount from dim_subcategory group by subcategoryid having count(*) > 1;
select locationid, count(*) as duplicatecount from dim_location group by locationid having count(*) > 1;
select date, count(*) as duplicatecount from dim_date group by date having count(*) > 1;
select countryid, count(*) as duplicatecount from dim_country group by countryid having count(*) > 1;
select customerid, count(*) as duplicatecount from dim_customer_star group by customerid having count(*) > 1;
select productid, count(*) as duplicatecount from dim_product_star group by productid having count(*) > 1;

-- 3. check for invalid or inconsistent values
-- leading/trailing spaces
select * from dim_customer where ltrim(rtrim(name)) <> name;
select * from dim_customer_star where ltrim(rtrim(name)) <> name;
select * from dim_product where ltrim(rtrim(productname)) <> productname;
select * from dim_product_star where ltrim(rtrim(productname)) <> productname;

-- empty strings
select * from dim_customer where name = '';
select * from dim_customer_star where name = '';
select * from dim_product where productname = '';
select * from dim_product_star where productname = '';

-- distinct region values for verification
select distinct region from dim_country;

-- 4. check for outliers / invalid numbers
select * from fact_sales where totalamount < 0;  
select * from fact_sales fs
join dim_date dd on fs.invoicedate = dd.date
where dd.date > getdate();  

select * from dim_customer_star where age < 0 ;
select * from dim_product_star where price < 0;

-- 5. applied cleaning & transformations
update fact_sales
set productid = 'unknown product for this invoice'
where productid is null;

update fact_sales
set customerid = 'unknown customer for this invoice'
where customerid is null;

update dim_customer_star
set age = (
    select avg(age * 1.0)  -- returns int value 
    from dim_customer_star
    where age is not null
)
where age is null;

update dim_country
set region = 'middle east'
where region = 'mena';

-- cleaning on dim_customer_star
select * from dim_customer_star;

select distinct left(name, charindex(' ', name + ' ') - 1) as firstname
from dim_customer_star
order by firstname;

select *
from dim_customer_star
where age is null;

update dim_customer_star
set region = 'middle east' where region = 'mena';

-- female customers
update dim_customer_star
set gender = 'female'
where left(name, charindex(' ', name + ' ') - 1) in 
      ('aisha','anna','emily','emma','fatma','sara','sophia');

-- male customers
update dim_customer_star
set gender = 'male'
where left(name, charindex(' ', name + ' ') - 1) in 
      ('ahmed','david','john','michael','mohamed','mostafa','omar','robert','youssef');
