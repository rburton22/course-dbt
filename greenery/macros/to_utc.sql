{% macro to_utc(date) %}

    {{ date }}::timestampntz

{% endmacro %}