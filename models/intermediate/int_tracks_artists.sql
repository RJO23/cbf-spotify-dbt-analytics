{{ config(materialized='view') }}

WITH raw_tracks AS (
    SELECT 
        track_id,
        artist_names
    FROM {{ ref('stg_tracks') }}
    WHERE artist_names IS NOT NULL
),

-- I've moved the unesting logic here from dim_artists (deleted) and kept the track_id so a single song can still be credited to two artists and a seperate row can be made for each.

split_artists AS (
    SELECT 
        track_id,
        SPLIT(REPLACE(artist_names, ';', ','), ',') AS artist_array
    FROM raw_tracks
),

flattened_artists AS (
    SELECT 
        track_id,
        TRIM(artist_name) AS artist_name
    FROM split_artists,
    UNNEST(split_artists.artist_array) AS artist_name
)

SELECT 
    track_id,
    artist_name
FROM flattened_artists
WHERE artist_name != ''