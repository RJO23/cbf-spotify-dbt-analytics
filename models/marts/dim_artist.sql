{{ config(materialized='table') }}

WITH unique_artists AS (
    SELECT DISTINCT artist_name
    FROM {{ ref('int_tracks_artists') }}
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['artist_name']) }} AS artist_key,
    artist_name
FROM unique_artists