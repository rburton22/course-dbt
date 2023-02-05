### Project #2 ###

1. What is our user repeat rate? **We have a user repeat rate of approximately .798.** 

```
with cte_prep as (
    select
        user_guid,
        count(order_guid) as order_cnt,
        case
            when order_cnt >= 2 then 1
            else 0
        end as user_type
    from dev_db.dbt_rburtonflexportcom.stg__orders
    group by 1
)

select 
    sum(user_type)/count(user_guid) as repeat_rate 
from cte_prep;
```

2. What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?

**Some good indicators that a user is likely to be a repeat purchaser are use of any available promotional offers or discounts, if the product bought is often bought more than once, and other indentification/classification information such as age, gender, or economic status of the user. Inversely, some good indicators that a user will likely NOT purchase again are any product returns, poor reviews, price in comparison to market value of good purchased, and the same identification/classification information as discussed prior. Additional features of interest could include competitor statistics, customer income/economic status, and markers of satisfaction (user survey?).**

3. Explain the marts models you added. Why did you organize the models in the way you did?

**I added two intermediate models named int_order_products, which compiles all information pertaining to order, products, and promotions, and int_users_products, which compiles all information pertaining to users and orders. There are then three dimension/fact models spread throughout the different marts. dim_products compiles simple product information, and an aggregated inventory revenue potential which may be able to inform areas of leakage upon conducting sales. user_order_facts calculates an order count, first order date, latest order date, and total user spend for each user in the greenery database. Lastly, product_order_facts calculates an order count, product count across all orders, and the average number of each product contained in an order for each product in the greenery database.**

4. What assumptions are you making about each model? (i.e. why are you adding each test?)

**The majority of these models follow the assumption that the primary key guid (id) will be both unique and non-null, as such these tests will be added to each model to estbalish a standardization of uniquenessin our model layers.** 

5. Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?

**The only instance of "bad" data that was found was the fact that the primary key for staging table stg__order_items was not unique. In order to remedy this data issue, I conducted a concatenation of order_id and product_id to establish a new unique primary key for this table named order_product_sk.**

6. Run the orders snapshot model using dbt snapshot and query it in snowflake to see how the data has changed since last week. Which orders changed from week 1 to week 2? 

```
select  
    order_id, 
    dbt_valid_to 
from dev_db.dbt_rburtonflexportcom.orders_snapshot 
where dbt_valid_to is not null;
```

**The above query resulted in the following 9 order_id's having changed since the time of first snapshot: 265f9aae-561a-4232-a78a-7052466e46b7, e42ba9a9-986a-4f00-8dd2-5cf8462c74ea, b4eec587-6bca-4b2a-b3d3-ef2db72c4a4f, 29d20dcd-d0c4-4bca-a52d-fc9363b5d7c6, c0873253-7827-4831-aa92-19c38372e58d, e2729b7d-e313-4a6f-9444-f7f65ae8db9a, 0e9b8ee9-ad0a-42f4-a778-e1dd3e6f6c51, 841074bf-571a-43a6-963c-ba7cbdb26c85, df91aa85-bfc7-4c31-93ef-4cee8d00a343.**