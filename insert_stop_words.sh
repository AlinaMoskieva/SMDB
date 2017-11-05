#!/bin/bash
echo "Parsing $1"

awk '{ for ( i = 1; i < NF; ++i ) print $(i); }' $1 |
while IFS= read -r var
do
  psql -U postgres -d SMDB -c "INSERT INTO stop_words (word) VALUES ('$var')"
  echo "$var"
done
psql -U postgres -d SMDB -c "UPDATE stop_words SET word = lower(regexp_replace(word, '\W+', '', 'g'))"
psql -U postgres -d SMDB -c "SELECT * FROM stop_words"
