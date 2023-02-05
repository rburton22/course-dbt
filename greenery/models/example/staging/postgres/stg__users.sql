{{
  config(
    materialized='table'
  )
}}

with src_users as (
    select * from {{ source('postgres', 'users') }}
),

cte_rename as (
    select
        user_id as user_guid,
        first_name,
        last_name,
        email,
        phone_number,
        {{ to_utc('created_at') }} as created_at_utc,
        {{ to_utc('updated_at') }} as updated_at_utc,
        address_id as address_guid
    from src_users
)

select * from cte_rename