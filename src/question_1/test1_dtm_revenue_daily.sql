SELECT
  COUNT(*) AS total_rows,
  COUNT(DISTINCT id) AS distinct_ids,
  COUNT(*) - COUNT(DISTINCT id) AS duplicate_ids,
  COUNT(*) - COUNT(id) AS null_ids
FROM
  (
    SELECT
      ROW_NUMBER() OVER (ORDER BY dt_day, retailer_country_group, order_type) AS id,
      dt_day,
      retailer_country_group,
      order_type,
      SUM(revenue) AS total_revenue
    FROM
      orders_and_its_categories oaic
    GROUP BY
      dt_day,
      retailer_country_group,
      order_type
  ) AS inner_table;
