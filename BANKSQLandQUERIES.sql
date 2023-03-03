create database bank; --- create database


use bank; # calling the database


### TAKING THE INSIGHT OF THE  BANK DATA BY RUNNING THE SELECT QUERIES

#bank_account_details

SELECT 
    *
FROM
    bank_account_details;
    
# bank_account_transaction

SELECT 
    *
FROM
    bank_account_transaction;
    
# bank_customer    

SELECT 
    *
FROM
    bank_customer;
    
# orders    
SELECT 
    *
FROM
    orders;
    
#customer
SELECT 
    *
FROM
    customer;
    
# Salesman
SELECT 
    *
FROM
    salesman;

# create the below output create a salesman name ,id of salesman total commission earn by size

SELECT 
    s.salesman_id,
    s.name,
    ROUND(SUM(s.commision * o.purch_amt)) AS totalcommision
FROM
    salesman s
        INNER JOIN
    orders o ON (s.salesman_id = o.salesman_id)
GROUP BY s.salesman_id
ORDER BY 3 DESC;

# account_no ,transaction amount ,transaction transaction channel fee applied;

SELECT 
    account_number,
    transaction_amount,
    transcation_channel,
    CASE
        WHEN transaction_amount < 0 THEN .05 * transaction_amount
        ELSE '0'
    END AS feeapplied
FROM
    bank_account_transaction
ORDER BY feeapplied DESC;

use bank;



# Subqueries--A query inside a another query(nested query)
# more than 1 select statement
# notes ( when aa sub query isc exucuted in a query is a executed first and o/p from inner query act as i/p for outer query
# in sub query we get the column only from one table )
# we can fetch columns from more than one

# requirement to get fisrt name and last name of all the managers

#------------------------------------------------------------------------------------------------------------------


### QUESTIONS SQL based BANK data------------------


use bank;  # kept the bank database name for the all csv of bank

/* 1 question Write a SQL query which will sort out the customer and their grade 
#who made an order. Every customer must have a grade and be served 
by at least one seller, who belongs to a region*/
#Ans-
select custemor_id, cust_name, grade from customer group by custemor_id order by custemor_id; #1

SELECT 
    c.custemor_id, c.cust_name, c.grade
FROM
    customer c
        JOIN
    salesman s ON (c.salesman = s.salesman_id)
        JOIN
    orders o ON (s.salesman_id = o.salesman_id)
        AND s.city IS NOT NULL
        AND c.grade IS NOT NULL
GROUP BY c.custemor_id
order by c.custemor_id;#1

SELECT 
    c.custemor_id, c.cust_name, c.grade,s.name
FROM
    customer c , salesman s , orders o
where c.salesman = s.salesman_id and s.salesman_id = o.salesman_id
        AND s.city IS NOT NULL
        AND c.grade IS NOT NULL
GROUP BY c.custemor_id
order by c.custemor_id;#2

/*2 question  Write a query for extracting the data from the order table for the 
salesman who earned the maximum commission.*/
#Ans-
SELECT 
    o.ord_no , s.name, MAX(commision) AS high_commision
FROM
    salesman s
        INNER JOIN
    orders o ON (o.salesman_id = s.salesman_id);#1
    
    select o.ord_no , o.purch_amt , s.name , s.commision,
    max(commision) as max_commision from orders o , salesman s
    where o.salesman_id = s.salesman_id;

/*3 question From orders retrieve only ord_no, purch_amt, ord_date, ord_date, 
salesman_id where salesman’s city is Nagpur(Note salesman_id of 
orderstable must be other than the list within the IN operator.*/
#Ans
SELECT 
    s.salesman_id, o.purch_amt, o.ord_date, s.city
FROM
    salesman s
        INNER JOIN
    orders o ON (o.salesman_id = s.salesman_id)
WHERE
    s.city = 'nagpur'; # not with this solution ans wrong

select salesman_id, city, name from salesman where city =  'nagpur' 
in ( select  purch_amt , ord_date , salesman_id   from orders );#2nd correct solution

/*4 question Write a query to create a report with the order date in such a way 
that the latest order date will come last along with the total purchase 
amount and the total commission for that date is (15 % for all sellers).*/ 
#Ans-

SELECT 
    o.ord_date,
    o.ord_no,
    SUM(o.purch_amt) AS total_purch_amt,
    s.commision,
    ROUND(SUM(0.15 * o.purch_amt), 2) AS totalcommision
FROM
    salesman s
        INNER JOIN
    orders o ON (s.salesman_id = o.salesman_id)
GROUP BY o.ord_date
ORDER BY o.ord_date DESC;

/*5 question Retrieve ord_no, purch_amt, ord_date, ord_date, salesman_id from 
 Orders table and display only those sellers whose purch_amt is 
 greater than average purch_amt.*/
SELECT 
    ord_no, purch_amt, ord_date, salesman_id
FROM
    orders
WHERE
    purch_amt > (SELECT 
            AVG(purch_amt)
        FROM
            orders); 


#6 question  Write a query to determine the Nth (Say N=5) highest purch_amt from Orders table.
select purch_amt from orders order by purch_amt limit 4,1;

#7  What are Entities and Relationships?
#Ans-
/*Entity - It is something that is use to identify object.
It is used for the representation of real world object.
relationship - It is use to relate or to show relation 
for-example suppose in the class there are childrens and a teacher
then here relation of teacher to childrens is one to many*/


/* 8  Print customer_id, account_number and balance_amount, condition 
that if balance_amount is nil then assign transaction_amount for 
account_type = "Credit Card"*/
/*select customer_id , account_number,balance_amount, (balance_amount+transaction_amount) ,account_type
when balance_amount < 0 then acount_type='credit card'
else balance_amount=0 from bank_account_details , bank_account_tranction;*/# ans progress
#Ans-
select * from bank_account_details;
SELECT 
    bad.customer_id,
    bat.Account_number,
    account_type,
    bad.balance_amount,
    (balance_amount + Transaction_amount) AS new_balance_amount
FROM
    bank_account_details bad,
    bank_account_transaction bat
WHERE
    bad.Account_Number = bat.Account_number
        AND balance_amount = 0
        AND account_type = 'Credit Card';


/*9. Print customer_id, account_number, balance_amount, conPrint 
account_number, balance_amount, transaction_amount from 
Bank_Account_Details and bank_account_transaction for all the 
transactions occurred during march, 2020 and april, 2020*/
#Ans-
SELECT 
    bad.customer_id,
    bad.account_number,
    bad.balance_amount,
    bat.transaction_amount,
    bat.transaction_date
FROM
    bank_account_transaction bat
        INNER JOIN
    bank_account_details bad ON bat.Account_Number = bad.Account_Number
WHERE
    bat.transaction_date BETWEEN '2020-03-01' AND '2020-04-30';



/*10. Print all of the customer id, account number, balance_amount,
transaction_amount from bank_cutomer, bank_account_details and 
bank_account_transactions tables where excluding all of their 
transactions in march, 2020 month .
*/
#Ans-
SELECT 
    bc.customer_id,
    bad.account_number,
    bad.balance_amount,
    bat.transaction_amount,
    bat.transaction_date
FROM
    bank_account_details bad
        INNER JOIN
    bank_customer bc ON bad.customer_id = bc.customer_id
        INNER JOIN
    bank_account_transaction bat ON bat.Account_Number = bad.account_number
WHERE
    bat.Transaction_Date NOT BETWEEN '2020-03-01' AND '2020-03-31';






  
  
  
  
  
  
  












