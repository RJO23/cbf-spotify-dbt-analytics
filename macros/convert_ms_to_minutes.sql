{% macro convert_ms_to_minutes(column_name) %}
    ROUND( CAST({{ column_name }} AS FLOAT64) / 60000.0, 2 )
{% endmacro %}