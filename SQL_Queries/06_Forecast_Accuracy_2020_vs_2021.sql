select f_2020.customer_code,f_2020.customer,f_2020.market,
	f_2020.forecast_accuracy as forecast_accuracy_2020,
    f_2021.forecast_accuracy as forecast_accuracy_2021,
    round(f_2020.forecast_accuracy - f_2021.forecast_accuracy,2) as dropped_accuracy
    from forecast_accuracy_2020 f_2020
    
join forecast_accuracy_2021 f_2021 using(customer_code)
where f_2021.forecast_accuracy < f_2020.forecast_accuracy
order by f_2020.forecast_accuracy desc;
