select word, count(word) as "word_amount", document_id from dictionary
	group by grouping sets(word, document_id, (word, document_id))
	having count(word) > 1 
	order by word nulls last, word_amount desc, document_id nulls last
