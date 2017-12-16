\set limit random(1, 32)
\set offset random(1, 32)

select * from news where to_tsvector(content) @@ to_tsquery(
 array_to_string(array(select unnest
                      (string_to_array('Before the king could rise, his frightened horse, although lame, had galloped away. The king looked, and saw that his soldiers were beaten, and that the battle was everywhere going against him',' ')) 
                      limit :limit offset :offset),' & ')::text 
   )
