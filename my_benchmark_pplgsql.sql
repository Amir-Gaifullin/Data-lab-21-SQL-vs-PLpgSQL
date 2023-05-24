\set id random(1, 100000)
BEGIN;
SELECT get_table_value_plpgsql(:id);
END;