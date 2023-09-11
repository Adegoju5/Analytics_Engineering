CREATE TABLE orders_brands_table AS
SELECT
    o.id_order,
    o.dt_submitted,
    b.country AS brand_country,
    b.nb_brand_shipping_days
FROM orders o
JOIN brands b ON o.id_brand = b.id_brand;
