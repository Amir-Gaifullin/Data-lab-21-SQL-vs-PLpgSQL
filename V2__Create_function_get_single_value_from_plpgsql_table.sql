CREATE FUNCTION get_single_value_from_table_plpgsql(table_name TEXT)
RETURNS TEXT
AS $$
DECLARE
  table_value TEXT;
BEGIN
  EXECUTE 'SELECT value FROM ' || quote_ident(table_name) || ' LIMIT 1' INTO table_value;
  RETURN table_value;
END;
$$
LANGUAGE plpgsql;
