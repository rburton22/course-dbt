{{
  config(
    materialized='table'
  )
}}

with src_addresses as (
    select * from {{ source('postgres', 'addresses') }}
),

cte_rename as (
    select
        address_id as address_guid,
        address,
        zipcode,
        state,
        country
    from src_addresses
)

select * from cte_rename
