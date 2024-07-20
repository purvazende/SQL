select * from employee;

select firstname, left(firstname,3),right(firstname, 3),
substring(birthdate,6,2) as birth_month
from employee;

select rtrim('    yes    ');

select lastname,replace(lastname,'e','a')
from employee;

select locate('o','koli');

select firstname, locate('e',firstname)
from employee;

select firstname, lastname,
concat(firstname,' ',lastname) as full_name 
from employee;
