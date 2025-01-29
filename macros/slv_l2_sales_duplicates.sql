{% macro test_slv_l2_sales_duplicates(model) %}
        SELECT
            COUNT(*) AS duplicate_count
        FROM {{ ref('slv_l2_sales') }}  
        GROUP BY date, product_name, geo_id, units, value_eur
        HAVING COUNT(*) > 1
{% endmacro %}
