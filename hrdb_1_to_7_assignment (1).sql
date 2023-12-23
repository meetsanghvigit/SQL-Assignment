-- assignment:-1
use hrdb;
-- 1. Display all information in the tables EMP and DEPT.
select * from employees,departments;

-- 2. Display only the hire date and employee name for each employee.
select hire_date,concat(first_name," ",last_name) as name from employees;

-- 3. Display the ename concatenated with the job ID, separated by a comma and space, and name the column Employee and Title
select concat(first_name," ",last_name,",",job_id) as employee from employees;

-- 4. Display the hire date, name and department number for all clerks.
select hire_date,first_name,department_id,job_title from jobs join employees on jobs.job_id=employees.job_id where job_title like "%Clerk%";

-- 5. Create a query to display all the data from the EMP table. Separate each column by a comma. Name the column THE OUTPUT
select concat_ws(", ",employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) as THE_OUTPUT from employees; 

-- 6. Display the names and salaries of all employees with a salary greater than 2000.
select first_name,salary from employees where salary>2000;

-- 7. Display the names and dates of employees with the column headers "Name" and "Start_Date"
select first_name as Name, hire_date as Start_date from employees;

-- 8. Display the names and hire dates of all employees in the order they were hired.
select first_name,hire_date from employees order by hire_date;

-- 9. Display the names and salaries of all employees in reverse salary order.
select concat(first_name,last_name) as name, salary from employees order by salary desc;

-- 10. Display 'ename" and "deptno" who are all earned commission and display salary in reverse order.
select concat(first_name," ",last_name) as Ename, department_id,salary from employees where commission_pct is not null order by salary desc;

-- 11. Display the last name and job title of all employees who do not have a manager
select concat(first_name," ",last_name) as Name,job_title from employees join jobs on employees.job_id=jobs.job_id where manager_id is null;


-- 12. Display the last name, job, and salary for all employees whose job is sales representative or stock clerk and whose salary is not equal to $2,500, $3,500, or $5,000
select last_name,job_title,salary from employees join jobs on employees.job_id=jobs.job_id where job_title="Sales Representative" or job_title="Stock Clerk" and salary!=2500 and salary!=3500 and salary!=5000;

-- assignment:-2

-- 1) Display the maximum, minimum and average salary and commission earned.
select first_name,max(salary), min(salary), avg(salary) as avg_salary, ifnull(salary*commission_pct,0) as commision from employees group by first_name,last_name order by avg_salary desc;

-- 2) Display the department number, total salary payout and total commission payout for each department
 select department_id as department_number,sum(salary) as total_salary, sum(ifnull(salary*commission_pct,0)) as total_commision from employees group by department_id;  

 -- 3) Display the department number and number of employees in each department.
 select department_id as department_number, count(employee_id) as number_of_employees from employees group by department_id; 

-- 4) Display the department number and total salary of employees in each department.
select department_id as department_number, sum(salary) as total_salary_of_employees from employees group by department_id; 

-- 5) Display the employee's name who doesn't earn a commission. Order the result set without using the column name
 select concat(first_name,' ',last_name) as employee_name from employees where commission_pct is null; 
 
 -- 6) Display the employees name, department id and commission. If an Employee doesn't earn the commission, then display as 'No commission'. Name the columns appropriately
 select concat(first_name,' ',last_name) as employee_name,department_id, ifnull(salary*commission_pct,'No commission') as commission from employees;
 
 -- 7) Display the employee's name, salary and commission multiplied by 2. If an Employee doesn't earn the commission, then display as 'No commission. Name the columns appropriately
 select concat(first_name,' ',last_name) as employee_name,salary,ifnull(salary*commission_pct/2,'No commission') as commission from employees;
 
 -- 8) Display the employee's name, department id who have the first name same as another employee in the same department
 

-- 9) Display the sum of salaries of the employees working under each Manager.
select manager_id, sum(salary) from employees where manager_id is not null group by manager_id;

-- 10) Select the Managers name, the count of employees working under the manager and the department ID of the manager.
/*create table managers as select first_name,last_name,employee_id as manager_id, department_id,hire_date,salary from employees 
where employee_id in (select manager_id from employees group by manager_id) ;
select * from managers;
select * from employees;
drop table managers;
*/
select managers.first_name as manager_name, count(employees.first_name) as employee, employees.department_id from managers 
join employees on managers.manager_id=employees.manager_id group by employees.first_name; 

