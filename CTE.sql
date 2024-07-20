select * from emp_demog;
with CTE_example(GENDER,AVG_AGE,MAX_AGE,MIN_AGE,COUNT_AGE) as 
(
select emp.gender, 
avg(age) as avg_age,
max(age) as max_age,
min(age) as min_age,
count(age) as count_of_age
from emp_demog as dem
join employee  as emp
on  dem.id=emp.id
group by emp.gender
)
select * from CTE_example ;
select * from employee;

with CTE_EXAMPLE AS 
( select id, concat(firstname,' ',lastname) as fullname , birthdate
 from employee
 where birthdate>'2001-07-06'
),
CTE_EXAMPLE2 as 
( select id,department_name, location
from emp_demog
where department_code > '101'
)

select * from 
CTE_EXAMPLE  AS ex1
join CTE_EXAMPLE2 as ex2 
on ex1.id=ex2.id;