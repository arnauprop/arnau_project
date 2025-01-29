WITH units_goal_nulls AS (
    SELECT
        `brand id ` AS brand_id, 
        `geography id` AS geo_id, 
        COALESCE(`202401`, 0) AS `202401`,
        COALESCE(`202402`, 0) AS `202402`,
        COALESCE(`202403`, 0) AS `202403`,
        COALESCE(`202404`, 0) AS `202404`,
        COALESCE(`202405`, 0) AS `202405`,
        COALESCE(`202406`, 0) AS `202406`,
        COALESCE(`202407`, 0) AS `202407`,
        COALESCE(`202408`, 0) AS `202408`,
        COALESCE(`202409`, 0) AS `202409`,
        COALESCE(`202410`, 0) AS `202410`,
        COALESCE(`202411`, 0) AS `202411`,
        COALESCE(`202412`, 0) AS `202412`,
    FROM {{ source('bronze', 'unit_goals') }}
    
),

units_goal_unpivoted AS (
    SELECT  
        month,
        brand_id, 
        geo_id, 
        units_goal
    FROM units_goal_nulls
    UNPIVOT (
        units_goal FOR month IN (
            `202401`, `202402`, `202403`, `202404`, `202405`, `202406`,
            `202407`, `202408`, `202409`, `202410`, `202411`, `202412`
        )
    )
)

SELECT 
    PARSE_DATE('%Y%m', month) AS month, --No queda en format date. Millor posar-ho amb dia inventat?
    brand_id,
    geo_id,
    units_goal
FROM units_goal_unpivoted