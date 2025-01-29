--month, units, value, goals, city, country, zone, product name, brand name
-- La taula brand no val per res en aquest exercici?

WITH units_goal AS(
    SELECT 
        EXTRACT(MONTH FROM month) as month,
        brand_id,
        geo_id,
        units_goal
FROM {{ ref("slv_l2_units_goal")}}
)

SELECT 
    u.month,
    g.city,
    g.country,
    g.zone,
    p.brand_name,
    SUM(u.units_goal) AS units_goal,
    SUM(s.units) AS units_sold,
    ROUND(SUM(s.value_eur), 2) AS value_eur
FROM units_goal u
LEFT JOIN {{ ref('slv_l2_geography')}} g ON u.geo_id = g.geo_id
LEFT JOIN {{ ref('slv_l2_product')}} p ON u.brand_id = p.brand_id
LEFT JOIN {{ ref('slv_l2_sales')}} s ON u.month = EXTRACT(month FROM s.date) AND u.geo_id = s.geo_id AND p.product_name = s.product_name
GROUP BY u.month, g.city, p.brand_name, g.country, g.zone
ORDER BY u.month, g.city, p.brand_name, g.country, g.zone
