-- 1. Buat query untuk menghitung total penjualan (dalam jumlah uang) yang dihasilkan oleh setiap produk.

select * from products;
select * from sales;

select p.product_id, p.product_name, sum(s.quantity*s.price) as total_sales_products
from sales s
join products p on s.product_id = p.product_id 
group by p.product_id, p.product_name;

-- 2. Buat query untuk menghitung rata-rata harga produk per kategori.

select * from products;

select category, avg(price) as avg_price_category
from products
group by category;

-- 3.Buat query untuk menghitung total penjualan yang dihasilkan oleh setiap karyawan.

select * from employees;
select * from sales;

select e.employee_id, e.name, sum(s.quantity*s.price) as total_sales_employees
from sales s
join employees e on s.employee_id = e.employee_id
group by e.employee_id, e.name;

-- 4.Buat query untuk mencari penjualan terbesar dan terkecil yang pernah terjadi.

select * from sales;

-- terkecil
select sale_id, sum(quantity*price) as total_sales
from sales
group by sale_id
order by total_sales asc;

-- terbesar
select sale_id, sum(quantity*price) as total_sales
from sales
group by sale_id
order by total_sales desc;

-- 5. Buat query untuk mencari produk yang memiliki total penjualan tertinggi (berdasarkan jumlah unit yang terjual).

select * from products;
select * from sales;

select p.product_id, p.product_name, s.quantity
from sales s
join products p on s.product_id = p.product_id
order by s.quantity desc;

-- 6. Buat query untuk mencari karyawan yang memiliki pendapatan di atas rata-rata.

select * from employees;
select avg(salary) from employees;

select *
from employees
where salary >
	(
		select avg(salary)
		from employees
	);

-- 7. Buat query untuk menampilkan semua penjualan beserta nama produk dan nama karyawan yang terlibat.

select * from sales;
select * from products;
select * from employees;

select s.sale_id, e.name, p.product_name, s.quantity, s.price, s.sale_date
from sales s
join employees e on s.employee_id = e.employee_id 
join products p on s.product_id = p.product_id ;

-- 8. Buat query untuk menghitung total penjualan yang dihasilkan oleh setiap departemen.

select * from sales;
select * from departments;
select * from employees;

select d.department_name, sum(s.quantity*s.price) as total_sales_dept
from sales s
join employees e on s.employee_id = e.employee_id
join departments d on e.department_id = d.department_id
group by d.department_name;

-- 9. Buat query untuk menampilkan nama dan gaji karyawan yang gajinya di atas rata-rata.

select * from employees;
select avg(salary) from employees;

select name, salary
from employees
where salary >
	(
		select avg(salary)
		from employees
	);

-- 10. Buat query menggunakan CTE untuk mengetahui jumlah total gaji per departemen dan menampilkan departemen yang total gajinya lebih tinggi dari 100000.

WITH DepartmentSalary AS (
    SELECT 
        department_id,
        SUM(salary) AS total_salary
    FROM 
        employees
    GROUP BY 
        department_id
)
SELECT 
    department_id,
    total_salary
FROM 
    DepartmentSalary
WHERE 
    total_salary > 100000;

-- pembuktian menggunakan simple query
select * from employees where salary > 100000; --kebetulan departmntnnya masing-masing 1



