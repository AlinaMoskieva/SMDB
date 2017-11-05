#!/bin/bash
echo "Parsing $1"

psql -U postgres -d SMDB -c "INSERT INTO documents (name) VALUES ('$1')"
# psql -U postgres -d SMDB -c "INSERT INTO documents (name, text) VALUES ('$1', '`cat $1`')"

document_id=`psql -U postgres -d SMDB -t -c "SELECT id FROM documents ORDER BY id DESC LIMIT 1"`

awk '{ for ( i = 1; i < NF; ++i ) print $(i); }' $1 |
while IFS= read -r var
do
  psql -U postgres -d SMDB -c "INSERT INTO dictionary (document_id, word) VALUES ($document_id, '$var')"
  echo "$var"
done
psql -U postgres -d SMDB -c "UPDATE dictionary SET word = lower(regexp_replace(word, '\W+', '', 'g'))"
psql -U postgres -d SMDB -c "SELECT * FROM dictionary"
psql -U postgres -d SMDB -c "SELECT * FROM documents"
psql -U postgres -d SMDB -c "SELECT count(*) FROM dictionary"

echo "Delete stop words from dictionary"

psql -U postgres -d SMDB -c "DELETE FROM dictionary WHERE (word IN (SELECT word FROM stop_words))"
psql -U postgres -d SMDB -c "SELECT count(*) FROM dictionary"
