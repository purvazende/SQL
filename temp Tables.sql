create temporary table  temp_table
(
firstname varchar(50),
lastname varchar(50),
fav_movie varchar(100)
);

insert into temp_table values
('purva','zende','Dangal'),
('aditi','chavan','barbie'),
('sam','williams','spiderman'),
('ana','mathews','DDLJ'),
('rocky','rockstar','YJHD');

select * from emp_sal;

create temporary table salary_over_60k
select * from emp_sal
where salary >= 60000;

select * from salary_over_60k;