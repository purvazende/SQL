select gender,avg(age) as avg_age
from emp_demog as dem
join employee as emp
on dem.id=emp.id
group by gender;


select concat(emp.firstname,' ',emp.lastname) as fullname, gender, age,
sum(age) over  (partition by gender order by emp.id) as rolling_total 
from employee as emp
join emp_demog as dem
on emp.id=dem.id;

select * from emp_demog;
select * from emp_sal;