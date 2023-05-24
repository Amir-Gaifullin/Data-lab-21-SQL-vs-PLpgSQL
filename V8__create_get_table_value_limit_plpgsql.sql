create function get_table_value_limit(value_limit int)
returns varchar
language plpgsql
as
$$
declare
   table_value varchar;
begin
   select name
   from product1
   LIMIT value_limit
   into table_value;

   return table_value;
end;
$$;
