-- create data_warehouse schema
create schema data_warehouse;

-- create dimension table
create table data_warehouse.dim_customer (
	customer_id SERIAL primary key,
	customer_name VARCHAR(100),
	email VARCHAR(100),
	phone_number VARCHAR(20)
);

create table data_warehouse.dim_product (
	 product_id SERIAL primary key,
	 product_name VARCHAR(100),
	 category VARCHAR(50),
	 price numeric(10, 2)
);

create table data_warehouse.dim_time (
	date_id SERIAL primary key,
	day_of_week VARCHAR(100),
	month VARCHAR(10),
	quarter VARCHAR(10),
	year INT
);


-- create fact table
create table data_warehouse.fact_sales (
	sale_id SERIAL primary key,
	customer_id INT references data_warehouse.dim_customer(customer_id),
	product_id INT references data_warehouse.dim_product(product_id),
	date_id INT references data_warehouse.dim_time(date_id),
	quantity INT,
	revenue NUMERIC(12, 2)
);



-- populate the dimension tables
insert into data_warehouse.dim_customer (customer_name, email, phone_number)
select customer_name, email, phone_number from global.customer;

insert into data_warehouse.dim_product (product_name, category, price)
select product_name, category, price from global.product;

insert into data_warehouse.dim_time (day_of_week, month, quarter, year)
select day_of_week, month, quarter, year from global.time;


-- populate the fact table 
insert into data_warehouse.fact_sales (customer_id, product_id, date_id, quantity, revenue)
select customer_id, product_id, date_id, quantity, revenue from global.sales; 



-- 1. Berapa banyak penjualan total revenue di Quarter 1 2024?
select * from data_warehouse.dim_time;

select sum(fs.revenue) as total_revenue
from data_warehouse.fact_sales fs
join data_warehouse.dim_time dt on fs.date_id = dt.date_id
where dt.quarter = '1' and dt.year = 2024;

-- 2. Berapa banyak penjualan secara quantity di Quarter 4 2023?
select * from data_warehouse.dim_time;

select sum(fs.quantity) as total_quantity
from data_warehouse.fact_sales fs
join data_warehouse.dim_time dt on fs.date_id = dt.date_id
where dt.quarter = '4' and dt.year = 2023;

-- 3. Dari semua data penjualan yang ada, carilah di Quarter berapa dan tahun berapa penjualan paling banyak secara revenue?
select dt.quarter, dt.year, sum(fs.revenue) as total_revenue
from data_warehouse.fact_sales fs
join data_warehouse.dim_time dt on fs.date_id = dt.date_id
group by dt.quarter, dt.year
order by total_revenue desc limit 1;

