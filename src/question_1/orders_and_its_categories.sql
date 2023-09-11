CREATE TABLE orders_and_its_categories AS
SELECT
    o.id_order AS id,
    o.dt_submitted AS dt_day,
    r.country_group AS retailer_country_group,
    CASE
        WHEN o.dt_submitted = first_order.dt_first_order_day THEN 'new'
        WHEN EXISTS (
            SELECT 1
            FROM orders o2
            WHERE o2.id_retailer = o.id_retailer AND o2.id_brand = o.id_brand AND o2.dt_submitted < o.dt_submitted
        ) THEN 'repeat reorder'
        WHEN o.dt_submitted > first_order.dt_first_order_day AND NOT EXISTS (
            SELECT 1
            FROM orders o2
            WHERE o2.id_retailer = o.id_retailer AND o2.id_brand = o.id_brand AND o2.dt_submitted < o.dt_submitted
        ) THEN 'repeat discovery'
        ELSE 'unknown'
    END AS order_type,
    o.order_amount AS revenue
FROM
    orders o
JOIN (
    SELECT
        id_retailer,
        MIN(dt_submitted) AS dt_first_order_day
    FROM
        orders
    GROUP BY
        id_retailer
) first_order ON o.id_retailer = first_order.id_retailer
JOIN retailers r ON o.id_retailer = r.id_retailer;


