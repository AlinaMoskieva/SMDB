\set content random(1, 1000000)

select * from news where to_tsvector(content) @@ to_tsquery(:content::text) 
