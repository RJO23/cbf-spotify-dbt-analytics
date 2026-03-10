{{ config(materialized='table') }}

SELECT DISTINCT
    track_genre AS genre_name
FROM {{ ref('int_tracks_enriched') }}
WHERE track_genre IS NOT NULL