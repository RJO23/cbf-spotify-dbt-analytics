{{ config(materialized='table') }}

SELECT DISTINCT
    track_id,
    track_name,
    album_name
FROM {{ ref('int_tracks_enriched') }}