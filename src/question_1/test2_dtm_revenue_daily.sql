CREATE TRIGGER chk_id_unique_not_null
BEFORE INSERT ON revenue_daily
FOR EACH ROW
WHEN NEW.id IS NOT NULL AND NEW.id IN (SELECT id FROM revenue_daily GROUP BY id HAVING COUNT(*) > 1)
BEGIN
  SELECT RAISE(ABORT, 'id must be unique and not null');
END;