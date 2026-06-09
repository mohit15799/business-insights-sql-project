with forecast_err_table as 
(
select s.customer_code,sum(s.sold_quantity) as sold_qty, sum(s.forecast_quantity) as frcst_qty,
	sum(forecast_quantity-sold_quantity) as net_error,
    sum(forecast_quantity-sold_quantity)*100/sum(forecast_quantity) as net_err_pct,
    sum(abs(forecast_quantity-sold_quantity)) as abs_net_err,
    sum(abs(forecast_quantity-sold_quantity)*100)/sum(forecast_quantity) as abs_err_pct
 from fact_act_est s
 where s.fiscal_year = 2021
 group by customer_code
 )
 select e.*,c.customer,c.market,
 if(abs_err_pct > 100,0,100 - abs_err_pct) as forecast_accuracy 
 from forecast_err_table e
 join dim_customer c
 using(customer_code)
 order by forecast_accuracy	desc