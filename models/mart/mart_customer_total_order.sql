{{config(
    materialized="table"
)}}

with dim_customer as (

    select * from {{ ref('dim_customer')}}
),

stg_customer_orders as (

    select O_ORDERKEY,O_CUSTKEY, O_TOTALPRICE   from {{ ref('stg_customer_order')}}
    group by O_ORDERKEY,O_CUSTKEY, O_TOTALPRICE

),

customer_sales_per_country as(

    select N_NAME Country, sum(O_TOTALPRICE) tolal_sales from stg_customer_orders left join dim_customer
    on stg_customer_orders.O_CUSTKEY = dim_customer.C_CUSTKEY
    group by N_NATIONKEY, N_NAME
    
)

select Country, tolal_sales from customer_sales_per_country ORDER BY tolal_sales DESC
