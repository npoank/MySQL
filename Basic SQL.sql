create database ListExpenses;
use ListExpenses;

create table expenses (num int not null, paydate date default '2022-12-31', receiver int default 1,
value dec(6,2) default 0.0, primary key(num));  

insert into expenses(num, paydate, value) values (1, '2020-07-05', 1450.25);
insert into expenses(num, paydate, value) values (2, '2019-06-14', 375.02);
insert into expenses(num, receiver, value) values (3, 2, 25.12);
insert into expenses(num, receiver, value) values (4, 3, 50.25);
insert into expenses(num, paydate, receiver) values (5, '2022-11-30', 4);
insert into expenses(num, paydate, receiver, value) values (6, '2018-04-09', 2, 4.63);
insert into expenses(num, receiver) values (7, 4);
insert into expenses(num, paydate, receiver, value) values (8, '2022-03-17', 3, 860.99);

create table receivers (num int not null, name varchar(255) not null, primary key(num));
insert into receivers (num, name) values (1, 'bosch');
insert into receivers (num, name) values (2, 'tech');
insert into receivers (num, name) values (3, 'fin');
insert into receivers (num, name) values (4, 'moto');

select * from expenses;
select * from receivers;
select * from expenses where receiver =2 and value > 10;
select paydate, receiver, value from expenses order by value;
select paydate, value, name from expenses, receivers where receiver = receivers.num; 
select num, upper(name) from receivers;
select * from expenses where month(paydate)=12;
select * from expenses where day(paydate)=31 order by value;
select distinct paydate from expenses;
select expenses.num, paydate, value, name from expenses, receivers rs where receiver=rs.num limit 0,3;
select num, name from receivers where name like 'bo%'; 
select * from expenses where value like '__.__';
select count(*) from expenses;
select count(distinct paydate) from expenses;
select min(paydate) from expenses;
select max(value) from expenses;
select sum(value) from expenses where year(paydate) = 2022;
select avg(value) from expenses;
select sum(value), name from expenses, receivers rs where receiver=rs.num group by name;
select count(*), name from expenses, receivers rs where receiver=rs.num group by name;

select expenses.num, value, paydate, name from expenses, receivers rs where receiver=rs.num and value >= (select avg(value) from expenses)*2; 
select name, (select count(*) from expenses where receiver = rs.num) from receivers rs;
select name, (select sum(value) from expenses where receiver = rs.num) from receivers rs;

select paydate, sum(value) as sumValue from expenses group by paydate;
select max(sumValue) from (select paydate, sum(value) as sumValue from expenses group by paydate) as sums;

select sum(value) from expenses, receivers rs where receiver=rs.num and name like 'fin';
select sum(value) from expenses where receiver in (select num from receivers where name like '%fin%');

select expenses.num, paydate, value, name from expenses, receivers where receiver = receivers.num order by receiver, paydate;
select expenses.num, paydate, value, name from expenses, receivers where receiver = receivers.num and substring(name,1,1)='b';
select expenses.num, paydate, value, name from expenses, receivers where receiver = receivers.num and left(name,1)='b';

drop table expenses;