-- 11) Select the employee name, department id, and the salary. Group the result with the manager name and the employee last name should have second letter 'a!
select concat(employees.first_name,' ',employees.last_name) as employees_name,employees.department_id,employees.salary,jobs.job_title 
from employees join jobs on employees.job_id=jobs.job_id join managers on employees.manager_id=managers.manager_id where substr(employees.last_name,2,1)='a' and substr(employees.first_name,2,1)='a' order by department_id;
select * from jobs;

-- 12) Display the average of sum of the salaries and group the result with the department id. Order the result with the department id.
select avg(salary),department_id as avg_of_salary from employees group by department_id order by department_id ;

-- 13) Select the maximum salary of each department along with the department id.
select department_id, max(salary) from employees group by department_id;

-- 14) Display the commission, if not null display 10% of salary, if null display a default value 1.


select * from employees;
select job_id from jobs where job_title like'%Manager%';

-- assiignment-3 string
-- 1. Write a query that displays the employee's last names only from the string's 2-5th 
-- position with the first letter capitalized and all other letters lowercase, Give each column an appropriate label.
select concat(upper(substr(last_name,2,1)),substr(last_name,3,5)) as l_name from employees;

-- 2. Write a query that displays the employee's first name and last name along with a " in
-- between for e.g.: first name : Ram; last name : Kumar then Ram-Kumar. Also displays the month on which the employee has joined.
select concat(first_name,'-',last_name) as employee, monthname(hire_date) as joining_month from employees;

-- 3. Write a query to display the employee's last name and if half of the salary is greater than ten thousand then increase the salary 
-- by 10% else by 11.5% along with the bonus amount of 1500 each. Provide each column an appropriate label.
select last_name, 
case
when salary/2>10000 then (salary*10/100)+salary 
else (salary*11.5/100)+1500+salary
end as increased_salary
from employees;

-- 4. Display the employee ID by Appending two zeros after 2nd digit and 'E' in the end, department id, salary and the manager name all 
-- in Upper case, if the Manager name consists of 'z' replace it with '$!
select concat(substr(employee_id,1,2),'00',substr(employee_id,3,1),'E') as employee_id,department_id,salary from employees;

-- 5. Write a query that displays the employee's last names with the first letter capitalized and all other letters lowercase, and the length of the
-- names, for all employees whose name starts with J, A, or M. Give each column an appropriate label. Sort the results by the employees' last names
select concat(upper(substr(last_name,1,1)),lower(substr(last_name,2))) as last_name, 
case 
	when substr(last_name,1,1)='A'or substr(last_name,1,1)='J' or substr(last_name,1,1)='M' then length(last_name)
    end as length_last_name
 from employees order by last_name;
 
 -- 6. Create a query to display the last name and salary for all employees. Format the salary to be 15 characters long, left-padded 
 -- with $. Label the column SALARY
 select last_name,concat('$',salary) as salary from employees;
 select last_name, LPAD(salary,15,'$') AS "SALARY" from employees;
 
 -- 7. Display the employee's name if it is a palindrome.
select case when substr(first_name,1)=reverse(first_name) then first_name end as first_name from employees order by employee_id desc;
select if(substr(first_name,1)=reverse(first_name),'Yes','No') from employees;

-- 8. Display First names of all employees with initcaps.
select INITCAP(first_name) FROM employees;

-- 9. From LOCATIONS table, extract the word between first and second space from the STREET ADDRESS column.
select substring_index(street_address," ", 3) from locations;
select street_address from locations;

-- 10. Extract first letter from First Name column and append it with the Last Name. Also add "@systechusa.com" at the end. 
-- Name the column as e-mail address. All characters should be in lower case. Display this along with their First Name.
select lower(concat(substr(first_name,1,1),last_name,'@systechusa.com')) as e_mail_address from employees; 

-- 11. Display the names and job titles of all employees with the same job as Trenna.
select first_name,
case 
	when first_name is not null then 'Trenna'
    end as job_title
    from employees;

