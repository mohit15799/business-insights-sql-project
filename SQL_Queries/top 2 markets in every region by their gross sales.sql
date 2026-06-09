with cte1 as(
select c.market,c.region,
round(sum(g.gross_price * f.sold_quantity)/1000000,2) as gross_sales
from fact_sales_monthly f
join dim_customer c
on f.customer_code = c.customer_code
join dim_product p
on f.product_code = p.product_code
join fact_gross_price g
on f.product_code = g.product_code and f.fiscal_year = g.fiscal_year
where f.fiscal_year = 2021
group by c.market,c.region
order by gross_sales desc),

	cte2 as (select *,
	dense_rank() over(partition by region order by gross_sales desc) as drnk
 from cte1)
 select * from cte2 where drnk <=2;
 
