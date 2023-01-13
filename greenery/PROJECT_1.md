### Project #1 ###

1. How many users do we have? **We have exactly 130 unique users.** 

```
select
  count(distinct user_guid) as dist_user_cnt
from dev_db.dbt_rburtonflexportcom.stg__users;
```

2. On average, how many orders do we receive per hour? **On average there are 7.520833 orders received per hour.**

```
with cte_prep as (
  select
    date_trunc('hour', created_at_utc) as hour,
    count(order_guid) as order_cnt
  from dev_db.dbt_rburtonflexportcom.stg__orders
  group by 1
)

select avg(order_cnt) as avg_orders_per_hour from cte_prep;
```

3. On average, how long does an order take from being placed to being delivered? **On average it takes 3.891803 days between the order being placed to being delivered.**

```
select
  avg(timediff('day', created_at_utc, delivered_at_utc)) as avg_days_diff
from dev_db.dbt_rburtonflexportcom.stg__orders
where delivered_at_utc is not null;
```

4. How many users have only made one purchase? Two purchases? Three+ purchases? **25 users have only made one purchase. 28 users have made two purchases. 71 users have made three or more purchases.**

```
with cte_prep as (
  select
    user_guid,
    count(order_guid) as order_cnt
  from dev_db.dbt_rburtonflexportcom.stg__orders
  group by 1
)

select
  sum(iff(order_cnt = 1, 1, 0)) as one_purchase,
  sum(iff(order_cnt = 2, 1, 0)) as two_purchases,
  sum(iff(order_cnt >= 3, 1, 0)) as three_plus_puchases
from cte_prep;
```

5. On average, how many unique sessions do we have per hour? **On average, there are 16.327586 unique (distinct) sessions per hour.**

```
with cte_prep as (
  select 
    date_trunc('hour', created_at_utc) as hour,
    count(distinct session_guid) as distinct_session_cnt
  from dev_db.dbt_rburtonflexportcom.stg__events
  group by 1
)

select avg(distinct_session_cnt) as avg_distinct_sessions from cte_prep;
```