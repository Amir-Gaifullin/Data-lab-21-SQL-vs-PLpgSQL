# Data-lab-21-SQL-vs-PLpgSQL

## Create 2 funcs SQL and PLpgSQL

* V1__Create_function_get_single_value_from_sql_table.sql
This function takes an input parameter as a table name and retrieves the first value found in that table using a regular SQL query. The function then returns the table value.

```
CREATE FUNCTION get_single_value_from_table_sql(table_name TEXT)
RETURNS TEXT AS $$
DECLARE
  table_value TEXT;
BEGIN
  SELECT value FROM pg_tables WHERE tablename = input_table_name LIMIT 1 INTO table_value;
  RETURN table_value;
END;
$$ LANGUAGE SQL;


```
* V2__Create_function_get_single_value_from_plpgsql_table.sql
This function takes an input parameter as a table name and retrieves the first value found in that table using a dynamic SQL query built by concatenating the table name with the query string using `quote_ident` to ensure safe identifier usage. The function then returns the table value.

```
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

```
* flyway migrate:
<img width="761" alt="Снимок экрана 2023-05-10 в 16 51 27" src="https://github.com/Amir-Gaifullin/Data-lab-17-Btree-BRIN-HASH/assets/47780452/62fd3728-da9e-4424-aef7-0ed76b0644a7">
<img width="1447" alt="Снимок экрана 2023-05-10 в 16 51 47" src="https://github.com/Amir-Gaifullin/Data-lab-17-Btree-BRIN-HASH/assets/47780452/760def87-3d39-4927-bd63-3e2a4d72f563">




## Benchmark Commands

### For Product1(Btree) table

```
pgbench -c 10 -T 300 flyway_test -f <(echo "SELECT get_single_value_from_table_sql('my_table');")
```

Result:
![telegram-cloud-photo-size-2-5395564228108209396-y](https://github.com/Amir-Gaifullin/Data-lab-17-Btree-BRIN-HASH/assets/47780452/b2aae918-e5d9-4b18-865d-0fbf27dcbf29)


### For Product2(BRIN) table

```
pgbench -c 10 -T 300 flyway_test -f <(echo "SELECT get_single_value_from_table_plpgsql('my_table');")
```


Result:
<img width="1022" alt="Снимок экрана 2023-05-10 в 19 37 24" src="https://github.com/Amir-Gaifullin/Data-lab-17-Btree-BRIN-HASH/assets/47780452/5ce4a1f5-bce3-4071-bf47-68d3748b8c37">


### For Product3(HASH) table

```
pgbench -c 10 -T 300 flyway_test -f <(echo "SELECT * FROM product2 WHERE name = 'Product0.02984555856039517';")
```

Result:
<img width="1002" alt="Снимок экрана 2023-05-10 в 19 43 06" src="https://github.com/Amir-Gaifullin/Data-lab-17-Btree-BRIN-HASH/assets/47780452/033c1a42-d152-47d8-bcfe-cb26a8367521">

