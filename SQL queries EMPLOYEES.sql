use employees ;

select count(*) from employees ;

show tables ;

select count(*) from dept_emp ;

select count(*) from dept_manager ;

select count(*) from departments ;

select count(*) from salaries ;

select count(*) from titles ;

#limit queries

select * from dept_emp limit 5;

select * from dept_emp limit 5;

#------------------------------
# use count for the knowing the no in the tables--

select count(*) from employees where gender='m' ;

select count(*) from employees where gender='M' ;

select first_name, last_name from employees where gender='m' ;

select distinct(first_name) from employees ;

#to distict name we use this clause 

select count(distinct(first_name)) as unique_name from employees ;

select * from employees where first_name = 'rohit' ;


select count(*) from employees where first_name = 'pranjal' or first_name ='pradeep';

select * from employees where first_name in( 'sushant' , 'pranjal' , 'pradeep' , 'adam') ;

 #use of not in to display the opposite records of in clause

select count(*) from employees where first_name not in( 'sushant' , 'pranjal' , 'pradeep' , 'adam') ;

#like fuctions or cluause use in query--

select count(*) from dept_manager ;

use employees;

select count(*) from dept_manager ;

select count(*) from dept_emp ;

select count(*) from dept_manager ;

select count(*) from titles ;

select count(*) from employees ;

select count(*) from salaries ;

show databases ;
use employees;

# USE like clause------------------------------------------------------

select * from employees where first_name like ('%sh') ;#find the name end with _sh
select * from employees where first_name like ('sh%') ;#find name start with SH i the column--

select * from employees where first_name like ('mar__') ;#under score missing letter which it search

#from the large the large string we small portion of string--

select substr(birth_date , 6 , 2 ) FROM employees; #select month by yyyy-mm-dd here birth date 
#column taken 6 is from were it start 2 is length to particular date

select * from employees limit 5;

#find age of the employees
select (substr(hire_date,1,4) - substr(birth_date,1,4)) from employees limit 10;

#find current age of employees
select birth_date,(substr( sysdate(),1,4)-substr(birth_date,1,4)) as emp_agee from employees ;

#hr want to know how many people were hire in 1991--

select * from employees where hire_date between '1991-01-01' and '1991-12-31';

#agrregate function --
#count,round off,min ,max,average, round off--

select max(salary ) from salaries;

select min(salary ) from salaries;

select avg(salary) from salaries;

# too give appropriate or or no without decimal--
select round(avg(salary)) from salaries;

# here give  upto 2 decimal from appropriate value --
select round(avg(salary),2) from salaries; 

# distinct give only unique name in the column--

# find no male and female for (camparison count we use group by clause)
select gender,count(gender) from employees group by gender;#to bring count of no of m and f-- 

#how many time the name are repeated find--\
select first_name,count(first_name) as no_of_unique_name
 from employees group by first_name;

select count(first_name) as no_of_georgi from employees 
where first_name='georgi';

# how arrage column --by order by clause-
select first_name,count(first_name) as no_of_unique_name from 
employees group by first_name order by no_of_unique_name ;#ascending order bydefault

select first_name,count(first_name) as no_of_unique_name from 
employees group by first_name order by no_of_unique_name desc;#decending order

select salary from salaries order by salary desc;

# find the avrg salaries for the employees
select emp_no,round(avg (salary),2) as average_salary from salaries 
group by emp_no order by average_salary desc;

select emp_no,round(avg (salary),2) as average from salaries where emp_no=109334;

# to remove 3 highest salary from the table
select emp_no,round(avg (salary),2) as average_salary from 
salaries group by emp_no order by average_salary desc limit 2,1 ;

# get those name and count which are appering more than 210

select * from employees limit 10;
select first_name,count(first_name) as no_of_unique from 
employees group by first_name order by no_of_unique in(no_of_unique>210);#wrong ans

# by sir right ANS
select first_name,count(first_name) as no_of_unique from 
employees group by first_name having no_of_unique > 210 order by no_of_unique;
# having is with group by
#having is used between group by and order by 
#so basicaaly having acts like where when spplied to a group by a block

# get the emp_no and avg salary is more than 70000
select emp_no,round(avg (salary),2) as average_salary from 
salaries group by emp_no having average_salary>70000 order by average_salary ;
#group by used to give no of unique name in column

# 19 june--------------------------------------------------------------------------
use employees ;

# CASE statement-------------------------------------------------------------------------

select * from salaries limit 20;
# hr wamt to put the emloyees in some group / categories based o their salary
# requirement if it is less than 50000 mark it as medium
# if it is more than 40000 and less than 50000 mark it as medium 
# we will use case statement 

select emp_no , salary ,
case
	when salary <= 40000 then 'low'
    when salary > 40000 and salary <= 50000 then 'medium'
    else 'high' end as income_categories
from salaries ; #while using case when--then--when--and--then--else--end as

