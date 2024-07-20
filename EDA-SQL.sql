/* EXPLORATORY DATA ANALYSIS */

select* from layoffs_staging2;

/* gives the max no. of employees laid off on a particular day and their percentage */
select max(total_laid_off),max(percentage_laid_off)
from layoffs_staging2;

/* viewing the comapnies who have had 100% lay off and check the funds they raised */
select *
from layoffs_staging2
where percentage_laid_off = 1
order by funds_raised_millions desc ;

/*check the total lay off according to the company  */
select company,sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

/* to get to know the time period of the lay offs */
select min(`date`),max(`date`)
from layoffs_staging2;

/*to check the rank of the industries based upon the no. of lay offs  */
select industry,sum(total_laid_off)
from layoffs_staging2
group by industry
order by 2 desc;

/*to check the rank of the countries  based upon the no. of lay offs  */
select country,sum(total_laid_off)
from layoffs_staging2
group by country
order by 2 desc;

/*to determine the total lay offs per year */
select year(`date`),sum(total_laid_off)
from layoffs_staging2
group by year(`date`)
order by 1 desc;

/*to understand the stage  of employee during layoffs   */
select stage,sum(total_laid_off)
from layoffs_staging2
group by stage 
order by 2 desc;

/* lay offs per month  */
select substring(`date`,1,7) as `MONTH`, sum(total_laid_off)
from layoffs_staging2
where substring(`date`,1,7) is not null
group by `MONTH`
order by 1 asc ;

/* CTE to perform the rolling total of layoffs based upon the month to understand the difference 
in different years */
with Rolling_total as
(
select substring(`date`,1,7) as `MONTH`, sum(total_laid_off) as total_off
from layoffs_staging2
where substring(`date`,1,7) is not null
group by `MONTH`
order by 1 asc 
)
select `MONTH`, total_off, 
sum(total_off) over(order by `MONTH`) As rolling_total 
from Rolling_total;

select company , sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

/*list of companies based upon the total lay off(desc) the did in the respective year */
select company, year(`date`), sum(total_laid_off)
from layoffs_staging2
group by company , year(`date`)
order by 3 desc  ;

select company, year(`date`) as years , sum(total_laid_off)  as total_off
from layoffs_staging2
group by company , year(`date`);

/*partition the the set based upon the year and rank them based on the no. of employees they laid off */
with company_year as 
(
select company, year(`date`) as years , sum(total_laid_off)  as total_off
from layoffs_staging2
group by company , year(`date`)
),
company_rank as 
(
select *,
dense_rank() over(partition by years order by total_off desc ) as ranking 
from  company_year
where years is not null
)
select * 
from company_rank
where ranking <= 5;

/*DONE :) */