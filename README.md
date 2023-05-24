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

<img width="912" alt="Снимок экрана 2023-05-24 в 20 35 41" src="https://github.com/Amir-Gaifullin/Data-lab-21-SQL-vs-PLpgSQL/assets/47780452/9b296ef0-0c86-4140-96eb-a53261a35ce3">


## Benchmark Commands

### For SQL func

```
pgbench -c 10 -T 300 flyway_test -f <(echo "SELECT name FROM product1 LIMIT 1;")
```

Result:

```
amir@amir1:~/flyway-9.8.1$ pgbench -c 10 -T 300 flyway_test -f <(echo "SELECT name FROM product1 LIMIT 1;")
pgbench (15.2 (Ubuntu 15.2-1.pgdg22.04+1))
starting vacuum...end.
transaction type: /dev/fd/63
scaling factor: 1
query mode: simple
number of clients: 10
number of threads: 1
maximum number of tries: 1
duration: 300 s
number of transactions actually processed: 357316
number of failed transactions: 0 (0.000%)
latency average = 8.389 ms
initial connection time = 314.714 ms
tps = 1192.063806 (without initial connection time)
```
<img width="904" alt="Снимок экрана 2023-05-24 в 20 02 03" src="https://github.com/Amir-Gaifullin/Data-lab-21-SQL-vs-PLpgSQL/assets/47780452/d6dc1490-ef2b-47a8-a9a6-99470bfc25c9">


### For PLpgSQL func

```
pgbench -c 10 -T 300 flyway_test -f <(echo "SELECT get_table_value_limit(1);")
```

Result:

```
amir@amir1:~/flyway-9.8.1$ pgbench -c 10 -T 300 flyway_test -f <(echo "SELECT get_table_value_limit(1);")
pgbench (15.2 (Ubuntu 15.2-1.pgdg22.04+1))
starting vacuum...end.
transaction type: /dev/fd/63
scaling factor: 1
query mode: simple
number of clients: 10
number of threads: 1
maximum number of tries: 1
duration: 300 s
number of transactions actually processed: 300350
number of failed transactions: 0 (0.000%)
latency average = 9.984 ms
initial connection time = 178.966 ms
tps = 1001.558423 (without initial connection time)
```
<img width="759" alt="Снимок экрана 2023-05-24 в 20 22 51" src="https://github.com/Amir-Gaifullin/Data-lab-21-SQL-vs-PLpgSQL/assets/47780452/4d795d2f-5f93-41f8-a890-a8414ddbcd3d">

