use classicmodels;

/*1. Write a query to display each customer’s name (as “Customer Name”) alongside the name of the employee
 who is responsible for that customer’s orders. The employee name should be in a single “Sales Rep” column formatted as
  “lastName, firstName”. The output should be sorted alphabetically by customer name. */

select c.customerName as "Customer Name", concat(e.lastName  ,' , ', e.firstName) as "Sales Repo"
from customers c 
join employees e 
on c.salesRepEmployeeNumber =e.employeeNumber
order by c.customerName;

/* 2. Determine which products are most popular with our customers. For each product, list the total quantity
  ordered along with the total sale generated (total quantity ordered * priceEach) for that product.
 The column headers should be “Product Name”, “Total # Ordered” and “Total Sale”. List the products by Total Sale descending.*/

select p.productName as "Product Name", o.quantityOrdered as "Total # Ordered", o.quantityOrdered * o.priceEach as "Total Sale"
from products p 
join orderdetails o 
on p.productCode = o.productCode
group by p.productName
order by o.quantityOrdered * o.priceEach desc ;

/*3. Write a query which lists order status and the # of orders with that status.
 Column headers should be “Order Status” and “# Orders”. Sort alphabetically by status. */ 

select status as "Order Status", count(*) as "# Orders" 
from orders
group by status 
order by status;

/*4. Write a query to list, for each product line, the total # of products sold from that product line.
   The first column should be “Product Line” and the second should be “# Sold”. Order by the second column descending.*/

select p2.productLine as "Product Line", sum(o.quantityOrdered) as "# Sold"
from products p 
join productlines p2 
on p.productLine = p2.productLine
join orderdetails o 
on p.productCode =o.productCode
group by p2.productLine 
order by sum(o.quantityOrdered) desc ;


/* 5.For each employee who represents customers, output the total # of orders that employee’s customers have placed alongside the total sale
 amount of those orders. The employee name should be output as a single column named “Sales Rep” formatted as “lastName, firstName”. 
 The second column should be titled “# Orders” and the third should be “Total Sales”.
  Sort the output by Total Sales descending. Only (and all) employees with the job title ‘Sales Rep’ should be included in the output,
  and if the employee made no sales the Total Sales should display as “0.00”.*/

select concat(e.lastName  ,' , ', e.firstName) as 'Sales Rep"', count(distinct o.orderNumber) as '# Orders', if(o2.quantityOrdered is null, '0.00', sum(o2.quantityOrdered * o2.priceEach))
from employees e 
left join  customers c 
on c.salesRepEmployeeNumber = e.employeeNumber
left join orders o 
on c.customerNumber = o.customerNumber 
left join orderdetails o2 
on o.orderNumber = o2.orderNumber 
where e.jobTitle = 'Sales Rep'
group by e.employeeNumber 
order by sum(o2.quantityOrdered * o2.priceEach) desc;

/* 6. Your product team is requesting data to help them create a bar-chart of monthly sales since the company’s inception. 
 * Write a query to output the month (January, February, etc.), 4-digit year, and total sales for that month. 
 * The first column should be labeled ‘Month’, the second ‘Year’, and the third should be ‘Payments Received’. 
 * Values in the third column should be formatted as numbers with two decimals – for example: 694,292.68. */

select monthname(p.paymentDate) as `Month`, cast(year(p.paymentDate) as char) as `Year`, format(sum(p.amount), 2) as `Payments Received`
from payments p 
group by `Year`, `Month`;





