show databases;
create database bank_24becs405;
use bank_24becs405;

create table branch (branch_name varchar(20), branchcity varchar(20), assets int (10),
 primary key(branch_name));

create table bank_Account ( accno int (10), branch_name varchar (20), balance int(20),
primary key(accno), 
foreign key(branch_name)references branch(branch_name));

create table depositer (customername varchar(20) , accno int(10),
foreign key(customername)references bank_customer(customername),
foreign key(accno)references bank_account(accno), primary key (accno,customername));

create table bank_customer (customername varchar(20) primary key, customer_street varchar (20),
city varchar(20));

create table loan (loan_number int(10) primary key, branch_name varchar(20), amount int (10),
foreign key(branch_name)references branch(branch_name));

desc branch;
desc bank_account;
desc depositer;
desc bank_customer;
desc loan;


insert into branch values ("SBI_chamrajpet","Bangalore",50000),
("SBI_ResidencyRoad","Bangalore",10000),
("SBI_ShivajiRoad","Bombay",20000),
("SBI_ParlimentRoad","Delhi",10000),
("SBI_Jantarmantar","Delhi",20000);
select * from branch;

insert into  bank_account values 
(1,"SBI_chamrajpet",2000),
(2,"SBI_ResidencyRoad",5000),
(3,"SBI_ShivajiRoad",6000),
(4,"SBI_ParlimentRoad",9000),
(5,"SBI_Jantarmantar",8000),
(6,"SBI_ShivajiRoad",4000),
(8,"SBI_ResidencyRoad",4000),
(9,"SBI_ParlimentRoad",3000),
(10,"SBI_ResidencyRoad",5000),
(11,"SBI_Jantarmantar",2000);
select * from  bank_account;

insert into  bank_customer values 
("Avinash","Bull_Temple_Road","Bangalore"),
("Dinesh","Bannergatta_Road","Bangalore"),
("Mohan","NationalCollege_Road","Bangalore"),
("Nikil","Akbar_Road","Delhi"),
("Ravi","Prithviraj_Road","Delhi");
select * from  bank_customer;

insert into  depositer values
("Avinash",1),
("Dinesh",2),
("Nikil",4),
("Ravi",5),
("Avinash",8),
("Nikil",9),
("Dinesh",10),
("Nikil",11);
select * from  depositer;

insert into loan values
(1,"SBI_chamrajpet",1000),
(2,"SBI_ResidencyRoad",2000),
(3,"SBI_ShivajiRoad",3000),
(4,"SBI_ParlimentRoad",4000),
(5,"SBI_Jantarmantar",5000);


select * from  loan;

SELECT branch_name, assets / 100000 AS "assets in lakhs"
FROM branch;

select d.customername from depositer d, bank_account b where
b.branch_name='SBI_ResidencyRoad' and d.accno=b.accno group by d.customername having
count(d.accno)>=2;

create view loansum as (
select branch_name, sum(amount) from loan group by branch_name
);
select * from loansum;
show tables;

select * from  bank_account;
select * from  depositer;



SELECT d.customername, b.branch_name
FROM depositer d
JOIN bank_account b ON d.accno = b.accno
GROUP BY d.customername, b.branch_name
HAVING COUNT(b.accno) >= 2;

show tables;
select * from branch;

/* q-01*/
select branch_name , assets as Total_assets 
from branch;

/* q-02*/
select customername
from  bank_customer where city="Bangalore";

/* q-03*/
select accno ,customername
from depositer;
/* q-04*/
Select distinct d.customername 
from depositer d,bank_account ba, branch b 
where d.accno=ba.accno and ba.branch_name=b.branch_name and b.branchcity="Delhi"
group by d.customername having
count(b.branch_name )>1;
/* q-05*/
SELECT c.customername
FROM  bank_customer c
JOIN depositer d ON c.customername = d.customername
JOIN bank_account b ON d.accno = b.accno
WHERE b.balance > 100000;


SELECT DISTINCT c.customername
FROM bank_customer c
JOIN depositer d ON c.customername = d.customername
JOIN bank_account b ON d.accno = b.accno
JOIN Loan l ON b.branch_name = l.branch_name
WHERE d.accno = l.loan_number;



/* q-07*/
select branch_name ,count(accno) 
from bank_account
group by branch_name  ;

/* q-08*/
select b.branch_name
from branch b
left join Loan l on b.branch_name = l.branch_name
where l.loan_number is null;

/* q-09*/
select b.branch_name, SUM(l.amount)as total_loan_amount
from branch b
join loan l ON b.branch_name = l.branch_name
GROUP BY b.branch_name
ORDER BY total_loan_amount ASC
LIMIT 1;


SELECT c.customername, l.amount
FROM bank_customer c
JOIN depositer d ON c.customername = d.customername
JOIN loan l ON d.accno = l.loan_number;


drop database bank_24becs405;
