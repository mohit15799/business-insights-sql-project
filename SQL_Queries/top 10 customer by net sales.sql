with cte1 as (
SELECT 
customer,round(sum(net_sales)/1000000,2) as net_sales_mln
FROM net_sales n
join dim_customer c on n.customer_code = c.customer_code
where fiscal_year = 2021
group by customer)

SELECT 
    customer,
    net_sales_mln,
    round(net_sales_mln*100/SUM(net_sales_mln) over(),2) as pct
FROM cte1
order by net_sales_mln
limit 10;