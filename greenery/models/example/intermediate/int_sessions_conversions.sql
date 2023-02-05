{{
  config(
    materialized='table'
  )
}}

with events as (
  select * from {{ ref('stg__events') }}
),

cte_prep as (
    select
       *,
       case
          when event_type = 'package_shipped' then true
          when event_type = 'checkout' then true
          when event_type = 'add_to_cart' then false
          else false
       end as event_type_conversion
    from events
),

cte_agg as (
   select 
       distinct(session_guid), 
       max(event_type_conversion) as is_conversion 
   from cte_prep 
   group by 1
)

select * from cte_agg
