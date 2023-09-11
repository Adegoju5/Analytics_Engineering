CREATE TABLE business_days_calendar (
  calendar_date DATE NOT NULL
);

INSERT INTO business_days_calendar (calendar_date)
SELECT generate_series::date
FROM generate_series(
    '2019-01-01'::timestamp,
    '2025-12-31'::timestamp,
    '1 day'::interval
) AS generate_series
WHERE EXTRACT(ISODOW FROM generate_series) < 6;
