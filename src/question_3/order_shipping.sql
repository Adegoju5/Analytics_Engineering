SELECT
  id_order,
  dt_submitted,
  brand_country,
  nb_brand_shipping_days,
  (
    SELECT
      calendar_date
    FROM
      (
        SELECT calendar_date
        FROM business_days_calendar bdc
        WHERE
          calendar_date NOT IN (
            SELECT dt_day
            FROM public_holidays ph
            WHERE ph.country = obt.brand_country
          )
          AND calendar_date >= obt.dt_submitted
      ) calendar_without_public_holidays_and_weekends
    ORDER BY
      calendar_date ASC
    LIMIT 1 OFFSET obt.nb_brand_shipping_days
  ) AS estimated_delivery_date
FROM
  orders_brands_table obt;