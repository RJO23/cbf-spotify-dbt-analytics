{{ config(materialized='view') }}

WITH track_metrics AS (
    SELECT 
        track_id,
        COUNT(*) AS row_count,
        COUNT(DISTINCT track_genre) AS genre_count,
        MIN(popularity) AS min_popularity,
        MAX(popularity) AS max_popularity
    FROM {{ ref('stg_tracks') }}
    GROUP BY track_id
)

SELECT 
    track_id,
    row_count,
    genre_count,
    min_popularity,
    max_popularity
FROM track_metrics
WHERE row_count > 1
ORDER BY row_count DESC