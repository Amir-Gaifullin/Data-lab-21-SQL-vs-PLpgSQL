create function get_table_value_sql(id int)
returns varchar
language sql
as
$$
  SELECT name
  FROM product1
  WHERE id=id;
$$;