-- 12. Display the names and department name of all employees working in the same city as Trenna.
select concat(first_name,last_name) as names, department_name from employees join departments on employees.department_id=departments.department_id;

-- 13. Display the name of the employee whose salary is the lowest.
select concat(first_name,' ',last_name) as employee_name, salary as lowest_salary from employees order by salary;

-- 14. Display the names of all employees except the lowest paid.
select first_name,salary from employees where salary!=(select min(salary) from employees);

-- assignment:-4
-- 1. Write a query to display the last name, department number, department name for all employees.  
use hrdb;
select * from employees;
select emp.last_name,dep.department_id as department_number,dep.department_name from employees as emp,departments as dep where emp.department_id=dep.department_id; 

-- 2. Create a unique list of all jobs that are in department 40 Include the location of the department in the output.   
select department_name,street_address from locations join departments on locations.location_id=departments.location_id where department_id=40;
 
-- 3. Write a query to display the employee last name,department name,location id and city of all employees who earn commission.   
select first_name,last_name,department_name,departments.location_id,city from employees 
join departments on employees.department_id=departments.department_id join locations on departments.location_id=locations.location_id;

-- 4. Display the employee last name and department name of all employees who have an 'a' in their last name   
select last_name, department_name from employees join  departments on employees.department_id=departments.department_id where last_name like '%a%';
 
-- 5. Write a query to display the last name,job,department number and department name for all employees who work in ATLANTA.
select last_name,job_title,departments.department_id,department_name from employees join jobs on jobs.job_id=employees.job_id join  departments on employees.department_id=departments.department_id;
 
-- 6. Display the employee last name and employee number along with their manager's last name and manager number.   
select employees.last_name, employee_id as employee_number, managers.last_name, managers.manager_id as manager_number from employees 
join managers on employees.manager_id=managers.manager_id;
select * from managers;
-- select * from employees order by manager_id desc;

-- 7. Display the employee last name and employee number along with their manager's last name and manager number (including the employees who have no manager).   
select employees.last_name as emp_l_name, employee_id as employee_number, managers.last_name, managers.manager_id as manager_number from employees 
left join managers on employees.manager_id=managers.manager_id;
 
-- 8. Create a query that displays employees last name,department number,and all the employees who work in the same department as a given employee.   
select emp.last_name, dep.department_id as departmnet_number from employees as emp join departments as dep on emp.department_id=dep.department_id order by dep.department_id;
 
-- 9. Create a query that displays the name,job,department name,salary,grade for all employees.  Derive grade based on salary(>=50000=A, >=30000=B,<30000=C)   
select concat(first_name,' ',last_name) as e_name, job_title,salary,
case 
	when salary >=50000 then 'A'
    when salary >=30000 then 'B' 
    when salary <30000 then 'C' 
    end as grade
from employees join jobs on employees.job_id=jobs.job_id join departments on employees.department_id=departments.department_id; 
 
-- 10. Display the names and hire date for all employees who were hired before their managers along withe their manager names and hire date. Label the columns as Employee name, emp_hire_date,manager name,man_hire_date 
select concat(emp.first_name,' ',emp.last_name) as employee_name , emp.hire_date as emp_hire_date,concat(man.first_name,' ',man.last_name) manager_name,man.hire_date as man_hire_date
 from employees as emp join managers as man on emp.manager_id=man.manager_id where emp.hire_date<man.hire_date;
use hrdb;

-- Assignment:-5
use adventureworks;
-- 1. Write a query to display employee numbers and employee name (first name, last name) of all the sales employees who received an amount of 2000 in bonus.   
-- there is no table for employee name and number in AdventureWorks database.
select * from employee;
-- select EmployeeID, concat(first_name,' ',last_name) as employee_name from employee;

-- 2. Fetch address details of employees belonging to the state CA. If address is null, provide default value N/A.   
-- There is no state column in any table of AdventureWorks database.
 select ifnull(concat(AddressLine1,' ',city), null) as address from address where StateProvinceID= 79;
-- select * from countryregion where Name like 'CA%';
 
-- 3. Write a query that displays all the products along with the Sales OrderID even if an order has never been placed for that product.   
select product.Name, salesorderdetail.SalesOrderID from product left join salesorderdetail on product.ProductID=salesorderdetail.ProductID;
 
