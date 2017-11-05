create table bulk_uploads(
  id serial primary key,
  name varchar
)

ALTER TABLE bulk_uploads SET (autovacuum_enabled = false);
select pg_reload_conf();

  select pg_size_pretty(pg_total_relation_size('bulk_uploads')); -- 16kb
-- insert
	select pg_size_pretty(pg_total_relation_size('bulk_uploads')); -- 358 MB
-- update
	select pg_size_pretty(pg_total_relation_size('bulk_uploads')); -- 729 MB
-- delete
	select pg_size_pretty(pg_total_relation_size('bulk_uploads')); -- 729 MB

-- vacuum
	vacuum bulk_uploads;
	select pg_size_pretty(pg_total_relation_size('bulk_uploads')); -- 729 MB
-- vacuum full
	vacuum full bulk_uploads;
	select pg_size_pretty(pg_total_relation_size('bulk_uploads')); -- 285 MB
