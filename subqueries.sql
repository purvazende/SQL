create table emp_demog
(id int, fullname varchar(10), department_name varchar(20), department_code int, location varchar(10));

insert into emp_demog value
(1,'purva z','Analysis',101,'pune'),
(2,'sam j','accountant',102,'banglore'),
(3,'rennie r','HR',103,'chennai'),
(4,'robin-hoo ','finance',104,'US'),
(5,'sasha s','management',105,'Germany');

select * from emp_sal;


select * from employee
where id in		
			(select id 
            from emp_demog
			where department_name='Analysis');
            
            
select firstanme,salary ,
(select avg(salary) 
from emp_sal)
from emp_sal;

select gender,max(age),min(age),avg(age),count(age) 
from employee
group by gender;

select avg(`max(age)`),avg(`min(age)`) from 
(select gender,max(age),min(age),avg(age),count(age) 
from employee
group by gender) as agg_table
;

select gender, avg(max),avg(min) from
(select gender,
max(age) as max, 
min(age) as min, 
count(age), 
avg(age) avg_age
from employee
group by gender) as agg_table
group  by gender;
"if gender is included then group by gender or the other field categorizes the values "
