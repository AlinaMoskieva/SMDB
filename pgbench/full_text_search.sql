create table news (
    id serial primary key,
    content text not null
)

insert into news (content) values('The battle had been raging for some time. King Richard rode hither and thither, cheering his men and fighting his foes. His enemy, Henry, who wished to be king, was pressing him hard.');
insert into news (content) values('Far away, at the other side of the field, King Richard saw his men falling back. Without his help they would soon be beaten. So he spurred his horse to ride to their aid.');
insert into news (content) values('He was hardly halfway across the stony field when one of the horses shoes flew off. The horse was lamed on a rock. Then another shoe came off. The horse stumbled, and his rider was thrown heavily to the ground.');

create index news_search_content_idx on news using GIN (to_tsvector('english', content));

select * from news where to_tsvector(content) @@ to_tsquery('away')
