with cte1 as (
SELECT 
c.customer,c.region,round(sum(net_sales)/1000000,2) as net_sales_mln
FROM net_sales n
join dim_customer c on n.customer_code = c.customer_code
where fiscal_year = 2021
group by c.customer,c.region
order by net_sales_mln desc)
SELECT 
    customer,region,
    net_sales_mln,
    round(net_sales_mln*100/SUM(net_sales_mln) over(partition by region),2) 
    as pct_share_region
FROM cte1
order by region,net_sales_mln desc;