create table d_set(
	item varchar
)


2.
  select(
	(select count(*) from (
		select item from a_set
			intersect
		select item from b_set) as float)
* 1.0
/

   (select count(*) from (
	select item from a_set
		union
	select item from b_set) as float)
) as result

3.

select (
	(select count(*) from (
		select item from c_set
			intersect all
		select item from d_set) as d)
* 1.0
/
	(select count(*) from (
		select item from c_set
			union all
		select item from d_set) as d))


1.
select item from b_set
	union
select 3 as item
	union
select 4 as item
	union
select 6 as item
	union
select 5 as item
	union
select null as item
