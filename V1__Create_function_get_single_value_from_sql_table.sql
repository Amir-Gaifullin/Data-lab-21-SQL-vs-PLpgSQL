CREATE FUNCTION get_single_value_from_table_sql(table_name TEXT)
RETURNS TEXT AS $$
DECLARE
  table_value TEXT;
BEGIN
  SELECT value FROM pg_tables WHERE tablename = input_table_name LIMIT 1 INTO table_value;
  RETURN table_value;
END;
$$ LANGUAGE SQL;

