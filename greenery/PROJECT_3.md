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

3. Run the orders snapshot model using dbt snapshot and query it in snowflake to see how the data has changed since last week. Which orders changed from week 2 to week 3?

```
select  
    order_id, 
    dbt_valid_to 
from dev_db.dbt_rburtonflexportcom.orders_snapshot 
where dbt_valid_to is not null;
```

**The above query resulted in the following 9 order_id's having changed since the time of last snapshot: 265f9aae-561a-4232-a78a-7052466e46b7, e42ba9a9-986a-4f00-8dd2-5cf8462c74ea, b4eec587-6bca-4b2a-b3d3-ef2db72c4a4f, 29d20dcd-d0c4-4bca-a52d-fc9363b5d7c6, c0873253-7827-4831-aa92-19c38372e58d, e2729b7d-e313-4a6f-9444-f7f65ae8db9a, 0e9b8ee9-ad0a-42f4-a778-e1dd3e6f6c51, 841074bf-571a-43a6-963c-ba7cbdb26c85, df91aa85-bfc7-4c31-93ef-4cee8d00a343.**
