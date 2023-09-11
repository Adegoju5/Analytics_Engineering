
SELECT
  id_retailer,
  SUM(period_discount) AS total_subscription_discount,
  AVG(period_discount) AS avg_period_subscription_discount,
  MAX(first_period_discount) AS last_period_subscription_discount,
  MAX(dt_period_start) AS dt_last_period_start
FROM (
  SELECT
    id_retailer,
    period_discount,
    FIRST_VALUE(period_discount) OVER (PARTITION BY id_retailer ORDER BY dt_period_start DESC) AS first_period_discount,
    dt_period_start
  FROM retailer_subscription_period_metrics
) AS subquery
GROUP BY
  id_retailer;




SELECT
    t1.id_retailer,
    SUM(t1.period_discount) AS total_subscription_discount,
    AVG(t1.period_discount) AS avg_period_subscription_discount,
    (
        SELECT t2.period_discount
        FROM retailer_subscription_period_metrics t2
        WHERE t2.id_retailer = t1.id_retailer
        ORDER BY t2.dt_period_start DESC
        LIMIT 1
    ) AS last_period_subscription_discount,
    MAX(t1.dt_period_start) AS dt_last_period_start
FROM
    retailer_subscription_period_metrics t1
GROUP BY
    t1.id_retailer;











