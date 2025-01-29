WITH product AS (
    SELECT 
        TRIM(`producto`) AS product_name,
        `product id` AS product_id,
        brand AS brand_id,
        TRIM(`test flag`) AS test_flag,
        TRIM(`brand name`) AS brand_name,
        TRIM(`business unit`) AS business_unit
    FROM {{ source('bronze', 'product')}}
)

SELECT *
FROM product