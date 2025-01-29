WITH geography AS (
    SELECT 
        `geo id` AS geo_id,
        TRIM(city) AS city,
        TRIM(country) AS country,
        TRIM(zone) AS zone
    FROM {{ source('bronze', 'geography')}}
)

SELECT *
FROM geography