#how many unique(distinct) titles are there
select * from titles;
select distinct (title) from titles ;

# hr manager want toknow informarion iin the format of
#if staff or engineer or assistant eng mark as 'entry level'
#if dsenior staff or senior engineer mark it as 'mid_level'
#if technical leader or manager mark it as 'management level'

select emp_no , title ,
case
	when title = 'staff' or title='engineer'  then 'entry_level'
    when title = 'senior staff' or title='Senior Engineer'  then 'mid_level'
    else 'management_level' end as hr_title
from titles ; #while using case when--then--when--and--then--else--end as

#second soltion-
select emp_no , title ,
case
	when title in( 'staff','engineer','assistant engineer')  then 'entry_level'
    when title in('senior staff','Senior Engineer')  then 'mid_level'
    else 'management_level' end as position
from titles ;

#ps:find out alll the employees for different different designations
# end sort the from highest to lowest
# title number of people for those title
select title,count(title) as no_of_emp from titles group by title order by no_of_emp desc;

#JOINS----------------------------------------------------------------------------------

select * from dept_manager;
# i want to get the names of all the managers and there emp_no 
# output emp no ,employees ,first name ,last_name--
select employees.emp_no , employees.first_name , employees.last_name
from employees
inner join dept_manager on ( employees.emp_no = dept_manager.emp_no);

select e.emp_no , e.first_name , e.last_name
from employees e
inner join dept_manager on ( e.emp_no = dept_manager.emp_no);

# practice----
# get the name , emp_no and the avrg salary for all the employees

select  e.emp_no , e.first_name , e.last_name , avg(s.salary) as avg_salary
from employees e 
join salaries s on ( e.emp_no = s.emp_no) group by emp_no;

#get me the name of all female managers--
select * from employees;
select * from dept_manager;
select * from departments;

use employees;

select  e.emp_no , e.first_name , e.last_name ,dm.dept_no , e.gender
from employees e 
join dept_manager dm on ( e.emp_no = dm.emp_no) where gender='F';

# emp_no,dept_no, dept_name from all employees

select  d.emp_no , dp.dept_name ,d.dept_no
from dept_emp d
join departments dp on ( d.dept_no = dp.dept_no) order by d.emp_no;

#-----------------------------------



use employees;

# emp_no , first name last name salary only for the manager
select  e.emp_no , e.first_name , e.last_name , round(avg(s.salary),2) as avg_sal
from employees e
join salaries s on ( e.emp_no = s.emp_no )
join titles t on (e.emp_no = t.emp_no )
where t.title = 'manager' 
group by t.emp_no 
order by avg_sal desc;

# 2 solution
select  e.emp_no , e.first_name , e.last_name , round(avg(s.salary),2) as avg_sal
from employees e
join salaries s on ( e.emp_no = s.emp_no )
join dept_manager dm on (e.emp_no = dm.emp_no )
group by dm.emp_no
order by avg_sal desc;

# shubham error-----
select  e.emp_no , e.first_name , e.last_name , round(avg(s.salary),2) as avg_sal
from employees e
join salaries s on ( e.emp_no = s.salary )
join titles t on (e.emp_no = t.title)
where t.title = 'manager' 
group by t.title;

# get the below datails
# emp_no fist_name last_ name for all the senior engin working in the 'production' dept
select  e.emp_no , e.first_name , e.last_name ,d.dept_name
from employees e
join dept_emp de on ( e.emp_no = de.emp_no )
join departments d on (de.dept_no = d.dept_no )
join titles t on (e.emp_no = t.emp_no)
where t.title = 'senior engineer' and d.dept_name='production'
group by t.emp_no;

# write a query to select the minimum salary fro the team leader

use employees;

# maximum salary of manager
select e.first_name, e.last_name, t.emp_no, max(s.salary)
 from titles t
 join salaries s on (t.emp_no = s.emp_no)
 join employees e on (e.emp_no = t.emp_no)
 where t.title = 'Manager';
 
 #minumum salary of technical leader--
 select e.first_name, e.last_name, t.emp_no, min(s.salary)
 from titles t
 join salaries s on (t.emp_no = s.emp_no)
 join employees e on (e.emp_no = t.emp_no)
 where t.title = 'Technique leader';

select t.emp_no, min(s.salary)
 from titles t
 join salaries s on (t.emp_no = s.emp_no)
 where t.title = 'Technique leader';
 
 # USE  concat function for joining two table names---
 select concat(first_name," ",last_name) as name from employees;
 
 #load csv file
 
 
 use employees;
 
#-------------------------------------------------------------------- 
#SUB QUERY--

# Subqueries--A query inside a another query(nested query)
# more than 1 select statement
# ( when aa sub query isc exucuted in a query is a executed first and o/p from inner query act as i/p for outer query
# in sub query we get the column only from one table )
# we can fetch columns from more than one
#inner query should be always in () paranthysis

