-- create dblink
create extension dblink;
select dblink_connect('dblink_connection', 'dbname=SMDB user=moskieva host=127.0.0.1 port=5432');


-- create materialized view
create materialized view master_logs_view as
  select * from dblink('dbname=SMDB user=moskieva host=127.0.0.1 port=5432', 'select * from master_table') 
    as copy (id integer, name varchar, number integer);

create unique index view_uniq_id_idx on master_logs_view (id);
select * from pg_indexes where tablename = 'master_logs_view' -- check for index exist

-- check data
select * from master_logs_view;

-- check diff between master table and view
insert into master_table (name, number) values ('testing view 1', 2)
select * from master_table
select * from master_logs_view

-- refresh
refresh materialized view concurrently master_logs_view

