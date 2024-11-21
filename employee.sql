create database dhanush_employee;
use dhanush_employee;
create table dept(
deptno int primary key,
dname varchar(20),
dloc varchar(30));

create table employee(
empno int primary key,
ename varchar(20),
mgr_no int,
hiredate date,
sal double ,
deptno int,
foreign key(deptno) references dept(deptno));

create table project(
pno int primary key,
ploc varchar(20),
pname varchar(20));

create table assigned_to(
empno int  , pno int ,
jobrole varchar(20),
primary key(pno,empno),
foreign key(empno) references employee(empno),
foreign key(pno) references project(pno));

create table incentives(
empno int ,
incentive_date date ,
incentive_amount double ,
primary key(empno,incentive_date),
foreign key(empno) references employee(empno));


insert into  dept values
(1,"CSE","Bengaluru"),
(2,"ISE","Mysuru"),
(3,"EEE","Bengaluru"),
(4,"ME","Hyderabad"),
(5,"IT","Mysuru");


insert into  employee values
(1,"Dhanush",5,"2006-02-24",100000,1),
(2,"Raja",6,"2007-03-20",20000,1),
(3,"venki",7,"2006-05-23",50000,2),
(4,"sundar",8,"2005-07-11",12000,3),
(5,"kavya",9,"2009-09-12",30000,4);

insert into project values
(001,"Bengaluru","Expence tracker"),
(002,"Bengaluru","Chat bot"),
(003,"Hyderabad","Instragram"),
(004,"Mysuru","Banking"),
(005,"Chittor","ChatGPT");


insert into assigned_to values
(1,001,"HR"),
(1,003,"Coder"),
(2,001,"Tester"),
(2,003,"Debugger"),
(5,005,"marketing");


insert into incentives values
(1,"2006-02-24",20000),
(2,"2006-03-25",100000),
(1,"2018-07-26",50000),
(3,"2009-08-27",10000),
(4,"2000-08-26",5000),
(5,"2006-12-10",70000);




/*q-01*/
select empno 
from assigned_to a, project p
where a.pno=p.pno and ploc in ("Bengaluru","Mysuru","Hyderabad");

/*q-02*/
select empno from
employee
where empno not in 
(select empno from incentives);

/*q-03*/
select 
e.ename,e.empno,d.deptno,a.jobrole, d.dloc, p.ploc from
employee e, dept d, project p, assigned_to a
where (e.deptno=d.deptno and a.empno=e.empno and p.pno=a.pno and p.ploc=d.dloc);

/*Additional Query*/


/*q-01*/
select e.empno, e.ename,e.sal,p.pno,p.ploc,p.pname from employee e 
left join assigned_to a on a.empno=e.empno
left join project p  on a.pno=p.pno;


/*q-02*/
select e.empno, e.ename ,sum(i.incentive_amount)
from employee e 
join incentives i on e.empno=i.empno 
group by empno,e.ename;

/*q-03*/
select p.pname,p.ploc from project p
join assigned_to a on a.pno=p.pno
where a.jobrole="Manager";

/*q-04*/
select d.dname,d.deptno ,count(e.empno) from employee e, dept d
where e.deptno=d.deptno
group by d.deptno;

/*q-05*/
select e.empno ,e.ename from employee e
left join assigned_to a on e.empno=a.empno where a.pno=Null;

/*q-06*/
select e.empno,e.ename, d.dname, d.dloc
from employee e ,dept d
where e.deptno=d.deptno;

/*q-07*/
select empno,ename,hiredate,sal,deptno
from employee
where mgr_no =5;

/*q-08*/
SELECT p.pno, p.pname, p.ploc, 
COUNT(a.empno) AS num_employees
FROM project p
JOIN assigned_to a ON p.pno = a.pno
GROUP BY p.pno, p.pname, p.ploc;

/*q-09*/
SELECT e1.empno AS emp1_no, e1.ename AS emp1_name, 
e2.empno AS emp2_no, e2.ename AS emp2_name, 
d.dname, d.dloc
FROM employee e1
JOIN employee e2 ON e1.mgr_no = e2.mgr_no AND e1.empno != e2.empno
JOIN dept d ON e1.deptno = d.deptno
ORDER BY e1.mgr_no;

/*q-10*/
SELECT i.empno, e.ename, 
COUNT(i.incentive_amount) AS num_incentives, 
SUM(i.incentive_amount) AS total_incentives
FROM incentives i
JOIN employee e ON i.empno = e.empno
GROUP BY i.empno, e.ename;

/*q-11*/
SELECT e.empno, e.ename, e.sal, e.deptno, 
a.job_role, p.pname, p.ploc
FROM employee e
JOIN assigned_to a ON e.empno = a.empno
JOIN project p ON a.pno = p.pno
WHERE a.job_role = 'Developer';

/*q-12*/
SELECT d.deptno, d.dname, d.dloc, 
AVG(e.sal) AS avg_salary
FROM dept d
JOIN employee e ON d.deptno = e.deptno
GROUP BY d.deptno, d.dname, d.dloc;
