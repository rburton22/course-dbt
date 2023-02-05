### Project #3 ###

1. What is our overall conversion rate? **We have an overall conversion rate of approximately 62.46%.** 

```
select 
   count_if(is_conversion)/count(session_guid) as conversion_rate 
from dev_db.dbt_rburtonflexportcom.int_sessions_conversions;
```

2. What is our conversion rate by product? **Our conversion rate by product is outlined in the table below.**

```
select
   name,
   sum(product_orders_cnt)/sum(unique_sessions) as product_conversion_rate
from int_product_agg
group by 1;
```

NAME 	|   PRODUCT_CONVERSION_RATE
--------   ------------------------
Orchid	|  0.453333
Ponytail Palm |	0.4
Pink Anthurium |	0.418919
Bamboo	0.537313 |
Spider Plant |	0.474576
Birds Nest Fern |	0.423077
ZZ Plant |	0.539683
Aloe Vera |	0.492308
Pothos |	0.344262
Ficus |	0.426471
Alocasia Polly |	0.411765
String of pearls |	0.609375
Angel Wings Begonia |	0.393443
Boston Fern |	0.412698
Fiddle Leaf Fig	 | 0.5
Devil's Ivy |	0.488889
Calathea Makoyana |	0.509434
Pilea Peperomioides |	0.474576
Peace Lily |	0.409091
Philodendron |	0.483871
Arrow Head |	0.555556
Snake Plant |	0.39726
Monstera |	0.510204
Bird of Paradise |	0.45
Rubber Plant |	0.518519
Jade Plant |	0.478261
Dragon Tree |	0.467742
Money Tree |	0.464286
Cactus |	0.545455
Majesty Palm |	0.492537
