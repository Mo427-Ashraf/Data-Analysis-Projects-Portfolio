use BikeStores;



-- 1.total sales per month

select
  year(o.order_date) as order_year,
  month(o.order_date) as order_month,
  sum(oi.quantity * oi.list_price * (1 - oi.discount)) as total_sales
from sales.orders o
join sales.order_items oi on o.order_id = oi.order_id
group by year(o.order_date), month(o.order_date)
order by order_year, order_month;




-- 2.total sales by store

select
  s.store_name,
  sum(oi.quantity * oi.list_price * (1 - oi.discount)) as total_sales
from sales.stores s
join sales.orders o on s.store_id = o.store_id
join sales.order_items oi on o.order_id = oi.order_id
group by s.store_name
order by total_sales desc;


-- 3.total sales by product category

select
  c.category_name,
  sum(oi.quantity) as total_units_sold,
  sum(oi.quantity * oi.list_price * (1 - oi.discount)) as total_sales
from production.categories c
join production.products p on c.category_id = p.category_id
join sales.order_items oi on p.product_id = oi.product_id
group by c.category_name
order by total_sales desc;


-- 4.top 10 customers by total sales(desc)

select top 10
  c.first_name + ' ' + c.last_name as customer_name,
  sum(oi.quantity * oi.list_price * (1 - oi.discount)) as total_sales
from sales.customers c
join sales.orders o on c.customer_id = o.customer_id
join sales.order_items oi on o.order_id = oi.order_id
group by c.first_name, c.last_name
order by total_sales desc;



-- 5.total sales by staff member

select
  st.first_name + ' ' + st.last_name as staff_name,
  sum(oi.quantity * oi.list_price * (1 - oi.discount)) as total_sales
from sales.staffs st
join sales.orders o on st.staff_id = o.staff_id
join sales.order_items oi on o.order_id = oi.order_id
group by st.first_name, st.last_name
order by total_sales desc;



-- 6.top 10 cities by #orders 
select top 10
  c.city,
  count(distinct o.order_id) as orders_count
from sales.customers c
join sales.orders o on c.customer_id = o.customer_id
group by c.city
order by orders_count desc;


-- 7.average order value per store


select
  s.store_name,
  sum(oi.quantity * oi.list_price * (1 - oi.discount)) /
  count(distinct o.order_id) as avg_order_value
from sales.stores s
join sales.orders o on s.store_id = o.store_id
join sales.order_items oi on o.order_id = oi.order_id
group by s.store_name
order by avg_order_value desc;

-- 8.low-stock products (ex:less than 5 units)

select
  st.store_name,
  p.product_name,
  b.brand_name,
  s.quantity
from production.stocks s
join production.products p on s.product_id = p.product_id
join production.brands b on p.brand_id = b.brand_id
join sales.stores st on s.store_id = st.store_id
where s.quantity < 5
order by st.store_name, s.quantity;

-- 9.bottom 10 customers by total sales(asc)

select top 10
  c.first_name + ' ' + c.last_name as customer_name,
  sum(oi.quantity * oi.list_price * (1 - oi.discount)) as total_sales
from sales.customers c
join sales.orders o on c.customer_id = o.customer_id
join sales.order_items oi on o.order_id = oi.order_id
group by c.first_name, c.last_name
order by total_sales asc;


-- 10. top 30 repeat customers (2+ orders)

select top 30
  c.customer_id,
  c.first_name + ' ' + c.last_name as customer_name,
  count(o.order_id) as orders_count
from sales.customers c
join sales.orders o on c.customer_id = o.customer_id
join sales.order_items oi on o.order_id = oi.order_id
group by c.customer_id, c.first_name, c.last_name
having count(o.order_id) >= 2
order by orders_count desc



-- 11.average discount applied per order

select
  avg(discount) as avg_discount_per_order
from sales.order_items;

-- 12.staff activity (number of orders handled)

select
  st.first_name + ' ' + st.last_name as staff_name,
  count(o.order_id) as orders_handled
from sales.staffs st
join sales.orders o on st.staff_id = o.staff_id
group by st.first_name, st.last_name
order by orders_handled desc;

