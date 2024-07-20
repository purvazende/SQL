select firstname,lastname,age,
case
    when age<21 then 'junior'
    when age between 21 and 25 then 'senior'
end as  age_bracket
from employee;

select * FROM emp_sal;
select firstanme, lastname,
case
    when salary <= 50000 then salary + (salary*0.05)
    when salary >= 70000 then salary + (salary*0.07)
    when dept='finance' then salary + (salary*0.1)
end as increased_salary
from emp_sal;