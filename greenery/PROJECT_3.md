### Project #3 ###

1. What is our overall conversion rate? **We have an overall conversion rate of approximately 62.46%.** 

```
select 
   count_if(is_conversion)/count(session_guid) as conversion_rate 
from dev_db.dbt_rburtonflexportcom.int_sessions_conversions;
```

2. What is our conversion rate by product? **Our conversion rate by product is outlined in the table resulting from the query below. These product conversion rates range from a maximum of approximately 60.94% for a String of Pearls to a minimum of approximately 34.43% for Pothos.**

```
select
   name,
   sum(product_orders_cnt)/sum(unique_sessions) as product_conversion_rate
from int_product_agg
group by 1;
```


