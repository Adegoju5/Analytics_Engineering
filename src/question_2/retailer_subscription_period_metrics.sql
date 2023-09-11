CREATE TABLE retailer_subscription_period_metrics AS
WITH retailer_periods AS (
  SELECT DISTINCT
    id_retailer,
    dt_period_start,
    dt_period_end
  FROM retailer_subscription_periods
  WHERE
    dt_subscription_start IS NOT NULL
    AND dt_period_start IS NOT NULL
    AND dt_period_end IS NOT NULL
)
SELECT
  ROW_NUMBER() OVER (ORDER BY rp.id_retailer, rp.dt_period_start) AS id_period,
  rp.id_retailer,
  rp.dt_period_start,
  rp.dt_period_end,
  COALESCE(SUM(o.discount_amount), 0) AS period_discount
FROM retailer_periods rp
LEFT JOIN orders o
  ON o.id_retailer = rp.id_retailer
  AND o.dt_submitted >= rp.dt_period_start
  AND o.dt_submitted <= rp.dt_period_end
GROUP BY
  rp.id_retailer,
  rp.dt_period_start,
  rp.dt_period_end;








