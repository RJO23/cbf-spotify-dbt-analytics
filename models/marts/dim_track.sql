{{ config(materialized='table') }}

SELECT
    {{ dbt_utils.generate_surrogate_key(['track_id']) }}  AS track_key,
    track_id,
    track_name,
    album_name,
    track_genre,
    duration_minutes,
    duration_category,
    popularity_bucket, -- Moved from fact table
    tempo_category     -- Moved from fact table
FROM {{ ref('int_track_deduped') }}