use employees;
# requirement to get fisrt name and last name of all the managers
select emp_no , first_name , last_name from employees
where emp_no in ( select emp_no from dept_manager ); #select only managers

select emp_no , first_name , last_name from employees
where emp_no in ( select emp_no from dept_manager); #select exept managers
    
# emp_no , salary _for the managers not using managers using subquery
select emp_no , salary , round(avg(salary)) as avg_salary from salaries
where emp_no in ( select emp_no from dept_manager) group by emp_no ;

#bring same answer using titles table--
select emp_no , salary , round(avg(salary)) as avg_salary from salaries
where emp_no in ( select emp_no from titles 
where title='manager') group by emp_no ;

# find the second max salary without using limit use use sub query--(158220, 157821, 155709)

select salary from salaries order by salary desc limit 2,1; # by using limit

select max(salary) from salaries
where salary < (select max(salary) 
from salaries where salary  not in (select max(salary) from salaries)) ;

select distinct (title) from titles;

#emp_no, fisrt_name, last_name, who are technical leader greater than 70000 salary
select emp_no , first_name , last_name from employees
where emp_no in ( select emp_no from titles where title = 'technique leader' 
and emp_no in(select emp_no from salaries
where salary > 70000 ) );

#i want emp_no fisrt name, last name, of all senior engineer who were hired in year 1985

select emp_no , first_name , last_name  from employees
where emp_no in ( select emp_no from titles where title = 'senior engineer' 
and emp_no in( select emp_no from employees where hire_date between '1985-01-01'
 and '1985-12-31') ); # using between
 
 select emp_no , first_name , last_name  from employees
where emp_no in ( select emp_no from titles where title = 'senior engineer' 
and emp_no in( select emp_no from employees where substring(hire_date , 1,4)= 1985)) ;# by using substr

select emp_no , first_name , last_name  from employees
where emp_no in ( select emp_no from titles where title = 'senior engineer' 
and emp_no in( select emp_no from employees where hire_date >= '1985-01-01'
 and hire_date <='1985-12-31') ); # giving direct condition--
 
# problem statement( recognize the old employees)
# select all the employees who have joined before 1990 and
# they are still woking organization given them 25% salary hike
# show the data for first 1000 employees 
# where substring(hire_date , 1,4)= 1985 and sysdate()
select * from dept_emp;


select e.emp_no, e.first_name, e.last_name ,s.salary,de.to_date, 
(1.25*s.salary) as new_salary,max(de.to_date),e.hire_date 
from employees e
join dept_emp de on(de.emp_no=e.emp_no)
join salaries s on (e.emp_no=s.emp_no)
group by emp_no having
max(de.to_date) > sysdate() and e.hire_date < "1990-01-01"
limit 1000; # substring(e.hire_date , 1,4)<= 1990 and sysdate();

#------------------------------------------------------------------------------------------------------
use employees;

# reqirement is to see the latest department in which  the employee is working
select emp_no , dept_no , max(from_date) from 
dept_emp
where to_date > sysdate()
group by emp_no;

 select emp_no , dept_no, max(from_date) from dept_emp
 group by emp_no having max(to_date) > sysdate() ;# wrong

select * from dept_emp;#331603
select emp_no, dept_no ,from_date , max(to_date )from dept_emp group by emp_no order by emp_no;

/*#select emp_no, dept_no from dept_emp where dept_no = max(dept_no)  in  group by emp_no order by emp_no*/
	
    
# in dept_emp table for a single person there can be more than 1 entry
 # find for how many people there is more than 1 entry
 
 select emp_no,count(emp_no) from dept_emp
 group by emp_no having count(emp_no)> 1;
 
 
 
 
 #---------------------------------------------------------------------------------------------------------------------
 # so know we are convince that same employees wentry can be more than one in the table of dept_emp
 #hr manager is intrested to see lastest information of dept_info of the employee
 
 # VIEW
 # COMPANY CONVENTION THAT ITS SHOOULD START WITH V
 CREATE view v__latest_dept_info as 
 select emp_no , dept_no, max(from_date) from dept_emp
 group by emp_no having max(to_date) > sysdate() ;
 
 #create view for average manager salary--
 create view v_avgsal_manager as
 select emp_no , salary , round(avg(salary)) as avg_salary from salaries
where emp_no in ( select emp_no from dept_manager) group by emp_no ;
 
select s.emp_no,round(avg(s.salary),2),t.title
from salaries s
inner join titles t on s.emp_no=t.emp_no where t.title='manager' group by t.emp_no;#2

# join, subquery we can select the data from more than 1 table
#union to select the data from more than 1 table
#union to combine the data  of the data from 2 more select statements
# condition which need to be satisfied while using union 
 #cols must have the similar data (int,char,varchar )
 #column in each statement must be in the same order 




 
 
															


	







    






 
 















