SELECT 
    EXTRACT(DAY FROM post_date) AS day_of_month,
    COUNT(post_id) AS post_count
FROM facebook_posts
GROUP BY day_of_month
ORDER BY day_of_month;
