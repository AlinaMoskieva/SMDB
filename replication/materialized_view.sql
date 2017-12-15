-- create materialized view
create materialized view master_table_logs_view as select * from master_table with data
create unique index view_uniq_id_index on master_table_logs_view (id);

select * from pg_indexes where tablename = 'master_table_logs_view' -- check for index exist

-- check data
select * from master_table_logs_view

-- check diff between master table and view
insert into master_table (name, number) values ('testing view 1', 2)
select * from master_table
select * from master_table_logs_view

-- refresh
refresh materialized view concurrently master_table_logs_view
