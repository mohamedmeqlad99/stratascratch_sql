WITH comment_counts AS (
    SELECT
        u.country,
        '2019-12' AS month,
        SUM(c.number_of_comments) AS total_comments
    FROM fb_comments_count c
    JOIN fb_active_users u ON c.user_id = u.user_id
    WHERE c.created_at >= '2019-12-01' AND c.created_at < '2020-01-01'
    GROUP BY u.country
    
    UNION ALL

    SELECT
        u.country,
        '2020-01' AS month,
        SUM(c.number_of_comments) AS total_comments
    FROM fb_comments_count c
    JOIN fb_active_users u ON c.user_id = u.user_id
    WHERE c.created_at >= '2020-01-01' AND c.created_at < '2020-02-01'
    GROUP BY u.country
),

ranked_comments AS (
    SELECT
        country,
        month,
        total_comments,
        DENSE_RANK() OVER (PARTITION BY month ORDER BY total_comments DESC) AS rank
    FROM comment_counts
)


SELECT 
    d.country,
    d.rank AS dec_rank,
    j.rank AS jan_rank,
    (d.rank - j.rank) AS rank_change
FROM ranked_comments d
JOIN ranked_comments j 
ON d.country = j.country
AND d.month = '2019-12'
AND j.month = '2020-01'
WHERE (d.rank - j.rank) > 0  
ORDER BY rank_change DESC;
