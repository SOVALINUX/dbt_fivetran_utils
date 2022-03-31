{% macro default_get_column_names_only(table_name, schema_name, database_name=target.database) %}

{% set query %}

select
    lower(column_name)
from {{ database_name }}.information_schema.columns
where lower(table_name) = '{{ table_name }}'
and lower(table_schema) = '{{ schema_name }}'
order by 1

{% endset %}

{% set results = run_query(query) %}
{% set results_list = results.columns[0].values() %}}

{{ return(results_list) }} 

{% endmacro %}



{% macro bigquery__get_column_names_only(table_name, schema_name, database_name=target.database) %}

{% set query %}

select
    lower(column_name)
from `{{ database_name }}`.{{ schema_name }}.INFORMATION_SCHEMA.COLUMNS
where lower(table_name) = '{{ table_name }}'
and lower(table_schema) = '{{ schema_name }}'
order by 1

{% endset %}

{% set results = run_query(query) %}
{% set results_list = results.columns[0].values() %}}
{{ log(results_list, info=True)}} 
{{ return(results_list) }}

{% endmacro %}



{% macro get_column_names_only(table_name, schema_name, database_name) -%}
{{ return(adapter.dispatch('get_column_names_only')(table_name, schema_name, database_name)) }}
{%- endmacro %}