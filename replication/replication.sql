create table logs(
  destination_id integer not null,
  table_name varchar(100) not null,
  action varchar(40) not null,
  changes json,
  replied boolean default false,
  created_at timestamp not null default current_timestamp,
  primary key (created_at, table_name)
);

-- create master table
create table master_table(
    id bigserial primary key,
    name varchar(100) not null,
    number integer not null
);

--create replied table
create table stand_by_table (like master_table including all);
select * from stand_by_table;


-- function

create or replace function fnc_insert_data_to_logs()
  returns trigger as
$BODY$
declare
  xTableSchema varchar(100):= 'SMDB';
  xTableMaster varchar(100):= 'logs';
begin
   if (TG_OP = 'DELETE') then
     execute 'insert into logs (destination_id, table_name, action) values ('|| OLD.id ||', ''' || TG_TABLE_NAME || ''', ''DELETE'')';
   elsif (TG_OP = 'UPDATE') then
   	 execute 'insert into logs (destination_id, table_name, action, changes) values ('|| New.id ||', ''' || TG_TABLE_NAME || ''', '''|| TG_OP || ''', '''|| (hstore(NEW)- hstore(OLD))::json ||''')';
   else
   	 execute 'insert into logs (destination_id, table_name, action, changes) values ('|| New.id ||', ''' || TG_TABLE_NAME || ''', '''|| TG_OP || ''', '''|| hstore(NEW)::json ||''')';
   end if;
   return null;
end;
$BODY$
language plpgsql volatile;

-- trigger 
create trigger trg_log_insert
	after insert or update or delete on master_table
	for each row
	execute procedure fnc_insert_data_to_logs();

--check
insert into master_table (name, number) values ('name', 1);
delete from master_table where id = 14;
update master_table set name='my_new_name' where(id = 14)

select * from logs
select * from stand_by_table
select * from master_table


