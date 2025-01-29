WITH sales AS (
    SELECT 
        PARSE_DATE('%d/%m/%Y', fecha) AS date,
        TRIM(producto) AS product_name,
        geography_id AS geo_id,
        unidades AS units,
        ROUND(euros, 2) AS value_eur
    FROM {{ source('bronze', 'sales')}}
)
SELECT date, product_name, geo_id, COALESCE(units, 0) AS units, COALESCE(value_eur, 0) AS value_eur
FROM sales