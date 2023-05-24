create function get_table_value_plpgsql(id int)
returns varchar
language plpgsql
as
$$
declare
   table_value varchar;
begin
   select name
   from product1
   where product1.id = get_table_value_plpgsql.id
   into table_value;

   return table_value;
end;
$$;
