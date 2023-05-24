# Data-lab-21-SQL-vs-PLpgSQL

## Create 2 funcs SQL and PLpgSQL

### V6__Create_function_to_get_value_plpgsql.sql

```
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
```

### V7__Create_function_to_get_value_sql.sql

```
create function get_table_value_sql1(id int)
returns varchar
language sql
as
$$
  SELECT name
  FROM product1
  WHERE id=id;
$$;

```

* flyway migrate:


## Benchmark Commands

### For SQL func

```
-- my_benchmark_sql.sql

\set id random(1, 100000)
BEGIN;
SELECT get_table_value_sql(:id);
END;
```

```
pgbench -c 10 -T 300 flyway_test -f my_benchmark_sql.sql
```

Result:


### For PLpgSQL func

```
-- my_benchmark_plpgsql.sql

\set id random(1, 100000)
BEGIN;
SELECT get_table_value_plpgsql(:id);
END;
```

```
pgbench -c 10 -T 300 flyway_test -f my_benchmark_plpgsql.sql
```

Result:


