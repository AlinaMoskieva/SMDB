-- 1 task. Create table
create table common_dictionary (
	id bigserial primary key,
	type varchar(40) not null,
	name varchar(100) not null,
	start_date timestamp not null default current_timestamp,
	end_date timestamp not null,
	status boolean not null default true,
	par_id integer references common_dictionary(id)
);


select * from common_dictionary;

-- fill in table
ruby uploader.rb
-- https://gist.github.com/AlinaMoskieva/a501e1aedff94744dfda92a5281a6200

-- 2 task. Create index
create index active_event_index on common_dictionary(id, name, status) where status = true and type = 'event';
explain analyze select id, name, status from common_dictionary where status and type = 'event';

-- Bitmap Heap Scan on common_dictionary
-- (cost=4.24..68.70 rows=437 width=41) (actual time=0.346..3.323 rows=2002 loops=1)


-- 3 task. Analytics
create table analytics(
	id bigserial primary key,
	shop varchar(100) not null,
	event varchar(100) not null,
	created_at date not null
);

create index shop_on_analytics_index on analytics(shop);
create index shop_on_analytics_date on analytics(created_at);


CREATE OR REPLACE FUNCTION fnc_my_table()
  RETURNS TRIGGER AS
$BODY$
DECLARE
  xTableSchema varchar(100):= 'SMDB';
  xTableMaster varchar(100):= 'analytics';
  xTableChild  varchar(100);
  xDate        varchar(40)  := extract('day' from NEW.created_at) || '_' || extract('month' from NEW.created_at);
BEGIN
   execute 'create table IF NOT EXISTS analytics_' || xDate || '() INHERITS (analytics)';
   execute 'insert into analytics_' || xDate || ' (shop, event, created_at) values (''' || New.shop || ''', '''|| New.event || ''', ''' || New.created_at || ''')';
   return null;
END;
$BODY$
LANGUAGE plpgsql VOLATILE;

create trigger trg_test_insert
	before insert on analytics
	for each row
	execute procedure fnc_my_table();


alter table analytics_25_11 add constraint partition_check check (created_at = '2017-11-25');

insert into analytics (shop, event, created_at) values ('shop', 'event', '2017-11-23')
select * from analytics where created_at = '2017-11-25' and shop = 'shop'
