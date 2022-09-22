{{config(
    materialized="table"
)}}

with orders as (

    select O_ORDERKEY, O_CUSTKEY, O_ORDERSTATUS, O_TOTALPRICE, O_ORDERDATE, L_ORDERKEY,  L_QUANTITY total_quantity,P_PARTKEY, P_NAME from {{ ref('stg_orders')}} stg_orders
    inner join {{ ref('stg_lineitem')}} stg_lineitem
        on stg_orders.O_ORDERKEY = stg_lineitem.L_ORDERKEY
    inner join {{ ref('part')}} parts
        on stg_lineitem.L_PARTKEY = parts.P_PARTKEY

)


select * from orders
