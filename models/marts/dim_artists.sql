{{ config(materialized='table') }}
SELECT DISTINCT
    artist_names AS artist_name 
FROM {{ ref('int_tracks_enriched') }}
WHERE artist_names IS NOT NULL