-- 4. Find the subcategories that have at least two different prices less than $15.   
create table subat15 select productsubcategory.name, product.listprice as price from productsubcategory 
join product on productsubcategory.ProductSubcategoryID=product.ProductSubcategoryID where listprice<15 group by listprice; 
select * from subat15 group by name having count(price) >= 2;

select * from product;
 
-- 5.  A. Write a query to display employees and their manager details. Fetch employee id,employee first name, and manager id, manager name. 
--     B. Display the employee id and employee name of employees who do not have manager. 
select EmployeeID, ManagerID from employee;
select EmployeeID, ManagerID from employee where EmployeeID not in (select ManagerID from employee group by ManagerID) group by EmployeeID; 
select EmployeeID, ManagerID from employee where ManagerID is null;

-- 6. A. Display the names of all products of a particular subcategory 15 and the names of their vendors. 
-- B. Find the products that have more than one vendor.   
-- for question A. there isn't any table connected with vendor fro productsubcategory.
select product.productsubcategoryid,productvendor.ProductID,productvendor.VendorID,vendor.Name from vendor 
join productvendor on productvendor.VendorID=vendor.VendorID
join product on productvendor.productid = product.productid 
where product.ProductSubcategoryID=15;
select ProductID, count(VendorID) as num_vendor from productvendor group by ProductID having count(VendorID)>1;

-- 7. Find all the customers who do not belong to any store.  
select * from customer left join store on customer.CustomerID=store.CustomerID where store.CustomerID is null;
 
-- 8. Find sales prices of product 718 that are less than the list price recommended for that product.   

 
-- 9. Display product number, description and sales of each product in the year 2001.   
select product.ProductNumber, Description from product join productdescription on product.ProductID=productdescription.ProductDescriptionID; 
select * from  salesorderheader;
select * from product;
-- there isn't any sales table connected to product or productdescription table so i have finished it with half answer.
 
-- 10. Build the logic on the above question to extract sales for each category by year. Fetch Product Name, Sales_2001, Sales_2002, Sales_2003.   
-- Hint: For questions 9 & 10 (From Sales.SalesOrderHeader, sales. SalesOrderDetail, Production. Product. Use ShipDate of SalesOrderHeader to extract shipped year. Calculate sales using QTY and unitprice from Sales OrderDetail.) 
-- there isn't any sales table connected to product or productdescription table so i don't have any answer.


-- Assignment:-6
-- 1. Write a query to display the last name and hire date of any employee in the same department as SALES.   
 select last_name,hire_date from employees join departments on employees.department_id=departments.department_id where department_name='sales';

-- 2. Create a query to display the employee numbers and last names of all employees who earn more than the average salary. Sort the results in ascending order of salary.   
select employee_id as employee_number, last_name from employees where salary>(select avg(salary) from employees) order by salary; 

-- 3. Write a query that displays the employee numbers and last names of all employees who work in a department with any employee whose last name contains a' u   
select employee_id as employee_number, last_name from employees where last_name like '%u%'; 

-- 4. Display the last name, department number, and job ID of all employees whose department location is ATLANTA.   
select last_name,department_id,job_id  from employees join loacations on departments.location_id=locations.location_id where locations.city='ATLANTA';
use hrdb;
select * from managers;
-- 5. Display the last name and salary of every employee who reports to FILLMORE
select employees.last_name,salary from employees join managers on managers.manager_id=employees.manager_id where managers.first_name='FILLMORE';

-- 6. Display the department number, last name, and job ID for every employee in the OPERATIONS department.   
select employees.department_id as department_number,last_name,job_id from employees join departments on employees.department_id=departments.department_id where departments.department_name='operations';  
 select * from departments;

-- 7. Modify the above query to display the employee numbers, last names, and salaries of all employees who earn more than the average salary and who work in a department with any employee with a 'u'in their name.   
select employees.department_id as department_number,last_name,salary from employees where salary>(select avg(salary) from employees) and last_name like '%u%';
 
-- 8. Display the names of all employees whose job title is the same as anyone in the sales dept.   
select concat(first_name,' ',last_name) as employee_name from employees join departments on employees.department_id=departments.department_id 
join jobs on employees.job_id=jobs.job_id where jobs.job_title=departments.department_name or job_title like '%sale%';
 
