-- 1. Create table and index for type info field
create table test(
	id serial primary key,
	type_info integer,
	name varchar(40)
);
CREATE INDEX type_info_index ON test(type_info);


-- create trigger function 


CREATE OR REPLACE FUNCTION fnc_my_table()
  RETURNS TRIGGER AS
$BODY$
DECLARE
  xTableSchema varchar(100):= 'SMDB';
  xTableMaster varchar(100):= 'tets';
  xTableChild  varchar(100);
  xTypeInfo    varchar(2)  := (NEW.type_info)::varchar;
BEGIN
   execute 'create table IF NOT EXISTS test_' || xTypeInfo || '() INHERITS (test)';
   execute 'insert into test_' || xTypeInfo || ' (type_info, name) values (' || New.type_info || ', '''|| New.name || ''')';
   return null;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;

create trigger trg_test_insert
	before insert on test
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


alter table test_1 add constraint partition_check check (type_info = 1);
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