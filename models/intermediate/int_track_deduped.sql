{{ config(materialized='table') }}

WITH staged_tracks AS (
    SELECT * FROM {{ ref('stg_tracks') }}
),

enriched_tracks AS (
    SELECT
        *, -- Grabs all the base columns from staging
        
        -- Popularity Buckets
        CASE
            WHEN popularity >= 80 THEN 'High'
            WHEN popularity >= 50 THEN 'Medium'
            ELSE 'Low'
        END AS popularity_bucket,

        -- Duration Categories
        CASE
            WHEN duration_minutes < 3.0 THEN 'Short (< 3 mins)'
            WHEN duration_minutes <= 5.0 THEN 'Standard (3-5 mins)'
            ELSE 'Long (> 5 mins)'
        END AS duration_category,

        -- Tempo Groupings
        CASE
            WHEN tempo >= 120.0 THEN 'Fast'
            WHEN tempo >= 90.0 THEN 'Medium'
            ELSE 'Slow'
        END AS tempo_category

    FROM staged_tracks
)

-- Selects the enriched data and applies the deduplication filter (I've since removed (int_tracks_enriched as it's no longer needed)
SELECT * FROM enriched_tracks
QUALIFY ROW_NUMBER() OVER (
    PARTITION BY track_id 
    ORDER BY popularity DESC
) = 1