-- 9. Write a compound query to produce a list of employees showing raise percentages, employee IDs, and salaries. Employees in department 1 and 3 are given a 5% raise, employees in department 2 are given a 10% raise, employees in departments 4 and 5 are given a 15% raise, and employees in department 6 are not given a raise.   
select employee_id,salary,
case
	when department_id in (10,30) then (salary*5/100) + salary
    when department_id=20 then (salary*10/100) + salary
    when department_id in (40,50) then (salary*15/100) + salary
    when department_id =60 then 'NOT GIVEN RAISE ' 
	end as raised_percent_salary from employees;
 
-- 10. Write a query to display the top three earners in the EMPLOYEES table. Display their last names and salaries.   
select last_name,salary as employee_name from employees order by salary desc limit 3;
 
-- 11. Display the names of all employees with their salary and commission earned. Employees with a null commission should have O in the commission column   
select concat(first_name,' ',last_name) as employee_name,salary,ifnull(salary*commission_pct,0) as commission from employees;
 
-- 12. Display the Managers (name) with top three salaries along with their salaries and department information. 
select departments.department_id,departments.department_name, concat(first_name,' ',last_name) as manager_name,salary from managers 
join departments on managers.department_id=departments.department_id;

 
-- ASSIGNMENT:-7

-- 1) Find the date difference between the hire date and resignation_date for all the employees. Display in no. of days, months and year(1 year 3 months 5 days).
select concat( (year(resignation_date)-year(hire_date)), ' years ', 
	 if( (month(resignation_date)-month(hire_date)) < 0 , - (month(resignation_date)-month(hire_date)) , (month(resignation_date)-month(hire_date)) ),
     ' months ' ,
	 if ( (day(resignation_date)-day(hire_date)) < 0 , -(day(resignation_date)-day(hire_date)) , (day(resignation_date)-day(hire_date)) ),
	 ' days ' ) as time
     from jobd;

-- 2) Format the hire date as mm/dd/yyyy(09/22/2003) and resignation_date as mon dd, yyyy(Aug 12th, 2004). Display the null as (DEC, 01th 1900)   
select date_format(start_date,'%m/' '%d/' '%Y' ) as hire_date ,concat(substr(date_format(end_date,'%M'),1,3),' ', date_format(end_date, '%D '  '%Y' ) )as resgn_date from job_history;
 
-- 3) Calcuate experience of the employee till date in Years and months(example 1 year and 3 months)   
 -- Use Getdate() as input date for the below three questions.   
select concat( (year(current_timestamp) - year(hire_date)) , ' years ',
	if( (month(current_timestamp)-month(hire_date)) <0 , - (month(current_timestamp)-month(hire_date)) , (month(current_timestamp)-month(hire_date)) ), ' months ',
	if( (day(current_timestamp)-day(hire_date)) <0 , - (day(current_timestamp)-day(hire_date)) , (day(current_timestamp)-day(hire_date)) ),' days ' )
as experience from jobd where resignation_date is null;
select year(current_timestamp), hire_date from jobd where resignation_date is null;
select * from jobd;
-- 4) Display the count of days in the previous quarter   
select quarter(hire_date) from jobd;
  
-- 5) Fetch the previous Quarter's second week's first day's date   
 
-- 6) Fetch the financial year's 15th week's dates (Format: Mon DD YYYY)   

 
-- 7) Find out the date that corresponds to the last Saturday of January, 2015 using with clause.   

 
-- Use Airport database for the below two question:
--  8) Find the number of days elapsed between first and last flights of a passenger. 
--  9) Find the total duration in minutes and in seconds of the flight from Rostov to Moscow.  


drop table jobd;
create table jobd(
employee_id int,
hire_date DATE default NULL,
resignation_date DATE default NULL
);

use hrdb;
insert into jobd (employee_id,hire_date,resignation_date)
values (1,'2000-02-01','2013-10-07'),
(2,'2003-12-04','2017-08-03'),
(3,'2012-09-22','2015-06-21'),
(4,'2015-04-13',null),
(5,'2016-06-03',NULL),
(6,'2017-08-08',NULL),
(7,'2016-11-13',NULL);
drop table jobd;
select * from jobd;