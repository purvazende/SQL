

create procedure large_salary()
select * from emp_sal
where salary >=60000;
call large_salary();

select * from emp_sal;

delimiter $$
create procedure sal()
begin
	select * from emp_sal
    where salary >= 60000;
    select * from emp_sal
    where salary <=90000;
end $$
delimiter ;

call sal();

delimiter $$
create procedure selective_salary(id int)
begin
	select salary 
    from emp_sal
    where empid  = id;
end $$
delimiter ;

call selective_salary(101);