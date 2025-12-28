WITH funnel AS (
    SELECT
        user_id,
        MAX(CASE WHEN event = 'homepage' THEN 1 ELSE 0 END) AS homepage,
        MAX(CASE WHEN event = 'signup' THEN 1 ELSE 0 END) AS signup,
        MAX(CASE WHEN event = 'activation' THEN 1 ELSE 0 END) AS activation,
        MAX(CASE WHEN event = 'retention' THEN 1 ELSE 0 END) AS retention
    FROM user_events
    GROUP BY user_id
)

SELECT
    COUNT(*) AS total_users,
    SUM(homepage) AS homepage_users,
    SUM(signup) AS signup_users,
    SUM(activation) AS activated_users,
    SUM(retention) AS retained_users,

    ROUND(100.0 * SUM(signup) / SUM(homepage), 2) AS homepage_to_signup_pct,
    ROUND(100.0 * SUM(activation) / SUM(signup), 2) AS signup_to_activation_pct,
    ROUND(100.0 * SUM(retention) / SUM(activation), 2) AS activation_to_retention_pct
FROM funnel;
