/*DATA CLEANING*/

select * from layoffs;

/*1. REMOVE DUPLICATES 
/*2. STANDARDIZE DATA
/*3. NULL VALUES or BLANK VALUES 
/*4. REMOVE ANY COLUMNS */

create table layoffs_staging
like layoffs;

select * from layoffs_staging;

insert layoffs_staging
select * from layoffs;

with duplicate_cte as 
(select *,
ROW_NUMBER()
OVER( PARTITION BY company,location, industry, 
total_laid_off,percentage_laid_off,`date`,
stage,country,funds_raised_millions)  as row_num
from layoffs_staging)

select * from 
duplicate_cte
where row_num > 1;

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

insert layoffs_staging2
select *,
ROW_NUMBER()
OVER( PARTITION BY company,location, industry, 
total_laid_off,percentage_laid_off,`date`,
stage,country,funds_raised_millions)  as row_num
from layoffs_staging;


select * 
from layoffs_staging2 
where row_num > 1;

DELETE 
from layoffs_staging2 
where row_num > 1;

/*2. STANDARDIZE DATA*/

/* to detect the areas of updation*/
select distinct(company)
from layoffs_staging2;

update layoffs_staging2
set company = trim(company);

/* to confirm the updation*/
select distinct(company)
from layoffs_staging2;

/* to detect the areas of updation*/
select distinct(industry)
from layoffs_staging2
order by 1;

select * 
from layoffs_staging2
where industry like 'crypto%';

update layoffs_staging2
set industry = 'crypto'
where industry like 'crypto%';

/* to confirm the updation*/
select distinct(industry)
from layoffs_staging2;

/* to detect the areas of updation*/
select distinct(location)
from layoffs_staging2
order by 1;

select distinct(country)
from layoffs_staging2
order by 1;

select  distinct country, trim(trailing '.' from country)
from layoffs_staging2
order by 1;

update layoffs_staging2
set country = trim(trailing '.' from country)
where country like 'United States%';

select distinct(country)
from layoffs_staging2
order by 1;

select `date`,
str_to_date(`date`,'%m/%d/%Y')
from layoffs_staging2;

update layoffs_staging2
set  `date`= str_to_date(`date`,'%m/%d/%Y');

alter table layoffs_staging2
modify column `date` DATE;

select * 
from layoffs_staging2;

/*3. NULL VALUES or BLANK VALUES */

select distinct industry 
from layoffs_staging2;

select * 
from layoffs_staging2
where industry is null
or industry = '' ;

select * 
from layoffs_staging2
where company = 'Airbnb';

update layoffs_staging2
set industry = null
where industry = '';

select t1.industry, t2.industry
from layoffs_staging2 t1
join layoffs_staging2 t2
on t1.company=t2.company
where t1.industry is null
and t2.industry is not null;

update layoffs_staging2 t1
join layoffs_staging2 t2
on t1.company=t2.company
set t1.industry=t2.industry
where t1.industry is null
and t2.industry is not null; 

select * 
from layoffs_staging2
where company = 'Airbnb';

select * 
from layoffs_staging2
where industry is null;

select * 
from layoffs_staging2
where company like 'Bally%';
/* reason for the null balue is that thsi comapny did only One layoff and hence no other 
row was available to copy data from */

select * 
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

delete
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

select * from layoffs_staging2;

alter table layoffs_staging2
drop column row_num;