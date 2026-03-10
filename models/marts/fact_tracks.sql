{{ config(materialized='table') }}

SELECT
    track_id,
    artist_names AS artist_name,
    track_genre AS genre_name,
    popularity,
    popularity_bucket,
    duration_minutes,
    duration_category,
    tempo,
    tempo_category,
    danceability,
    energy
FROM {{ ref('int_tracks_enriched') }}