# Data-lab-21-SQL-vs-PLpgSQL

## Create 2 funcs SQL and PLpgSQL

### V8__Create_get_table_value_limit_plpgsql.sql

```
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
```

### SQL func

```
SELECT name FROM product1 LIMIT 1;
```

* flyway migrate:
<img width="904" alt="Снимок экрана 2023-05-24 в 20 02 03" src="https://github.com/Amir-Gaifullin/Data-lab-21-SQL-vs-PLpgSQL/assets/47780452/538110b8-b4fb-4db5-84cd-fc7108f206b2">


## Benchmark Commands

### For SQL func

```
pgbench -c 10 -T 300 flyway_test -f <(echo "SELECT name FROM product1 LIMIT 1;")
```

Result:

<img width="759" alt="Снимок экрана 2023-05-24 в 20 22 51" src="https://github.com/Amir-Gaifullin/Data-lab-21-SQL-vs-PLpgSQL/assets/47780452/689df966-20bc-4409-8cc7-7b7d3c401b1c">


### For PLpgSQL func

```
pgbench -c 10 -T 300 flyway_test -f <(echo "SELECT get_table_value_limit(1);")
```

Result:

<img width="759" alt="Снимок экрана 2023-05-24 в 20 28 59" src="https://github.com/Amir-Gaifullin/Data-lab-21-SQL-vs-PLpgSQL/assets/47780452/e4f2c5e0-db23-4581-85a2-8d9dd8b18d88">

