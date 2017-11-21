create table uploads(
  id serial primary key,
  name varchar
)

select count(*) from uploads; -- 122

create index uploads_id on uploads(id);
analyze;

explain analyse select * from uploads where(id = 3) -- "Seq Scan on uploads  (cost=0.00..1.15 rows=1 width=6)"
explain select * from uploads where(id = 3) -- "Index Scan using uploads_id on uploads  (cost=0.14..8.15 rows=1 width=6)"
explain analyse select * from uploads where(id = 3)
