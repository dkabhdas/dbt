{{config(
    materialized="table"
)}}

with customers as (

    select C_CUSTKEY, C_NAME, N_NAME, N_NATIONKEY from {{ ref('stg_customer')}} stg_customer
    inner join {{ ref('stg_nation')}} stg_nation
    on stg_customer.C_NATIONKEY = stg_nation.N_NATIONKEY
)


select * from customers
