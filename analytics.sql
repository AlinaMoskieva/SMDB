-- 1. Create table and index for type info field
create table analytics(
	id bigserial primary key,
	shop varchar(100) not null,
	event varchar(100) not null,
  created_at timestamp not null default current_timestamp
);
create index shop_on_analytics_index on analytics(shop);

alter table analyze_01_12 add constraint partition_check check (created_at::date = date '2015-07-15');


-- create trigger function


CREATE OR REPLACE FUNCTION fnc_my_table()
  RETURNS TRIGGER AS
$BODY$
DECLARE
  xTableSchema varchar(100):= 'SMDB';
  xTableMaster varchar(100):= 'analytics';
  xTableChild  varchar(100);
  xDate        date  := (NEW.created_at)::date;
BEGIN
   execute 'create table IF NOT EXISTS analytics_' || xDate || '() INHERITS (analytics)';
   execute 'insert into analytics_' || xDate || ' (shop, event) values (' || New.shop || ', '''|| New.event || ''')';
   return null;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;

create trigger trg_test_insert
	before insert on analytics
	for each row
	execute procedure fnc_my_table();

insert into test (type_info, name) values (1, 'name');
insert into test (type_info, name) values (2, 'name');
insert into test (type_info, name) values (3, 'name');
insert into test (type_info, name) values (4, 'name');
insert into test (type_info, name) values (5, 'name');
insert into test (type_info, name) values (6, 'name');
insert into test (type_info, name) values (7, 'name');
insert into test (type_info, name) values (8, 'name');
insert into test (type_info, name) values (9, 'name');
insert into test (type_info, name) values (10, 'name');
insert into test (type_info, name) values (11, 'name');
insert into test (type_info, name) values (12, 'name');
insert into test (type_info, name) values (13, 'name');
insert into test (type_info, name) values (14, 'name');
insert into test (type_info, name) values (15, 'name');


explain analyze select * from test where type_info = 10

select * from test_2;
select * from only test;

SELECT table_name
  FROM information_schema.tables
 WHERE table_schema='public'w
   AND table_type='BASE TABLE';


alter table analyze_01_12 add constraint partition_check check (he_timestamp_column::date = date '2015-07-15');
alter table test_2 add constraint partition_check check (type_info = 2);
alter table test_3 add constraint partition_check check (type_info = 3);
alter table test_4 add constraint partition_check check (type_info = 4);
alter table test_5 add constraint partition_check check (type_info = 5);
alter table test_6 add constraint partition_check check (type_info = 6);
alter table test_7 add constraint partition_check check (type_info = 7);
alter table test_8 add constraint partition_check check (type_info = 8);
alter table test_9 add constraint partition_check check (type_info = 9);
alter table test_10 add constraint partition_check check (type_info = 10);
alter table test_11 add constraint partition_check check (type_info = 11);
alter table test_12 add constraint partition_check check (type_info = 12);
alter table test_13 add constraint partition_check check (type_info = 13);
alter table test_14 add constraint partition_check check (type_info = 14);
alter table test_15 add constraint partition_check check (type_info = 15);
