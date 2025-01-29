WITH brand AS (
    SELECT DISTINCT
        `brand id` AS brand_id,
        brand AS brand_name,
        category,
        `business unit` AS business_unit
    FROM {{ source('bronze', 'brand')}}
)

SELECT *
FROM brand