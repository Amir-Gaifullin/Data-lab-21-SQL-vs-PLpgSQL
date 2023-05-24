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
<img width="716" alt="Снимок экрана 2023-05-25 в 00 05 39" src="https://github.com/Amir-Gaifullin/Data-lab-21-SQL-vs-PLpgSQL/assets/47780452/270b45af-e9ab-489e-9ddb-809fc11e56db">
<img width="817" alt="Снимок экрана 2023-05-25 в 00 07 12" src="https://github.com/Amir-Gaifullin/Data-lab-21-SQL-vs-PLpgSQL/assets/47780452/2c49cb85-ed81-4008-a612-29aed374fee8">


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

<img width="502" alt="Снимок экрана 2023-05-25 в 00 24 22" src="https://github.com/Amir-Gaifullin/Data-lab-21-SQL-vs-PLpgSQL/assets/47780452/c2e7fceb-070b-4778-97ec-2e0ea2503eda">


### For PLpgSQL func

```
-- my_benchmark_plpgsql.sql

\set id random(1, 100000)
BEGIN;
SELECT get_table_value_plpgsql(:id);
END;
```

```
pgbench -c 10 -T 300 flyway_test -f my_benchmark_pplgsql.sql
```

Result:

<img width="529" alt="Снимок экрана 2023-05-25 в 00 39 31" src="https://github.com/Amir-Gaifullin/Data-lab-21-SQL-vs-PLpgSQL/assets/47780452/ea00df56-3f2b-4a43-8456-dfdbf1871a5c">

